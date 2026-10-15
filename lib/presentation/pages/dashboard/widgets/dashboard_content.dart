import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:rental_room/presentation/extensions/extensions.dart';

import '../../../../domain/domain.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../presentation.dart';
import '../../index.dart';
import 'dashboard_category_list.dart';
import 'dashboard_empty_text.dart';
import 'dashboard_section_title.dart';
import 'owner_metric_cards.dart';
import 'owner_monthly_revenue_card.dart';
import 'static_promo_card.dart';
import 'vertical_rooms_section.dart';

/// Tab index of "Posts" inside IndexPage.
const int _postsTabIndex = 1;

/// Max rooms shown per section.
const int _sectionLimit = 4;

/// Firestore room type IDs.
String? _selectedTypeId; // null = all types

class DashboardContent extends StatefulWidget {
  final UserEntity user;

  const DashboardContent({super.key, required this.user});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  bool get _isOwner => widget.user.role == UserRole.owner;

  @override
  void initState() {
    super.initState();
    _scheduleLoad();
  }

  @override
  void didUpdateWidget(covariant DashboardContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.user.id != widget.user.id ||
        oldWidget.user.latitude != widget.user.latitude ||
        oldWidget.user.longitude != widget.user.longitude ||
        oldWidget.user.address != widget.user.address) {
      _scheduleLoad();
    }
  }

  /// Single place for all initial loading (one frame callback only).
  void _scheduleLoad() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final userId = widget.user.id;

      _refreshRooms();
      context.read<FavoriteCubit>().loadFavorites(userId);

      if (_isOwner) {
        context.read<BookingCubit>().fetchBookings(userId, ownerId: userId);
      }
    });
  }

  void _refreshRooms() {
    context.read<RoomCubit>().fetchRooms(status: _isOwner ? null : 'available');
  }

  /// Opens the Posts tab. Pass [roomTypeId] to pre-apply a type filter.
  void _goToPosts({String? roomTypeId, bool nearby = false}) {
    final uri = Uri(
      path: IndexPage.routePath,
      queryParameters: {
        'tab': '$_postsTabIndex',
        if (roomTypeId != null) 'type': roomTypeId,
        if (nearby) 'nearby': 'true',
      },
    );
    context.go(uri.toString());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_isOwner) ...[
          DashboardSectionTitle(l10n.overview),
          const SizedBox(height: 12),
          OwnerMetricsOverview(user: widget.user),
          const SizedBox(height: 28),
          OwnerMonthlyRevenueCard(user: widget.user),
          const SizedBox(height: 28),
        ] else ...[
          StaticPromoCard(
            title: l10n.promoCashback,
            expirationText: l10n.promoExpired,
            imageAssetPath: 'assets/images/unsplash_RFDP7_80v5A.png',
          ),
          const SizedBox(height: 20),
        ],
        BlocBuilder<RoomCubit, RoomState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => _isOwner
                  ? const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()),
              )
                  : const DashboardSkeletonLoader(),
              loaded: (rooms) =>
              _isOwner ? _buildOwner(rooms) : _buildTenant(rooms),
              failure: (message) => Padding(
                padding: const EdgeInsets.all(32),
                child: Center(
                  child: Text(
                    l10n.errorLoadingRooms(message),
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ],
    );
  }

  // ───────────────────────── OWNER ─────────────────────────

  Widget _buildOwner(List<RoomEntity> rooms) {
    final l10n = AppLocalizations.of(context)!;
    final latest = _latest(rooms.where((r) => r.ownerId == widget.user.id));

    return VerticalRoomsSection(
      title: l10n.latestProperties,
      emptyText: l10n.noPropertiesYet,
      rooms: latest,
      user: widget.user,
      showOwnerActions: true,
      onSeeAll: _goToPosts,
      onRoomUpdated: _refreshRooms,
    );
  }

  // ───────────────────────── TENANT ─────────────────────────

  Widget _buildTenant(List<RoomEntity> rooms) {
    final l10n = AppLocalizations.of(context)!;
    final available = rooms.where((r) => r.status == 'available');

    final recommended = _latest(
      _selectedTypeId == null
          ? available
          : available.where((r) => r.roomTypeId == _selectedTypeId),
    );

    // Nearby rooms based on user location (latitude/longitude or address matching)
    final userLat = widget.user.latitude;
    final userLng = widget.user.longitude;
    List<RoomEntity> nearbyRooms = [];

    if (userLat != null && userLng != null) {
      const distance = Distance();
      final roomsWithDistance = available.where((r) => r.latitude != null && r.longitude != null).map((r) {
        final dist = distance.as(LengthUnit.Kilometer, LatLng(userLat, userLng), LatLng(r.latitude!, r.longitude!));
        return MapEntry(r, dist);
      }).toList()..sort((a, b) => a.value.compareTo(b.value));
      nearbyRooms = roomsWithDistance.map((e) => e.key).take(_sectionLimit).toList();
    }

    if (nearbyRooms.isEmpty && widget.user.address != null && widget.user.address!.trim().isNotEmpty) {
      final userAddress = widget.user.address!.toLowerCase();
      final parts = userAddress
          .split(',')
          .map((e) => e.trim())
          .where((e) =>
              e.isNotEmpty &&
              e != 'myanmar' &&
              e != 'burma' &&
              e != 'myanmar (burma)' &&
              !RegExp(r'^\d+$').hasMatch(e))
          .toList();

      if (parts.isNotEmpty) {
        // Exclude broad region names if more specific township/district parts exist
        final specificParts = parts.where((p) {
          final lower = p.toLowerCase();
          return !lower.contains('region') &&
              !lower.contains('state') &&
              !lower.contains('division') &&
              lower != 'yangon' &&
              lower != 'mandalay' &&
              lower != 'naypyidaw';
        }).toList();

        final searchKeywords = specificParts.isNotEmpty ? specificParts : parts;

        nearbyRooms = available.where((r) {
          final rAddr = r.location.toLowerCase();
          return searchKeywords.any((kw) => rAddr.contains(kw));
        }).take(_sectionLimit).toList();
      }
    }

    final typeName = _selectedTypeId != null ? l10n.localizedRoomType(_selectedTypeId!) : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashboardSectionTitle(l10n.categories),
        const SizedBox(height: 12),
        DashboardCategoryList(
          selectedId: _selectedTypeId,
          onTap: (id) => setState(() => _selectedTypeId = id),
        ),
        const SizedBox(height: 24),

        DashboardSectionTitle(
          typeName ?? l10n.recommended,
          onSeeAll: () => _goToPosts(roomTypeId: _selectedTypeId),
        ),
        const SizedBox(height: 6),
        if (recommended.isEmpty)
          DashboardEmptyText(
            typeName == null
                ? l10n.noRoomsAvailable
                : l10n.noTypeAvailable(typeName),
          )
        else
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: recommended.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (_, i) => RecommendedRoomCard(
                room: recommended[i],
                currentUser: widget.user,
                onRoomUpdated: _refreshRooms,
              ),
            ),
          ),
        const SizedBox(height: 20),

        VerticalRoomsSection(
          title: 'Rooms Near ${widget.user.name.isNotEmpty ? widget.user.name : 'You'}',
          emptyText: l10n.noNearbyRooms,
          rooms: nearbyRooms,
          user: widget.user,
          showOwnerActions: false,
          onSeeAll: () => _goToPosts(nearby: true),
          onRoomUpdated: _refreshRooms,
        ),
      ],
    );
  }

  /// Newest first, limited to [_sectionLimit].
  List<RoomEntity> _latest(Iterable<RoomEntity> rooms) {
    final epoch = DateTime.fromMillisecondsSinceEpoch(0);
    final list = rooms.toList()
      ..sort((a, b) => (b.createdAt ?? epoch).compareTo(a.createdAt ?? epoch));
    return list.take(_sectionLimit).toList();
  }
}

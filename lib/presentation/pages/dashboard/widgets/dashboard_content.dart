import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/domain.dart';
import '../../../presentation.dart';
import '../../index.dart';
import 'owner_metric_cards.dart';
import 'owner_monthly_revenue_card.dart';
import 'static_promo_card.dart';

/// Tab index of "Posts" inside IndexPage.
const int _postsTabIndex = 1;

/// Max rooms shown per section.
const int _sectionLimit = 4;

/// Firestore room type IDs.
// const String _dormTypeId = 'rt_dorm';
String? _selectedTypeId; // null = all types
const String _miniCondoTypeId = 'rt_minicondo';

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
    if (oldWidget.user.id != widget.user.id) _scheduleLoad();
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
  void _goToPosts({String? roomTypeId}) {
    final uri = Uri(
      path: IndexPage.routePath,
      queryParameters: {
        'tab': '$_postsTabIndex',
        if (roomTypeId != null) 'type': roomTypeId,
      },
    );
    context.go(uri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_isOwner) ...[
          const _SectionTitle('Overview'),
          const SizedBox(height: 12),
          OwnerMetricsOverview(user: widget.user),
          const SizedBox(height: 28),
          OwnerMonthlyRevenueCard(user: widget.user),
          const SizedBox(height: 28),
        ] else ...[
          const StaticPromoCard(
            title: 'GET YOUR 20%\nCASHBACK',
            expirationText: '*Expired 25 Dec 2026',
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
                    'Error loading rooms: $message',
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
    final latest = _latest(rooms.where((r) => r.ownerId == widget.user.id));

    return _VerticalRoomsSection(
      title: 'Latest Properties',
      emptyText: 'No properties listed yet.',
      rooms: latest,
      user: widget.user,
      showOwnerActions: true,
      onSeeAll: _goToPosts,
      onRoomUpdated: _refreshRooms,
    );
  }

  // ───────────────────────── TENANT ─────────────────────────

  Widget _buildTenant(List<RoomEntity> rooms) {
    final available = rooms.where((r) => r.status == 'available');

    final recommended = _latest(
      _selectedTypeId == null
          ? available
          : available.where((r) => r.roomTypeId == _selectedTypeId),
    );
    final miniCondos = _latest(
      available.where((r) => r.roomTypeId == _miniCondoTypeId),
    );

    final typeName = LookupConstants.roomTypes[_selectedTypeId];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle('Categories'),
        const SizedBox(height: 12),
        _CategoryList(
          selectedId: _selectedTypeId,
          onTap: (id) => setState(() => _selectedTypeId = id),
        ),
        const SizedBox(height: 24),

        _SectionTitle(
          typeName == null ? 'Recommended' : 'Recommended · $typeName',
          onSeeAll: () => _goToPosts(roomTypeId: _selectedTypeId),
        ),
        const SizedBox(height: 6),
        if (recommended.isEmpty)
          _EmptyText(
            typeName == null
                ? 'No rooms available.'
                : 'No $typeName available.',
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

        if (_selectedTypeId != _miniCondoTypeId)
          _VerticalRoomsSection(
            title: 'Mini Condo',
            emptyText: 'No mini condos available.',
            rooms: miniCondos,
            user: widget.user,
            showOwnerActions: false,
            onSeeAll: () => _goToPosts(roomTypeId: _miniCondoTypeId),
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

/// Title + "See all" + vertical RoomCards + empty state.
class _VerticalRoomsSection extends StatelessWidget {
  final String title;
  final String emptyText;
  final List<RoomEntity> rooms;
  final UserEntity user;
  final bool showOwnerActions;
  final VoidCallback onSeeAll;
  final VoidCallback onRoomUpdated;

  const _VerticalRoomsSection({
    required this.title,
    required this.emptyText,
    required this.rooms,
    required this.user,
    required this.showOwnerActions,
    required this.onSeeAll,
    required this.onRoomUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title, onSeeAll: onSeeAll),
        const SizedBox(height: 12),
        if (rooms.isEmpty)
          _EmptyText(emptyText)
        else
          Column(
            children: rooms
                .map(
                  (room) => RoomCard(
                    room: room,
                    currentUser: user,
                    showOwnerActions: showOwnerActions,
                    onRoomUpdated: onRoomUpdated,
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

/// Section heading with optional "See all" button.
class _SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const _SectionTitle(this.title, {this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final text = Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : AppColors.clrBlack,
      ),
    );

    if (onSeeAll == null) return text;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        text,
        TextButton(
          onPressed: onSeeAll,
          child: const Text(
            'See all',
            style: TextStyle(
              color: Color(0xFF6C5CE7),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyText extends StatelessWidget {
  final String text;

  const _EmptyText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      alignment: Alignment.center,
      child: Text(text, style: TextStyle(color: Colors.grey.shade600)),
    );
  }
}

class _CategoryList extends StatelessWidget {
  final String? selectedId; // null = All
  final ValueChanged<String?> onTap;

  const _CategoryList({required this.selectedId, required this.onTap});


  @override
  Widget build(BuildContext context) {
    final entries = LookupConstants.roomTypes.entries.toList();

    return SizedBox(
      height: 104,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: entries.length + 1, // +1 for "All"
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          if (i == 0) {
            return _CategoryItem(
              label: 'All',
              icon: Icons.apps_rounded,
              selected: selectedId == null,
              onTap: () => onTap(null),
            );
          }
          final e = entries[i - 1];
          return _CategoryItem(
            label: e.value,
            icon: roomTypeIcon(e.key),
            selected: e.key == selectedId,
            onTap: () => onTap(e.key),
          );
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? scheme.primary : Colors.grey.shade300,
                ),
              ),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: selected ? scheme.primary : Colors.white,
                child: Icon(
                  icon,
                  size: 22,
                  color: selected ? scheme.onPrimary : Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 80,
              child: Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight:
                  selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
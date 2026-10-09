import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_room/presentation/pages/room/owner/widgets/room_detail_screen.dart';

import '../../../../di/injector.dart';
import '../../../../domain/domain.dart';
import '../../../blocs/blocs.dart';
import '../../../components/components.dart';
import '../../../extensions/number.dart';
import 'add_edit_room_page.dart';

class OwnerRoomDetailScreen extends StatefulWidget {
  static const String routeName = 'owner-room-detail';
  static const String routePath = '/owner-room-detail';

  final RoomEntity room;

  const OwnerRoomDetailScreen({super.key, required this.room});

  @override
  State<OwnerRoomDetailScreen> createState() => _OwnerRoomDetailScreenState();
}

class _OwnerRoomDetailScreenState extends State<OwnerRoomDetailScreen> {
  late RoomEntity _room;
  List<Map<String, dynamic>> _amenitiesList = [];

  @override
  void initState() {
    super.initState();
    _room = widget.room;
    _loadAmenities();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentUser = context.read<AuthenticationCubit>().user;
      if (currentUser != null && mounted) {
        context.read<FavoriteCubit>().loadFavorites(currentUser.id);
      }
    });
  }

  Future<void> _loadAmenities() async {
    try {
      final repo = inject<RoomRepository>();
      final amenities = await repo.getAmenities();
      if (mounted) {
        setState(() => _amenitiesList = amenities);
      }
    } catch (_) {}
  }

  Future<void> _refreshRoomData() async {
    final currentUser = context.read<AuthenticationCubit>().user;
    if (currentUser != null && mounted) {
      context.read<FavoriteCubit>().loadFavorites(currentUser.id);
    }

    try {
      final repo = inject<RoomRepository>();
      final updatedRoom = await repo.getRoomById(_room.id);
      if (updatedRoom != null && mounted) {
        setState(() => _room = updatedRoom);
        return;
      }
    } catch (_) {}

    if (!mounted) return;
    await context.read<RoomCubit>().fetchRooms();
    if (!mounted) return;
    final state = context.read<RoomCubit>().state;
    state.maybeWhen(
      loaded: (rooms) {
        final updated = rooms.where((r) => r.id == _room.id).firstOrNull;
        if (updated != null && mounted) {
          setState(() => _room = updated);
        }
      },
      orElse: () {},
    );
  }

  void _confirmDelete(BuildContext context) {
    showRoomDeleteDialog(
      context: context,
      roomId: _room.id,
      onDeleted: () {
        if (mounted) {
          context.pop(true);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoomHeroHeader(
              room: _room,
              images: _room.images,
              ownerAction: _OwnerRoomDeleteButton(
                onPressed: () => _confirmDelete(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _OwnerRoomFavoriteStatsCard(roomId: _room.id),
                  RoomVisitorStatsCard(roomId: _room.id),
                  RoomCollapsibleDescriptionSection(
                    description: _room.description,
                  ),
                  RoomAmenitiesSection(
                    amenityIds: _room.amenityIds,
                    amenitiesList: _amenitiesList,
                  ),
                  RoomLocationMapSection(room: _room),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _OwnerRoomBottomActionBar(
        room: _room,
        onEditRoom: () async {
          final updated = await context.push(
            AddEditRoomScreen.routePath,
            extra: _room,
          );
          if (updated is RoomEntity && mounted) {
            setState(() => _room = updated);
          } else if (mounted) {
            await _refreshRoomData();
          }
        },
      ),
    );
  }
}

// 1. Delete Button Widget
class _OwnerRoomDeleteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _OwnerRoomDeleteButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        tooltip: 'Delete Room',
        icon: Icon(
          Icons.delete_outline_rounded,
          color: Colors.red.shade400,
          size: 22,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

// 2. Favorite Stats Card Widget
class _OwnerRoomFavoriteStatsCard extends StatelessWidget {
  final String roomId;

  const _OwnerRoomFavoriteStatsCard({required this.roomId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, favoriteState) {
        final favCount = favoriteState.getFavoriteCount(roomId);
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Row(
            children: [
              Icon(
                Icons.favorite_rounded,
                color: Colors.red.shade600,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                      child: Text(
                        '$favCount ${favCount == 1 ? 'User Favorited' : 'Users Favorited'} This Room',
                        key: ValueKey<int>(favCount),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade900,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Track engagement for your property listing.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// 3. Bottom Action Bar Widget
class _OwnerRoomBottomActionBar extends StatelessWidget {
  final RoomEntity room;
  final Future<void> Function() onEditRoom;

  const _OwnerRoomBottomActionBar({
    required this.room,
    required this.onEditRoom,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Price',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                room.pricePerMonth.toKsFormat,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => onEditRoom(),
                icon: const Icon(Icons.edit_outlined, size: 20),
                label: const Text(
                  'Edit Room Details',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

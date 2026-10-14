import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injector.dart';
import '../../../../domain/domain.dart';
import '../../../blocs/blocs.dart';
import '../../../components/components.dart';
import '../widgets/widgets.dart';
import 'add_edit_room_page.dart';
import 'widgets/owner_room_bottom_action_bar.dart';
import 'widgets/owner_room_delete_button.dart';
import 'widgets/owner_room_favorite_stats_card.dart';
import 'widgets/owner_room_visitor_stats_card.dart';

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
              ownerAction: OwnerRoomDeleteButton(
                onPressed: () => _confirmDelete(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OwnerRoomFavoriteStatsCard(roomId: _room.id),
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
      bottomNavigationBar: OwnerRoomBottomActionBar(
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

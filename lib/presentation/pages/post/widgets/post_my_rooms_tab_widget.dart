import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/domain.dart';
import '../../../presentation.dart';


class PostMyRoomsTabWidget extends StatelessWidget {
  final List<RoomEntity> myRooms;
  final UserEntity user;
  final Future<void> Function() onRefresh;

  const PostMyRoomsTabWidget({
    super.key,
    required this.myRooms,
    required this.user,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        children: [
          // BANNER & ADD ROOM ACTION
          Card(
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Properties (${myRooms.length})',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.role == UserRole.owner
                              ? 'Manage your listed rooms, edit details, and track favorites.'
                              : 'You are viewing rooms owned by your account.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (user.role == UserRole.owner)
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      ),
                      icon: const Icon(Icons.add_rounded, size: 18),
                      label: const Text('Add Room'),
                      onPressed: () async {
                        await context.push(AddEditRoomScreen.routePath);
                        onRefresh();
                      },
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          if (myRooms.isEmpty)
            Container(
              height: 280,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.house_siding_rounded, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    user.role == UserRole.owner
                        ? 'You haven\'t added any rooms yet.'
                        : 'No rooms listed under your account.',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                  if (user.role == UserRole.owner) ...[
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add_circle_outline_rounded),
                      label: const Text('Add Your First Room'),
                      onPressed: () async {
                        await context.push(AddEditRoomScreen.routePath);
                        onRefresh();
                      },
                    ),
                  ],
                ],
              ),
            )
          else
            ...myRooms.map(
              (room) => RoomCard(
                room: room,
                currentUser: user,
                showOwnerActions: true,
                onRoomUpdated: () => onRefresh(),
              ),
            ),
        ],
      ),
    );
  }
}

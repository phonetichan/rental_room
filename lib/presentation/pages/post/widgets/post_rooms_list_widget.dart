import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';
import '../../../presentation.dart';

class PostRoomsListWidget extends StatelessWidget {
  final List<RoomEntity> rooms;
  final String emptyMessage;
  final UserEntity currentUser;
  final Future<void> Function() onRefresh;

  const PostRoomsListWidget({
    super.key,
    required this.rooms,
    required this.emptyMessage,
    required this.currentUser,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (rooms.isEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: 350,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.no_meeting_room_outlined, size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text(
                  emptyMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return RoomCard(
            room: room,
            currentUser: currentUser,
            showOwnerActions: false,
            onRoomUpdated: () => onRefresh(),
          );
        },
      ),
    );
  }
}

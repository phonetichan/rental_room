import 'package:flutter/material.dart';
import '../../../../domain/domain.dart';
import '../../../components/components.dart';
import 'dashboard_empty_text.dart';
import 'dashboard_section_title.dart';

class VerticalRoomsSection extends StatelessWidget {
  final String title;
  final String emptyText;
  final List<RoomEntity> rooms;
  final UserEntity user;
  final bool showOwnerActions;
  final VoidCallback onSeeAll;
  final VoidCallback onRoomUpdated;

  const VerticalRoomsSection({
    super.key,
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
        DashboardSectionTitle(title, onSeeAll: onSeeAll),
        const SizedBox(height: 12),
        if (rooms.isEmpty)
          DashboardEmptyText(emptyText)
        else
          Column(
            children: rooms
                .map<Widget>(
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

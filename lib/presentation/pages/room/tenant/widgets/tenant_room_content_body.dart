import 'package:flutter/material.dart';

import '../../../../../data/data.dart';
import '../../../../../domain/domain.dart';
import '../../widgets/widgets.dart';

/// Main content body for tenant room details screen.
class TenantRoomContentBody extends StatelessWidget {
  final RoomEntity room;
  final List<Map<String, dynamic>> amenitiesList;
  final UserModel? ownerUser;

  const TenantRoomContentBody({
    super.key,
    required this.room,
    required this.amenitiesList,
    required this.ownerUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoomCollapsibleDescriptionSection(description: room.description),
          RoomOwnerInfoTile(ownerId: room.ownerId, owner: ownerUser),
          RoomAmenitiesSection(
            amenityIds: room.amenityIds,
            amenitiesList: amenitiesList,
          ),
          RoomLocationMapSection(room: room),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

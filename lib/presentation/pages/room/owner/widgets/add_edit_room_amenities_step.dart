import 'package:flutter/material.dart';
import 'room_amenities_selector_widget.dart';

class AddEditRoomAmenitiesStep extends StatelessWidget {
  final List<Map<String, dynamic>> amenitiesList;
  final List<String> selectedAmenityIds;
  final bool isSubmitting;
  final ValueChanged<String> onAmenitySelected;

  const AddEditRoomAmenitiesStep({
    super.key,
    required this.amenitiesList,
    required this.selectedAmenityIds,
    required this.isSubmitting,
    required this.onAmenitySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey(1),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RoomAmenitiesSelectorWidget(
          amenitiesList: amenitiesList,
          selectedAmenityIds: selectedAmenityIds,
          isSubmitting: isSubmitting,
          onAmenitySelected: onAmenitySelected,
        ),
      ],
    );
  }
}

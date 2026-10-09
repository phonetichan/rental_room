import 'package:flutter/material.dart';

import '../../../../../data/data.dart';
import '../../../../../di/di.dart';

class RoomAmenitiesSelectorWidget extends StatelessWidget {
  final List<Map<String, dynamic>> amenitiesList;
  final List<String> selectedAmenityIds;
  final bool isSubmitting;
  final ValueChanged<String> onAmenitySelected;

  const RoomAmenitiesSelectorWidget({
    super.key,
    required this.amenitiesList,
    required this.selectedAmenityIds,
    required this.isSubmitting,
    required this.onAmenitySelected,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Wrap(
      spacing: 8, // Comfortable space between chips
      runSpacing: 8, // Removes the wide vertical gap between rows
      children: amenitiesList.map((amenity) {
        final amenityId = amenity['id'] as String;
        final amenityName = amenity['name'] as String;
        final amenityIcon = (amenity['icon'] as String?) ?? 'help_outline';
        final isSelected = selectedAmenityIds.contains(amenityId);

        return FilterChip(
          selected: isSelected,
          showCheckmark: false,
          // Removes the invisible 48px hit-box padding that creates huge gaps
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          avatar: Icon(
            inject<AuthDataSource>().getAmenityIcon(amenityIcon),
            size: 18,
            color: isSelected ? Colors.white : primaryColor,
          ),
          label: Text(amenityName),
          labelStyle: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : primaryColor,
          ),
          backgroundColor: primaryColor.withValues(alpha: 0.08),
          selectedColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: isSelected
                  ? primaryColor
                  : primaryColor.withValues(alpha: 0.2),
            ),
          ),
          onSelected: isSubmitting ? null : (_) => onAmenitySelected(amenityId),
        );
      }).toList(),
    );
  }
}
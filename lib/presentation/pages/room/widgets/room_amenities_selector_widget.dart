import 'package:flutter/material.dart';
import '../../../../data/datasource/remote/auth_data_source.dart';
import '../../../../di/di.dart';

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
      spacing: 8,
      runSpacing: 10,
      children: amenitiesList.map((amenity) {
        final amenityId = amenity['id'] as String;
        final amenityName = amenity['name'] as String;
        final amenityIcon = (amenity['icon'] as String?) ?? 'help_outline';
        final isSelected = selectedAmenityIds.contains(amenityId);

        return FilterChip(
          selected: isSelected,
          showCheckmark: false,
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected ? primaryColor : primaryColor.withValues(alpha: 0.2),
            ),
          ),
          onSelected: isSubmitting ? null : (_) => onAmenitySelected(amenityId),
        );
      }).toList(),
    );
  }
}

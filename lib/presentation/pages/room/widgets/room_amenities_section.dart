import 'package:flutter/material.dart';

import 'package:rental_room/data/data.dart';
import 'package:rental_room/di/injector.dart';
import 'package:rental_room/presentation/extensions/l10n/l10n.dart';
import 'package:rental_room/presentation/extensions/l10n/lookup_l10n.dart';
import 'room_section_card.dart';

/// Amenities chips list section widget.
class RoomAmenitiesSection extends StatelessWidget {
  final List<String> amenityIds;
  final List<Map<String, dynamic>> amenitiesList;

  const RoomAmenitiesSection({
    super.key,
    required this.amenityIds,
    required this.amenitiesList,
  });

  @override
  Widget build(BuildContext context) {
    if (amenityIds.isEmpty) return const SizedBox.shrink();

    final primaryColor = Theme.of(context).primaryColor;

    return RoomSectionCard(
      title: context.l10n.amenities,
      icon: Icons.star_outline,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: amenityIds.toSet().toList().map((amenityId) {
            final matching = amenitiesList
                .where((a) => a['id'] == amenityId)
                .firstOrNull;
            final name = context.l10n.localizedAmenity(amenityId);
            final iconName = matching != null
                ? ((matching['icon'] as String?) ?? 'help_outline')
                : amenityId.replaceFirst('amenity_', '');
            final icon = inject<AuthDataSource>().getAmenityIcon(iconName);

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: primaryColor.withValues(alpha: 0.3)),
                color: primaryColor.withValues(alpha: 0.05),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: Center(
                      child: Transform.translate(
                        offset: const Offset(0, 1),
                        child: Icon(icon, size: 16, color: primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

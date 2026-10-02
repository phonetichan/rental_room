import 'package:flutter/material.dart';
import '../../../../domain/domain.dart';

class RoomTypeSection extends StatelessWidget {
  final String? roomTypeId;
  final ValueChanged<String?> onRoomTypeChanged;

  const RoomTypeSection({
    super.key,
    required this.roomTypeId,
    required this.onRoomTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.category_outlined, size: 18, color: colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              'Room Type',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: -0.2,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ChoiceChip(
              label: const Text('All Types'),
              selected: roomTypeId == null || roomTypeId!.isEmpty,
              onSelected: (_) => onRoomTypeChanged(null),
              selectedColor: colorScheme.primary,
              backgroundColor: colorScheme.surfaceContainerHighest.withAlpha(80),
              labelStyle: TextStyle(
                color: (roomTypeId == null || roomTypeId!.isEmpty)
                    ? colorScheme.onPrimary
                    : colorScheme.onSurface,
                fontWeight: (roomTypeId == null || roomTypeId!.isEmpty)
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
              side: BorderSide(
                color: (roomTypeId == null || roomTypeId!.isEmpty)
                    ? colorScheme.primary
                    : theme.dividerColor,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            ...LookupConstants.roomTypes.entries.map((entry) {
              final isSelected = roomTypeId == entry.key;
              return ChoiceChip(
                label: Text(entry.value),
                selected: isSelected,
                onSelected: (_) => onRoomTypeChanged(entry.key),
                selectedColor: colorScheme.primary,
                backgroundColor: colorScheme.surfaceContainerHighest.withAlpha(80),
                labelStyle: TextStyle(
                  color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                side: BorderSide(
                  color: isSelected ? colorScheme.primary : theme.dividerColor,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              );
            }),
          ],
        ),
      ],
    );
  }
}

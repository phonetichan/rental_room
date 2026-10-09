import 'package:flutter/material.dart';

import '../../room/tenant/widgets/tenant_filter_chips.dart';

class BookingFilterChips extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;
  final bool isOwner;

  const BookingFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
    required this.isOwner,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      {
        'id': 'all',
        'label': 'All',
        'icon': Icons.border_all_rounded,
        'color': null
      },
      {
        'id': 'pending',
        'label': 'Pending',
        'icon': Icons.hourglass_top_rounded,
        'color': Colors.orange.shade700
      },
      {
        'id': 'confirmed',
        'label': 'Confirmed',
        'icon': Icons.check_circle_outline_rounded,
        'color': Colors.green.shade700
      },
    ];

    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: filters.map((f) {
          final id = f['id'] as String;
          final label = f['label'] as String;
          final icon = f['icon'] as IconData;
          final color = f['color'] as Color?;
          final isSelected = selectedFilter == id;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChipItem(
              label: label,
              icon: icon,
              iconColor: isSelected ? Colors.white : color,
              isSelected: isSelected,
              onTap: () => onFilterSelected(id),
            ),
          );
        }).toList(),
      ),
    );
  }
}

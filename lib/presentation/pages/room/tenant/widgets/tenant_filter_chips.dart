import 'package:flutter/material.dart';
import '../../../../../domain/domain.dart';
import '../../../../components/modal/room_filter.dart';

class TenantFilterChips extends StatelessWidget {
  final RoomFilter filter;
  final List<Map<String, dynamic>> roomTypes;
  final ValueChanged<RoomFilter> onFilterChanged;

  const TenantFilterChips({
    super.key,
    required this.filter,
    this.roomTypes = const [],
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final categories = roomTypes.isNotEmpty
        ? roomTypes.map((type) {
            return {
              'id': (type['id'] ?? type['roomTypeId'] ?? '').toString(),
              'name': (type['name'] ?? type['typeName'] ?? 'Unknown').toString(),
            };
          }).toList()
        : LookupConstants.roomTypes.entries.map((entry) {
            return {'id': entry.key, 'name': entry.value};
          }).toList();

    final bool isAllSelected = !filter.isFavoriteOnly &&
        (filter.roomTypeId == null || filter.roomTypeId!.isEmpty);
    final bool isFavoriteSelected = filter.isFavoriteOnly;

    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // 1. All Chip
          FilterChipItem(
            label: 'All',
            icon: Icons.border_all_rounded,
            isSelected: isAllSelected,
            onTap: () {
              onFilterChanged(
                filter.copyWith(roomTypeId: '', isFavoriteOnly: false),
              );
            },
          ),
          const SizedBox(width: 8),

          // 2. Favorites Chip
          FilterChipItem(
            label: 'Favorites',
            icon: Icons.favorite_rounded,
            iconColor: isFavoriteSelected ? Colors.red : Colors.grey,
            isSelected: isFavoriteSelected,
            onTap: () {
              onFilterChanged(
                filter.copyWith(isFavoriteOnly: true, roomTypeId: ''),
              );
            },
          ),
          const SizedBox(width: 8),

          // 3. Category Chips
          ...categories.map((cat) {
            final catId = cat['id']!;
            final catName = cat['name']!;
            final isSelected = !filter.isFavoriteOnly && filter.roomTypeId == catId;

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChipItem(
                label: catName,
                icon: Icons.category_outlined,
                isSelected: isSelected,
                onTap: () {
                  onFilterChanged(
                    filter.copyWith(roomTypeId: catId, isFavoriteOnly: false),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

class FilterChipItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChipItem({
    super.key,
    required this.label,
    required this.icon,
    this.iconColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor
              : (isDark ? Colors.white.withAlpha(20) : Colors.grey.shade100),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withAlpha(50),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected
                  ? Colors.white
                  : (iconColor ?? (isDark ? Colors.white70 : Colors.grey.shade600)),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : (isDark ? Colors.white : Colors.grey.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

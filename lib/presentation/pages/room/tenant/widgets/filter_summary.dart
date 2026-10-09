import 'package:flutter/material.dart';
import '../../../../../domain/domain.dart';
import '../../../../components/modal/room_filter.dart';

class FilterSummary extends StatelessWidget {
  final RoomFilter filter;

  const FilterSummary({super.key, required this.filter});

  /// ["A"] -> "A", ["A","B"] -> "A and B", ["A","B","C"] -> "A, B and C"
  String _joinNatural(List<String> items) {
    if (items.length == 1) return items.first;
    final head = items.sublist(0, items.length - 1).join(', ');
    return '$head and ${items.last}';
  }

  String? _build() {
    final items = <String>[];

    final typeId = filter.roomTypeId;
    if (typeId != null && typeId.isNotEmpty) {
      items.add(LookupConstants.roomTypes[typeId] ?? typeId);
    }

    if (filter.maxGuests != null) {
      items.add(filter.maxGuests == 4
          ? 'Guests 4+'
          : 'Guests ${filter.maxGuests}');
    }

    if (filter.bedrooms != null) {
      items.add(filter.bedrooms == 4 ? 'Bed 4+' : 'Bed ${filter.bedrooms}');
    }

    if (filter.minPrice != null || filter.maxPrice != null) {
      final min = filter.minPrice?.toStringAsFixed(0);
      final max = filter.maxPrice?.toStringAsFixed(0);
      if (min != null && max != null) {
        items.add('Ks $min - $max');
      } else if (min != null) {
        items.add('From Ks $min');
      } else {
        items.add('Up to Ks $max');
      }
    }

    if (filter.isFavoriteOnly) items.add('Saved only');

    if (items.isEmpty) return null;

    final verb = items.length == 1 ? 'is' : 'are';
    return '${_joinNatural(items)} $verb filtered';
  }

  @override
  Widget build(BuildContext context) {
    final text = _build();
    if (text == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.filter_alt_outlined,
              size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
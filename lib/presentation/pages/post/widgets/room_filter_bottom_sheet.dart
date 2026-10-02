import 'package:flutter/material.dart';
import '../../../../domain/domain.dart';
import '../../../presentation.dart';
import '../models/room_filter.dart';

class RoomFilterBottomSheet extends StatefulWidget {
  final RoomFilter initialFilter;
  final ValueChanged<RoomFilter> onApply;

  const RoomFilterBottomSheet({
    super.key,
    required this.initialFilter,
    required this.onApply,
  });

  @override
  State<RoomFilterBottomSheet> createState() => _RoomFilterBottomSheetState();
}

class _RoomFilterBottomSheetState extends State<RoomFilterBottomSheet> {
  late TextEditingController _minPriceController;
  late TextEditingController _maxPriceController;
  String? _roomTypeId;
  int? _bedrooms;
  int? _maxGuests;

  @override
  void initState() {
    super.initState();
    _minPriceController = TextEditingController(
      text: widget.initialFilter.minPrice?.toStringAsFixed(0) ?? '',
    );
    _maxPriceController = TextEditingController(
      text: widget.initialFilter.maxPrice?.toStringAsFixed(0) ?? '',
    );
    _roomTypeId = widget.initialFilter.roomTypeId;
    _bedrooms = widget.initialFilter.bedrooms;
    _maxGuests = widget.initialFilter.maxGuests;
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _resetFilters() {
    setState(() {
      _minPriceController.clear();
      _maxPriceController.clear();
      _roomTypeId = null;
      _bedrooms = null;
      _maxGuests = null;
    });
  }

  void _applyFilters() {
    final double? minPrice = double.tryParse(_minPriceController.text.trim());
    final double? maxPrice = double.tryParse(_maxPriceController.text.trim());

    final updatedFilter = RoomFilter(
      roomTypeId: _roomTypeId,
      minPrice: minPrice,
      maxPrice: maxPrice,
      bedrooms: _bedrooms,
      maxGuests: _maxGuests,
      isFavoriteOnly: widget.initialFilter.isFavoriteOnly,
    );

    widget.onApply(updatedFilter);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = isDark ? AppColors.clrDarkSurface : AppColors.clrWhite;
    final fillColor = isDark ? AppColors.clrWhite.withValues(alpha: 0.08) : AppColors.clrSoftGrey;
    final textColor = isDark ? AppColors.clrWhite : AppColors.clrBlack;

    final categories = LookupConstants.roomTypes.entries.map((entry) {
      return {'id': entry.key, 'name': entry.value};
    }).toList();

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sheet Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Options',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                TextButton(
                  onPressed: _resetFilters,
                  child: const Text('Clear All'),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 12),

            // 1. PRICE RANGE SECTION
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price Range',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _minPriceController.clear();
                    _maxPriceController.clear();
                    setState(() {});
                  },
                  child: Text(
                    'Clear',
                    style: TextStyle(color: AppColors.clrGrey, fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _minPriceController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: 'from',
                      hintStyle: TextStyle(color: AppColors.clrGrey),
                      filled: true,
                      fillColor: fillColor,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _maxPriceController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: 'to',
                      hintStyle: TextStyle(color: AppColors.clrGrey),
                      filled: true,
                      fillColor: fillColor,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Ks',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 2. ROOM TYPE (CATEGORY) SECTION
            Text(
              'Room Type',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                ChoiceChip(
                  label: const Text('All Types'),
                  selected: _roomTypeId == null || _roomTypeId!.isEmpty,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _roomTypeId = null);
                    }
                  },
                ),
                ...categories.map((cat) {
                  final catId = cat['id']!;
                  final catName = cat['name']!;
                  final isSelected = _roomTypeId == catId;
                  return ChoiceChip(
                    label: Text(catName),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _roomTypeId = selected ? catId : null;
                      });
                    },
                  );
                }),
              ],
            ),

            const SizedBox(height: 20),

            // 3. ROOM NUMBER (BEDROOMS) SECTION: Any, 1, 2, 3, 4+
            Text(
              'Room Number (Bedrooms)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: const Text('Any'),
                      selected: _bedrooms == null,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _bedrooms = null);
                        }
                      },
                    ),
                  ),
                  ...List.generate(4, (index) {
                    final count = index + 1;
                    final isSelected = _bedrooms == count;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(index == 3 ? '4+' : '$count'),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _bedrooms = selected ? count : null;
                          });
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 4. MAX GUESTS SECTION: Any, 1, 2, 3, 4+
            Text(
              'Max Guests',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: const Text('Any'),
                      selected: _maxGuests == null,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _maxGuests = null);
                        }
                      },
                    ),
                  ),
                  ...List.generate(4, (index) {
                    final count = index + 1;
                    final isSelected = _maxGuests == count;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(index == 3 ? '4+' : '$count'),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _maxGuests = selected ? count : null;
                          });
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // APPLY BUTTON
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _applyFilters,
                child: const Text('Apply Filters', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

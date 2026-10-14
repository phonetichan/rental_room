import 'package:flutter/material.dart';

import '../../../../../domain/domain.dart';
import '../../../../extensions/extensions.dart';
import '../../../../presentation.dart';

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

  Widget _sectionTitle(String text, Color color) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
    );
  }

  Widget _countChips({
    required int? selectedValue,
    required ValueChanged<int?> onChanged,
    required String anyLabel,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(anyLabel),
              selected: selectedValue == null,
              onSelected: (selected) {
                if (selected) onChanged(null);
              },
            ),
          ),
          ...List.generate(4, (index) {
            final count = index + 1;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(context.localizedNumber(index == 3 ? '4+' : count)),
                selected: selectedValue == count,
                onSelected: (selected) => onChanged(selected ? count : null),
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = isDark
        ? AppColors.clrDarkSurface
        : AppColors.clrWhite;
    final fillColor = isDark
        ? AppColors.clrWhite.withValues(alpha: 0.08)
        : AppColors.clrSoftGrey;
    final textColor = isDark ? AppColors.clrWhite : AppColors.clrBlack;
    final l10n = context.l10n;

    final categories = LookupConstants.roomTypes.keys
        .map((id) => (id: id, name: l10n.localizedRoomType(id)))
        .toList();

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
                  l10n.filterOptions,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                TextButton(
                  onPressed: _resetFilters,
                  child: Text(l10n.filterClearAll),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 12),

            // 1. PRICE RANGE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _sectionTitle(l10n.filterPriceRange, textColor),
                GestureDetector(
                  onTap: () {
                    _minPriceController.clear();
                    _maxPriceController.clear();
                    setState(() {});
                  },
                  child: Text(
                    l10n.filterClear,
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
                      hintText: l10n.filterFrom,
                      hintStyle: TextStyle(color: AppColors.clrGrey),
                      filled: true,
                      fillColor: fillColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
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
                      hintText: l10n.filterTo,
                      hintStyle: TextStyle(color: AppColors.clrGrey),
                      filled: true,
                      fillColor: fillColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
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

            // 2. ROOM TYPE
            _sectionTitle(l10n.filterRoomType, textColor),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                ChoiceChip(
                  label: Text(l10n.filterAllTypes),
                  selected: _roomTypeId == null || _roomTypeId!.isEmpty,
                  onSelected: (selected) {
                    if (selected) setState(() => _roomTypeId = null);
                  },
                ),
                ...categories.map((cat) {
                  return ChoiceChip(
                    label: Text(cat.name),
                    selected: _roomTypeId == cat.id,
                    onSelected: (selected) {
                      setState(() => _roomTypeId = selected ? cat.id : null);
                    },
                  );
                }),
              ],
            ),

            const SizedBox(height: 20),

            // 3. ROOM NUMBER (BEDROOMS)
            _sectionTitle(l10n.filterRoomNumber, textColor),
            const SizedBox(height: 8),
            _countChips(
              selectedValue: _bedrooms,
              anyLabel: l10n.filterAny,
              onChanged: (v) => setState(() => _bedrooms = v),
            ),

            const SizedBox(height: 20),

            // 4. MAX GUESTS
            _sectionTitle(l10n.filterMaxGuests, textColor),
            const SizedBox(height: 8),
            _countChips(
              selectedValue: _maxGuests,
              anyLabel: l10n.filterAny,
              onChanged: (v) => setState(() => _maxGuests = v),
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
                child: Text(
                  l10n.filterApply,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

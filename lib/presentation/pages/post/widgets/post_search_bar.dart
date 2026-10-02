import 'package:flutter/material.dart';
import '../../../presentation.dart';

class PostSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String searchQuery;
  final String hintText;
  final bool hasActiveFilters;
  final int activeFilterCount;
  final VoidCallback onFilterTap;
  final VoidCallback onClear;
  final ValueChanged<String> onChanged;

  const PostSearchBar({
    super.key,
    required this.controller,
    required this.searchQuery,
    this.hintText = 'Search here...',
    this.hasActiveFilters = false,
    this.activeFilterCount = 0,
    required this.onFilterTap,
    required this.onClear,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.clrDarkCard : AppColors.clrWhite;
    final textColor = isDark ? AppColors.clrWhite : AppColors.clrBlack;
    final iconColor = isDark ? Colors.white70 : AppColors.clrBlack;
    final dividerColor = isDark ? AppColors.clrDarkerGrey : AppColors.clrSoftGrey;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // 1. Search Bar Field
          Expanded(
            child: Center(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                style: TextStyle(fontSize: 14, color: textColor),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: isDark ? AppColors.clrGrey : AppColors.clrGrey,
                    fontSize: 14,
                  ),
                  contentPadding: const EdgeInsets.only(
                    left: 20,
                    top: 14,
                    bottom: 14,
                  ),
                  border: InputBorder.none,
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Clear button appears when typing
                      if (searchQuery.isNotEmpty)
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 18,
                            color: iconColor,
                          ),
                          onPressed: onClear,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),

                      if (searchQuery.isNotEmpty) const SizedBox(width: 8),

                      // Vertical Divider
                      Container(
                        height: 22,
                        width: 1,
                        color: dividerColor,
                      ),

                      // Right Search Icon
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0, right: 18.0),
                        child: Icon(
                          Icons.search,
                          color: iconColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // 2. Filter Button
          Stack(
            clipBehavior: Clip.none,
            children: [
              InkWell(
                onTap: onFilterTap,
                borderRadius: BorderRadius.circular(26),
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(26),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.filter_alt,
                    color: iconColor,
                    size: 20,
                  ),
                ),
              ),

              // Active Filters Count Badge
              if (hasActiveFilters)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: AppColors.clrRed,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '$activeFilterCount',
                      style: const TextStyle(
                        color: AppColors.clrWhite,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

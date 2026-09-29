import 'package:flutter/material.dart';

class PostSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final String searchQuery;
  final VoidCallback onClear;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;
  final bool hasActiveFilters;
  final int activeFilterCount;
  final String hintText;

  const PostSearchBar({
    super.key,
    required this.controller,
    required this.searchQuery,
    required this.onClear,
    this.onChanged,
    this.onFilterTap,
    this.hasActiveFilters = false,
    this.activeFilterCount = 0,
    this.hintText = 'Search rooms, location...',
  });

  @override
  State<PostSearchBar> createState() => _PostSearchBarState();
}

class _PostSearchBarState extends State<PostSearchBar> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final isSearching = widget.searchQuery.trim().isNotEmpty;
    final isFocused = _focusNode.hasFocus;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        textInputAction: TextInputAction.search,
        textAlignVertical: TextAlignVertical.center,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontSize: 14,
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.65),
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: isDark
              ? Colors.white.withValues(alpha: 0.07)
              : colorScheme.surfaceContainerHighest,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),

          // --- BORDERS CONFIGURATION ---
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(
              color: isDark
                  ? colorScheme.outline.withValues(alpha: 0.20)
                  : colorScheme.outline.withValues(alpha: 0.25),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(
              color: colorScheme.primary,
              width: 1.8,
            ),
          ),

          // SEARCH ICON
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 20,
            color: isFocused || isSearching
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 44,
            minHeight: 44,
          ),

          // CLEAR & FILTER BUTTONS
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSearching)
                IconButton(
                  onPressed: widget.onClear,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 36,
                  ),
                  icon: Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              if (widget.onFilterTap != null)
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Material(
                    color: widget.hasActiveFilters
                        ? colorScheme.primary.withValues(alpha: 0.16)
                        : Colors.transparent,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: widget.onFilterTap,
                      customBorder: const CircleBorder(),
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            Icon(
                              Icons.tune_rounded,
                              size: 18,
                              color: widget.hasActiveFilters
                                  ? colorScheme.primary
                                  : colorScheme.onSurfaceVariant,
                            ),
                            if (widget.hasActiveFilters)
                              Positioned(
                                top: 3,
                                right: 3,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class SegmentedTabItem {
  const SegmentedTabItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

class SegmentedTabBar extends StatelessWidget {
  const SegmentedTabBar({super.key, required this.controller, required this.tabs});

  final TabController controller;
  final List<SegmentedTabItem> tabs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 48,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : theme.dividerColor.withValues(alpha: 0.1),
          ),
        ),
        child: TabBar(
          controller: controller,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          labelPadding: EdgeInsets.zero,
          labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          unselectedLabelStyle:
          const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: theme.colorScheme.primary.withValues(alpha: 0.12),
          ),
          tabs: [
            for (final t in tabs)
              Tab(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(t.icon, size: 18),
                    const SizedBox(width: 8),
                    Text(t.label),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
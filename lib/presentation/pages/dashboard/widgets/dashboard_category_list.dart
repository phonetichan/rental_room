import 'package:flutter/material.dart';
import '../../../../domain/domain.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../extensions/extensions.dart';

class DashboardCategoryList extends StatelessWidget {
  final String? selectedId; // null = All
  final ValueChanged<String?> onTap;

  const DashboardCategoryList({super.key, required this.selectedId, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final entries = LookupConstants.roomTypes.entries.toList();

    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: entries.length + 1, // +1 for "All"
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          if (i == 0) {
            return _CategoryItem(
              label: l10n.all,
              selected: selectedId == null,
              onTap: () => onTap(null),
            );
          }
          final e = entries[i - 1];
          return _CategoryItem(
            label: l10n.localizedRoomType(e.key),
            selected: e.key == selectedId,
            onTap: () => onTap(e.key),
          );
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Material(
        color: selected ? scheme.primary : Colors.white,
        shape: StadiumBorder(
          side: BorderSide(
            color: selected ? scheme.primary : Colors.grey.shade300,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          customBorder: const StadiumBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: selected ? scheme.onPrimary : Colors.black87,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

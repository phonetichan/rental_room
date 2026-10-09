import 'package:flutter/material.dart';

class FavoriteFilterSection extends StatelessWidget {
  final bool isFavoriteOnly;
  final ValueChanged<bool> onChanged;

  const FavoriteFilterSection({
    super.key,
    required this.isFavoriteOnly,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withAlpha(100),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        secondary: Icon(
          isFavoriteOnly ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: isFavoriteOnly ? Colors.redAccent : colorScheme.onSurfaceVariant,
        ),
        title: Text(
          'Saved Rooms Only',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          'Show only rooms from your favorites',
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        value: isFavoriteOnly,
        activeThumbColor: colorScheme.primary,
        onChanged: onChanged,
      ),
    );
  }
}

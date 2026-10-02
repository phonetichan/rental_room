import 'package:flutter/material.dart';

class CountFilterSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final int? selectedValue;
  final ValueChanged<int?> onChanged;

  const CountFilterSection({
    super.key,
    required this.title,
    required this.icon,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCountChip(context, 'Any', null, selectedValue, onChanged),
            _buildCountChip(context, '1', 1, selectedValue, onChanged),
            _buildCountChip(context, '2', 2, selectedValue, onChanged),
            _buildCountChip(context, '3', 3, selectedValue, onChanged),
            _buildCountChip(context, '4+', 4, selectedValue, onChanged),
          ],
        ),
      ],
    );
  }

  Widget _buildCountChip(
      BuildContext context,
      String label,
      int? value,
      int? groupValue,
      ValueChanged<int?> onChanged,
      ) {
    final isSelected = groupValue == value;
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => onChanged(value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.surfaceContainerHighest.withAlpha(80),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? colorScheme.primary : Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../extensions/l10n/l10n.dart';

class ContractSummarySection extends StatelessWidget {
  final List<int> allowedDurations;
  final int selectedDurationMonth;
  final ValueChanged<int> onDurationSelected;
  final DateTime startDate;
  final DateTime endDate;
  final VoidCallback onSelectStartDate;
  final bool isCompleted;

  const ContractSummarySection({
    super.key,
    required this.allowedDurations,
    required this.selectedDurationMonth,
    required this.onDurationSelected,
    required this.startDate,
    required this.endDate,
    required this.onSelectStartDate,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.agreementDetails,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          l10n.leaseDuration,
          style: theme.textTheme.labelMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: allowedDurations.map((months) {
            final isSelected = selectedDurationMonth == months;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: GestureDetector(
                  onTap: () => onDurationSelected(months),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? colorScheme.primary
                            : theme.dividerColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        l10n.monthsCount(months),
                        style: TextStyle(
                          color: isSelected
                              ? colorScheme.onPrimary
                              : colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        Text(
          l10n.startDate,
          style: theme.textTheme.labelMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onSelectStartDate,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${startDate.day} ${_monthName(context, startDate.month)} ${startDate.year}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.calendar_month_rounded,
                  color: colorScheme.primary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.leaseExpiryDate,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                '${endDate.day} ${_monthName(context, endDate.month)} ${endDate.year}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _monthName(BuildContext context, int month) {
    final l10n = context.l10n;
    switch (month) {
      case 1: return l10n.monthJan;
      case 2: return l10n.monthFeb;
      case 3: return l10n.monthMar;
      case 4: return l10n.monthApr;
      case 5: return l10n.monthMay;
      case 6: return l10n.monthJun;
      case 7: return l10n.monthJul;
      case 8: return l10n.monthAug;
      case 9: return l10n.monthSep;
      case 10: return l10n.monthOct;
      case 11: return l10n.monthNov;
      case 12: return l10n.monthDec;
      default: return '';
    }
  }
}

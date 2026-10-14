import 'package:flutter/material.dart';
import '../../../extensions/l10n/l10n.dart';

class ContractHeaderBanner extends StatelessWidget {
  final bool isCompleted;

  const ContractHeaderBanner({
    super.key,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCompleted
            ? Colors.green.withValues(alpha: 0.1)
            : colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted
              ? Colors.green.withValues(alpha: 0.3)
              : colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isCompleted
                ? Icons.check_circle_rounded
                : Icons.lock_clock_outlined,
            color: isCompleted ? Colors.green : colorScheme.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCompleted
                      ? l10n.contractConfirmed
                      : l10n.ownerConfirmedContract,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isCompleted
                      ? l10n.agreementFinalizedLockedDesc
                      : l10n.reviewTermsBeforeSaving,
                  maxLines: 2,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

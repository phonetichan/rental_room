import 'package:flutter/material.dart';
import '../../../../extensions/l10n.dart';
import '../../widgets/booking_checklist_card.dart';

class BookingStepContactView extends StatelessWidget {
  final bool isPhoneContacted;
  final bool isReadOnly;
  final ValueChanged<bool> onPhoneContactedChanged;
  final VoidCallback onSaveOrUpdate;
  final VoidCallback onReadOnlyWarning;

  const BookingStepContactView({
    super.key,
    required this.isPhoneContacted,
    required this.isReadOnly,
    required this.onPhoneContactedChanged,
    required this.onSaveOrUpdate,
    required this.onReadOnlyWarning,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textPrimary = theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;
    final textSecondary = theme.textTheme.bodySmall?.color ?? theme.colorScheme.onSurfaceVariant;
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.stepContactOwner,
          style: TextStyle(
            color: textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.stepContactOwnerDesc,
          maxLines: 5,
          style: TextStyle(color: textSecondary, fontSize: 13),
        ),
        const SizedBox(height: 16),
        BookingChecklistCard(
          title: l10n.phoneContacted,
          subtitle: l10n.phoneContactedSubtitle,
          badgeText: isPhoneContacted ? l10n.done : null,
          icon: Icons.phone,
          isSelected: isPhoneContacted,
          onTap: () {
            if (isReadOnly) {
              onReadOnlyWarning();
              return;
            }
            onPhoneContactedChanged(!isPhoneContacted);
            onSaveOrUpdate();
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../extensions/l10n/l10n.dart';
import 'booking_checklist_card.dart';
import 'animated_visitor_counter_card.dart';

class BookingStepInspectView extends StatelessWidget {
  final bool isVisited;
  final bool isReadOnly;
  final String roomId;
  final ValueChanged<bool> onVisitedChanged;
  final VoidCallback onSaveOrUpdate;
  final VoidCallback onReadOnlyWarning;

  const BookingStepInspectView({
    super.key,
    required this.isVisited,
    required this.isReadOnly,
    required this.roomId,
    required this.onVisitedChanged,
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
          l10n.stepInspectRoom,
          style: TextStyle(
            color: textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.stepInspectRoomDesc,
          style: TextStyle(color: textSecondary, fontSize: 13),
        ),
        const SizedBox(height: 16),
        BookingChecklistCard(
          title: l10n.roomVisited,
          subtitle: l10n.roomVisitedSubtitle,
          badgeText: isVisited ? l10n.visitedBadge : null,
          icon: Icons.location_on,
          isSelected: isVisited,
          onTap: () {
            if (isReadOnly) {
              onReadOnlyWarning();
              return;
            }
            onVisitedChanged(!isVisited);
            onSaveOrUpdate();
          },
        ),
        const SizedBox(height: 16),
        AnimatedVisitorCounterCard(
          isVisited: isVisited,
          roomId: roomId,
        ),
      ],
    );
  }
}

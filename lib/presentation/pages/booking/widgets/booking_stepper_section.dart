import 'package:flutter/material.dart';
import '../../../../domain/domain.dart';

class BookingStepperSection extends StatelessWidget {
  final BookingEntity? booking;

  const BookingStepperSection({super.key, this.booking});

  @override
  Widget build(BuildContext context) {
    final status = booking?.status ?? 'draft';
    final isPhoneContacted = booking?.isPhoneContacted ?? false;
    final isVisited = booking?.isVisited ?? false;
    final isConfirmed = status == 'confirmed';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepItem(
          context,
          stepNumber: '1',
          label: 'Contact',
          isActive: true,
          isCompleted: isPhoneContacted,
        ),
        _buildConnectorLine(context, isDone: isPhoneContacted),
        _buildStepItem(
          context,
          stepNumber: '2',
          label: 'Visit',
          isActive: isPhoneContacted,
          isCompleted: isVisited,
        ),
        _buildConnectorLine(context, isDone: isVisited || isConfirmed),
        _buildStepItem(
          context,
          stepNumber: '3',
          label: 'Confirm',
          isActive: isVisited || isConfirmed,
          isCompleted: isConfirmed,
        ),
      ],
    );
  }

  Widget _buildStepItem(
    BuildContext context, {
    required String stepNumber,
    required String label,
    required bool isActive,
    required bool isCompleted,
  }) {
    final theme = Theme.of(context);
    final primaryAccent = theme.colorScheme.primary;
    final textPrimary = theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;
    final textSecondary = theme.textTheme.bodySmall?.color ?? theme.colorScheme.onSurfaceVariant;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted
                ? primaryAccent
                : isActive
                    ? primaryAccent.withAlpha(51)
                    : theme.disabledColor.withOpacity(0.2),
            border: Border.all(
              color: isActive ? primaryAccent : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Center(
            child: isCompleted
                ? Icon(Icons.check, color: theme.colorScheme.onPrimary, size: 16)
                : Text(
                    stepNumber,
                    style: TextStyle(
                      color: isActive ? primaryAccent : textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight:
                isActive || isCompleted ? FontWeight.w600 : FontWeight.w400,
            color:
                isCompleted || isActive ? textPrimary : textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildConnectorLine(BuildContext context, {required bool isDone}) {
    final theme = Theme.of(context);
    return Container(
      width: 40,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 6).copyWith(bottom: 18),
      color: isDone ? theme.colorScheme.primary : theme.disabledColor.withOpacity(0.2),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepData {
  final String label;
  final IconData icon;
  const StepData(this.label, this.icon);
}

class AppStepper extends StatelessWidget {
  final List<StepData> steps;
  final int activeStep;
  final ValueChanged<int>? onStepTapped; // null = not tappable

  const AppStepper({
    super.key,
    required this.steps,
    required this.activeStep,
    this.onStepTapped,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      color: theme.cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            _StepIndicator(
              step: steps[i],
              isActive: activeStep == i,
              isDone: activeStep > i,
              onTap: onStepTapped == null ? null : () => onStepTapped!(i),
            ),
            if (i < steps.length - 1) _StepConnector(isDone: activeStep > i),
          ],
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final StepData step;
  final bool isActive;
  final bool isDone;
  final VoidCallback? onTap;

  const _StepIndicator({
    required this.step,
    required this.isActive,
    required this.isDone,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final textPrimary =
        theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;
    final textSecondary =
        theme.textTheme.bodySmall?.color ?? theme.colorScheme.onSurfaceVariant;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDone || isActive
                  ? primary
                  : theme.disabledColor.withOpacity(0.2),
              border: Border.all(
                color: isActive ? primary : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Center(
              child: Icon(
                isDone ? Icons.check : step.icon,
                size: 18,
                color: isDone || isActive
                    ? theme.colorScheme.onPrimary
                    : textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            step.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
              color: isActive ? textPrimary : textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StepConnector extends StatelessWidget {
  final bool isDone;
  const _StepConnector({required this.isDone});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 18),
        color: isDone
            ? theme.colorScheme.primary
            : theme.disabledColor.withOpacity(0.2),
      ),
    );
  }
}
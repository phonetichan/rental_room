import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../styles/colors.dart';

class DashboardSectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const DashboardSectionTitle(this.title, {super.key, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    final text = Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : AppColors.clrBlack,
      ),
    );

    if (onSeeAll == null) return text;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        text,
        TextButton(
          onPressed: onSeeAll,
          child: Text(
            l10n.seeAll,
            style: const TextStyle(
              color: Color(0xFF6C5CE7),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

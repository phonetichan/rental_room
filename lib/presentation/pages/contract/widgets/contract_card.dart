import 'package:flutter/material.dart';
import '../../../../domain/domain.dart';
import '../../../extensions/contract/contract_extensions.dart';
import '../../../styles/colors.dart';
import '../../../styles/design_system.dart';
import '../../../extensions/extensions.dart';
import 'contract_countdown_banner.dart';

class ContractCard extends StatelessWidget {
  final ContractEntity contract;
  final RoomEntity? room;
  final UserEntity currentUser;
  final VoidCallback? onTap;

  const ContractCard({
    super.key,
    required this.contract,
    this.room,
    required this.currentUser,
    this.onTap,
  });

  bool get isOwner => currentUser.role == UserRole.owner;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final styles = AppStyles(
      screenSize: MediaQuery.maybeOf(context)?.size,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
    );
    final theme = isDark ? styles.dark : styles.light;

    return Container(
      margin: EdgeInsets.only(bottom: styles.insets.sm),
      decoration: BoxDecoration(
        color: isDark ? AppColors.clrDarkSurface : AppColors.clrWhite,
        borderRadius: BorderRadius.circular(styles.corner.lg),
        border: Border.all(
          color: isDark
              ? AppColors.clrDarkerGrey.withAlpha(120)
              : AppColors.clrSoftGrey,
          width: 1,
        ),
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: Colors.black.withAlpha(80),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withAlpha(10),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(styles.corner.lg),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(styles.insets.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(styles.insets.xs),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.clrPrimary.withAlpha(40)
                            : AppColors.clrPrimaryLight.withAlpha(100),
                        borderRadius: BorderRadius.circular(styles.corner.md),
                      ),
                      child: Icon(
                        Icons.handshake_rounded,
                        color: isDark
                            ? AppColors.clrPrimaryLight
                            : AppColors.clrPrimary,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: styles.spacing.spacing200),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            room?.name ?? 'Rental Contract',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : null,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: styles.spacing.spacing50),
                          Text(
                            'Duration: ${contract.durationMonth} Months',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isDark ? Colors.white60 : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: styles.spacing.spacing100),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: styles.insets.xs,
                        vertical: styles.insets.xxs,
                      ),
                      decoration: BoxDecoration(
                        color: (isDark ? AppColors.clrPrimaryLight : AppColors.clrPrimary).withAlpha(25),
                        borderRadius: BorderRadius.circular(styles.corner.lg),
                        border: Border.all(
                          color: (isDark ? AppColors.clrPrimaryLight : AppColors.clrPrimary).withAlpha(80),
                        ),
                      ),
                      child: const Text(
                        'Contracted',
                        style: TextStyle(
                          color: AppColors.clrPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: styles.spacing.spacing300),
                Container(
                  padding: EdgeInsets.all(styles.insets.sm),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.clrOffBlack.withAlpha(180)
                        : AppColors.clrSofterGrey,
                    borderRadius: BorderRadius.circular(styles.corner.md),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.payments_outlined,
                            size: 18,
                            color: isDark ? Colors.white70 : AppColors.clrDarkGrey,
                          ),
                          SizedBox(width: styles.spacing.spacing100),
                          Text(
                            'Monthly Rent',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isDark ? Colors.white70 : AppColors.clrDarkGrey,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            contract.monthlyRent.toKsLabelFormat,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.clrPrimaryLight : AppColors.clrPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (contract.countsForBadge) ...[
                  SizedBox(height: styles.spacing.spacing200),
                  Row(
                    children: [
                      ContractCountdownBanner(contract: contract),
                      const Spacer(),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: isDark ? Colors.white60 : AppColors.clrDarkGrey,
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

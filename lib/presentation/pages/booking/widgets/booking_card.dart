import 'package:flutter/material.dart';
import '../../contract/widgets/contract_countdown_banner.dart';
import '../../../../domain/domain.dart';
import '../../../extensions/extensions.dart';
import '../../../styles/colors.dart';
import '../../../styles/design_system.dart';

class BookingCard extends StatelessWidget {
  final BookingEntity booking;
  final UserEntity currentUser;
  final VoidCallback onBookingUpdated;
  final VoidCallback? onTap;
  final ContractEntity? contract;

  const BookingCard({
    super.key,
    required this.booking,
    required this.currentUser,
    required this.onBookingUpdated,
    this.contract,
    this.onTap,
  });

  bool get isOwner => currentUser.role == UserRole.owner;

  @override
  Widget build(BuildContext context) {
    // 1. Instantiate AppStyles according to screen dimensions & current theme mode
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
          splashColor: isDark
              ? AppColors.clrPrimary.withAlpha(30)
              : AppColors.clrPrimaryLight.withAlpha(50),
          highlightColor: isDark
              ? Colors.white.withAlpha(10)
              : Colors.black.withAlpha(5),
          onTap: onTap, // Handled directly by parent
          // onTap: onTap ?? () => _navigateToDetails(context),
          child: Padding(
            padding: EdgeInsets.all(styles.insets.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
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
                        border: isDark
                            ? Border.all(
                                color: AppColors.clrPrimary.withAlpha(80),
                                width: 1,
                              )
                            : null,
                      ),
                      child: Icon(
                        Icons.house_rounded,
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
                            (booking.roomName != null &&
                                    booking.roomName!.isNotEmpty)
                                ? booking.roomName!.capitalizeWords
                                : (booking.id.length > 8
                                      ? 'Booking #${booking.id.substring(0, 8)}'
                                      : 'Booking #${booking.id}'),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : null,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (booking.createdAt != null) ...[
                            SizedBox(height: styles.spacing.spacing50),
                            Text(
                              'Requested ${booking.createdAt!.day}/${booking.createdAt!.month}/${booking.createdAt!.year}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: isDark ? Colors.white60 : null,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(width: styles.spacing.spacing100),
                    _buildStatusChip(
                      styles,
                      (contract?.effectiveStatus == ContractStatus.expired)
                          ? 'expired'
                          : (contract != null && contract?.status == ContractStatus.active)
                              ? 'contracted'
                              : booking.status,
                      isDark,
                    ),
                  ],
                ),

                SizedBox(height: styles.spacing.spacing300),

                // Info Section
                Container(
                  padding: EdgeInsets.all(styles.insets.sm),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.clrOffBlack.withAlpha(180)
                        : AppColors.clrSofterGrey,
                    borderRadius: BorderRadius.circular(styles.corner.md),
                    border: isDark
                        ? Border.all(
                            color: Colors.white.withAlpha(12),
                            width: 1,
                          )
                        : null,
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow(
                        theme: theme,
                        styles: styles,
                        isDark: isDark,
                        icon: isOwner
                            ? Icons.person_outline_rounded
                            : Icons.phone_android_rounded,
                        label: isOwner ? 'Tenant' : 'Contact Phone',
                        value: isOwner
                            ? (booking.tenantName ?? 'Tenant User')
                            : (booking.tenantPhone ?? 'N/A'),
                      ),
                      if (booking.roomPrice != null) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: styles.insets.xs,
                          ),
                          child: Divider(
                            height: 1,
                            color: isDark
                                ? Colors.white.withAlpha(20)
                                : AppColors.clrSoftGrey,
                          ),
                        ),
                        _buildInfoRow(
                          theme: theme,
                          styles: styles,
                          isDark: isDark,
                          icon: Icons.payments_outlined,
                          label: 'Room Price',
                          value: booking.roomPrice!.toKsLabelFormat,
                          isHighlight: true,
                        ),
                      ],
                    ],
                  ),
                ),

                // Contract countdown: only while days are left
                if (contract != null && contract!.countsForBadge) ...[
                  SizedBox(height: styles.spacing.spacing200),
                  Row(
                    children: [
                      ContractCountdownBanner(contract: contract!),
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

  Widget _buildInfoRow({
    required ThemeData theme,
    required AppStyles styles,
    required bool isDark,
    required IconData icon,
    required String label,
    required String value,
    bool isHighlight = false,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: isDark ? Colors.white70 : AppColors.clrDarkGrey,
        ),
        SizedBox(width: styles.spacing.spacing100),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDark ? Colors.white70 : AppColors.clrDarkGrey,
          ),
        ),
        const Spacer(),
        Text(
          value,
          textAlign: TextAlign.end,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
            color: isHighlight
                ? (isDark ? AppColors.clrPrimaryLight : AppColors.clrPrimary)
                : (isDark ? Colors.white : null),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(AppStyles styles, String status, bool isDark) {
    late Color chipColor;
    late String label;

    switch (status.toLowerCase()) {
      case 'pending':
        chipColor = isDark ? Colors.amberAccent : Colors.amber.shade700;
        label = 'Pending';
        break;
      case 'confirmed':
      case 'success':
        chipColor = isDark ? AppColors.clrPrimaryLight : AppColors.clrPrimary;
        label = 'Confirmed';
        break;
      case 'contracted':
        chipColor = isDark ? AppColors.clrPrimaryLight : AppColors.clrPrimary;
        label = 'Contracted';
        break;
      case 'cancelled':
        chipColor = isDark ? Colors.redAccent : Colors.red.shade700;
        label = 'Cancelled';
        break;
      case 'expired':
        chipColor = isDark ? Colors.redAccent : Colors.red.shade700;
        label = 'Expired';
        break;
      case 'draft':
      default:
        chipColor = isDark ? Colors.grey.shade400 : AppColors.clrGrey;
        label = status.toUpperCase();
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: styles.insets.xs,
        vertical: styles.insets.xxs,
      ),
      decoration: BoxDecoration(
        color: isDark ? chipColor.withAlpha(40) : chipColor.withAlpha(25),
        borderRadius: BorderRadius.circular(styles.corner.lg),
        border: Border.all(
          color: isDark ? chipColor.withAlpha(120) : chipColor.withAlpha(80),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: chipColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

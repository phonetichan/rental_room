// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../domain/domain.dart';
// import '../../../blocs/blocs.dart';
// import '../../../extensions/extensions.dart';
// import '../new_booking_view.dart';
//
// class BookingCard extends StatelessWidget {
//   final BookingEntity booking;
//   final UserEntity currentUser;
//   final VoidCallback onBookingUpdated;
//   final VoidCallback? onTap;
//
//   const BookingCard({
//     super.key,
//     required this.booking,
//     required this.currentUser,
//     required this.onBookingUpdated,
//     this.onTap,
//   });
//
//   bool get isOwner => currentUser.role == UserRole.owner;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         side: BorderSide(
//           color: theme.colorScheme.outlineVariant.withAlpha(128),
//         ),
//       ),
//       clipBehavior: Clip.antiAlias,
//       child: InkWell(
//         onTap: onTap ??
//             () async {
//               BookingCubit? bookingCubit;
//               try {
//                 bookingCubit = context.read<BookingCubit>();
//               } catch (_) {}
//
//               final updated = await Navigator.of(context).push<bool>(
//                 MaterialPageRoute(
//                   builder: (_) {
//                     if (bookingCubit != null) {
//                       return BlocProvider.value(
//                         value: bookingCubit,
//                         child: NewBookingView(
//                           booking: booking,
//                           currentUser: currentUser,
//                         ),
//                       );
//                     }
//                     return NewBookingView(
//                       booking: booking,
//                       currentUser: currentUser,
//                     );
//                   },
//                 ),
//               );
//
//               if (updated == true) {
//                 onBookingUpdated();
//               }
//             },
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header: Title (roomName) & Status Chip
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       (booking.roomName != null && booking.roomName!.isNotEmpty)
//                           ? booking.roomName!.capitalizeWords
//                           : (booking.id.length > 8
//                               ? 'Booking Ref #${booking.id.substring(0, 8)}'
//                               : 'Booking Ref #${booking.id}'),
//                       style: theme.textTheme.titleMedium?.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   _buildStatusChip(context, booking.status),
//                 ],
//               ),
//               const SizedBox(height: 12),
//
//               // Booking Details Section
//               if (booking.createdAt != null) ...[
//                 _buildInfoRow(
//                   context,
//                   icon: Icons.calendar_today_rounded,
//                   label: 'Requested On',
//                   value:
//                       '${booking.createdAt!.day}/${booking.createdAt!.month}/${booking.createdAt!.year}',
//                 ),
//                 const SizedBox(height: 8),
//               ],
//               _buildInfoRow(
//                 context,
//                 icon: isOwner
//                     ? Icons.person_outline_rounded
//                     : Icons.phone_android_rounded,
//                 label: isOwner ? 'Tenant' : 'Contact Phone',
//                 value: isOwner
//                     ? (booking.tenantName ?? 'Tenant User')
//                     : (booking.tenantPhone ?? 'N/A'),
//               ),
//               if (booking.roomPrice != null) ...[
//                 const SizedBox(height: 8),
//                 _buildInfoRow(
//                   context,
//                   icon: Icons.payments_outlined,
//                   label: 'Room Price',
//                   value: '${booking.roomPrice!.toStringAsFixed(0)} MMK',
//                   isHighlight: true,
//                 ),
//               ],
//
//               // Action Buttons Section
//               if (_shouldShowActions()) ...[
//                 const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 12),
//                   child: Divider(height: 1),
//                 ),
//                 _buildActionButtons(context),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//     required String value,
//     bool isHighlight = false,
//   }) {
//     final theme = Theme.of(context);
//     return Row(
//       children: [
//         Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant),
//         const SizedBox(width: 8),
//         Text(
//           '$label: ',
//           style: theme.textTheme.bodyMedium?.copyWith(
//             color: theme.colorScheme.onSurfaceVariant,
//           ),
//         ),
//         Expanded(
//           child: Text(
//             value,
//             textAlign: TextAlign.end,
//             style: theme.textTheme.bodyMedium?.copyWith(
//               fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
//               color: isHighlight
//                   ? theme.colorScheme.primary
//                   : theme.colorScheme.onSurface,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildStatusChip(BuildContext context, String status) {
//     Color color;
//     String label;
//
//     switch (status.toLowerCase()) {
//       case 'pending':
//         color = Colors.orange;
//         label = 'Pending';
//         break;
//       case 'confirmed':
//         color = Colors.green;
//         label = 'Confirmed';
//         break;
//       case 'cancelled':
//         color = Colors.red;
//         label = 'Cancelled';
//         break;
//       case 'draft':
//       default:
//         color = Colors.grey;
//         label = status.toUpperCase();
//         break;
//     }
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: color.withAlpha(30),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: color.withAlpha(80)),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           color: color,
//           fontSize: 12,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
//
//   bool _shouldShowActions() {
//     final status = booking.status.toLowerCase();
//     if (status == 'cancelled') return false;
//     if (isOwner) {
//       return status == 'pending' || status == 'draft';
//     } else {
//       // Tenants do not show action buttons in the booking list card
//       return false;
//     }
//   }
//
//   Future<void> _updateStatus(
//     BuildContext context,
//     String newStatus,
//     String actionTitle,
//     String confirmMessage,
//   ) async {
//     final confirm = await showDialog<bool>(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text(actionTitle),
//         content: Text(
//           confirmMessage,
//           maxLines: 3,
//           overflow: TextOverflow.ellipsis, // Clips smoothly if it exceeds 3 lines
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(ctx).pop(false),
//             child: const Text('No'),
//           ),
//           ElevatedButton(
//             onPressed: () => Navigator.of(ctx).pop(true),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: newStatus == 'cancelled'
//                   ? Colors.red
//                   : Theme.of(context).colorScheme.primary,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('Yes'),
//           ),
//         ],
//       ),
//     );
//
//     if (confirm == true && context.mounted) {
//       final updated = booking.copyWith(status: newStatus);
//       context.read<BookingCubit>().updateBooking(updated);
//     }
//   }
//
//   Widget _buildActionButtons(BuildContext context) {
//     if (isOwner) {
//       if (booking.status.toLowerCase() == 'confirmed') {
//         return const SizedBox.shrink();
//       }
//       return SizedBox(
//         width: double.infinity,
//         child: ElevatedButton(
//           onPressed: () => _updateStatus(
//             context,
//             'confirmed',
//             'Accept Booking',
//             'Are you sure you want to accept this booking request?',
//           ),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Theme.of(context).colorScheme.primary,
//             foregroundColor: Colors.white,
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           child: const Text('Accept & Confirm'),
//         ),
//       );
//     }
//
//     return const SizedBox.shrink();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/di.dart';
import '../../../../domain/domain.dart';
import '../../../blocs/blocs.dart';
import '../../../extensions/extensions.dart';
import '../../../styles/colors.dart';
import '../../../styles/design_system.dart';

class BookingCard extends StatelessWidget {
  final BookingEntity booking;
  final UserEntity currentUser;
  final VoidCallback onBookingUpdated;
  final VoidCallback? onTap;

  const BookingCard({
    super.key,
    required this.booking,
    required this.currentUser,
    required this.onBookingUpdated,
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
                    _buildStatusChip(styles, booking.status, isDark),
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
                          value: '${booking.roomPrice!.toStringAsFixed(0)} MMK',
                          isHighlight: true,
                        ),
                      ],
                    ],
                  ),
                ),

                // Action Buttons Section
                if (_shouldShowActions()) ...[
                  SizedBox(height: styles.spacing.spacing300),
                  _buildActionButtons(context, styles, theme, isDark),
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
      case 'cancelled':
        chipColor = isDark ? Colors.redAccent : Colors.red.shade700;
        label = 'Cancelled';
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

  bool _shouldShowActions() {
    final status = booking.status.toLowerCase();
    if (isOwner) {
      return status == 'pending' || status == 'draft';
    } else {
      return status == 'cancelled';
    }
  }

  Future<void> _updateStatus(
    BuildContext context,
    AppStyles styles,
    String newStatus,
    String actionTitle,
    String confirmMessage,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(styles.corner.lg),
        ),
        title: Text(actionTitle),
        content: Text(
          confirmMessage,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: newStatus == 'cancelled'
                  ? AppColors.clrRed
                  : AppColors.clrPrimary,
              foregroundColor: AppColors.clrWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(styles.corner.md),
              ),
            ),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      final updated = booking.copyWith(status: newStatus);
      context.read<BookingCubit>().updateBooking(updated);

      if (newStatus.toLowerCase() == 'confirmed') {
        try {
          // 1. Update room status to 'rented'
          final roomRepo = inject<RoomRepository>();
          final room = await roomRepo.getRoomById(booking.roomId);
          if (room != null) {
            final rentedRoom = room.copyWith(
              status: 'rented',
              updatedAt: DateTime.now(),
            );
            await roomRepo.updateRoom(rentedRoom);
          }

          // 2. Create automatic contract (minimum duration 3 months)
          final contractUseCase = inject<CreateContractUseCase>();
          final now = DateTime.now();

          int targetYear = now.year;
          int targetMonth = now.month + 3;
          while (targetMonth > 12) {
            targetMonth -= 12;
            targetYear += 1;
          }
          int targetDay = now.day;
          final lastDayOfMonth = DateTime(targetYear, targetMonth + 1, 0).day;
          if (targetDay > lastDayOfMonth) targetDay = lastDayOfMonth;
          final endDate = DateTime(targetYear, targetMonth, targetDay);

          final contract = ContractEntity(
            id: '',
            bookingId: booking.id,
            roomId: booking.roomId,
            ownerId: booking.ownerId ?? '',
            tenantId: booking.userId,
            startDate: now,
            endDate: endDate,
            durationMonth: 3,
            monthlyRent: booking.roomPrice ?? 0.0,
            description:
                'Standard Rental Agreement for ${booking.roomName}. Minimum duration 3 months.',
            createdAt: now,
          );
          await contractUseCase(contract);

          // 3. Cancel other pending/draft requests for this room so user2 and user3 know it's rented
          final bookingRepo = inject<BookingRepository>();
          await bookingRepo.cancelOtherPendingBookingsForRoom(
            booking.roomId,
            booking.id,
          );
        } catch (_) {}
      }

      onBookingUpdated();
    }
  }

  Widget _buildActionButtons(
    BuildContext context,
    AppStyles styles,
    ThemeData theme,
    bool isDark,
  ) {
    if (isOwner) {
      if (booking.status.toLowerCase() == 'confirmed') {
        return const SizedBox.shrink();
      }
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => _updateStatus(
            context,
            styles,
            'confirmed',
            'Accept Booking',
            'Are you sure you want to accept this booking request?',
          ),
          icon: const Icon(Icons.check_circle_rounded, size: 18),
          label: const Text(
            'Accept & Confirm',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark
                ? AppColors.clrPrimary
                : AppColors.clrPrimary,
            foregroundColor: AppColors.clrWhite,
            elevation: isDark ? 4 : 1,
            shadowColor: isDark ? AppColors.clrPrimary.withAlpha(100) : null,
            padding: EdgeInsets.symmetric(vertical: styles.insets.sm),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(styles.corner.md),
            ),
          ),
        ),
      );
    }

    if (!isOwner && booking.status.toLowerCase() == 'cancelled') {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(styles.corner.lg),
                ),
                title: const Text('Remove Request'),
                content: const Text(
                  'Are you sure you want to remove this rental request from your list?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: const Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Yes, Remove'),
                  ),
                ],
              ),
            );

            if (confirm == true && context.mounted) {
              await context.read<BookingCubit>().deleteBooking(booking.id);
              onBookingUpdated();
            }
          },
          icon: const Icon(Icons.delete_outline_rounded, size: 18),
          label: const Text(
            'Remove from List',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.redAccent,
            side: const BorderSide(color: Colors.redAccent),
            padding: EdgeInsets.symmetric(vertical: styles.insets.sm),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(styles.corner.md),
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

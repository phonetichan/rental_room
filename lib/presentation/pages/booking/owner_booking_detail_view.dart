// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../../data/data.dart';
// import '../../../di/di.dart';
// import '../../../domain/domain.dart';
// import '../../blocs/blocs.dart';
// import 'widgets/widgets.dart';
//
// class OwnerBookingDetailView extends StatefulWidget {
//   static const String routeName = 'owner-booking-detail';
//   static const String routePath = '/owner-booking-detail';
//   final BookingEntity booking;
//   final UserEntity currentUser;
//
//   const OwnerBookingDetailView({
//     super.key,
//     required this.booking,
//     required this.currentUser,
//   });
//
//   @override
//   State<OwnerBookingDetailView> createState() => _OwnerBookingDetailViewState();
// }
//
// class _OwnerBookingDetailViewState extends State<OwnerBookingDetailView> {
//   late BookingEntity _currentBooking;
//   final ISnackShower _snackShower = inject<ISnackShower>();
//
//   @override
//   void initState() {
//     super.initState();
//     _currentBooking = widget.booking;
//   }
//
//   Future<void> _makeCall(String phone) async {
//     final uri = Uri.parse('tel:$phone');
//     try {
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri);
//       } else if (mounted) {
//         _snackShower.error(context: context, message: 'Could not call $phone');
//       }
//     } catch (e) {
//       if (mounted) {
//         _snackShower.error(context: context, message: 'Error making call: $e');
//       }
//     }
//   }
//
//   Future<void> _updateStatus(String newStatus, String actionTitle) async {
//     final updated = _currentBooking.copyWith(status: newStatus);
//     context.read<BookingCubit>().updateBooking(updated);
//
//     if (newStatus.toLowerCase() == 'confirmed') {
//       try {
//         // 1. Update room status to 'rented'
//         final roomRepo = inject<RoomRepository>();
//         final room = await roomRepo.getRoomById(_currentBooking.roomId);
//         if (room != null) {
//           final rentedRoom = room.copyWith(status: 'rented', updatedAt: DateTime.now());
//           await roomRepo.updateRoom(rentedRoom);
//         }
//
//         // 2. Create automatic contract (minimum duration 3 months)
//         final contractUseCase = inject<CreateContractUseCase>();
//         final now = DateTime.now();
//
//         int targetYear = now.year;
//         int targetMonth = now.month + 3;
//         while (targetMonth > 12) {
//           targetMonth -= 12;
//           targetYear += 1;
//         }
//         int targetDay = now.day;
//         final lastDayOfMonth = DateTime(targetYear, targetMonth + 1, 0).day;
//         if (targetDay > lastDayOfMonth) targetDay = lastDayOfMonth;
//         final endDate = DateTime(targetYear, targetMonth, targetDay);
//
//         final contract = ContractEntity(
//           id: '',
//           bookingId: _currentBooking.id,
//           roomId: _currentBooking.roomId,
//           ownerId: _currentBooking.ownerId ?? '',
//           tenantId: _currentBooking.userId,
//           startDate: now,
//           endDate: endDate,
//           durationMonth: 3,
//           monthlyRent: _currentBooking.roomPrice ?? 0.0,
//           description: 'Standard Rental Agreement for ${_currentBooking.roomName}. Minimum duration 3 months.',
//           createdAt: now,
//         );
//         await contractUseCase(contract);
//
//         // 3. Cancel other pending/draft requests for this room so user2 and user3 know it's rented
//         final bookingRepo = inject<BookingRepository>();
//         await bookingRepo.cancelOtherPendingBookingsForRoom(_currentBooking.roomId, _currentBooking.id);
//       } catch (_) {}
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final backgroundColor = theme.scaffoldBackgroundColor;
//     final cardBackground = theme.cardColor;
//     final textPrimary = theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;
//     final primaryAccent = theme.colorScheme.primary;
//     final isConfirmed = _currentBooking.status.toLowerCase() == 'confirmed';
//     final isCancelled = _currentBooking.status.toLowerCase() == 'cancelled';
//
//     return BlocListener<BookingCubit, BookingState>(
//       listener: (context, state) {
//         state.maybeWhen(
//           success: (message, updatedBooking) {
//             if (updatedBooking != null) {
//               setState(() {
//                 _currentBooking = updatedBooking;
//               });
//             }
//             if (message.isNotEmpty) {
//               _snackShower.success(context: context, message: message);
//             }
//           },
//           failure: (message) {
//             _snackShower.error(context: context, message: message);
//           },
//           orElse: () {},
//         );
//       },
//       child: Scaffold(
//         backgroundColor: backgroundColor,
//         appBar: AppBar(
//           backgroundColor: backgroundColor,
//           elevation: 0,
//           leading: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: CircleAvatar(
//               backgroundColor: cardBackground,
//               child: IconButton(
//                 icon: Icon(Icons.arrow_back, color: textPrimary, size: 20),
//                 onPressed: () => Navigator.of(context).pop(true),
//               ),
//             ),
//           ),
//           title: Text(
//             'Booking Request Details',
//             style: TextStyle(
//               color: textPrimary,
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),
//           centerTitle: true,
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Room & Tenant Info Card
//                 BookingRoomInfoCard(
//                   booking: _currentBooking,
//                   currentUser: widget.currentUser,
//                   onMakeCall: _makeCall,
//                 ),
//                 const SizedBox(height: 24),
//
//                 // Status info
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: cardBackground,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: theme.dividerColor),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Request Status',
//                         style: TextStyle(
//                           color: theme.textTheme.bodySmall?.color,
//                           fontSize: 13,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         isCancelled
//                             ? 'ALREADY RENTED'
//                             : _currentBooking.status.toUpperCase(),
//                         style: TextStyle(
//                           color: isConfirmed
//                               ? Colors.green
//                               : isCancelled
//                                   ? Colors.red
//                                   : primaryAccent,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Spacer(),
//
//                 // Owner Confirm / Accept Action
//                 if (!isConfirmed && !isCancelled) ...[
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: primaryAccent,
//                         foregroundColor: theme.colorScheme.onPrimary,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       icon: const Icon(Icons.check_circle, size: 20),
//                       label: const Text(
//                         'Accept & Confirm Booking',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       onPressed: () => _updateStatus('confirmed', 'Accept Booking'),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/data.dart';
import '../../../di/di.dart';
import '../../../domain/domain.dart';
import '../../blocs/blocs.dart';
import 'widgets/widgets.dart';

class OwnerBookingDetailView extends StatefulWidget {
  static const String routeName = 'owner-booking-detail';
  static const String routePath = '/owner-booking-detail';

  final BookingEntity booking;
  final UserEntity currentUser;

  const OwnerBookingDetailView({
    super.key,
    required this.booking,
    required this.currentUser,
  });

  @override
  State<OwnerBookingDetailView> createState() => _OwnerBookingDetailViewState();
}

class _OwnerBookingDetailViewState extends State<OwnerBookingDetailView> {
  late BookingEntity _currentBooking;
  final ISnackShower _snackShower = inject<ISnackShower>();

  @override
  void initState() {
    super.initState();
    _currentBooking = widget.booking;
  }

  Future<void> _makeCall(String phone) async {
    final uri = Uri.parse('tel:$phone');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else if (mounted) {
        _snackShower.error(context: context, message: 'Could not launch phone dialer for $phone');
      }
    } catch (e) {
      if (mounted) {
        _snackShower.error(context: context, message: 'Error placing phone call: $e');
      }
    }
  }

  Future<void> _handleStatusUpdate(String newStatus) async {
    final updated = _currentBooking.copyWith(status: newStatus);
    context.read<BookingCubit>().updateBooking(updated);

    if (newStatus.toLowerCase() == 'confirmed') {
      try {
        final roomRepo = inject<RoomRepository>();
        final room = await roomRepo.getRoomById(_currentBooking.roomId);
        if (room != null) {
          final rentedRoom = room.copyWith(
            status: 'rented',
            updatedAt: DateTime.now(),
          );
          await roomRepo.updateRoom(rentedRoom);
        }

        final contractUseCase = inject<CreateContractUseCase>();
        final now = DateTime.now();
        final endDate = DateTime(now.year, now.month + 3, now.day);

        final contract = ContractEntity(
          id: '',
          bookingId: _currentBooking.id,
          roomId: _currentBooking.roomId,
          ownerId: _currentBooking.ownerId ?? '',
          tenantId: _currentBooking.userId,
          startDate: now,
          endDate: endDate,
          durationMonth: 3,
          monthlyRent: _currentBooking.roomPrice ?? 0.0,
          description:
          'Standard Rental Agreement for ${_currentBooking.roomName}. Minimum duration 3 months.',
          createdAt: now,
        );
        await contractUseCase(contract);

        final bookingRepo = inject<BookingRepository>();
        await bookingRepo.cancelOtherPendingBookingsForRoom(
          _currentBooking.roomId,
          _currentBooking.id,
        );
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final status = _currentBooking.status.toLowerCase();
    final isConfirmed = status == 'confirmed';
    final isCancelled = status == 'cancelled';
    final isPending = !isConfirmed && !isCancelled;

    return BlocListener<BookingCubit, BookingState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (message, updatedBooking) {
            if (updatedBooking != null) {
              setState(() {
                _currentBooking = updatedBooking;
              });
            }
            if (message.isNotEmpty) {
              _snackShower.success(context: context, message: message);
            }
          },
          failure: (message) {
            _snackShower.error(context: context, message: message);
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: colorScheme.surfaceContainer,
        appBar: AppBar(
          backgroundColor: colorScheme.surface,
          elevation: 0,
          scrolledUnderElevation: 0.5,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
            onPressed: () => Navigator.of(context).pop(true),
          ),
          title: Text(
            'Booking Request',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildStatusBanner(context, status),
                    const SizedBox(height: 16),
                    BookingRoomInfoCard(
                      booking: _currentBooking,
                      currentUser: widget.currentUser,
                      onMakeCall: _makeCall,
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryCard(context),
                  ],
                ),
              ),
              if (isPending) _buildBottomActionBar(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBanner(BuildContext context, String status) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color containerColor;
    Color contentColor;
    IconData icon;
    String title;
    String subtitle;

    switch (status) {
      case 'confirmed':
      case 'success':
        containerColor = colorScheme.primaryContainer;
        contentColor = colorScheme.onPrimaryContainer;
        icon = Icons.check_circle_rounded;
        title = 'Booking Confirmed';
        subtitle = 'Contract created & room marked as rented.';
        break;
      case 'cancelled':
        containerColor = colorScheme.errorContainer;
        contentColor = colorScheme.onErrorContainer;
        icon = Icons.cancel_rounded;
        title = 'Request Cancelled';
        subtitle = 'This rental request was cancelled.';
        break;
      case 'pending':
      default:
        containerColor = Colors.amber.shade100;
        contentColor = Colors.amber.shade900;
        icon = Icons.pending_actions_rounded;
        title = 'Pending Approval';
        subtitle = 'Review applicant information before accepting.';
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: contentColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: contentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: contentColor.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final price = _currentBooking.roomPrice ?? 0.0;
    final formattedPrice = NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(price);

    return Card(
      elevation: 0,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rental Terms',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              context,
              icon: Icons.calendar_month_outlined,
              label: 'Standard Contract Term',
              value: '3 Months Minimum',
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1),
            ),
            _buildInfoRow(
              context,
              icon: Icons.payments_outlined,
              label: 'Monthly Rent',
              value: formattedPrice,
              isHighlighted: true,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1),
            ),
            _buildInfoRow(
              context,
              icon: Icons.security_outlined,
              label: 'Security Deposit',
              value: formattedPrice,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
        bool isHighlighted = false,
      }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Icon(icon, size: 20, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 12),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isHighlighted ? colorScheme.primary : colorScheme.onSurface,
            fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActionBar(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final status = _currentBooking.status.toLowerCase();
    final isConfirmed = status == 'confirmed';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.5)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isConfirmed) ...[
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => _handleStatusUpdate('confirmed'),
              child: const Text('Accept Booking'),
            ),
            const SizedBox(height: 8),
          ],
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              foregroundColor: Colors.redAccent,
              side: const BorderSide(color: Colors.redAccent),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.cancel_outlined, size: 20),
            label: Text(isConfirmed ? 'Cancel / Remove Booking' : 'Cancel Request'),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Cancel Booking'),
                  content: const Text('Are you sure you want to cancel and delete this booking request?'),
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
                      child: const Text('Yes, Cancel'),
                    ),
                  ],
                ),
              );

              if (confirm == true && context.mounted) {
                await context.read<BookingCubit>().deleteBooking(_currentBooking.id);
                if (context.mounted) {
                  Navigator.of(context).pop(true);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
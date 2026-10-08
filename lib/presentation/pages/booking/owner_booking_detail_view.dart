// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../../data/data.dart';
// import '../../../di/di.dart';
// import '../../../domain/domain.dart';
// import '../../../domain/entity/contract_status.dart';
// import '../../blocs/blocs.dart';
// import '../contract/widgets/contract_voucher_card.dart';
// import 'widgets/widgets.dart';
//
// import 'package:cached_network_image/cached_network_image.dart';

// class OwnerBookingDetailView extends StatefulWidget {
//   static const String routeName = 'owner-booking-detail';
//   static const String routePath = '/owner-booking-detail';
//
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
//   ContractEntity? _contract;
//   bool _isLoadingContract = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _currentBooking = widget.booking;
//     _loadContract();
//   }
//
//   Future<void> _loadContract() async {
//     try {
//       final getContractUseCase = inject<GetContractByBookingUseCase>();
//       final result = await getContractUseCase(_currentBooking.id);
//       result.onSuccess((contract) {
//         if (mounted) {
//           setState(() {
//             _contract = contract;
//             _isLoadingContract = false;
//           });
//         }
//       });
//     } catch (_) {
//       if (mounted) {
//         setState(() {
//           _isLoadingContract = false;
//         });
//       }
//     }
//   }
//
//   Future<void> _makeCall(String phone) async {
//     final uri = Uri.parse('tel:$phone');
//     try {
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri);
//       } else if (mounted) {
//         _snackShower.error(context: context, message: 'Could not launch phone dialer for $phone');
//       }
//     } catch (e) {
//       if (mounted) {
//         _snackShower.error(context: context, message: 'Error placing phone call: $e');
//       }
//     }
//   }
//
//   Future<void> _handleAcceptBooking() async {
//     // 1. Update status to 'confirmed' (waiting for tenant to contract)
//     final updated = _currentBooking.copyWith(
//       status: 'confirmed',
//       isReadByTenant: false,
//       isReadByOwner: true,
//     );
//     await context.read<BookingCubit>().updateBooking(updated);
//
//     try {
//       // 2. Update room status to 'rented'
//       final roomRepo = inject<RoomRepository>();
//       final room = await roomRepo.getRoomById(_currentBooking.roomId);
//       if (room != null) {
//         final rentedRoom = room.copyWith(
//           status: 'rented',
//           updatedAt: DateTime.now(),
//         );
//         await roomRepo.updateRoom(rentedRoom);
//       }
//
//       // 3. Create initial contract draft for tenant to contract
//       final contractUseCase = inject<CreateContractUseCase>();
//       final now = DateTime.now();
//       final endDate = DateTime(now.year, now.month + 3, now.day);
//
//       final contract = ContractEntity(
//         id: '',
//         bookingId: _currentBooking.id,
//         roomId: _currentBooking.roomId,
//         ownerId: _currentBooking.ownerId ?? '',
//         tenantId: _currentBooking.userId,
//         startDate: now,
//         endDate: endDate,
//         durationMonth: 3,
//         monthlyRent: _currentBooking.roomPrice ?? 0.0,
//         description:
//         'Standard Rental Agreement for ${_currentBooking.roomName ?? 'Room'}. Minimum duration 3 months.',
//         status: ContractStatus.pending,
//         createdAt: now,
//       );
//       final createResult = await contractUseCase(contract);
//       createResult.onSuccess((created) {
//         if (mounted) {
//           setState(() {
//             _contract = created;
//           });
//         }
//       });
//
//       // 4. Cancel other pending bookings for this room
//       final bookingRepo = inject<BookingRepository>();
//       await bookingRepo.cancelOtherPendingBookingsForRoom(
//         _currentBooking.roomId,
//         _currentBooking.id,
//       );
//     } catch (e) {
//       _snackShower.error(context: context, message: 'Error confirming booking: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//
//     final status = _currentBooking.status.toLowerCase();
//     final isPending = status == 'pending' || status == 'draft';
//     final isConfirmed = status == 'confirmed';
//     final isContracted = status == 'contracted' || status == 'voucher_ready';
//     final isCancelled = status == 'cancelled';
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
//         backgroundColor: colorScheme.surfaceContainer,
//         appBar: AppBar(
//           backgroundColor: colorScheme.surface,
//           elevation: 0,
//           scrolledUnderElevation: 0.5,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
//             onPressed: () => Navigator.of(context).pop(true),
//           ),
//           title: Text(
//             'Booking Request Details',
//             style: theme.textTheme.titleMedium?.copyWith(
//               fontWeight: FontWeight.bold,
//               color: colorScheme.onSurface,
//             ),
//           ),
//           centerTitle: true,
//         ),
//         body: SafeArea(
//           child: Column(
//             children: [
//               Expanded(
//                 child: ListView(
//                   physics: const BouncingScrollPhysics(),
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   children: [
//                     _buildStatusBanner(context, status),
//                     const SizedBox(height: 16),
//                     BookingRoomInfoCard(
//                       booking: _currentBooking,
//                       currentUser: widget.currentUser,
//                       onMakeCall: _makeCall,
//                     ),
//                     const SizedBox(height: 16),
//                     if (isContracted && _contract != null) ...[
//                       // Concept 2: After tenant contracts, show voucher readable ONLY in owner side
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 8),
//                         child: Text(
//                           'Contract Voucher (Owner View)',
//                           style: theme.textTheme.titleSmall?.copyWith(
//                             fontWeight: FontWeight.bold,
//                             color: colorScheme.primary,
//                           ),
//                         ),
//                       ),
//                       ContractVoucherCard(contract: _contract!),
//                     ] else ...[
//                       _buildSummaryCard(context),
//                     ],
//                   ],
//                 ),
//               ),
//               if (isPending)
//                 _buildBottomActionBar(context)
//               else if (isConfirmed)
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: colorScheme.surface,
//                     border: Border(
//                       top: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.5)),
//                     ),
//                   ),
//                   child: Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(14),
//                     decoration: BoxDecoration(
//                       color: colorScheme.primaryContainer.withOpacity(0.4),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.hourglass_top_rounded, color: colorScheme.primary, size: 20),
//                         const SizedBox(width: 8),
//                         Text(
//                           'Waiting for tenant to contract...',
//                           style: theme.textTheme.bodyMedium?.copyWith(
//                             color: colorScheme.primary,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatusBanner(BuildContext context, String status) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//
//     Color containerColor;
//     Color contentColor;
//     IconData icon;
//     String title;
//     String subtitle;
//
//     switch (status) {
//       case 'contracted':
//       case 'voucher_ready':
//         containerColor = colorScheme.primaryContainer;
//         contentColor = colorScheme.onPrimaryContainer;
//         icon = Icons.verified_rounded;
//         title = 'Contract Finalized';
//         subtitle = 'Tenant has contracted. Voucher is ready below.';
//         break;
//       case 'confirmed':
//         containerColor = Colors.blue.shade100;
//         contentColor = Colors.blue.shade900;
//         icon = Icons.hourglass_top_rounded;
//         title = 'Waiting for Tenant';
//         subtitle = 'Booking accepted. Waiting for tenant to sign contract.';
//         break;
//       case 'cancelled':
//         containerColor = colorScheme.errorContainer;
//         contentColor = colorScheme.onErrorContainer;
//         icon = Icons.cancel_rounded;
//         title = 'Request Cancelled';
//         subtitle = 'This rental request was cancelled.';
//         break;
//       case 'pending':
//       default:
//         containerColor = Colors.amber.shade100;
//         contentColor = Colors.amber.shade900;
//         icon = Icons.pending_actions_rounded;
//         title = 'Pending Approval';
//         subtitle = 'Review applicant information before accepting.';
//         break;
//     }
//
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: containerColor,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: contentColor, size: 24),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: theme.textTheme.titleSmall?.copyWith(
//                     color: contentColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   subtitle,
//                   style: theme.textTheme.bodySmall?.copyWith(
//                     color: contentColor.withOpacity(0.85),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSummaryCard(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//     final price = _currentBooking.roomPrice ?? 0.0;
//     final formattedPrice = NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(price);
//
//     return Card(
//       elevation: 0,
//       color: colorScheme.surface,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         side: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.5)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Rental Terms',
//               style: theme.textTheme.titleMedium?.copyWith(
//                 fontWeight: FontWeight.bold,
//                 color: colorScheme.onSurface,
//               ),
//             ),
//             const SizedBox(height: 16),
//             _buildInfoRow(
//               context,
//               icon: Icons.calendar_month_outlined,
//               label: 'Standard Contract Term',
//               value: '3 Months Minimum',
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 12),
//               child: Divider(height: 1),
//             ),
//             _buildInfoRow(
//               context,
//               icon: Icons.payments_outlined,
//               label: 'Monthly Rent',
//               value: formattedPrice,
//               isHighlighted: true,
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 12),
//               child: Divider(height: 1),
//             ),
//             _buildInfoRow(
//               context,
//               icon: Icons.security_outlined,
//               label: 'Security Deposit',
//               value: formattedPrice,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(
//       BuildContext context, {
//         required IconData icon,
//         required String label,
//         required String value,
//         bool isHighlighted = false,
//       }) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//
//     return Row(
//       children: [
//         Icon(icon, size: 20, color: colorScheme.onSurfaceVariant),
//         const SizedBox(width: 12),
//         Text(
//           label,
//           style: theme.textTheme.bodyMedium?.copyWith(
//             color: colorScheme.onSurfaceVariant,
//           ),
//         ),
//         const Spacer(),
//         Text(
//           value,
//           style: theme.textTheme.bodyMedium?.copyWith(
//             color: isHighlighted ? colorScheme.primary : colorScheme.onSurface,
//             fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildBottomActionBar(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.surface,
//         border: Border(
//           top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5)),
//         ),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           FilledButton(
//             style: FilledButton.styleFrom(
//               minimumSize: const Size.fromHeight(48),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             onPressed: _handleAcceptBooking,
//             child: const Text('Accept & Confirm Booking'),
//           ),
//           const SizedBox(height: 8),
//           OutlinedButton.icon(
//             style: OutlinedButton.styleFrom(
//               minimumSize: const Size.fromHeight(48),
//               foregroundColor: Colors.redAccent,
//               side: const BorderSide(color: Colors.redAccent),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             icon: const Icon(Icons.cancel_outlined, size: 20),
//             label: const Text('Reject Request'),
//             onPressed: () async {
//               final confirm = await showDialog<bool>(
//                 context: context,
//                 builder: (ctx) => AlertDialog(
//                   title: const Text('Reject Booking'),
//                   content: const Text('Are you sure you want to reject and delete this booking request?'),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.of(ctx).pop(false),
//                       child: const Text('No'),
//                     ),
//                     ElevatedButton(
//                       onPressed: () => Navigator.of(ctx).pop(true),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.red,
//                         foregroundColor: Colors.white,
//                       ),
//                       child: const Text('Yes, Reject'),
//                     ),
//                   ],
//                 ),
//               );
//
//               if (confirm == true && context.mounted) {
//                 await context.read<BookingCubit>().deleteBooking(_currentBooking.id);
//                 if (context.mounted) {
//                   Navigator.of(context).pop(true);
//                 }
//               }
//             },
//           ),
//         ],
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
import '../../styles/colors.dart';
import '../../extensions/extensions.dart';

import 'package:cached_network_image/cached_network_image.dart';

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

  ContractEntity? _contract;
  UserModel? _tenantUser;
  UserModel? _ownerUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _currentBooking = widget.booking;
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    try {
      final getContractUseCase = inject<GetContractByBookingUseCase>();
      final authDataSource = inject<AuthDataSource>();

      // 1. Fetch Contract Data
      final contractResult = await getContractUseCase(_currentBooking.id);

      ContractEntity? fetchedContract;
      contractResult.onSuccess((contract) {
        fetchedContract = contract;
      });

      final tenantId = fetchedContract?.tenantId ?? _currentBooking.userId;
      final ownerId = fetchedContract?.ownerId ?? _currentBooking.ownerId;

      // 2. Fetch Tenant & Owner Profiles in parallel
      final results = await Future.wait([
        authDataSource.getUserById(tenantId),
        if (ownerId != null && ownerId.isNotEmpty)
          authDataSource.getUserById(ownerId)
        else
          Future.value(null),
      ]);

      if (mounted) {
        setState(() {
          _contract = fetchedContract;
          _tenantUser = results[0];
          _ownerUser = results[1];
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _makeCall(String phone) async {
    final uri = Uri.parse('tel:$phone');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else if (mounted) {
        _snackShower.error(
          context: context,
          message: 'Could not launch phone dialer for $phone',
        );
      }
    } catch (e) {
      if (mounted) {
        _snackShower.error(
          context: context,
          message: 'Error placing phone call: $e',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final favCount = context.select<FavoriteCubit, int>(
          (cubit) => cubit.state.getFavoriteCount(_currentBooking.roomId),
    );

    return Scaffold(
      backgroundColor: AppColors.clrWhite,
      appBar: AppBar(
        backgroundColor: AppColors.clrWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        title: Text(
          'Voucher',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            // 1. ROOM HEADER CARD
            _buildPropertyHeaderCard(context, favCount),
            const SizedBox(height: 24),

            // 2. PERIOD DURATION SECTION
            _buildPeriodSection(context),
            const SizedBox(height: 24),

            // 3. TENANT INFO CARD
            if (_tenantUser != null) ...[
              _buildUserCard(
                context,
                title: 'Tenant Details',
                userName: _tenantUser!.name,
                userImage: _tenantUser!.image,
                phoneNumber: _tenantUser!.phoneNumber,
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 24),
            ],

            // 4. OWNER INFO CARD
            if (_ownerUser != null) ...[
              _buildUserCard(
                context,
                title: 'Owner Details',
                userName: _ownerUser!.name,
                userImage: _ownerUser!.image,
                phoneNumber: _ownerUser!.phoneNumber,
                icon: Icons.real_estate_agent_outlined,
              ),
              const SizedBox(height: 24),
            ],

            // 5. PRICE DETAILS SECTION
            _buildPriceDetailsSection(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  /// Reusable Card component for displaying Tenant / Owner Information
  Widget _buildUserCard(
      BuildContext context, {
        required String title,
        required String userName,
        required String? userImage,
        required String phoneNumber,
        required IconData icon,
      }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.clrBlack,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.clrWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.clrSoftGrey),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // User Avatar Profile Picture
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: userImage != null && userImage.isNotEmpty
                    ? CachedNetworkImage(
                  imageUrl: userImage,
                  width: 52,
                  height: 52,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 52,
                    height: 52,
                    color: const Color(0xFFF3EDF7),
                    child: const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                      ),
                    ),
                  ),
                  errorWidget: (_, __, ___) => _buildDefaultAvatar(),
                )
                    : _buildDefaultAvatar(),
              ),
              const SizedBox(width: 14),

              // Username & Phone Number
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.clrBlack,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      phoneNumber.isNotEmpty ? phoneNumber : 'No phone provided',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.clrDarkGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Phone Call Quick Action Button
              if (phoneNumber.isNotEmpty)
                IconButton(
                  onPressed: () => _makeCall(phoneNumber),
                  icon: const Icon(
                    Icons.phone_outlined,
                    color: Color(0xFF7B51D3),
                  ),
                  tooltip: 'Call $userName',
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      width: 52,
      height: 52,
      color: const Color(0xFFF3EDF7),
      child: const Icon(
        Icons.person_rounded,
        color: Color(0xFF7B51D3),
        size: 28,
      ),
    );
  }

  /// Property Header Card with Saves Count
  Widget _buildPropertyHeaderCard(BuildContext context, int favCount) {
    final theme = Theme.of(context);
    final price = _contract?.monthlyRent ?? _currentBooking.roomPrice ?? 0.0;
    final formattedPrice = price.toKsLabelFormat;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.clrWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.clrSoftGrey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _currentBooking.roomImageUrl != null &&
                _currentBooking.roomImageUrl!.isNotEmpty
                ? CachedNetworkImage(
              imageUrl: _currentBooking.roomImageUrl!,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 90,
                height: 90,
                color: AppColors.clrSofterGrey,
                child: const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 90,
                height: 90,
                color: AppColors.clrSofterGrey,
                child: Icon(
                  Icons.apartment_rounded,
                  size: 36,
                  color: AppColors.clrGrey,
                ),
              ),
            )
                : Container(
              width: 90,
              height: 90,
              color: AppColors.clrSofterGrey,
              child: Icon(
                Icons.apartment_rounded,
                size: 36,
                color: AppColors.clrGrey,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _currentBooking.roomName ?? 'Property Name',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.clrBlack,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: AppColors.clrGrey,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Location Address',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.clrGrey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$formattedPrice/month',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.clrBlack,
                      ),
                    ),
                    Text(
                      '$favCount ${favCount == 1 ? 'Save' : 'Saves'}',
                      key: ValueKey<int>(favCount),
                      style: TextStyle(
                        color: theme.colorScheme.error,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Period Section (Sourced from Contract dates)
  Widget _buildPeriodSection(BuildContext context) {
    final theme = Theme.of(context);

    String dateRangeText = 'N/A';
    if (_contract != null) {
      final startDateStr = DateFormat('dd MMM yyyy').format(_contract!.startDate);
      final endDateStr = DateFormat('dd MMM yyyy').format(_contract!.endDate);
      dateRangeText = '$startDateStr - $endDateStr';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Period',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.clrBlack,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF3EDF7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.calendar_month_outlined,
                color: Color(0xFF7B51D3),
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.clrGrey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  dateRangeText,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.clrBlack,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColors.clrGrey,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Make sure to check your date before making any sort of payments',
          style: theme.textTheme.bodySmall?.copyWith(
            color: AppColors.clrGrey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  /// Price Details Breakdown
  Widget _buildPriceDetailsSection(BuildContext context) {
    final theme = Theme.of(context);

    final durationMonths = _contract?.durationMonth ?? 1;
    final monthlyRent = _contract?.monthlyRent ?? _currentBooking.roomPrice ?? 0.0;
    final totalAmount = monthlyRent * durationMonths;

    final formattedMonthly = monthlyRent.toKsLabelFormat;
    final formattedTotal = totalAmount.toKsLabelFormat;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Details',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.clrBlack,
          ),
        ),
        const SizedBox(height: 16),
        _buildPriceRow(
          context,
          'Period time',
          '$durationMonths ${durationMonths == 1 ? 'Month' : 'Months'}',
        ),
        const SizedBox(height: 12),
        _buildPriceRow(context, 'Monthly payment', formattedMonthly),
        const SizedBox(height: 12),
        _buildPriceRow(context, 'Tax', '0 Ks'),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.clrBlack,
              ),
            ),
            Text(
              formattedTotal,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF7B51D3),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.clrGrey,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.clrBlack,
          ),
        ),
      ],
    );
  }
}
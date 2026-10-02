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
// class BookingDetailView extends StatelessWidget {
//   static const String routeName = 'booking-detail';
//   static const String routePath = '/booking-detail';
//   final BookingEntity booking;
//   final UserEntity currentUser;
//
//   const BookingDetailView({
//     super.key,
//     required this.booking,
//     required this.currentUser,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     BookingCubit? bookingCubit;
//     try {
//       bookingCubit = context.read<BookingCubit>();
//     } catch (_) {
//       bookingCubit = null;
//     }
//
//     if (bookingCubit != null) {
//       return BlocProvider.value(
//         value: bookingCubit,
//         child: _BookingDetailViewContent(
//           booking: booking,
//           currentUser: currentUser,
//         ),
//       );
//     }
//
//     return BlocProvider<BookingCubit>(
//       create: (context) => inject<BookingCubit>(),
//       child: _BookingDetailViewContent(
//         booking: booking,
//         currentUser: currentUser,
//       ),
//     );
//   }
// }
//
// class _BookingDetailViewContent extends StatefulWidget {
//   final BookingEntity booking;
//   final UserEntity currentUser;
//
//   const _BookingDetailViewContent({
//     required this.booking,
//     required this.currentUser,
//   });
//
//   @override
//   State<_BookingDetailViewContent> createState() =>
//       _BookingDetailViewContentState();
// }
//
// class _BookingDetailViewContentState extends State<_BookingDetailViewContent> {
//   late BookingEntity _currentBooking;
//   final ISnackShower _snackShower = inject<ISnackShower>();
//   Future<UserModel?>? _ownerFuture;
//
//   bool _isValidId(String? id) {
//     if (id == null) return false;
//     final trimmed = id.trim();
//     return trimmed.isNotEmpty && trimmed != 'null' && trimmed != 'UNDEFINED';
//   }
//
//   void _initOwnerFuture() {
//     final ownerId = widget.booking.ownerId;
//     if (_isValidId(ownerId)) {
//       _ownerFuture = inject<AuthDataSource>().getUserById(ownerId!.trim());
//     } else {
//       _ownerFuture = null;
//     }
//   }
//
//   Future<void> _makeCall(BuildContext context, String phone) async {
//     final uri = Uri.parse('tel:$phone');
//     try {
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri);
//       } else if (context.mounted) {
//         _snackShower.error(
//             context: context, message: 'Could not launch call for $phone');
//       }
//     } catch (e) {
//       if (context.mounted) {
//         _snackShower.error(
//             context: context, message: 'Error making call: $e');
//       }
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _currentBooking = widget.booking;
//     _initOwnerFuture();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final backgroundColor = theme.scaffoldBackgroundColor;
//     final cardBackground = theme.cardColor;
//     final textPrimary = theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;
//
//     return BlocListener<BookingCubit, BookingState>(
//       listener: (context, state) {
//         state.maybeWhen(
//           success: (message, updatedBooking) {
//             if (updatedBooking != null && mounted) {
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
//             'Booking Details',
//             style: TextStyle(
//               color: textPrimary,
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),
//           centerTitle: true,
//         ),
//         body: SafeArea(
//           child: Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Header Progress Tracker
//                       BookingStepperSection(booking: _currentBooking),
//                       const SizedBox(height: 24),
//
//                       // Room & Contact Information Card
//                       BookingRoomInfoCard(
//                         booking: _currentBooking,
//                         currentUser: widget.currentUser,
//                         ownerFuture: _ownerFuture,
//                         onMakeCall: (phone) => _makeCall(context, phone),
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Animated Visitor Counter Card
//                       AnimatedVisitorCounterCard(
//                         isVisited: _currentBooking.isVisited,
//                       ),
//                       const SizedBox(height: 24),
//
//                       BookingActionSection(
//                         booking: _currentBooking,
//                         currentUser: widget.currentUser,
//                         onConfirmBooking: () {
//                           final updated =
//                               _currentBooking.copyWith(status: 'confirmed');
//                           context.read<BookingCubit>().updateBooking(updated);
//                         },
//                         onCancelBooking: () async {
//                           final confirm = await showDialog<bool>(
//                             context: context,
//                             builder: (ctx) => AlertDialog(
//                               title: const Text('Cancel Booking'),
//                               content: const Text(
//                                   'Are you sure you want to cancel this booking request?'),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () => Navigator.of(ctx).pop(false),
//                                   child: const Text('No'),
//                                 ),
//                                 ElevatedButton(
//                                   onPressed: () => Navigator.of(ctx).pop(true),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.red,
//                                     foregroundColor: Colors.white,
//                                   ),
//                                   child: const Text('Yes, Cancel'),
//                                 ),
//                               ],
//                             ),
//                           );
//
//                           if (confirm == true && context.mounted) {
//                             final updated =
//                                 _currentBooking.copyWith(status: 'cancelled');
//                             context.read<BookingCubit>().updateBooking(updated);
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // Bottom Fixed Summary Bar
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: cardBackground,
//                   border: Border(top: BorderSide(color: theme.dividerColor)),
//                 ),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: theme.colorScheme.primary,
//                       foregroundColor: theme.colorScheme.onPrimary,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     onPressed: () => Navigator.of(context).pop(true),
//                     child: const Text(
//                       'Done',
//                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

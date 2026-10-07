import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/data.dart';
import '../../../di/di.dart';
import '../../../domain/domain.dart';
import '../../styles/colors.dart';
import '../../blocs/blocs.dart';
import '../../presentation.dart';
import 'widgets/widgets.dart';

class NewBookingView extends StatefulWidget {
  static const String routeName = 'new-booking';
  static const String routePath = '/new-booking';
  final RoomEntity? room;
  final BookingEntity? booking;
  final UserEntity currentUser;

  const NewBookingView({
    super.key,
    this.room,
    this.booking,
    required this.currentUser,
  });

  @override
  State<NewBookingView> createState() => _NewBookingViewState();
}

class _NewBookingViewState extends State<NewBookingView> {
  int _activeStep = 0;
  late bool _isPhoneContacted;
  late bool _isVisited;
  BookingEntity? _currentBooking;

  final ISnackShower _snackShower = inject<ISnackShower>();
  Future<UserModel?>? _ownerFuture;

  bool get _isReadOnly {
    final status = (_currentBooking?.status ?? '').toLowerCase();
    return status == 'pending' ||
        status == 'confirmed' ||
        status == 'cancelled';
  }

  @override
  void initState() {
    super.initState();
    _currentBooking = widget.booking;
    if (_isReadOnly) {
      _activeStep = 2;
      _isPhoneContacted = true;
      _isVisited = true;
    } else {
      _isPhoneContacted = widget.booking?.isPhoneContacted ?? false;
      _isVisited = widget.booking?.isVisited ?? false;
    }
    _initOwnerFuture();
  }

  RoomEntity get _resolvedRoom {
    if (widget.room != null) return widget.room!;
    final b = _currentBooking ?? widget.booking;
    return RoomEntity(
      id: b?.roomId ?? '',
      ownerId: b?.ownerId ?? '',
      roomTypeId: '',
      roomNumber: '',
      name: b?.roomName ?? 'Room Details',
      floor: '',
      maxGuests: 1,
      pricePerMonth: b?.roomPrice ?? 0.0,
      location: '',
      numberBedrooms: 1,
      roomSqft: 0.0,
      images: b?.roomImageUrl != null && b!.roomImageUrl!.isNotEmpty
          ? [
              RoomImageEntity(
                id: '',
                roomId: b.roomId,
                imageUrl: b.roomImageUrl!,
              ),
            ]
          : [],
    );
  }

  void _initOwnerFuture() {
    final ownerId = widget.room?.ownerId ?? widget.booking?.ownerId;
    if (ownerId != null &&
        ownerId.trim().isNotEmpty &&
        ownerId != 'null' &&
        ownerId != 'UNDEFINED') {
      _ownerFuture = inject<AuthDataSource>().getUserById(ownerId.trim());
    } else {
      _ownerFuture = null;
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
          message: 'Could not launch call for $phone',
        );
      }
    } catch (e) {
      if (mounted) {
        _snackShower.error(context: context, message: 'Error making call: $e');
      }
    }
  }

  void _saveOrUpdateBooking({bool silent = false}) {
    if (_isReadOnly) return;
    final room = _resolvedRoom;
    final newStatus = _currentBooking?.status ?? 'draft';

    if (_currentBooking != null && _currentBooking!.id.isNotEmpty) {
      final updated = _currentBooking!.copyWith(
        isPhoneContacted: _isPhoneContacted,
        isVisited: _isVisited,
        status: newStatus,
        isReadByOwner: false,
        isReadByTenant: true,
      );
      context.read<BookingCubit>().updateBooking(updated, silent: silent);
    } else if (_isPhoneContacted || _isVisited) {
      final newBooking = BookingEntity(
        id: '',
        roomId: room.id,
        userId: widget.currentUser.id,
        ownerId: room.ownerId,
        status: newStatus,
        isPhoneContacted: _isPhoneContacted,
        isVisited: _isVisited,
        isReadByOwner: false,
        isReadByTenant: true,
        createdAt: DateTime.now(),
        roomName: room.name,
        roomPrice: room.pricePerMonth,
        roomImageUrl: room.images.isNotEmpty
            ? room.images.first.imageUrl
            : null,
        tenantName: widget.currentUser.name,
        tenantPhone: widget.currentUser.phoneNumber,
      );
      context.read<BookingCubit>().createBooking(newBooking, silent: silent);
    }
  }

  void _submitBooking() {
    if (_isReadOnly) return;
    final room = _resolvedRoom;
    const newStatus = 'pending';

    if (_currentBooking != null && _currentBooking!.id.isNotEmpty) {
      final updated = _currentBooking!.copyWith(
        isPhoneContacted: _isPhoneContacted,
        isVisited: _isVisited,
        status: newStatus,
        isReadByOwner: false,
        isReadByTenant: true,
      );
      context.read<BookingCubit>().updateBooking(updated, silent: false);
    } else {
      final newBooking = BookingEntity(
        id: '',
        roomId: room.id,
        userId: widget.currentUser.id,
        ownerId: room.ownerId,
        status: newStatus,
        isPhoneContacted: _isPhoneContacted,
        isVisited: _isVisited,
        isReadByOwner: false,
        isReadByTenant: true,
        createdAt: DateTime.now(),
        roomName: room.name,
        roomPrice: room.pricePerMonth,
        roomImageUrl: room.images.isNotEmpty
            ? room.images.first.imageUrl
            : null,
        tenantName: widget.currentUser.name,
        tenantPhone: widget.currentUser.phoneNumber,
      );
      context.read<BookingCubit>().createBooking(newBooking, silent: false);
    }
  }

  Future<void> _cancelAndDeleteBooking() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Booking'),
        content: const Text(
          'Are you sure you want to cancel and delete this booking request?',
          maxLines: 3,
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
            child: const Text('Yes, Delete'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      if (_currentBooking != null && _currentBooking!.id.isNotEmpty) {
        context.read<BookingCubit>().deleteBooking(_currentBooking!.id);
      } else {
        Navigator.of(context).pop(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final backgroundColor = theme.scaffoldBackgroundColor;
    final cardBackground = theme.cardColor;
    final primaryAccent = theme.colorScheme.primary;
    final textPrimary =
        theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;
    final textSecondary =
        theme.textTheme.bodySmall?.color ?? theme.colorScheme.onSurfaceVariant;
    final borderColor = theme.dividerColor;

    final room = _resolvedRoom;

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
            if (message.contains('deleted') ||
                message.contains('cancelled') ||
                message.contains('created') ||
                message.contains('updated') ||
                message.contains('successfully')) {
              Navigator.of(context).pop(true);
            }
          },
          failure: (message) {
            _snackShower.error(context: context, message: message);
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: cardBackground,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: textPrimary, size: 20),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ),
          ),
          title: Text(
            _currentBooking != null && _currentBooking!.id.isNotEmpty
                ? 'Booking Steps & Details'
                : 'New Booking Request',
            style: TextStyle(
              color: textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Step Indicator Header
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                color: cardBackground,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStepIndicator(context, 0, 'Contact', Icons.phone),
                    _buildConnector(context, _activeStep >= 1),
                    _buildStepIndicator(context, 1, 'Visit', Icons.location_on),
                    _buildConnector(context, _activeStep >= 2),
                    _buildStepIndicator(
                      context,
                      2,
                      'Submit',
                      Icons.check_circle,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_isReadOnly) ...[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: (_currentBooking?.status.toLowerCase() == 'cancelled')
                                ? Colors.red.shade700
                                : (_currentBooking?.status.toLowerCase() == 'confirmed' || _currentBooking?.status.toLowerCase() == 'success')
                                    ? AppColors.clrPrimary
                                    : Colors.amber.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            (_currentBooking?.status.toLowerCase() == 'cancelled')
                                ? 'This room has already been rented by another tenant. This request is cancelled.'
                                : (_currentBooking?.status.toLowerCase() == 'confirmed' || _currentBooking?.status.toLowerCase() == 'success')
                                    ? 'Your booking request has been confirmed!'
                                    : 'This booking request has status "${_currentBooking?.status.toUpperCase()}" and needs approval from owner.',
                            maxLines: 4,
                            style: TextStyle(
                              color: (_currentBooking?.status.toLowerCase() == 'cancelled' || _currentBooking?.status.toLowerCase() == 'confirmed' || _currentBooking?.status.toLowerCase() == 'success')
                                  ? Colors.white
                                  : Colors.amber.shade900,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],

                      // Room Preview Card
                      BookingRoomInfoCard(
                        room: room,
                        booking: _currentBooking,
                        currentUser: widget.currentUser,
                        ownerFuture: _ownerFuture,
                        onMakeCall: _makeCall,
                      ),
                      const SizedBox(height: 16),

                      // Step Content based on _activeStep
                      if (_currentBooking?.status.toLowerCase() == 'cancelled') ...[
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(Icons.delete_outline_rounded),
                            label: const Text(
                              'Remove from List',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
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
                                await context.read<BookingCubit>().deleteBooking(_currentBooking!.id);
                                if (context.mounted) {
                                  Navigator.of(context).pop(true);
                                }
                              }
                            },
                          ),
                        ),
                      ] else if (_activeStep == 0) ...[
                        Text(
                          'Step 1: Contact Owner',
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Reach out to the property owner via phone call to discuss room availability and details. Once contacted, your booking draft will be created automatically.',
                          maxLines: 5,
                          style: TextStyle(color: textSecondary, fontSize: 13),
                        ),
                        const SizedBox(height: 16),
                        _NewBookingChecklistCard(
                          title: 'Phone Contacted',
                          subtitle: 'I have spoken with the owner by phone',
                          badgeText: _isPhoneContacted ? 'Done' : null,
                          icon: Icons.phone,
                          isSelected: _isPhoneContacted,
                          onTap: () {
                            if (_isReadOnly) {
                              _snackShower.info(
                                context: context,
                                message: 'Booking request is already submitted and cannot be changed.',
                              );
                              return;
                            }
                            setState(() {
                              _isPhoneContacted = !_isPhoneContacted;
                            });
                            _saveOrUpdateBooking(silent: true);
                            if (_isPhoneContacted) {
                              _snackShower.success(
                                context: context,
                                message: 'Phone call done',
                              );
                            }
                          },
                        ),
                      ] else if (_activeStep == 1) ...[
                        Text(
                          'Step 2: Inspect Room',
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Visit the property in person to inspect the room before finalizing your booking.',
                          style: TextStyle(color: textSecondary, fontSize: 13),
                        ),
                        const SizedBox(height: 16),
                        _NewBookingChecklistCard(
                          title: 'Room Visited',
                          subtitle: 'I have visited and inspected the room',
                          badgeText: _isVisited ? 'Visited' : null,
                          icon: Icons.location_on,
                          isSelected: _isVisited,
                          onTap: () async {
                            if (_isReadOnly) {
                              _snackShower.info(
                                context: context,
                                message: 'Booking request is already submitted and cannot be changed.',
                              );
                              return;
                            }
                            final nextVisitedState = !_isVisited;
                            setState(() {
                              _isVisited = nextVisitedState;
                            });

                            // Record or remove room view in DB to update visitor count
                            final roomId = _resolvedRoom.id;
                            final userId = widget.currentUser.id;
                            if (roomId.isNotEmpty && userId.isNotEmpty) {
                              if (nextVisitedState) {
                                await inject<RecordRoomViewUseCase>().call(
                                  RecordRoomViewParams(
                                    roomId: roomId,
                                    userId: userId,
                                  ),
                                );
                              } else {
                                await inject<RemoveRoomViewUseCase>().call(
                                  RemoveRoomViewParams(
                                    roomId: roomId,
                                    userId: userId,
                                  ),
                                );
                              }
                            }

                            if (!context.mounted) return;
                            _saveOrUpdateBooking(silent: true);
                            if (_isVisited) {
                              _snackShower.success(
                                context: context,
                                message: 'Visit done',
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        AnimatedVisitorCounterCard(
                          isVisited: _isVisited,
                          roomId: _resolvedRoom.id,
                        ),
                      ] else ...[
                        Text(
                          'Step 3: Review & Submit',
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Review your checklist and submit your booking request to the owner.',
                          style: TextStyle(color: textSecondary, fontSize: 13),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: cardBackground,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: borderColor),
                          ),
                          child: Column(
                            children: [
                              _buildReviewRow(
                                context,
                                'Phone Contacted',
                                _isPhoneContacted,
                              ),
                              Divider(color: borderColor, height: 24),
                              _buildReviewRow(
                                context,
                                'Room Visited',
                                _isVisited,
                              ),
                              Divider(color: borderColor, height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Monthly Rent',
                                    style: TextStyle(color: textSecondary),
                                  ),
                                  Text(
                                    '${room.pricePerMonth.toStringAsFixed(0)} MMK',
                                    style: TextStyle(
                                      color: primaryAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (_currentBooking?.status.toLowerCase() == 'confirmed') ...[
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryAccent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: const Icon(Icons.description_outlined),
                              label: const Text(
                                'View Rental Contract Voucher',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              onPressed: () {
                                context.pushNamed(
                                  ContractDetailPage.routeName,
                                  extra: _currentBooking!.id,
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        // Delete Booking Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _isReadOnly
                                  ? theme.disabledColor
                                  : Colors.redAccent,
                              side: BorderSide(
                                color: _isReadOnly
                                    ? theme.disabledColor
                                    : Colors.redAccent,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: Icon(
                              Icons.delete_outline,
                              size: 20,
                              color: _isReadOnly
                                  ? theme.disabledColor
                                  : Colors.redAccent,
                            ),
                            label: Text(
                              _isReadOnly
                                  ? 'Delete Disabled (Submitted)'
                                  : 'Delete Booking',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: _isReadOnly
                                    ? theme.disabledColor
                                    : Colors.redAccent,
                              ),
                            ),
                            onPressed: _isReadOnly
                                ? null
                                : _cancelAndDeleteBooking,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Bottom Navigation Bar
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardBackground,
                  border: Border(top: BorderSide(color: borderColor)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_activeStep > 0)
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: textPrimary,
                          // Explicitly remove all borders and outlines
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide.none,
                          ),
                        ),
                        // Disables tap action when _isReadOnly is true
                        onPressed: _isReadOnly
                            ? null
                            : () {
                                setState(() {
                                  _activeStep--;
                                });
                              },
                        child: const Text(
                          'Back',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isReadOnly
                            ? theme.disabledColor
                            : primaryAccent,
                        foregroundColor: theme.colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _isReadOnly
                          ? null
                          : () {
                              if (_activeStep < 2) {
                                if (_activeStep == 0 && !_isPhoneContacted) {
                                  _snackShower.error(
                                    context: context,
                                    message:
                                        'Please complete Phone Contact first.',
                                  );
                                  return;
                                }
                                if (_activeStep == 1 && !_isVisited) {
                                  _snackShower.error(
                                    context: context,
                                    message:
                                        'Please complete Room Visited first.',
                                  );
                                  return;
                                }
                                setState(() {
                                  _activeStep++;
                                });
                              } else {
                                _submitBooking();
                              }
                            },
                      child: Text(
                        _isReadOnly
                            ? 'Request Submitted'
                            : (_activeStep < 2 ? 'Next' : 'Submit Request'),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator(
    BuildContext context,
    int stepIndex,
    String label,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    final isActive = _activeStep == stepIndex;
    final isDone = _activeStep > stepIndex;
    final primaryAccent = theme.colorScheme.primary;
    final textPrimary =
        theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;
    final textSecondary =
        theme.textTheme.bodySmall?.color ?? theme.colorScheme.onSurfaceVariant;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDone || isActive
                ? primaryAccent
                : theme.disabledColor.withOpacity(0.2),
            border: Border.all(
              color: isActive ? primaryAccent : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Center(
            child: isDone
                ? Icon(
                    Icons.check,
                    color: theme.colorScheme.onPrimary,
                    size: 18,
                  )
                : Icon(
                    icon,
                    color: isActive
                        ? theme.colorScheme.onPrimary
                        : textSecondary,
                    size: 18,
                  ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
            color: isActive ? textPrimary : textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildConnector(BuildContext context, bool isDone) {
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

  Widget _buildReviewRow(BuildContext context, String title, bool isCompleted) {
    final textPrimary = Theme.of(context).textTheme.bodyLarge?.color;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: textPrimary, fontSize: 15)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isCompleted
                ? Colors.green.withOpacity(0.15)
                : Colors.orange.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            isCompleted ? 'Completed' : 'Pending',
            style: TextStyle(
              color: isCompleted ? Colors.green : Colors.orange,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _NewBookingChecklistCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? badgeText;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NewBookingChecklistCard({
    required this.title,
    required this.subtitle,
    this.badgeText,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardBackground = theme.cardColor;
    final primaryAccent = theme.colorScheme.primary;
    final textPrimary =
        theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;
    final textSecondary =
        theme.textTheme.bodySmall?.color ?? theme.colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? primaryAccent : theme.dividerColor,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? primaryAccent : textSecondary,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (badgeText != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            badgeText!,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(color: textSecondary, fontSize: 12),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? primaryAccent : Colors.transparent,
                border: Border.all(
                  color: isSelected ? primaryAccent : textSecondary,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 14,
                      color: theme.colorScheme.onPrimary,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

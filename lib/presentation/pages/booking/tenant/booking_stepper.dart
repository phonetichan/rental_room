import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/data.dart';
import '../../../../di/di.dart';
import '../../../../domain/domain.dart';
import '../../../extensions/extensions.dart';
import '../../../presentation.dart';

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
      name: b?.roomName ?? context.l10n.roomDetails,
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
        roomImageUrl:
        room.images.isNotEmpty ? room.images.first.imageUrl : null,
        tenantName: widget.currentUser.name,
        tenantPhone: widget.currentUser.phoneNumber,
      );
      context.read<BookingCubit>().createBooking(newBooking, silent: silent);
    }
  }

  Future<void> _submitBooking() async {
    if (_isReadOnly) return;
    final l10n = context.l10n;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          l10n.submitRequest,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        content: Text(
          l10n.submitBookingRequestConfirm,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        actionsOverflowDirection: VerticalDirection.down,
        actionsOverflowButtonSpacing: 8,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(l10n.submit),
          ),
        ],
      ),
    );

    if (confirm != true || !mounted) return;

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
        roomImageUrl:
        room.images.isNotEmpty ? room.images.first.imageUrl : null,
        tenantName: widget.currentUser.name,
        tenantPhone: widget.currentUser.phoneNumber,
      );
      context.read<BookingCubit>().createBooking(newBooking, silent: false);
    }
  }

  Future<void> _cancelAndDeleteBooking() async {
    final l10n = context.l10n;
    final isOwner = widget.currentUser.role == UserRole.owner;
    final isAlreadyCancelled =
        _currentBooking?.status.toLowerCase() == 'cancelled';

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          isAlreadyCancelled
              ? l10n.removeRequest
              : (isOwner ? l10n.cancelRequest : l10n.deleteRequest),
        ),
        content: Text(
          isAlreadyCancelled
              ? l10n.removeRequestConfirmation
              : (isOwner
                  ? l10n.cancelRequestConfirmation
                  : l10n.deleteRequestConfirmation),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        actionsOverflowDirection: VerticalDirection.down,
        actionsOverflowButtonSpacing: 8,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text(
              isAlreadyCancelled
                  ? l10n.remove
                  : (isOwner ? l10n.cancelRequest : l10n.delete),
            ),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      if (_currentBooking != null && _currentBooking!.id.isNotEmpty) {
        if (isAlreadyCancelled) {
          await context.read<BookingCubit>().deleteBooking(
            _currentBooking!.id,
            isOwner: isOwner,
            silent: true,
          );
          if (mounted) {
            Navigator.of(context).pop(true);
          }
        } else {
          final updated = _currentBooking!.copyWith(status: 'cancelled');
          await context
              .read<BookingCubit>()
              .updateBooking(updated, silent: true);
          if (mounted) {
            Navigator.of(context).pop(true);
          }
        }
      } else {
        Navigator.of(context).pop(false);
      }
    }
  }

  Future<void> _confirmBooking() async {
    final l10n = context.l10n;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          l10n.confirmBooking,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        content: Text(
          l10n.acceptBookingConfirmation,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        actionsOverflowDirection: VerticalDirection.down,
        actionsOverflowButtonSpacing: 8,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      if (_currentBooking != null && _currentBooking!.id.isNotEmpty) {
        await context.read<BookingCubit>().confirmBooking(_currentBooking!);
        if (mounted) {
          Navigator.of(context).pop(true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    final backgroundColor = theme.scaffoldBackgroundColor;
    final cardBackground = theme.cardColor;
    final primaryAccent = theme.colorScheme.primary;
    final textPrimary =
        theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;
    final borderColor = theme.dividerColor;

    final room = _resolvedRoom;
    final statusLower = _currentBooking?.status.toLowerCase();

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
                ? l10n.bookingStepsAndDetails
                : l10n.bookingRequest,
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
              AppStepper(
                activeStep: _activeStep,
                steps: [
                  StepData(l10n.contact, Icons.phone),
                  StepData(l10n.visit, Icons.location_on),
                  StepData(l10n.submit, Icons.check_circle),
                ],
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
                            color: (statusLower == 'cancelled')
                                ? Colors.red.shade700
                                : (statusLower == 'confirmed' ||
                                statusLower == 'success')
                                ? AppColors.clrPrimary
                                : Colors.amber.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            (statusLower == 'cancelled')
                                ? l10n.roomAlreadyRentedNotice
                                : (statusLower == 'confirmed' ||
                                statusLower == 'success')
                                ? l10n.bookingRequestConfirmed
                                : l10n.bookingNeedsApproval(
                              _currentBooking?.status
                                  .toUpperCase() ??
                                  '',
                            ),
                            maxLines: 3,
                            style: TextStyle(
                              color: (statusLower == 'cancelled' ||
                                  statusLower == 'confirmed' ||
                                  statusLower == 'success')
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
                        onMakeCall: (phone) => phone.makeCall(context: context),
                      ),
                      const SizedBox(height: 16),

                      // Step Content based on _activeStep
                      if (statusLower == 'cancelled') ...[
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
                            label: Text(
                              l10n.removeFromList,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  title: Text(
                                    l10n.removeRequest,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  content: Text(
                                    l10n.removeRequestConfirmation,
                                    maxLines: 8,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  actionsOverflowDirection: VerticalDirection.down,
                                  actionsOverflowButtonSpacing: 8,
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(ctx).pop(false),
                                      child: Text(l10n.no),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => Navigator.of(ctx).pop(true),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                      ),
                                      child: Text(l10n.yesRemove),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true && context.mounted) {
                                final isOwner = widget.currentUser.role == UserRole.owner;
                                await context.read<BookingCubit>().deleteBooking(
                                  _currentBooking!.id,
                                  isOwner: isOwner,
                                  silent: true,
                                );
                                if (context.mounted) {
                                  Navigator.of(context).pop(true);
                                }
                              }
                            },
                          ),
                        ),
                      ] else if (_activeStep == 0) ...[
                        BookingStepContactView(
                          isPhoneContacted: _isPhoneContacted,
                          isReadOnly: _isReadOnly,
                          onPhoneContactedChanged: (val) {
                            setState(() {
                              _isPhoneContacted = val;
                            });
                            if (val) {
                              _snackShower.success(
                                context: context,
                                message: l10n.phoneCallDone,
                              );
                            }
                          },
                          onSaveOrUpdate: () =>
                              _saveOrUpdateBooking(silent: true),
                          onReadOnlyWarning: () {
                            _snackShower.info(
                              context: context,
                              message: l10n.bookingAlreadySubmitted,
                            );
                          },
                        ),
                      ] else if (_activeStep == 1) ...[
                        BookingStepInspectView(
                          isVisited: _isVisited,
                          isReadOnly: _isReadOnly,
                          roomId: _resolvedRoom.id,
                          onVisitedChanged: (val) async {
                            final nextVisitedState = val;
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
                            if (_isVisited) {
                              _snackShower.success(
                                context: context,
                                message: l10n.visitDone,
                              );
                            }
                          },
                          onSaveOrUpdate: () =>
                              _saveOrUpdateBooking(silent: true),
                          onReadOnlyWarning: () {
                            _snackShower.info(
                              context: context,
                              message: l10n.bookingAlreadySubmitted,
                            );
                          },
                        ),
                      ] else ...[
                        BookingStepReviewView(
                          isPhoneContacted: _isPhoneContacted,
                          isVisited: _isVisited,
                          monthlyRent: room.pricePerMonth,
                          isConfirmed: statusLower == 'confirmed',
                          isOwner: widget.currentUser.role == UserRole.owner,
                          isReadOnly: _isReadOnly,
                          onViewVoucher: () {
                            if (_currentBooking != null) {
                              context.pushNamed(
                                ContractUpdatePage.routeName,
                                extra: _currentBooking!.id,
                              );
                            }
                          },
                          onDeleteBooking: _cancelAndDeleteBooking,
                          onConfirmBooking: _confirmBooking,
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
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide.none,
                          ),
                        ),
                        onPressed: _isReadOnly
                            ? null
                            : () {
                          setState(() {
                            _activeStep--;
                          });
                        },
                        child: Text(
                          l10n.back,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        _isReadOnly ? theme.disabledColor : primaryAccent,
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
                              message: l10n.pleaseCompletePhoneContactFirst,
                            );
                            return;
                          }
                          if (_activeStep == 1 && !_isVisited) {
                            _snackShower.error(
                              context: context,
                              message: l10n.pleaseCompleteRoomVisitedFirst,
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
                            ? l10n.requestSubmitted
                            : (_activeStep < 2 ? l10n.next : l10n.submitRequest),
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
}
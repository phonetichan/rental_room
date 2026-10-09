import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data.dart';
import '../../../../di/injector.dart';
import '../../../../domain/domain.dart';
import '../../../blocs/blocs.dart';
import '../../../extensions/number.dart';
import '../../booking/booking_stepper.dart';
import '../owner/widgets/room_detail_screen.dart';

class TenantRoomDetailScreen extends StatefulWidget {
  static const String routeName = 'tenant-room-detail';
  static const String routePath = '/tenant-room-detail';

  final RoomEntity room;

  const TenantRoomDetailScreen({super.key, required this.room});

  @override
  State<TenantRoomDetailScreen> createState() => _TenantRoomDetailScreenState();
}

class _TenantRoomDetailScreenState extends State<TenantRoomDetailScreen> {
  late RoomEntity _room;
  List<Map<String, dynamic>> _amenitiesList = [];
  UserModel? _ownerUser;
  bool _isBookingLoading = false;
  final ISnackShower _snackShower = inject<ISnackShower>();

  @override
  void initState() {
    super.initState();
    _room = widget.room;
    _loadAmenities();
    _loadOwnerData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentUser = context.read<AuthenticationCubit>().user;
      if (currentUser != null && mounted) {
        context.read<FavoriteCubit>().loadFavorites(currentUser.id);
        try {
          context.read<BookingCubit>().fetchBookings(
                currentUser.id,
                userId: currentUser.id,
              );
        } catch (_) {}
      }
    });
  }

  Future<void> _loadAmenities() async {
    try {
      final repo = inject<RoomRepository>();
      final amenities = await repo.getAmenities();
      if (mounted) {
        setState(() => _amenitiesList = amenities);
      }
    } catch (_) {}
  }

  Future<void> _loadOwnerData() async {
    final ownerId = _room.ownerId;
    if (ownerId != null && ownerId.trim().isNotEmpty) {
      try {
        final owner = await inject<AuthDataSource>().getUserById(ownerId.trim());
        if (mounted) {
          setState(() => _ownerUser = owner);
        }
      } catch (_) {}
    }
  }

  Future<void> _handleBooking(UserEntity currentUser) async {
    setState(() => _isBookingLoading = true);
    BookingCubit? bookingCubit;
    try {
      bookingCubit = context.read<BookingCubit>();
    } catch (_) {}

    await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) {
          if (bookingCubit != null) {
            return BlocProvider.value(
              value: bookingCubit,
              child: NewBookingView(room: _room, currentUser: currentUser),
            );
          }
          return NewBookingView(room: _room, currentUser: currentUser);
        },
      ),
    );

    if (mounted) {
      try {
        context.read<BookingCubit>().fetchBookings(
              currentUser.id,
              userId: currentUser.id,
            );
      } catch (_) {}
      setState(() => _isBookingLoading = false);
    }
  }

  Future<void> _openExistingBooking(
    BookingEntity booking,
    UserEntity currentUser,
  ) async {
    BookingCubit? bookingCubit;
    try {
      bookingCubit = context.read<BookingCubit>();
    } catch (_) {}

    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) {
          if (bookingCubit != null) {
            return BlocProvider.value(
              value: bookingCubit,
              child: NewBookingView(booking: booking, currentUser: currentUser),
            );
          }
          return NewBookingView(booking: booking, currentUser: currentUser);
        },
      ),
    );

    if (result == true && mounted) {
      try {
        context.read<BookingCubit>().fetchBookings(
              currentUser.id,
              userId: currentUser.id,
            );
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<AuthenticationCubit>().user;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoomHeroHeader(
              room: _room,
              images: _room.images,
              currentUser: currentUser,
            ),
            _TenantRoomContentBody(
              room: _room,
              amenitiesList: _amenitiesList,
              ownerUser: _ownerUser,
            ),
          ],
        ),
      ),
      bottomNavigationBar: _TenantRoomBottomActionBar(
        room: _room,
        currentUser: currentUser,
        isBookingLoading: _isBookingLoading,
        onHandleBooking: (user) => _handleBooking(user),
        onOpenExistingBooking: (booking, user) => _openExistingBooking(booking, user),
      ),
    );
  }
}

// 1. Favorite Button Widget
class _TenantRoomFavoriteButton extends StatelessWidget {
  final RoomEntity room;
  final UserEntity? currentUser;

  const _TenantRoomFavoriteButton({
    required this.room,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) return const SizedBox.shrink();

    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, favoriteState) {
        final isFav = favoriteState.isFavorite(room.id);
        return Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.45),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            tooltip: isFav ? 'Remove from Saved' : 'Save Room',
            icon: Icon(
              isFav ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              color: isFav ? const Color(0xFFEF4444) : Colors.white,
              size: 22,
            ),
            onPressed: () {
              context.read<FavoriteCubit>().toggleFavorite(
                    roomId: room.id,
                    userId: currentUser!.id,
                    ownerId: room.ownerId,
                  );
            },
          ),
        );
      },
    );
  }
}

// 2. Content Body Widget
class _TenantRoomContentBody extends StatelessWidget {
  final RoomEntity room;
  final List<Map<String, dynamic>> amenitiesList;
  final UserModel? ownerUser;

  const _TenantRoomContentBody({
    required this.room,
    required this.amenitiesList,
    required this.ownerUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoomCollapsibleDescriptionSection(description: room.description),
          RoomOwnerInfoTile(ownerId: room.ownerId, owner: ownerUser),
          RoomAmenitiesSection(
            amenityIds: room.amenityIds,
            amenitiesList: amenitiesList,
          ),
          RoomLocationMapSection(room: room),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// 3. Bottom Action Bar Widget
class _TenantRoomBottomActionBar extends StatelessWidget {
  final RoomEntity room;
  final UserEntity? currentUser;
  final bool isBookingLoading;
  final ValueChanged<UserEntity> onHandleBooking;
  final void Function(BookingEntity booking, UserEntity currentUser) onOpenExistingBooking;

  const _TenantRoomBottomActionBar({
    required this.room,
    required this.currentUser,
    required this.isBookingLoading,
    required this.onHandleBooking,
    required this.onOpenExistingBooking,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Price',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                room.pricePerMonth.toKsFormat,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: BlocBuilder<BookingCubit, BookingState>(
              builder: (context, bookingState) {
                final existingBooking = bookingState.maybeWhen(
                  loaded: (bookings) {
                    try {
                      return bookings.firstWhere((b) => b.roomId == room.id);
                    } catch (_) {
                      return null;
                    }
                  },
                  orElse: () => null,
                );

                final isAlreadyBooked = existingBooking != null;

                return SizedBox(
                  height: 48,
                  child: isAlreadyBooked
                      ? OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: primaryColor,
                            side: BorderSide(color: primaryColor, width: 1.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {
                            if (currentUser != null) {
                              onOpenExistingBooking(existingBooking, currentUser!);
                            }
                          },
                          icon: const Icon(Icons.assignment_outlined, size: 20),
                          label: const Text(
                            'Request Detail',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: (isBookingLoading || currentUser == null)
                              ? null
                              : () => onHandleBooking(currentUser!),
                          icon: isBookingLoading
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.bookmark_add_outlined, size: 20),
                          label: const Text(
                            'Rent Now',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data.dart';
import '../../../../di/injector.dart';
import '../../../../domain/domain.dart';
import '../../../blocs/blocs.dart';
import '../../booking/tenant/booking_stepper.dart';
import '../widgets/widgets.dart';
import 'widgets/tenant_room_bottom_action_bar.dart';
import 'widgets/tenant_room_content_body.dart';

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
    if (ownerId.trim().isNotEmpty) {
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
            TenantRoomContentBody(
              room: _room,
              amenitiesList: _amenitiesList,
              ownerUser: _ownerUser,
            ),
          ],
        ),
      ),
      bottomNavigationBar: TenantRoomBottomActionBar(
        room: _room,
        currentUser: currentUser,
        isBookingLoading: _isBookingLoading,
        onHandleBooking: (user) => _handleBooking(user),
        onOpenExistingBooking: (booking, user) => _openExistingBooking(booking, user),
      ),
    );
  }
}

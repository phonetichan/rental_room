import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';
import '../../presentation.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/owner_dashboard_content.dart';

class DashboardView extends StatelessWidget {
  final UserEntity user;

  const DashboardView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isOwner = user.role == UserRole.owner;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<RoomCubit, RoomState>(
            builder: (context, roomState) {
              return BlocBuilder<BookingCubit, BookingState>(
                builder: (context, bookingState) {
                  int pendingCount = 0;

                  if (isOwner) {
                    final List<RoomEntity> ownerRooms = roomState.maybeWhen(
                      loaded: (rooms) =>
                          rooms.where((r) => r.ownerId == user.id).toList(),
                      orElse: () => [],
                    );

                    final List<BookingEntity> ownerBookings =
                        bookingState.maybeWhen(
                      loaded: (bookings) => bookings
                          .where((b) =>
                              b.ownerId == user.id ||
                              ownerRooms.any((r) => r.id == b.roomId))
                          .toList(),
                      orElse: () => [],
                    );

                    pendingCount = ownerBookings
                        .where((b) => b.status.trim().toLowerCase() == 'pending')
                        .length;
                  }

                  return DashboardHeader(
                    user: user,
                    isOwner: isOwner,
                    notificationCount: pendingCount,
                  );
                },
              );
            },
          ),
          if (isOwner) ...[
            const SizedBox(height: 20),
            OwnerDashboardContent(user: user),
          ],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_room/presentation/pages/dashboard/widgets/dashboard_content.dart';
import 'package:rental_room/presentation/pages/dashboard/widgets/dashboard_header.dart';
import 'package:rental_room/presentation/pages/profile/edit_location/edit_location.dart';
import '../../../domain/domain.dart';
import '../../presentation.dart';

class DashboardView extends StatelessWidget {
  final UserEntity user;

  const DashboardView({
    super.key,
    required this.user,
  });

  Future<void> _onRefresh(BuildContext context) async {
    final isOwner = user.role == UserRole.owner;
    context.read<RoomCubit>().fetchRooms(status: isOwner ? null : 'available');
    context.read<FavoriteCubit>().loadFavorites(user.id);
    if (isOwner) {
      await context.read<BookingCubit>().fetchBookings(user.id, ownerId: user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOwner = user.role == UserRole.owner;

    return RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardHeader(
              isOwner: isOwner,
              address: user.address,
              user: user,
              onLocationPressed: () => context.push(EditLocationScreen.routePath),
            ),
            const SizedBox(height: 20),
            DashboardContent(user: user),
          ],
        ),
      ),
    );
  }
}

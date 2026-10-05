import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/domain.dart';
import '../../../presentation.dart';
import 'dashboard_header.dart';
import 'owner_metric_cards.dart';
import 'owner_monthly_revenue_card.dart';

class OwnerDashboardContent extends StatefulWidget {
  final UserEntity user;

  const OwnerDashboardContent({super.key, required this.user});

  @override
  State<OwnerDashboardContent> createState() => _OwnerDashboardContentState();
}

class _OwnerDashboardContentState extends State<OwnerDashboardContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RoomCubit>().fetchRooms();
      context.read<FavoriteCubit>().loadFavorites(widget.user.id);
      context.read<BookingCubit>().fetchBookings(
            widget.user.id,
            ownerId: widget.user.id,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. OVERVIEW & METRIC CARDS
          Text(
            'Overview',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : AppColors.clrBlack,
            ),
          ),
          const SizedBox(height: 12),
          OwnerMetricsOverview(user: widget.user),

          const SizedBox(height: 28),

          // 2. MONTHLY REVENUE BAR CHART CARD
          OwnerMonthlyRevenueCard(user: widget.user),

          const SizedBox(height: 28),

          // 3. ROOM LIST / PROPERTIES SECTION
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Properties',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppColors.clrBlack,
                ),
              ),
              HeaderIconButton(
                icon: Icons.add_rounded,
                onPressed: () async {
                  await context.push(AddEditRoomScreen.routePath);
                  if (context.mounted) {
                    context.read<RoomCubit>().fetchRooms();
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          BlocBuilder<RoomCubit, RoomState>(
            builder: (context, state) {
              final List<RoomEntity> ownerRooms = state.maybeWhen(
                loaded: (rooms) =>
                    rooms.where((r) => r.ownerId == widget.user.id).toList(),
                orElse: () => [],
              );

              if (ownerRooms.isEmpty) {
                return Container(
                  height: 160,
                  alignment: Alignment.center,
                  child: Text(
                    'No properties listed yet.',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                );
              }

              return Column(
                children: ownerRooms
                    .map(
                      (room) => RoomCard(
                        room: room,
                        currentUser: widget.user,
                        showOwnerActions: true,
                        onRoomUpdated: () {
                          context.read<RoomCubit>().fetchRooms();
                        },
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

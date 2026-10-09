import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_room/di/di.dart';
import 'package:rental_room/presentation/pages/room/tenant/widgets/room_paginated_tab.dart';
import 'package:rental_room/presentation/pages/room/tenant/widgets/segmented_tab_bar.dart';

import '../../../../../domain/domain.dart';
import '../../../../blocs/blocs.dart';

class OwnerPostViewContent extends StatefulWidget {
  final UserEntity user;

  const OwnerPostViewContent({super.key, required this.user});

  @override
  State<OwnerPostViewContent> createState() => _OwnerPostViewContentState();
}

class _OwnerPostViewContentState extends State<OwnerPostViewContent>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final PaginatedCubit<RoomEntity> _availableRoomsCubit; // this owner's available rooms
  late final PaginatedCubit<RoomEntity> _rentedRoomsCubit;    // this owner's rented rooms

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    final repo = inject<RoomRepository>();

    _availableRoomsCubit = PaginatedCubit<RoomEntity>(
      fetcher: (cursor, limit) => repo.fetchRoomsPage(
        ownerId: widget.user.id,
        status: 'available',
        cursor: cursor,
        limit: limit,
      ),
    );

    _rentedRoomsCubit = PaginatedCubit<RoomEntity>(
      fetcher: (cursor, limit) => repo.fetchRoomsPage(
        ownerId: widget.user.id,
        status: 'rented',
        cursor: cursor,
        limit: limit,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshData());
  }

  @override
  void dispose() {
    _availableRoomsCubit.close();
    _rentedRoomsCubit.close();
    _tabController.dispose();
    super.dispose();
  }

  // Favorites reload too, so the "N Saves" badges stay current
  Future<void> _refreshData() async {
    _availableRoomsCubit.refresh();
    _rentedRoomsCubit.refresh();
    await context.read<FavoriteCubit>().loadFavorites(widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SegmentedTabBar(
          controller: _tabController,
          tabs: const [
            SegmentedTabItem(icon: Icons.meeting_room_outlined, label: 'Available'),
            SegmentedTabItem(icon: Icons.check_circle_outline, label: 'Rented'),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              RoomPaginatedTab(
                cubit: _availableRoomsCubit,
                user: widget.user,
                onRefresh: _refreshData,
                emptyIcon: Icons.no_meeting_room_outlined,
                emptyMessage: 'No available rooms found.',
              ),
              RoomPaginatedTab(
                cubit: _rentedRoomsCubit,
                user: widget.user,
                onRefresh: _refreshData,
                emptyIcon: Icons.check_circle_outline,
                emptyMessage: 'No rented rooms found.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
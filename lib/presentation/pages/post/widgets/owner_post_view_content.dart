// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'post_my_rooms_tab_widget.dart';
//
// import '../../../../domain/domain.dart';
// import '../../../presentation.dart';
//
// class OwnerPostViewContent extends StatefulWidget {
//   final UserEntity user;
//
//   const OwnerPostViewContent({super.key, required this.user});
//
//   @override
//   State<OwnerPostViewContent> createState() => _OwnerPostViewContentState();
// }
//
// class _OwnerPostViewContentState extends State<OwnerPostViewContent>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<RoomCubit>().fetchRooms();
//       context.read<FavoriteCubit>().loadFavorites(widget.user.id);
//     });
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return BlocBuilder<RoomCubit, RoomState>(
//       builder: (context, state) {
//         final allRooms = state.maybeWhen(
//           loaded: (list) => list,
//           orElse: () => <RoomEntity>[],
//         );
//
//         final availableRooms = allRooms.where((r) => r.status.toLowerCase() == 'available').toList();
//         final myRooms = allRooms.where((r) => r.ownerId == widget.user.id).toList();
//
//         return Column(
//           children: [
//             // SEGMENTED TAB BAR HEADER WITH ICONS (Rooms and My Rooms)
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: Container(
//                 height: 48,
//                 padding: const EdgeInsets.all(4),
//                 decoration: BoxDecoration(
//                   color: isDark
//                       ? Colors.white.withValues(alpha: 0.06)
//                       : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: isDark
//                         ? Colors.white.withValues(alpha: 0.08)
//                         : theme.dividerColor.withValues(alpha: 0.1),
//                   ),
//                 ),
//                 child: TabBar(
//                   controller: _tabController,
//                   indicatorSize: TabBarIndicatorSize.tab,
//                   dividerColor: Colors.transparent,
//                   labelPadding: EdgeInsets.zero,
//                   labelStyle: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   unselectedLabelStyle: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   labelColor: theme.colorScheme.primary,
//                   unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
//                   indicator: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: theme.colorScheme.primary.withValues(alpha: 0.12),
//                   ),
//                   tabs: const [
//                     Tab(
//                       height: 40,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.meeting_room_outlined, size: 18),
//                           SizedBox(width: 8),
//                           Text('Rooms'),
//                         ],
//                       ),
//                     ),
//                     Tab(
//                       height: 40,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.other_houses_outlined, size: 18),
//                           SizedBox(width: 8),
//                           Text('My Rooms'),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Expanded(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   // Tab 1: Available Rooms
//                   RefreshIndicator(
//                     onRefresh: () async {
//                       context.read<RoomCubit>().fetchRooms();
//                     },
//                     child: availableRooms.isEmpty
//                         ? ListView(
//                             children: const [
//                               SizedBox(height: 200),
//                               Center(child: Text('No rooms available.')),
//                             ],
//                           )
//                         : ListView.builder(
//                             itemCount: availableRooms.length,
//                             itemBuilder: (context, index) {
//                               final room = availableRooms[index];
//                               return RoomCard(
//                                 room: room,
//                                 currentUser: widget.user,
//                                 showOwnerActions: false,
//                                 onRoomUpdated: () => context.read<RoomCubit>().fetchRooms(),
//                               );
//                             },
//                           ),
//                   ),
//                   // Tab 2: My Rooms (with User Saved count)
//                   PostMyRoomsTabWidget(
//                     myRooms: myRooms,
//                     user: widget.user,
//                     onRefresh: () async {
//                       context.read<RoomCubit>().fetchRooms();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_room/di/di.dart';
import 'package:rental_room/presentation/pages/post/widgets/room_paginated_tab.dart';
import 'package:rental_room/presentation/pages/post/widgets/segmented_tab_bar.dart';

import '../../../../domain/domain.dart';
import '../../../presentation.dart';
// import your getIt file here

class OwnerPostViewContent extends StatefulWidget {
  final UserEntity user;

  const OwnerPostViewContent({super.key, required this.user});

  @override
  State<OwnerPostViewContent> createState() => _OwnerPostViewContentState();
}

class _OwnerPostViewContentState extends State<OwnerPostViewContent>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final PaginatedCubit<RoomEntity> _roomsCubit;   // all available rooms
  late final PaginatedCubit<RoomEntity> _myRoomsCubit; // this owner's rooms, any status

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    final repo = inject<RoomRepository>();

    _roomsCubit = PaginatedCubit<RoomEntity>(
      fetcher: (cursor, limit) => repo.fetchRoomsPage(
        status: 'available',
        cursor: cursor,
        limit: limit,
      ),
    );

    _myRoomsCubit = PaginatedCubit<RoomEntity>(
      fetcher: (cursor, limit) => repo.fetchRoomsPage(
        ownerId: widget.user.id,
        cursor: cursor,
        limit: limit,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshData());
  }

  @override
  void dispose() {
    _roomsCubit.close();
    _myRoomsCubit.close();
    _tabController.dispose();
    super.dispose();
  }

  // Favorites reload too, so the "N Saves" badges stay current
  Future<void> _refreshData() async {
    _roomsCubit.refresh();
    _myRoomsCubit.refresh();
    await context.read<FavoriteCubit>().loadFavorites(widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SegmentedTabBar(
          controller: _tabController,
          tabs: const [
            SegmentedTabItem(icon: Icons.meeting_room_outlined, label: 'Rooms'),
            SegmentedTabItem(icon: Icons.other_houses_outlined, label: 'My Rooms'),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              RoomPaginatedTab(
                cubit: _roomsCubit,
                user: widget.user,
                onRefresh: _refreshData,
                emptyIcon: Icons.no_meeting_room_outlined,
                emptyMessage: 'No rooms available.',
              ),
              RoomPaginatedTab(
                cubit: _myRoomsCubit,
                user: widget.user,
                onRefresh: _refreshData,
                emptyIcon: Icons.other_houses_outlined,
                emptyMessage: 'You have not posted any rooms yet.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'post_my_rooms_tab_widget.dart';

import '../../../../domain/domain.dart';
import '../../../presentation.dart';

class OwnerPostViewContent extends StatefulWidget {
  final UserEntity user;

  const OwnerPostViewContent({super.key, required this.user});

  @override
  State<OwnerPostViewContent> createState() => _OwnerPostViewContentState();
}

class _OwnerPostViewContentState extends State<OwnerPostViewContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RoomCubit>().fetchRooms();
      context.read<FavoriteCubit>().loadFavorites(widget.user.id);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<RoomCubit, RoomState>(
      builder: (context, state) {
        final allRooms = state.maybeWhen(
          loaded: (list) => list,
          orElse: () => <RoomEntity>[],
        );

        final myRooms = allRooms.where((r) => r.ownerId == widget.user.id).toList();

        return Column(
          children: [
            // SEGMENTED TAB BAR HEADER WITH ICONS (Rooms and My Rooms)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                height: 48,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.06)
                      : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : theme.dividerColor.withValues(alpha: 0.1),
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelPadding: EdgeInsets.zero,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  labelColor: theme.colorScheme.primary,
                  unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: theme.colorScheme.primary.withValues(alpha: 0.12),
                  ),
                  tabs: const [
                    Tab(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.meeting_room_outlined, size: 18),
                          SizedBox(width: 8),
                          Text('Rooms'),
                        ],
                      ),
                    ),
                    Tab(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.other_houses_outlined, size: 18),
                          SizedBox(width: 8),
                          Text('My Rooms'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Tab 1: All Rooms
                  RefreshIndicator(
                    onRefresh: () async {
                      context.read<RoomCubit>().fetchRooms();
                    },
                    child: allRooms.isEmpty
                        ? ListView(
                            children: const [
                              SizedBox(height: 200),
                              Center(child: Text('No rooms available.')),
                            ],
                          )
                        : ListView.builder(
                            itemCount: allRooms.length,
                            itemBuilder: (context, index) {
                              final room = allRooms[index];
                              return RoomCard(
                                room: room,
                                currentUser: widget.user,
                                showOwnerActions: false,
                                onRoomUpdated: () => context.read<RoomCubit>().fetchRooms(),
                              );
                            },
                          ),
                  ),
                  // Tab 2: My Rooms (with User Saved count)
                  PostMyRoomsTabWidget(
                    myRooms: myRooms,
                    user: widget.user,
                    onRefresh: () async {
                      context.read<RoomCubit>().fetchRooms();
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

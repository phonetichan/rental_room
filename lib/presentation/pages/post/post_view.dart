// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../../domain/domain.dart';
// import '../../presentation.dart';
//
// class PostView extends StatefulWidget {
//   final UserEntity user;
//
//   const PostView({super.key, required this.user});
//
//   @override
//   State<PostView> createState() => _PostViewState();
// }
//
// class _PostViewState extends State<PostView> with SingleTickerProviderStateMixin {
//   late final TabController _tabController;
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _searchController.addListener(() {
//       setState(() {
//         _searchQuery = _searchController.text.trim().toLowerCase();
//       });
//     });
//
//     // Initial fetch of rooms and favorites
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<RoomCubit>().fetchRooms();
//       context.read<FavoriteCubit>().loadFavorites(widget.user.id);
//     });
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   void _refreshData() {
//     context.read<RoomCubit>().fetchRooms();
//     context.read<FavoriteCubit>().loadFavorites(widget.user.id);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final primaryColor = theme.primaryColor;
//
//     return Column(
//       children: [
//         // TAB BAR HEADER
//         Container(
//           color: theme.cardColor,
//           child: TabBar(
//             controller: _tabController,
//             labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//             unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
//             indicatorColor: primaryColor,
//             labelColor: primaryColor,
//             tabs: const [
//               Tab(
//                 icon: Icon(Icons.apartment_rounded, size: 20),
//                 text: 'Rooms',
//               ),
//               Tab(
//                 icon: Icon(Icons.home_work_rounded, size: 20),
//                 text: 'My Rooms',
//               ),
//             ],
//           ),
//         ),
//
//         // SEARCH BAR
//         Padding(
//           padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
//           child: TextField(
//             controller: _searchController,
//             decoration: InputDecoration(
//               hintText: 'Search by room name or location...',
//               prefixIcon: const Icon(Icons.search_rounded),
//               suffixIcon: _searchQuery.isNotEmpty
//                   ? IconButton(
//                       icon: const Icon(Icons.clear_rounded),
//                       onPressed: () => _searchController.clear(),
//                     )
//                   : null,
//               contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide(color: Colors.grey.shade300),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide(color: Colors.grey.shade300),
//               ),
//             ),
//           ),
//         ),
//
//         // TAB BAR VIEW CONTENT
//         Expanded(
//           child: BlocConsumer<RoomCubit, RoomState>(
//             listener: (context, state) {
//               state.maybeWhen(
//                 failure: (error) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text(error), backgroundColor: Colors.red),
//                   );
//                 },
//                 orElse: () {},
//               );
//             },
//             builder: (context, state) {
//               return state.maybeWhen(
//                 loading: () => const Center(child: CircularProgressIndicator()),
//                 loaded: (rooms) {
//                   // Filter rooms by search query
//                   final filteredRooms = rooms.where((r) {
//                     if (_searchQuery.isEmpty) return true;
//                     return r.name.toLowerCase().contains(_searchQuery) ||
//                         r.location.toLowerCase().contains(_searchQuery);
//                   }).toList();
//
//                   // Filter for My Rooms tab
//                   final myRooms = filteredRooms.where((r) => r.ownerId == widget.user.id).toList();
//
//                   return TabBarView(
//                     controller: _tabController,
//                     children: [
//                       // TAB 1: ALL ROOMS
//                       _buildRoomsList(
//                         rooms: filteredRooms,
//                         emptyMessage: _searchQuery.isNotEmpty
//                             ? 'No rooms found matching "$_searchQuery"'
//                             : 'No rental rooms available at the moment.',
//                         isMyRoomsTab: false,
//                       ),
//
//                       // TAB 2: MY ROOMS
//                       _buildMyRoomsTab(
//                         myRooms: myRooms,
//                       ),
//                     ],
//                   );
//                 },
//                 failure: (error) => Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Error: $error', style: const TextStyle(color: Colors.red)),
//                       const SizedBox(height: 12),
//                       ElevatedButton.icon(
//                         onPressed: _refreshData,
//                         icon: const Icon(Icons.refresh_rounded),
//                         label: const Text('Retry'),
//                       ),
//                     ],
//                   ),
//                 ),
//                 orElse: () => const Center(child: CircularProgressIndicator()),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildRoomsList({
//     required List<RoomEntity> rooms,
//     required String emptyMessage,
//     required bool isMyRoomsTab,
//   }) {
//     if (rooms.isEmpty) {
//       return RefreshIndicator(
//         onRefresh: () async => _refreshData(),
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           child: Container(
//             height: 350,
//             alignment: Alignment.center,
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.no_meeting_room_outlined, size: 64, color: Colors.grey.shade400),
//                 const SizedBox(height: 16),
//                 Text(
//                   emptyMessage,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//
//     return RefreshIndicator(
//       onRefresh: () async => _refreshData(),
//       child: ListView.builder(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         itemCount: rooms.length,
//         itemBuilder: (context, index) {
//           final room = rooms[index];
//           return RoomCard(
//             room: room,
//             currentUser: widget.user,
//             showOwnerActions: false,
//             onRoomUpdated: _refreshData,
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildMyRoomsTab({required List<RoomEntity> myRooms}) {
//     final theme = Theme.of(context);
//
//     return RefreshIndicator(
//       onRefresh: () async => _refreshData(),
//       child: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           // BANNER & ADD ROOM ACTION
//           Card(
//             color: theme.colorScheme.primaryContainer.withValues(alpha: 0.6),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//             elevation: 0,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Your Properties (${myRooms.length})',
//                           style: theme.textTheme.titleMedium?.copyWith(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           widget.user.role == UserRole.owner
//                               ? 'Manage your listed rooms, edit details, and track favorites.'
//                               : 'You are viewing rooms owned by your account.',
//                           style: theme.textTheme.bodySmall,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   if (widget.user.role == UserRole.owner)
//                     ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//                       ),
//                       icon: const Icon(Icons.add_rounded, size: 18),
//                       label: const Text('Add Room'),
//                       onPressed: () async {
//                         await context.push(AddEditRoomScreen.routePath);
//                         _refreshData();
//                       },
//                     ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//
//           if (myRooms.isEmpty)
//             Container(
//               height: 280,
//               alignment: Alignment.center,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.house_siding_rounded, size: 64, color: Colors.grey.shade400),
//                   const SizedBox(height: 16),
//                   Text(
//                     widget.user.role == UserRole.owner
//                         ? 'You haven\'t added any rooms yet.'
//                         : 'No rooms listed under your account.',
//                     style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
//                   ),
//                   if (widget.user.role == UserRole.owner) ...[
//                     const SizedBox(height: 16),
//                     ElevatedButton.icon(
//                       icon: const Icon(Icons.add_circle_outline_rounded),
//                       label: const Text('Add Your First Room'),
//                       onPressed: () async {
//                         await context.push(AddEditRoomScreen.routePath);
//                         _refreshData();
//                       },
//                     ),
//                   ],
//                 ],
//               ),
//             )
//           else
//             ...myRooms.map(
//               (room) => RoomCard(
//                 room: room,
//                 currentUser: widget.user,
//                 showOwnerActions: true,
//                 onRoomUpdated: _refreshData,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_room/presentation/pages/post/widgets/post_search_bar.dart';

import '../../../domain/domain.dart';
import '../../presentation.dart';

class PostView extends StatefulWidget {
  final UserEntity user;

  const PostView({super.key, required this.user});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });

    // Initial fetch of rooms and favorites
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RoomCubit>().fetchRooms();
      context.read<FavoriteCubit>().loadFavorites(widget.user.id);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _refreshData() {
    context.read<RoomCubit>().fetchRooms();
    context.read<FavoriteCubit>().loadFavorites(widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        // SEGMENTED TAB BAR HEADER WITH ICONS
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                // TAB 1: ROOMS WITH ICON
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
                // TAB 2: MY ROOMS WITH ICON
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

        // SEARCH BAR
        // SEARCH BAR
        PostSearchBar(
          controller: _searchController,
          searchQuery: _searchQuery,
          hintText: 'Search by room name or location...',
          onClear: () {
            _searchController.clear();
            setState(() {
              _searchQuery = '';
            });
          },
          onChanged: (value) {
            setState(() {
              _searchQuery = value.trim().toLowerCase();
            });
          },
        ),

        // TAB BAR VIEW CONTENT
        Expanded(
          child: BlocConsumer<RoomCubit, RoomState>(
            listener: (context, state) {
              state.maybeWhen(
                failure: (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error), backgroundColor: Colors.red),
                  );
                },
                orElse: () {},
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (rooms) {
                  // Filter rooms by search query
                  final filteredRooms = rooms.where((r) {
                    if (_searchQuery.isEmpty) return true;
                    return r.name.toLowerCase().contains(_searchQuery) ||
                        r.location.toLowerCase().contains(_searchQuery);
                  }).toList();

                  // Filter for My Rooms tab
                  final myRooms = filteredRooms
                      .where((r) => r.ownerId == widget.user.id)
                      .toList();

                  return TabBarView(
                    controller: _tabController,
                    children: [
                      // TAB 1: ALL ROOMS
                      _buildRoomsList(
                        rooms: filteredRooms,
                        emptyMessage: _searchQuery.isNotEmpty
                            ? 'No rooms found matching "$_searchQuery"'
                            : 'No rental rooms available at the moment.',
                        isMyRoomsTab: false,
                      ),

                      // TAB 2: MY ROOMS
                      _buildMyRoomsTab(myRooms: myRooms),
                    ],
                  );
                },
                failure: (error) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error: $error',
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: _refreshData,
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
                orElse: () => const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRoomsList({
    required List<RoomEntity> rooms,
    required String emptyMessage,
    required bool isMyRoomsTab,
  }) {
    if (rooms.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async => _refreshData(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: 350,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.no_meeting_room_outlined,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  emptyMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => _refreshData(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return RoomCard(
            room: room,
            currentUser: widget.user,
            showOwnerActions: false,
            onRoomUpdated: _refreshData,
          );
        },
      ),
    );
  }

  Widget _buildMyRoomsTab({required List<RoomEntity> myRooms}) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: () async => _refreshData(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // BANNER & ADD ROOM ACTION
          Card(
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Properties (${myRooms.length})',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.user.role == UserRole.owner
                              ? 'Manage your listed rooms, edit details, and track favorites.'
                              : 'You are viewing rooms owned by your account.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (widget.user.role == UserRole.owner)
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                      ),
                      icon: const Icon(Icons.add_rounded, size: 18),
                      label: const Text('Add Room'),
                      onPressed: () async {
                        await context.push(AddEditRoomScreen.routePath);
                        _refreshData();
                      },
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          if (myRooms.isEmpty)
            Container(
              height: 280,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.house_siding_rounded,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.user.role == UserRole.owner
                        ? 'You haven\'t added any rooms yet.'
                        : 'No rooms listed under your account.',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                  if (widget.user.role == UserRole.owner) ...[
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add_circle_outline_rounded),
                      label: const Text('Add Your First Room'),
                      onPressed: () async {
                        await context.push(AddEditRoomScreen.routePath);
                        _refreshData();
                      },
                    ),
                  ],
                ],
              ),
            )
          else
            ...myRooms.map(
                  (room) => RoomCard(
                room: room,
                currentUser: widget.user,
                showOwnerActions: true,
                onRoomUpdated: _refreshData,
              ),
            ),
        ],
      ),
    );
  }
}
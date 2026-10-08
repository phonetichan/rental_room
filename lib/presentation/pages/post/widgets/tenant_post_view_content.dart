// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../models/room_filter.dart';
// import 'post_search_bar.dart';
// import 'room_filter_bottom_sheet.dart';
//
// import '../../../../domain/domain.dart';
// import '../../../presentation.dart';
//
// class TenantPostViewContent extends StatefulWidget {
//   final UserEntity user;
//
//   const TenantPostViewContent({super.key, required this.user});
//
//   @override
//   State<TenantPostViewContent> createState() => _TenantPostViewContentState();
// }
//
// class _TenantPostViewContentState extends State<TenantPostViewContent>
//     with SingleTickerProviderStateMixin {
//   late final TabController _tabController;
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';
//   RoomFilter _filter = const RoomFilter();
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _tabController.addListener(() {
//       if (!_tabController.indexIsChanging) {
//         setState(() {
//           _filter = _filter.copyWith(isFavoriteOnly: _tabController.index == 1);
//         });
//       }
//     });
//
//     _searchController.addListener(() {
//       setState(() {
//         _searchQuery = _searchController.text.trim().toLowerCase();
//       });
//     });
//
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
//   void _showFilterBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) {
//         return RoomFilterBottomSheet(
//           initialFilter: _filter,
//           onApply: (newFilter) {
//             setState(() {
//               _filter = newFilter;
//               if (_filter.isFavoriteOnly) {
//                 _tabController.index = 1;
//               } else {
//                 _tabController.index = 0;
//               }
//             });
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Column(
//       children: [
//         PostSearchBar(
//           controller: _searchController,
//           searchQuery: _searchQuery,
//           hintText: 'Search rooms, location...',
//           hasActiveFilters: _filter.hasActiveFilters,
//           activeFilterCount: _filter.activeCount,
//           onFilterTap: () => _showFilterBottomSheet(context),
//           onClear: () {
//             _searchController.clear();
//             setState(() {
//               _searchQuery = '';
//             });
//           },
//           onChanged: (value) {
//             setState(() {
//               _searchQuery = value.trim().toLowerCase();
//             });
//           },
//         ),
//         // SEGMENTED TAB BAR HEADER WITH ICONS (All and Saved)
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child: Container(
//             height: 48,
//             padding: const EdgeInsets.all(4),
//             decoration: BoxDecoration(
//               color: isDark
//                   ? Colors.white.withValues(alpha: 0.06)
//                   : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: isDark
//                     ? Colors.white.withValues(alpha: 0.08)
//                     : theme.dividerColor.withValues(alpha: 0.1),
//               ),
//             ),
//             child: TabBar(
//               controller: _tabController,
//               indicatorSize: TabBarIndicatorSize.tab,
//               dividerColor: Colors.transparent,
//               labelPadding: EdgeInsets.zero,
//               labelStyle: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//               ),
//               unselectedLabelStyle: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//               ),
//               labelColor: theme.colorScheme.primary,
//               unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
//               indicator: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: theme.colorScheme.primary.withValues(alpha: 0.12),
//               ),
//               tabs: const [
//                 Tab(
//                   height: 40,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.meeting_room_outlined, size: 18),
//                       SizedBox(width: 8),
//                       Text('All'),
//                     ],
//                   ),
//                 ),
//                 Tab(
//                   height: 40,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.bookmark_rounded, size: 18),
//                       SizedBox(width: 8),
//                       Text('Saved'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Expanded(
//           child: BlocBuilder<FavoriteCubit, FavoriteState>(
//             builder: (context, favoriteState) {
//               return BlocConsumer<RoomCubit, RoomState>(
//                 listener: (context, state) {
//                   state.maybeWhen(
//                     failure: (error) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text(error), backgroundColor: Colors.red),
//                       );
//                     },
//                     orElse: () {},
//                   );
//                 },
//                 builder: (context, state) {
//                   return state.maybeWhen(
//                     loading: () => const Center(child: CircularProgressIndicator()),
//                     loaded: (rooms) {
//                       final filteredRooms = rooms.where((r) {
//                         if (_searchQuery.isNotEmpty) {
//                           final query = _searchQuery;
//                           final matchesName = r.name.toLowerCase().contains(query);
//                           final matchesLoc = r.location.toLowerCase().contains(query);
//                           final matchesDesc = r.description?.toLowerCase().contains(query) ?? false;
//                           if (!matchesName && !matchesLoc && !matchesDesc) return false;
//                         }
//
//                         if (_tabController.index == 1 || _filter.isFavoriteOnly) {
//                           if (!favoriteState.isFavorite(r.id)) return false;
//                         }
//
//                         if (_filter.roomTypeId != null && _filter.roomTypeId!.isNotEmpty) {
//                           if (r.roomTypeId != _filter.roomTypeId) return false;
//                         }
//
//                         if (_filter.minPrice != null) {
//                           if (r.pricePerMonth < _filter.minPrice!) return false;
//                         }
//
//                         if (_filter.maxPrice != null) {
//                           if (r.pricePerMonth > _filter.maxPrice!) return false;
//                         }
//
//                         if (_filter.bedrooms != null) {
//                           if (_filter.bedrooms! == 4) {
//                             if (r.numberBedrooms < 4) return false;
//                           } else {
//                             if (r.numberBedrooms != _filter.bedrooms!) return false;
//                           }
//                         }
//
//                         if (_filter.maxGuests != null) {
//                           if (_filter.maxGuests! == 4) {
//                             if (r.maxGuests < 4) return false;
//                           } else {
//                             if (r.maxGuests != _filter.maxGuests!) return false;
//                           }
//                         }
//
//                         if (r.status != 'available') {
//                           return false;
//                         }
//
//                         return true;
//                       }).toList();
//
//                       if (filteredRooms.isEmpty) {
//                         return RefreshIndicator(
//                           onRefresh: () async => _refreshData(),
//                           child: SingleChildScrollView(
//                             physics: const AlwaysScrollableScrollPhysics(),
//                             child: Container(
//                               height: 350,
//                               alignment: Alignment.center,
//                               padding: const EdgeInsets.all(24),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     (_tabController.index == 1 || _filter.isFavoriteOnly)
//                                         ? Icons.bookmark_border_rounded
//                                         : Icons.no_meeting_room_outlined,
//                                     size: 64,
//                                     color: Colors.grey.shade400,
//                                   ),
//                                   const SizedBox(height: 16),
//                                   Text(
//                                     (_tabController.index == 1 || _filter.isFavoriteOnly)
//                                         ? 'No saved rooms found.'
//                                         : 'No rooms match your filter criteria.',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.grey.shade600,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       }
//
//                       return RefreshIndicator(
//                         onRefresh: () async => _refreshData(),
//                         child: ListView.builder(
//                           itemCount: filteredRooms.length,
//                           itemBuilder: (context, index) {
//                             final room = filteredRooms[index];
//                             return RoomCard(
//                               room: room,
//                               currentUser: widget.user,
//                               showOwnerActions: false,
//                               onRoomUpdated: _refreshData,
//                             );
//                           },
//                         ),
//                       );
//                     },
//                     failure: (message) => Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(32.0),
//                         child: Text(
//                           'Error loading rooms: $message',
//                           style: const TextStyle(color: Colors.red),
//                         ),
//                       ),
//                     ),
//                     orElse: () => const SizedBox.shrink(),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/foundation.dart' show setEquals;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/injector.dart';
import '../../../../domain/domain.dart';
import '../../../presentation.dart';
import '../models/room_filter.dart';
import 'post_search_bar.dart';
import 'room_filter_bottom_sheet.dart';
import 'room_paginated_tab.dart';
import 'segmented_tab_bar.dart';

class TenantPostViewContent extends StatefulWidget {
  final UserEntity user;
  final String? initialRoomTypeId;

  const TenantPostViewContent({
    super.key,
    required this.user,
    this.initialRoomTypeId,
  });

  @override
  State<TenantPostViewContent> createState() => _TenantPostViewContentState();
}

class _TenantPostViewContentState extends State<TenantPostViewContent>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late RoomFilter _filter;

  late final PaginatedCubit<RoomEntity> _allCubit;
  late final PaginatedCubit<RoomEntity> _savedCubit;

  // Snapshot of saved room ids used for Saved paging (stays stable between pages)
  Set<String> _loadedSavedIds = {};

  @override
  void initState() {
    super.initState();
    _filter = RoomFilter(roomTypeId: widget.initialRoomTypeId);

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _filter = _filter.copyWith(isFavoriteOnly: _tabController.index == 1);
        });
        // Opening Saved after saving something new in "All" -> reload it
        if (_tabController.index == 1 &&
            !setEquals(_currentFavoriteIds, _loadedSavedIds)) {
          _refreshSaved();
        }
      }
    });

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });

    final repo = inject<RoomRepository>();

    _allCubit = PaginatedCubit<RoomEntity>(
      fetcher: (cursor, limit) => repo.fetchRoomsPage(
        status: 'available',
        roomTypeId: _filter.roomTypeId, // read at call time, always current
        cursor: cursor,
        limit: limit,
      ),
    );

    _savedCubit = PaginatedCubit<RoomEntity>(
      fetcher: (cursor, limit) =>
          repo.fetchRoomsByIds(_loadedSavedIds.toList(), cursor, limit),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshData());
  }

  @override
  void didUpdateWidget(covariant TenantPostViewContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialRoomTypeId != widget.initialRoomTypeId ||
        _filter.roomTypeId != widget.initialRoomTypeId) {
      setState(() {
        _filter = _filter.copyWith(roomTypeId: widget.initialRoomTypeId);
      });
      _allCubit.refresh();
    }
  }

  @override
  void dispose() {
    _allCubit.close();
    _savedCubit.close();
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Current user's saved room ids from FavoriteCubit
  Set<String> get _currentFavoriteIds =>
      context.read<FavoriteCubit>().state.userFavoriteRoomIds;

  void _refreshSaved() {
    // Copy, so the snapshot is not the same object as the cubit state
    _loadedSavedIds = {..._currentFavoriteIds};
    _savedCubit.refresh();
  }

  Future<void> _refreshData() async {
    _allCubit.refresh();
    await context.read<FavoriteCubit>().loadFavorites(widget.user.id);
    if (!mounted) return;
    _refreshSaved();
  }

  // Client-side filters. "available" and "favorite" are handled elsewhere now.
  bool _matches(RoomEntity r) {
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery;
      final ok = r.name.toLowerCase().contains(q) ||
          r.location.toLowerCase().contains(q) ||
          (r.description?.toLowerCase().contains(q) ?? false);
      if (!ok) return false;
    }
    if (_filter.roomTypeId != null &&
        _filter.roomTypeId!.isNotEmpty &&
        r.roomTypeId != _filter.roomTypeId) {
      return false;
    }
    if (_filter.minPrice != null && r.pricePerMonth < _filter.minPrice!) {
      return false;
    }
    if (_filter.maxPrice != null && r.pricePerMonth > _filter.maxPrice!) {
      return false;
    }
    if (_filter.bedrooms != null) {
      final b = _filter.bedrooms!;
      if (b == 4 ? r.numberBedrooms < 4 : r.numberBedrooms != b) return false;
    }
    if (_filter.maxGuests != null) {
      final g = _filter.maxGuests!;
      if (g == 4 ? r.maxGuests < 4 : r.maxGuests != g) return false;
    }
    return true;
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return RoomFilterBottomSheet(
          initialFilter: _filter,
          onApply: (newFilter) {
            final typeChanged = newFilter.roomTypeId != _filter.roomTypeId;
            setState(() {
              _filter = newFilter;
              _tabController.index = _filter.isFavoriteOnly ? 1 : 0;
            });
            if (typeChanged) _allCubit.refresh(); // server-side filter changed
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostSearchBar(
          controller: _searchController,
          searchQuery: _searchQuery,
          hintText: 'Search rooms, location...',
          hasActiveFilters: _filter.hasActiveFilters,
          activeFilterCount: _filter.activeCount,
          onFilterTap: () => _showFilterBottomSheet(context),
          onClear: () {
            _searchController.clear();
            setState(() => _searchQuery = '');
          },
          onChanged: (value) {
            setState(() => _searchQuery = value.trim().toLowerCase());
          },
        ),
        SegmentedTabBar(
          controller: _tabController,
          tabs: const [
            SegmentedTabItem(icon: Icons.meeting_room_outlined, label: 'All'),
            SegmentedTabItem(icon: Icons.bookmark_rounded, label: 'Saved'),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              RoomPaginatedTab(
                cubit: _allCubit,
                user: widget.user,
                onRefresh: _refreshData,
                filter: _matches,
                emptyIcon: Icons.no_meeting_room_outlined,
                emptyMessage: 'No rooms match your filter criteria.',
              ),
              RoomPaginatedTab(
                cubit: _savedCubit,
                user: widget.user,
                onRefresh: _refreshData,
                filter: _matches,
                favoritesOnly: true,
                emptyIcon: Icons.bookmark_border_rounded,
                emptyMessage: 'No saved rooms found.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
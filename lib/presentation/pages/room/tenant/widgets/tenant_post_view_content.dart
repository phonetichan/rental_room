import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../di/injector.dart';
import '../../../../../domain/domain.dart';
import '../../../../blocs/blocs.dart';
import '../../../../components/components.dart';
import '../../../../components/modal/room_filter.dart';
import '../saved_rooms_page.dart';
import 'filter_summary.dart';
import 'post_search_bar.dart';
import 'room_filter_bottom_sheet.dart';
import 'room_paginated_tab.dart';

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

class _TenantPostViewContentState extends State<TenantPostViewContent> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late RoomFilter _filter;
  StreamSubscription<PaginatedState<RoomEntity>>? _sub;
  late final PaginatedCubit<RoomEntity> _allCubit;

  Timer? _debounce;
  final ValueNotifier<bool> _isFilling = ValueNotifier(false);
  bool _filling = false;
  bool _again = false;

  @override
  void initState() {
    super.initState();
    _filter = RoomFilter(roomTypeId: widget.initialRoomTypeId);

    final repo = inject<RoomRepository>();

    _allCubit = PaginatedCubit<RoomEntity>(
      fetcher: (cursor, limit) => repo.fetchRoomsPage(
        status: 'available',
        // CHANGED: empty string is treated as "no type filter"
        roomTypeId:
        (_filter.roomTypeId?.isEmpty ?? true) ? null : _filter.roomTypeId,
        cursor: cursor,
        limit: limit,
      ),
    );

    _sub = _allCubit.stream.listen((s) {
      final idle = !s.isInitialLoading && !s.isRefreshing && !s.isLoadingMore;
      final noneVisible = !s.items.any(_matches);
      if (idle && s.hasMore && s.error == null && noneVisible && !_filling) {
        _fill();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshData());
  }

  @override
  void didUpdateWidget(covariant TenantPostViewContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialRoomTypeId != widget.initialRoomTypeId) {
      setState(() {
        _filter = RoomFilter(
          roomTypeId: widget.initialRoomTypeId,
          minPrice: _filter.minPrice,
          maxPrice: _filter.maxPrice,
          bedrooms: _filter.bedrooms,
          maxGuests: _filter.maxGuests,
          isFavoriteOnly: _filter.isFavoriteOnly,
        );
      });
      _allCubit.refresh().then((_) => _fill());
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _isFilling.dispose();
    _sub?.cancel();
    _allCubit.close();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fill() async {
    if (!mounted) return;
    if (_filling) {
      _again = true;
      return;
    }
    _filling = true;
    _isFilling.value = true;
    try {
      do {
        _again = false;
        // CHANGED: 7 -> 5, so page 2 loads on scroll, not automatically
        await _allCubit.loadUntil(_matches, minMatches: 5);
      } while (_again && mounted);
    } finally {
      _filling = false;
      if (mounted) _isFilling.value = false;
    }
  }

  void _fillDebounced() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), _fill);
  }

  void _updateFilter(RoomFilter newFilter) {
    final typeChanged = newFilter.roomTypeId != _filter.roomTypeId;
    setState(() => _filter = newFilter);
    if (typeChanged) {
      _allCubit.refresh().then((_) => _fill());
    } else {
      _fill();
    }
  }

  Future<void> _refreshData() async {
    await _allCubit.refresh();
    _fill();
    if (mounted) {
      await context.read<FavoriteCubit>().loadFavorites(widget.user.id);
    }
  }

  bool _matches(RoomEntity r) {
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery;
      final ok =
          r.name.toLowerCase().contains(q) ||
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
          onApply: _updateFilter,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: PostSearchBar(
                controller: _searchController,
                searchQuery: _searchQuery,
                hintText: 'Search rooms, location...',
                hasActiveFilters: _filter.hasActiveFilters,
                activeFilterCount: _filter.activeCount,
                onFilterTap: () => _showFilterBottomSheet(context),
                onClear: () {
                  _searchController.clear();
                  setState(() => _searchQuery = '');
                  _fillDebounced();
                },
                onChanged: (value) {
                  setState(() => _searchQuery = value.trim().toLowerCase());
                  _fillDebounced();
                },
              ),
            ),
            const SizedBox(width: 8),
            SavedRoomsButton(
              onTap: () =>
                  context.push(SavedRoomsPage.routePath, extra: widget.user),
            ),
          ],
        ),
        FilterSummary(filter: _filter),
        const SizedBox(height: 8),
        Expanded(
          child: ValueListenableBuilder<bool>(
            valueListenable: _isFilling,
            builder: (_, filling, __) => RoomPaginatedTab(
              cubit: _allCubit,
              user: widget.user,
              onRefresh: _refreshData,
              filter: _matches,
              isFilling: filling,
              emptyIcon: Icons.no_meeting_room_outlined,
              emptyMessage: 'No rooms match your filter criteria.',
            ),
          ),
        ),
      ],
    );
  }
}
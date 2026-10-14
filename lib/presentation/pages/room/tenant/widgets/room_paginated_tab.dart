import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/domain.dart';
import '../../../../blocs/blocs.dart';
import '../../../../components/components.dart';

class RoomPaginatedTab extends StatelessWidget {
  const RoomPaginatedTab({
    super.key,
    required this.cubit,
    required this.user,
    required this.onRefresh,
    required this.emptyIcon,
    required this.emptyMessage,
    this.filter,
    this.favoritesOnly = false,
    this.isFilling = false, // new
  });

  final PaginatedCubit<RoomEntity> cubit;
  final UserEntity user;
  final Future<void> Function() onRefresh;
  final IconData emptyIcon;
  final String emptyMessage;
  final bool Function(RoomEntity room)? filter; // search / filter sheet
  final bool favoritesOnly; // true for the Saved tab
  final bool isFilling; // new

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginatedCubit<RoomEntity>, PaginatedState<RoomEntity>>(
      bloc: cubit,
      builder: (context, state) {
        if (state.isInitialLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!favoritesOnly) return _list(state, null);

        // Saved tab: un-saved rooms disappear immediately
        return BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, fav) => _list(state, fav),
        );
      },
    );
  }

  Widget _list(PaginatedState<RoomEntity> state, FavoriteState? fav) {
    bool test(RoomEntity r) {
      if (fav != null && !fav.isFavorite(r.id)) return false;
      return filter?.call(r) ?? true;
    }

    final items = state.items.where(test).toList();

    final busy = isFilling || state.isLoadingMore || state.isRefreshing;

    // Empty now, but more may still come -> spinner, never the "empty" message
    if (items.isEmpty && state.error == null && (busy || state.hasMore)) {
      return const Center(child: CircularProgressIndicator());
    }

    return PaginatedListView<RoomEntity>(
      items: items,
      hasMore: state.hasMore,
      isLoadingMore: state.isLoadingMore,
      errorMessage: state.error,
      onLoadMore: () =>
          cubit.loadUntil(test, minMatches: items.length + cubit.pageSize),
      onRetry: cubit.retry,
      onRefresh: onRefresh,
      emptyBuilder: (_) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(emptyIcon, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
      itemBuilder: (context, room, _) =>
          RoomCard(room: room, currentUser: user, onRoomUpdated: onRefresh),
    );
  }
}

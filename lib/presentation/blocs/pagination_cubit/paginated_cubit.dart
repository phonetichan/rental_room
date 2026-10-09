import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/domain.dart';

part 'paginated_state.dart';

part 'paginated_cubit.freezed.dart';

typedef PageFetcher<T> = Future<PageResult<T>> Function(
  Object? cursor,
  int limit,
);

class PaginatedCubit<T> extends Cubit<PaginatedState<T>> {
  PaginatedCubit({required PageFetcher<T> fetcher, this.pageSize = 5})
    : _fetcher = fetcher,
      super(PaginatedState<T>());

  final PageFetcher<T> _fetcher;
  final int pageSize;

  Object? _cursor;
  int _generation = 0;

  /// Keeps current items on screen, then replaces them with fresh page 1.
  /// isInitialLoading stays true only until the very first load finishes.
  Future<void> refresh() async {
    _generation++;
    _cursor = null;
    emit(state.copyWith(isRefreshing: true, isLoadingMore: false, error: null));
    await _load(replace: true);
  }

  Future<void> loadMore() async {
    debugPrint('loadMore: init=${state.isInitialLoading} refreshing=${state.isRefreshing} '
        'more=${state.isLoadingMore} hasMore=${state.hasMore} err=${state.error}');
    if (state.isInitialLoading ||
        state.isRefreshing ||
        state.isLoadingMore ||
        !state.hasMore ||
        state.error != null) {
      return;
    }
    emit(state.copyWith(isLoadingMore: true));
    await _load();
  }

  Future<void> retry() async {
    if (_cursor == null) {
      await refresh(); // page 1 failed
    } else {
      emit(state.copyWith(error: null));
      await loadMore(); // a later page failed
    }
  }

  Future<void> loadUntil(
    bool Function(T item) test, {
    int minMatches = 5,
    bool loadAll = false,
    int? maxPages,
  }) async {
    final gen = _generation;
    var pages = 0;

    while (!isClosed &&
        gen == _generation &&
        (maxPages == null || pages < maxPages) &&
        state.hasMore &&
        state.error == null &&
        !state.isInitialLoading &&
        !state.isRefreshing &&
        !state.isLoadingMore &&
        (loadAll || state.items.where(test).length < minMatches)) {
      await loadMore();
      pages++;
    }
  }

  Future<void> _load({bool replace = false}) async {
    final gen = _generation;
    try {
      final page = await _fetcher(_cursor, pageSize);
      debugPrint('page: ${page.items.length} items, hasMore=${page.hasMore}, cursor=${page.cursor}');
      if (gen != _generation || isClosed) return;

      _cursor = page.cursor;
      emit(
        state.copyWith(
          items: replace ? page.items : [...state.items, ...page.items],
          isInitialLoading: false,
          isLoadingMore: false,
          isRefreshing: false,
          hasMore: page.hasMore,
          error: null,
        ),
      );
    } catch (e, st) {
      debugPrint('LOAD error: $e\n$st');
      if (gen != _generation || isClosed) return;
      emit(
        state.copyWith(
          isInitialLoading: false,
          isLoadingMore: false,
          isRefreshing: false,
          error: e.toString(),
        ),
      );
    }
  }
}

/// Long-lived cubit for the saved rooms list.
class SavedRoomsCubit extends PaginatedCubit<RoomEntity> {
  SavedRoomsCubit({required super.fetcher});
}

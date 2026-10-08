import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/domain.dart'; // PageResult (adjust path if needed)

part 'paginated_state.dart';
part 'paginated_cubit.freezed.dart';

/// Any function that loads one page. The cubit doesn't care where data comes from.
typedef PageFetcher<T> = Future<PageResult<T>> Function(Object? cursor, int limit);

class PaginatedCubit<T> extends Cubit<PaginatedState<T>> {
  PaginatedCubit({required PageFetcher<T> fetcher, this.pageSize = 7})
      : _fetcher = fetcher,
        super(PaginatedState<T>());

  final PageFetcher<T> _fetcher;
  final int pageSize;

  Object? _cursor;     // "where did the last page end?"
  int _generation = 0; // detects outdated requests after refresh()

  /// First load, pull-to-refresh, or server-side filter change.
  /// Keeps the current items on screen until the new page 1 is ready.
  Future<void> refresh() async {
    _generation++;
    _cursor = null;
    if (state.items.isEmpty) {
      emit(PaginatedState<T>()); // nothing to hold, show the first-load spinner
    } else {
      emit(state.copyWith(
        isRefreshing: true,
        isLoadingMore: false,
        error: null,
      ));
    }
    await _load(replace: true);
  }

  /// Called when the user scrolls near the bottom.
  Future<void> loadMore() async {
    if (state.isInitialLoading ||
        state.isRefreshing || // don't page while page 1 is reloading
        state.isLoadingMore ||
        !state.hasMore ||
        state.error != null) {
      return; // already loading, nothing left, or in error
    }
    emit(state.copyWith(isLoadingMore: true));
    await _load();
  }

  Future<void> retry() async {
    emit(state.copyWith(error: null));
    await loadMore();
  }

  Future<void> _load({bool replace = false}) async {
    final gen = _generation;
    try {
      final page = await _fetcher(_cursor, pageSize);
      if (gen != _generation || isClosed) return; // outdated result, ignore

      _cursor = page.cursor; // remember where this page ended
      emit(state.copyWith(
        // replace on refresh, append on loadMore
        items: replace ? page.items : [...state.items, ...page.items],
        isInitialLoading: false,
        isLoadingMore: false,
        isRefreshing: false,
        hasMore: page.hasMore,
        error: null,
      ));
    } catch (e) {
      if (gen != _generation || isClosed) return;
      emit(state.copyWith(
        isInitialLoading: false,
        isLoadingMore: false,
        isRefreshing: false, // old items stay visible
        error: e.toString(),
      ));
    }
  }
}
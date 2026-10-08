part of 'paginated_cubit.dart';

@freezed
abstract class PaginatedState<T> with _$PaginatedState<T> {
  const factory PaginatedState({
    @Default([]) List<T> items,          // everything loaded so far
    @Default(true) bool isInitialLoading, // first page in progress
    @Default(false) bool isLoadingMore,   // next page in progress
    @Default(false) bool isRefreshing, // NEW: reloading page 1, old items still shown
    @Default(true) bool hasMore,          // false => show "No more data"
    String? error,
  }) = _PaginatedState<T>;
}


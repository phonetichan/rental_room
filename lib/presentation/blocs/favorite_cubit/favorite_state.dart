part of 'favorite_cubit.dart';

@freezed
abstract class FavoriteState with _$FavoriteState {
  const FavoriteState._();

  const factory FavoriteState({
    @Default({}) Set<String> userFavoriteRoomIds,
    @Default({}) Map<String, int> favoriteCounts,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _FavoriteState;

  bool isFavorite(String roomId) => userFavoriteRoomIds.contains(roomId);

  int getFavoriteCount(String roomId) => favoriteCounts[roomId] ?? 0;
}

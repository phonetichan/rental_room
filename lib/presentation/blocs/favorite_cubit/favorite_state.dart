class FavoriteState {
  final Set<String> userFavoriteRoomIds;
  final Map<String, int> favoriteCounts;
  final bool isLoading;
  final String? errorMessage;

  const FavoriteState({
    this.userFavoriteRoomIds = const {},
    this.favoriteCounts = const {},
    this.isLoading = false,
    this.errorMessage,
  });

  bool isFavorite(String roomId) => userFavoriteRoomIds.contains(roomId);

  int getFavoriteCount(String roomId) => favoriteCounts[roomId] ?? 0;

  FavoriteState copyWith({
    Set<String>? userFavoriteRoomIds,
    Map<String, int>? favoriteCounts,
    bool? isLoading,
    String? errorMessage,
  }) {
    return FavoriteState(
      userFavoriteRoomIds: userFavoriteRoomIds ?? this.userFavoriteRoomIds,
      favoriteCounts: favoriteCounts ?? this.favoriteCounts,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

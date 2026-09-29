import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecase/get_favorite_counts_usecase.dart';
import '../../../domain/usecase/get_user_favorites_usecase.dart';
import '../../../domain/usecase/toggle_favorite_usecase.dart';
import 'favorite_state.dart';

export 'favorite_state.dart';

@injectable
class FavoriteCubit extends Cubit<FavoriteState> {
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final GetUserFavoritesUseCase _getUserFavoritesUseCase;
  final GetFavoriteCountsUseCase _getFavoriteCountsUseCase;

  FavoriteCubit(
    this._toggleFavoriteUseCase,
    this._getUserFavoritesUseCase,
    this._getFavoriteCountsUseCase,
  ) : super(const FavoriteState());

  Future<void> loadFavorites(String userId) async {
    emit(state.copyWith(isLoading: true));

    final favsResult = await _getUserFavoritesUseCase(userId);
    final countsResult = await _getFavoriteCountsUseCase();

    Set<String> userFavs = state.userFavoriteRoomIds;
    Map<String, int> counts = state.favoriteCounts;

    favsResult.onSuccess((favList) {
      userFavs = favList.map((e) => e.roomId).toSet();
    });

    countsResult.onSuccess((countsMap) {
      counts = countsMap;
    });

    emit(state.copyWith(
      userFavoriteRoomIds: userFavs,
      favoriteCounts: counts,
      isLoading: false,
    ));
  }

  Future<void> toggleFavorite({
    required String roomId,
    required String userId,
    String? ownerId,
  }) async {
    if (ownerId != null && ownerId.isNotEmpty && userId == ownerId) {
      emit(state.copyWith(errorMessage: 'Owners cannot favorite their own rooms.'));
      return;
    }

    final bool currentlyFavorite = state.isFavorite(roomId);
    final int currentCount = state.getFavoriteCount(roomId);

    // Optimistic UI Update
    final updatedFavs = Set<String>.from(state.userFavoriteRoomIds);
    final updatedCounts = Map<String, int>.from(state.favoriteCounts);

    if (currentlyFavorite) {
      updatedFavs.remove(roomId);
      updatedCounts[roomId] = (currentCount - 1).clamp(0, 999999);
    } else {
      updatedFavs.add(roomId);
      updatedCounts[roomId] = currentCount + 1;
    }

    emit(state.copyWith(
      userFavoriteRoomIds: updatedFavs,
      favoriteCounts: updatedCounts,
    ));

    final result = await _toggleFavoriteUseCase(
      ToggleFavoriteParams(roomId: roomId, userId: userId, ownerId: ownerId),
    );

    result.onError((failure) {
      // Revert optimistic update on failure
      final revertedFavs = Set<String>.from(state.userFavoriteRoomIds);
      final revertedCounts = Map<String, int>.from(state.favoriteCounts);

      if (currentlyFavorite) {
        revertedFavs.add(roomId);
        revertedCounts[roomId] = currentCount;
      } else {
        revertedFavs.remove(roomId);
        revertedCounts[roomId] = currentCount;
      }

      emit(state.copyWith(
        userFavoriteRoomIds: revertedFavs,
        favoriteCounts: revertedCounts,
        errorMessage: failure.reason,
      ));
    });
  }
}

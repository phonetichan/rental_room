import '../../entity/favorite/favorite_entity.dart';

abstract class FavoriteRepository {
  Future<bool> toggleFavorite(String roomId, String userId);
  Future<List<FavoriteEntity>> getUserFavorites(String userId);
  Future<Map<String, int>> getFavoriteCounts();
  Future<int> getFavoriteCountForRoom(String roomId);
}

import 'package:injectable/injectable.dart';
import '../../domain/entity/favorite_entity.dart';
import '../../domain/repository/favorite_repository.dart';
import '../datasource/remote/favorite_data_source.dart';

@LazySingleton(as: FavoriteRepository)
class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource _remoteDataSource;

  FavoriteRepositoryImpl(this._remoteDataSource);

  @override
  Future<bool> toggleFavorite(String roomId, String userId) async {
    return await _remoteDataSource.toggleFavorite(roomId, userId);
  }

  @override
  Future<List<FavoriteEntity>> getUserFavorites(String userId) async {
    final models = await _remoteDataSource.getUserFavorites(userId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Map<String, int>> getFavoriteCounts() async {
    return await _remoteDataSource.getFavoriteCounts();
  }

  @override
  Future<int> getFavoriteCountForRoom(String roomId) async {
    return await _remoteDataSource.getFavoriteCountForRoom(roomId);
  }
}

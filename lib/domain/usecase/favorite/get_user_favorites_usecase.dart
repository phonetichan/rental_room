import 'package:injectable/injectable.dart';
import '../../../core/core.dart';
import '../../entity/favorite/favorite_entity.dart';
import '../../repository/favorite/favorite_repository.dart';

@lazySingleton
class GetUserFavoritesUseCase implements UseCase<DataState<List<FavoriteEntity>>, String> {
  final FavoriteRepository _repository;

  const GetUserFavoritesUseCase(this._repository);

  @override
  Future<DataState<List<FavoriteEntity>>> call(String userId) async {
    try {
      final favorites = await _repository.getUserFavorites(userId);
      return Success(favorites);
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}

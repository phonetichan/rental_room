import 'package:injectable/injectable.dart';
import '../../core/core.dart';
import '../repository/favorite_repository.dart';

@lazySingleton
class GetFavoriteCountsUseCase implements UseCase<DataState<Map<String, int>>, void> {
  final FavoriteRepository _repository;

  const GetFavoriteCountsUseCase(this._repository);

  @override
  Future<DataState<Map<String, int>>> call([void param]) async {
    try {
      final counts = await _repository.getFavoriteCounts();
      return Success(counts);
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}

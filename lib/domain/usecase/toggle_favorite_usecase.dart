import 'package:injectable/injectable.dart';
import '../../core/core.dart';
import '../repository/favorite_repository.dart';

class ToggleFavoriteParams {
  final String roomId;
  final String userId;
  final String? ownerId;

  const ToggleFavoriteParams({
    required this.roomId,
    required this.userId,
    this.ownerId,
  });
}

@lazySingleton
class ToggleFavoriteUseCase implements UseCase<DataState<bool>, ToggleFavoriteParams> {
  final FavoriteRepository _repository;

  const ToggleFavoriteUseCase(this._repository);

  @override
  Future<DataState<bool>> call(ToggleFavoriteParams param) async {
    if (param.ownerId != null && param.ownerId!.isNotEmpty && param.userId == param.ownerId) {
      return Failed(DbFailure('Owners cannot favorite their own rooms.'));
    }

    try {
      final isFavorited = await _repository.toggleFavorite(param.roomId, param.userId);
      return Success(isFavorited);
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}

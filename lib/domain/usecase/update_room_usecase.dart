import 'package:injectable/injectable.dart';
import '../../../core/core.dart';
import '../entity/room_entity.dart';
import '../repository/room_repository.dart';

@lazySingleton
class UpdateRoomUseCase implements UseCase<DataState<RoomEntity>, RoomEntity> {
  final RoomRepository _repository;

  const UpdateRoomUseCase(this._repository);

  @override
  Future<DataState<RoomEntity>> call(RoomEntity param) async {
    try {
      final updatedRoom = await _repository.updateRoom(param);
      return Success(updatedRoom);
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}

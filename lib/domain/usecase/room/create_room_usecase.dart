import 'package:injectable/injectable.dart';
import '../../../../core/core.dart';
import '../../entity/room/room_entity.dart';
import '../../repository/room/room_repository.dart';

@lazySingleton
class CreateRoomUseCase implements UseCase<DataState<RoomEntity>, RoomEntity> {
  final RoomRepository _repository;

  const CreateRoomUseCase(this._repository);

  @override
  Future<DataState<RoomEntity>> call(RoomEntity param) async {
    try {
      final createdRoom = await _repository.createRoom(param);
      return Success(createdRoom);
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}

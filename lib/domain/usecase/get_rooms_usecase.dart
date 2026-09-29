import 'package:injectable/injectable.dart';
import '../../../core/core.dart';
import '../entity/room_entity.dart';
import '../repository/room_repository.dart';

class GetRoomsParams {
  final String? ownerId;
  final String? roomTypeId;
  final String? status;

  const GetRoomsParams({
    this.ownerId,
    this.roomTypeId,
    this.status,
  });
}

@lazySingleton
class GetRoomsUseCase implements UseCase<DataState<List<RoomEntity>>, GetRoomsParams> {
  final RoomRepository _repository;

  const GetRoomsUseCase(this._repository);

  @override
  Future<DataState<List<RoomEntity>>> call(GetRoomsParams param) async {
    try {
      final rooms = await _repository.getRooms(
        ownerId: param.ownerId,
        roomTypeId: param.roomTypeId,
        status: param.status,
      );
      return Success(rooms);
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}

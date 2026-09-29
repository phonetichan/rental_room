import 'package:injectable/injectable.dart';
import '../../../core/core.dart';
import '../repository/room_repository.dart';

@lazySingleton
class DeleteRoomUseCase implements UseCase<DataState<void>, String> {
  final RoomRepository _repository;

  const DeleteRoomUseCase(this._repository);

  @override
  Future<DataState<void>> call(String roomId) async {
    try {
      await _repository.deleteRoom(roomId);
      return const Success(null);
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}

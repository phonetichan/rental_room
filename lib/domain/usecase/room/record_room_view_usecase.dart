import 'package:injectable/injectable.dart';

import '../../../core/core.dart';
import '../../repository/room/room_view_respository.dart';

class RecordRoomViewParams {
  final String roomId;
  final String userId;

  const RecordRoomViewParams({
    required this.roomId,
    required this.userId,
  });
}

@lazySingleton
class RecordRoomViewUseCase implements UseCase<DataState<void>, RecordRoomViewParams> {
  final RoomViewRepository _repository;

  const RecordRoomViewUseCase(this._repository);

  @override
  Future<DataState<void>> call(RecordRoomViewParams param) async {
    try {
      await _repository.recordRoomView(
        roomId: param.roomId,
        userId: param.userId,
      );
      return const Success(null);
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}

import 'package:injectable/injectable.dart';

import '../../../core/core.dart';
import '../../repository/room/room_view_respository.dart';

class RemoveRoomViewParams {
  final String roomId;
  final String userId;

  const RemoveRoomViewParams({
    required this.roomId,
    required this.userId,
  });
}

@lazySingleton
class RemoveRoomViewUseCase
    implements UseCase<DataState<void>, RemoveRoomViewParams> {
  final RoomViewRepository _repository;

  const RemoveRoomViewUseCase(this._repository);

  @override
  Future<DataState<void>> call(RemoveRoomViewParams param) async {
    try {
      await _repository.removeRoomView(
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

import 'package:injectable/injectable.dart';

import '../../core/core.dart';
import '../repository/room_view_respository.dart';

@lazySingleton
class GetRoomVisitorCountUseCase implements UseCase<DataState<int>, String> {
  final RoomViewRepository _repository;

  const GetRoomVisitorCountUseCase(this._repository);

  @override
  Future<DataState<int>> call(String roomId) async {
    try {
      final count = await _repository.getRoomVisitorCount(roomId);
      return Success(count);
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}

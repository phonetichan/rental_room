import 'package:injectable/injectable.dart';

import '../../../domain/repository/room/room_view_respository.dart';
import '../../data.dart';

@LazySingleton(as: RoomViewRepository)
class RoomViewRepositoryImpl implements RoomViewRepository {
  final RoomViewRemoteDataSource _remoteDataSource;

  RoomViewRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> recordRoomView({
    required String roomId,
    required String userId,
  }) {
    return _remoteDataSource.recordRoomView(
      roomId: roomId,
      userId: userId,
    );
  }

  @override
  Future<void> removeRoomView({
    required String roomId,
    required String userId,
  }) {
    return _remoteDataSource.removeRoomView(
      roomId: roomId,
      userId: userId,
    );
  }

  @override
  Future<int> getRoomVisitorCount(String roomId) {
    return _remoteDataSource.getRoomVisitorCount(roomId);
  }
}
import 'package:injectable/injectable.dart';
import 'package:rental_room/data/datasource/remote/room_view_data_source.dart';

import '../../domain/repository/room_view_respository.dart';

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
import 'package:injectable/injectable.dart';
import 'package:rental_room/domain/entity/page_result.dart';

import '../../domain/entity/room_entity.dart';
import '../../domain/repository/room_repository.dart';
import '../datasource/remote/room_data_source.dart';
import '../model/room_model.dart';

@LazySingleton(as: RoomRepository)
class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDataSource _remoteDataSource;

  RoomRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<RoomEntity>> getRooms({String? ownerId, String? roomTypeId, String? status}) async {
    final roomModels = await _remoteDataSource.getRooms(
      ownerId: ownerId,
      roomTypeId: roomTypeId,
      status: status,
    );
    return roomModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<RoomEntity?> getRoomById(String roomId) async {
    final model = await _remoteDataSource.getRoomById(roomId);
    return model?.toEntity();
  }

  @override
  Future<RoomEntity> createRoom(RoomEntity room) async {
    final modelToCreate = RoomModel.fromEntity(room);
    final createdModel = await _remoteDataSource.createRoom(modelToCreate);
    return createdModel.toEntity();
  }

  @override
  Future<RoomEntity> updateRoom(RoomEntity room) async {
    final modelToUpdate = RoomModel.fromEntity(room);
    final updatedModel = await _remoteDataSource.updateRoom(modelToUpdate);
    return updatedModel.toEntity();
  }

  @override
  Future<void> deleteRoom(String roomId) async {
    await _remoteDataSource.deleteRoom(roomId);
  }

  @override
  Future<List<Map<String, dynamic>>> getRoomTypes() {
    return _remoteDataSource.getRoomTypes();
  }

  @override
  Future<List<Map<String, dynamic>>> getAmenities() {
    return _remoteDataSource.getAmenities();
  }

  @override
  Future<PageResult<RoomEntity>> fetchRoomsPage({
    String? ownerId,
    String? roomTypeId,
    String? status,
    Object? cursor,
    required int limit,
  }) async {
    final page = await _remoteDataSource.fetchRoomsPage(
      ownerId: ownerId,
      roomTypeId: roomTypeId,
      status: status,
      cursor: cursor,
      limit: limit,
    );
    return PageResult<RoomEntity>(
      items: page.items.map((m) => m.toEntity()).toList(),
      cursor: page.cursor,
      hasMore: page.hasMore,
    );
  }

  @override
  Future<PageResult<RoomEntity>> fetchRoomsByIds(
      List<String> ids,
      Object? cursor,
      int limit,
      ) async {
    final page = await _remoteDataSource.fetchRoomsByIds(ids, cursor, limit);
    return PageResult<RoomEntity>(
      items: page.items.map((m) => m.toEntity()).toList(),
      cursor: page.cursor,
      hasMore: page.hasMore,
    );
  }
}

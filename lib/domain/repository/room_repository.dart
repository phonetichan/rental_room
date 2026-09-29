import '../entity/room_entity.dart';

abstract class RoomRepository {
  Future<List<RoomEntity>> getRooms({String? ownerId, String? roomTypeId, String? status});
  Future<RoomEntity?> getRoomById(String roomId);
  Future<RoomEntity> createRoom(RoomEntity room);
  Future<RoomEntity> updateRoom(RoomEntity room);
  Future<void> deleteRoom(String roomId);
  Future<List<Map<String, dynamic>>> getRoomTypes();
  Future<List<Map<String, dynamic>>> getAmenities();
}

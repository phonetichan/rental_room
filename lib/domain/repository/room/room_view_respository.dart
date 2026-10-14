abstract class RoomViewRepository {
  /// Records a visit to a room by the given user.
  Future<void> recordRoomView({
    required String roomId,
    required String userId,
  });

  /// Removes a visit record when a user unselects/cancels a visit.
  Future<void> removeRoomView({
    required String roomId,
    required String userId,
  });

  /// Retrieves the total count of unique visitors for a given room.
  Future<int> getRoomVisitorCount(String roomId);
}
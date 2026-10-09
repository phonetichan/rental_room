class RoomViewEntity {
  final String id;
  final String roomId;
  final String userId;
  final DateTime viewedAt;

  const RoomViewEntity({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.viewedAt,
  });
}
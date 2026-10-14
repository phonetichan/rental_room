class FavoriteEntity {
  final String id;
  final String roomId;
  final String userId;
  final DateTime? createdAt;

  const FavoriteEntity({
    required this.id,
    required this.roomId,
    required this.userId,
    this.createdAt,
  });

  FavoriteEntity copyWith({
    String? id,
    String? roomId,
    String? userId,
    DateTime? createdAt,
  }) {
    return FavoriteEntity(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class RoomImageEntity {
  final String id;
  final String roomId;
  final String imageUrl;
  final bool isPrimary;

  const RoomImageEntity({
    required this.id,
    required this.roomId,
    required this.imageUrl,
    this.isPrimary = false,
  });

  RoomImageEntity copyWith({
    String? id,
    String? roomId,
    String? imageUrl,
    bool? isPrimary,
  }) {
    return RoomImageEntity(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      imageUrl: imageUrl ?? this.imageUrl,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }
}

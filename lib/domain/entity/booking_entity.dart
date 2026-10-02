class BookingEntity {
  final String id;
  final String userId; // Tenant ID
  final String roomId; // Room ID
  final String? ownerId; // Owner ID
  final bool isPhoneContacted;
  final bool isVisited;
  final String status; // "draft", "pending", "confirmed", "cancelled"
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Optional display metadata
  final String? roomName;
  final double? roomPrice;
  final String? roomImageUrl;
  final String? tenantName;
  final String? tenantPhone;

  const BookingEntity({
    required this.id,
    required this.userId,
    required this.roomId,
    this.ownerId,
    this.isPhoneContacted = false,
    this.isVisited = false,
    this.status = 'draft',
    this.createdAt,
    this.updatedAt,
    this.roomName,
    this.roomPrice,
    this.roomImageUrl,
    this.tenantName,
    this.tenantPhone,
  });

  BookingEntity copyWith({
    String? id,
    String? userId,
    String? roomId,
    String? ownerId,
    bool? isPhoneContacted,
    bool? isVisited,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? roomName,
    double? roomPrice,
    String? roomImageUrl,
    String? tenantName,
    String? tenantPhone,
  }) {
    return BookingEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      roomId: roomId ?? this.roomId,
      ownerId: ownerId ?? this.ownerId,
      isPhoneContacted: isPhoneContacted ?? this.isPhoneContacted,
      isVisited: isVisited ?? this.isVisited,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      roomName: roomName ?? this.roomName,
      roomPrice: roomPrice ?? this.roomPrice,
      roomImageUrl: roomImageUrl ?? this.roomImageUrl,
      tenantName: tenantName ?? this.tenantName,
      tenantPhone: tenantPhone ?? this.tenantPhone,
    );
  }
}

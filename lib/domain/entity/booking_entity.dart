class BookingEntity {
  final String id;
  final String userId; // Tenant ID
  final String roomId; // Room ID
  final String? ownerId; // Owner ID
  final bool isPhoneContacted;
  final bool isVisited;
  final bool isReadByTenant;
  final bool isReadByOwner;
  final String status; // "draft", "pending", "confirmed", "cancelled", "contracted"
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Optional display metadata
  final String? roomName;
  final double? roomPrice;
  final String? roomImageUrl;
  final String? tenantName;
  final String? tenantPhone;

  /// Helper getters for the refined workflow states
  bool get isPending => status.toLowerCase() == 'pending' || status.toLowerCase() == 'draft';
  bool get isConfirmed => status.toLowerCase() == 'confirmed';
  bool get isContracted => status.toLowerCase() == 'contracted' || status.toLowerCase() == 'voucher_ready';
  bool get isCancelled => status.toLowerCase() == 'cancelled';

  const BookingEntity({
    required this.id,
    required this.userId,
    required this.roomId,
    this.ownerId,
    this.isPhoneContacted = false,
    this.isVisited = false,
    this.isReadByTenant = false,
    this.isReadByOwner = false,
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
    bool? isReadByTenant,
    bool? isReadByOwner,
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
      isReadByTenant: isReadByTenant ?? this.isReadByTenant,
      isReadByOwner: isReadByOwner ?? this.isReadByOwner,
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

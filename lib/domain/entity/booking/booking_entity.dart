abstract class BookingStatus {
  static const draft = 'draft';
  static const pending = 'pending';
  static const confirmed = 'confirmed';
  static const cancelled = 'cancelled';
  static const contracted = 'contracted';
  static const expired = 'expired';
}

class BookingEntity {
  final String id;
  final String userId; // Tenant ID
  final String roomId; // Room ID
  final String? ownerId; // Owner ID
  final bool isPhoneContacted;
  final bool isVisited;
  final bool isReadByTenant;
  final bool isReadByOwner;
  final String status; // "draft", "pending", "confirmed", "cancelled", "contracted", "expired"
  final DateTime? createdAt;
  final DateTime? updatedAt;
  // Optional display metadata
  final String? roomName;
  final double? roomPrice;
  final String? roomImageUrl;
  final String? tenantName;
  final String? tenantPhone;

  /// Helper getters for the refined workflow states
  bool get isDraft => status.toLowerCase() == BookingStatus.draft;
  bool get isPending => status.toLowerCase() == BookingStatus.pending; // submitted only
  bool get isConfirmed => status.toLowerCase() == BookingStatus.confirmed;
  bool get isContracted =>
      status.toLowerCase() == BookingStatus.contracted || status.toLowerCase() == 'voucher_ready';
  bool get isCancelled => status.toLowerCase() == BookingStatus.cancelled;
  bool get isExpired => status.toLowerCase() == BookingStatus.expired;

  /// A booking the tenant actually submitted (visible to the owner)
  bool get isSubmitted => !isDraft;

  const BookingEntity({
    required this.id,
    required this.userId,
    required this.roomId,
    this.ownerId,
    this.isPhoneContacted = false,
    this.isVisited = false,
    this.isReadByTenant = false,
    this.isReadByOwner = false,
    this.status = BookingStatus.draft,
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

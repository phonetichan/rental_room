import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entity/booking/booking_entity.dart';

part 'booking_model.freezed.dart';

@freezed
class BookingModel with _$BookingModel {
  const BookingModel._();

  const factory BookingModel({
    required String id,
    required String userId,
    required String roomId,
    String? ownerId,
    @Default(false) bool isPhoneContacted,
    @Default(false) bool isVisited,
    @Default(false) bool isReadByTenant,
    @Default(false) bool isReadByOwner,
    @Default('draft') String status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? roomName,
    double? roomPrice,
    String? roomImageUrl,
    String? tenantName,
    String? tenantPhone,
  }) = _BookingModel;

  factory BookingModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return BookingModel(
      id: doc.id,
      userId: data['userId'] as String? ?? '',
      roomId: data['roomId'] as String? ?? '',
      ownerId: data['ownerId'] as String?,
      isPhoneContacted: data['isPhoneContacted'] as bool? ?? false,
      isVisited: data['isVisited'] as bool? ?? false,
      isReadByTenant: data['isReadByTenant'] as bool? ?? false,
      isReadByOwner: data['isReadByOwner'] as bool? ?? false,
      status: data['status'] as String? ?? 'draft',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
      roomName: data['roomName'] as String?,
      roomPrice: (data['roomPrice'] as num?)?.toDouble(),
      roomImageUrl: data['roomImageUrl'] as String?,
      tenantName: data['tenantName'] as String?,
      tenantPhone: data['tenantPhone'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'roomId': roomId,
      if (ownerId != null) 'ownerId': ownerId,
      'isPhoneContacted': isPhoneContacted,
      'isVisited': isVisited,
      'isReadByTenant': isReadByTenant,
      'isReadByOwner': isReadByOwner,
      'status': status,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      if (roomName != null) 'roomName': roomName,
      if (roomPrice != null) 'roomPrice': roomPrice,
      if (roomImageUrl != null) 'roomImageUrl': roomImageUrl,
      if (tenantName != null) 'tenantName': tenantName,
      if (tenantPhone != null) 'tenantPhone': tenantPhone,
    };
  }

  BookingEntity toEntity() {
    return BookingEntity(
      id: id,
      userId: userId,
      roomId: roomId,
      ownerId: ownerId,
      isPhoneContacted: isPhoneContacted,
      isVisited: isVisited,
      isReadByTenant: isReadByTenant,
      isReadByOwner: isReadByOwner,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      roomName: roomName,
      roomPrice: roomPrice,
      roomImageUrl: roomImageUrl,
      tenantName: tenantName,
      tenantPhone: tenantPhone,
    );
  }

  factory BookingModel.fromEntity(BookingEntity entity) {
    return BookingModel(
      id: entity.id,
      userId: entity.userId,
      roomId: entity.roomId,
      ownerId: entity.ownerId,
      isPhoneContacted: entity.isPhoneContacted,
      isVisited: entity.isVisited,
      isReadByTenant: entity.isReadByTenant,
      isReadByOwner: entity.isReadByOwner,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      roomName: entity.roomName,
      roomPrice: entity.roomPrice,
      roomImageUrl: entity.roomImageUrl,
      tenantName: entity.tenantName,
      tenantPhone: entity.tenantPhone,
    );
  }
}

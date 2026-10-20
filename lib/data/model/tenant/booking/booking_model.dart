
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entity/booking/booking_entity.dart';

part 'booking_model.freezed.dart';

@freezed
abstract class BookingModel with _$BookingModel {
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
    @Default(false) bool isRemovedByTenant,
    @Default(false) bool isRemovedByOwner,
    @Default(BookingStatus.draft) String status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? roomName,
    double? roomPrice,
    String? roomImageUrl,
    String? tenantName,
    String? tenantPhone,
  }) = _BookingModel;

  /// Create a model from a Firestore document.
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
      isRemovedByTenant: data['isRemovedByTenant'] as bool? ?? false,
      isRemovedByOwner: data['isRemovedByOwner'] as bool? ?? false,
      status: data['status'] as String? ?? BookingStatus.draft,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
      roomName: data['roomName'] as String?,
      roomPrice: (data['roomPrice'] as num?)?.toDouble(),
      roomImageUrl: data['roomImageUrl'] as String?,
      tenantName: data['tenantName'] as String?,
      tenantPhone: data['tenantPhone'] as String?,
    );
  }

  /// Convert the model to a Firestore-compatible map.
  ///
  /// Use this with set() or update() as appropriate.
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'roomId': roomId,
      'ownerId': ownerId,
      'isPhoneContacted': isPhoneContacted,
      'isVisited': isVisited,
      'isReadByTenant': isReadByTenant,
      'isReadByOwner': isReadByOwner,
      'isRemovedByTenant': isRemovedByTenant,
      'isRemovedByOwner': isRemovedByOwner,
      'status': status,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'roomName': roomName,
      'roomPrice': roomPrice,
      'roomImageUrl': roomImageUrl,
      'tenantName': tenantName,
      'tenantPhone': tenantPhone,
    };
  }

  /// Convert the model to the domain entity.
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
      isRemovedByTenant: isRemovedByTenant,
      isRemovedByOwner: isRemovedByOwner,
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

  /// Create a model from the domain entity.
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
      isRemovedByTenant: entity.isRemovedByTenant,
      isRemovedByOwner: entity.isRemovedByOwner,
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

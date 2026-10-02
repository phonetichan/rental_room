// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../domain/entity/booking_entity.dart';
//
// class BookingModel {
//   final String id;
//   final String userId;
//   final String roomId;
//   final String? ownerId;
//   final bool isPhoneContacted;
//   final bool isVisited;
//   final String status;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   // Display metadata
//   final String? roomName;
//   final double? roomPrice;
//   final String? roomImageUrl;
//   final String? tenantName;
//   final String? tenantPhone;
//
//   BookingModel({
//     required this.id,
//     required this.userId,
//     required this.roomId,
//     this.ownerId,
//     this.isPhoneContacted = false,
//     this.isVisited = false,
//     this.status = 'draft',
//     this.createdAt,
//     this.updatedAt,
//     this.roomName,
//     this.roomPrice,
//     this.roomImageUrl,
//     this.tenantName,
//     this.tenantPhone,
//   });
//
//   factory BookingModel.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>? ?? {};
//
//     bool contacted = data['isPhoneContacted'] as bool? ?? false;
//     bool visited = data['isVisited'] as bool? ?? false;
//     String currentStatus = data['status'] as String? ?? 'draft';
//
//     if (contacted && visited && currentStatus == 'draft') {
//       currentStatus = 'pending';
//     }
//
//     return BookingModel(
//       id: doc.id,
//       userId: data['userId'] as String? ?? '',
//       roomId: data['roomId'] as String? ?? '',
//       ownerId: data['ownerId'] as String?,
//       isPhoneContacted: contacted,
//       isVisited: visited,
//       status: currentStatus,
//       createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
//       updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
//       roomName: data['roomName'] as String?,
//       roomPrice: (data['roomPrice'] as num?)?.toDouble(),
//       roomImageUrl: data['roomImageUrl'] as String?,
//       tenantName: data['tenantName'] as String?,
//       tenantPhone: data['tenantPhone'] as String?,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     String finalStatus = status;
//     if (isPhoneContacted && isVisited && finalStatus == 'draft') {
//       finalStatus = 'pending';
//     }
//
//     return {
//       'userId': userId,
//       'roomId': roomId,
//       if (ownerId != null) 'ownerId': ownerId,
//       'isPhoneContacted': isPhoneContacted,
//       'isVisited': isVisited,
//       'status': finalStatus,
//       'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
//       'updatedAt': FieldValue.serverTimestamp(),
//       if (roomName != null) 'roomName': roomName,
//       if (roomPrice != null) 'roomPrice': roomPrice,
//       if (roomImageUrl != null) 'roomImageUrl': roomImageUrl,
//       if (tenantName != null) 'tenantName': tenantName,
//       if (tenantPhone != null) 'tenantPhone': tenantPhone,
//     };
//   }
//
//   BookingEntity toEntity() {
//     String finalStatus = status;
//     if (isPhoneContacted && isVisited && finalStatus == 'draft') {
//       finalStatus = 'pending';
//     }
//
//     return BookingEntity(
//       id: id,
//       userId: userId,
//       roomId: roomId,
//       ownerId: ownerId,
//       isPhoneContacted: isPhoneContacted,
//       isVisited: isVisited,
//       status: finalStatus,
//       createdAt: createdAt,
//       updatedAt: updatedAt,
//       roomName: roomName,
//       roomPrice: roomPrice,
//       roomImageUrl: roomImageUrl,
//       tenantName: tenantName,
//       tenantPhone: tenantPhone,
//     );
//   }
//
//   factory BookingModel.fromEntity(BookingEntity entity) {
//     String finalStatus = entity.status;
//     if (entity.isPhoneContacted && entity.isVisited && finalStatus == 'draft') {
//       finalStatus = 'pending';
//     }
//
//     return BookingModel(
//       id: entity.id,
//       userId: entity.userId,
//       roomId: entity.roomId,
//       ownerId: entity.ownerId,
//       isPhoneContacted: entity.isPhoneContacted,
//       isVisited: entity.isVisited,
//       status: finalStatus,
//       createdAt: entity.createdAt,
//       updatedAt: entity.updatedAt,
//       roomName: entity.roomName,
//       roomPrice: entity.roomPrice,
//       roomImageUrl: entity.roomImageUrl,
//       tenantName: entity.tenantName,
//       tenantPhone: entity.tenantPhone,
//     );
//   }
// }
//
//


import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/booking_entity.dart';

class BookingModel {
  final String id;
  final String userId;
  final String roomId;
  final String? ownerId;
  final bool isPhoneContacted;
  final bool isVisited;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Display metadata
  final String? roomName;
  final double? roomPrice;
  final String? roomImageUrl;
  final String? tenantName;
  final String? tenantPhone;

  BookingModel({
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

  factory BookingModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return BookingModel(
      id: doc.id,
      userId: data['userId'] as String? ?? '',
      roomId: data['roomId'] as String? ?? '',
      ownerId: data['ownerId'] as String?,
      isPhoneContacted: data['isPhoneContacted'] as bool? ?? false,
      isVisited: data['isVisited'] as bool? ?? false,
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

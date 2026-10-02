// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../domain/entity/contract_entity.dart';
//
// class ContractModel extends ContractEntity {
//   const ContractModel({
//     required super.id,
//     required super.bookingId,
//     required super.roomId,
//     required super.ownerId,
//     required super.tenantId,
//     required super.startDate,
//     required super.endDate,
//     required super.durationMonth,
//     required super.monthlyRent,
//     required super.description,
//     required super.createdAt,
//   });
//
//   factory ContractModel.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>? ?? {};
//     return ContractModel(
//       id: doc.id,
//       bookingId: data['bookingId'] as String? ?? '',
//       roomId: data['roomId'] as String? ?? '',
//       ownerId: data['ownerId'] as String? ?? '',
//       tenantId: data['tenantId'] as String? ?? '',
//       startDate: (data['startDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
//       endDate: (data['endDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
//       durationMonth: (data['durationMonth'] as num?)?.toInt() ?? 3,
//       monthlyRent: (data['monthlyRent'] as num?)?.toDouble() ?? 0.0,
//       description: data['description'] as String? ?? '',
//       createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
//     );
//   }
//
//   Map<String, dynamic> toFirestore() {
//     return {
//       'bookingId': bookingId,
//       'roomId': roomId,
//       'ownerId': ownerId,
//       'tenantId': tenantId,
//       'startDate': Timestamp.fromDate(startDate),
//       'endDate': Timestamp.fromDate(endDate),
//       'durationMonth': durationMonth,
//       'monthlyRent': monthlyRent,
//       'description': description,
//       'createdAt': FieldValue.serverTimestamp(),
//     };
//   }
//
//   factory ContractModel.fromEntity(ContractEntity entity) {
//     return ContractModel(
//       id: entity.id,
//       bookingId: entity.bookingId,
//       roomId: entity.roomId,
//       ownerId: entity.ownerId,
//       tenantId: entity.tenantId,
//       startDate: entity.startDate,
//       endDate: entity.endDate,
//       durationMonth: entity.durationMonth,
//       monthlyRent: entity.monthlyRent,
//       description: entity.description,
//       createdAt: entity.createdAt,
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/contract_entity.dart';
import '../../domain/entity/contract_status.dart'; // Import your status enum

class ContractModel extends ContractEntity {
  const ContractModel({
    required super.id,
    required super.bookingId,
    required super.roomId,
    required super.ownerId,
    required super.tenantId,
    required super.startDate,
    required super.endDate,
    required super.durationMonth,
    required super.monthlyRent,
    required super.description,
    super.status = ContractStatus.pending, // Added status parameter
    required super.createdAt,
  });

  factory ContractModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return ContractModel(
      id: doc.id,
      bookingId: data['bookingId'] as String? ?? '',
      roomId: data['roomId'] as String? ?? '',
      ownerId: data['ownerId'] as String? ?? '',
      tenantId: data['tenantId'] as String? ?? '',
      startDate: (data['startDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      endDate: (data['endDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      durationMonth: (data['durationMonth'] as num?)?.toInt() ?? 3,
      monthlyRent: (data['monthlyRent'] as num?)?.toDouble() ?? 0.0,
      description: data['description'] as String? ?? '',
      status: ContractStatus.fromString(data['status'] as String? ?? ''), // Parse enum safely
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'bookingId': bookingId,
      'roomId': roomId,
      'ownerId': ownerId,
      'tenantId': tenantId,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'durationMonth': durationMonth,
      'monthlyRent': monthlyRent,
      'description': description,
      'status': status.value, // Save enum string representation
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory ContractModel.fromEntity(ContractEntity entity) {
    return ContractModel(
      id: entity.id,
      bookingId: entity.bookingId,
      roomId: entity.roomId,
      ownerId: entity.ownerId,
      tenantId: entity.tenantId,
      startDate: entity.startDate,
      endDate: entity.endDate,
      durationMonth: entity.durationMonth,
      monthlyRent: entity.monthlyRent,
      description: entity.description,
      status: entity.status,
      createdAt: entity.createdAt,
    );
  }
}
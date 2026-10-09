import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entity/contract/contract_entity.dart';
import '../../../../domain/entity/contract/contract_status.dart';

part 'contract_model.freezed.dart';

@freezed
class ContractModel with _$ContractModel {
  const ContractModel._();

  const factory ContractModel({
    required String id,
    required String bookingId,
    required String roomId,
    required String ownerId,
    required String tenantId,
    required DateTime startDate,
    required DateTime endDate,
    required int durationMonth,
    required double monthlyRent,
    required String description,
    @Default(ContractStatus.pending) ContractStatus status,
    required DateTime createdAt,
  }) = _ContractModel;

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
      status: ContractStatus.fromString(data['status'] as String? ?? ''),
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
      'status': status.value,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  ContractEntity toEntity() {
    return ContractEntity(
      id: id,
      bookingId: bookingId,
      roomId: roomId,
      ownerId: ownerId,
      tenantId: tenantId,
      startDate: startDate,
      endDate: endDate,
      durationMonth: durationMonth,
      monthlyRent: monthlyRent,
      description: description,
      status: status,
      createdAt: createdAt,
    );
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

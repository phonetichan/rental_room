// class ContractEntity {
//   final String id;
//   final String bookingId;
//   final String roomId;
//   final String ownerId;
//   final String tenantId;
//   final DateTime startDate;
//   final DateTime endDate;
//   final int durationMonth;
//   final double monthlyRent;
//   final String description;
//   final DateTime createdAt;
//
//   const ContractEntity({
//     required this.id,
//     required this.bookingId,
//     required this.roomId,
//     required this.ownerId,
//     required this.tenantId,
//     required this.startDate,
//     required this.endDate,
//     required this.durationMonth,
//     required this.monthlyRent,
//     required this.description,
//     required this.createdAt,
//   });
//
//   ContractEntity copyWith({
//     String? id,
//     String? bookingId,
//     String? roomId,
//     String? ownerId,
//     String? tenantId,
//     DateTime? startDate,
//     DateTime? endDate,
//     int? durationMonth,
//     double? monthlyRent,
//     String? description,
//     DateTime? createdAt,
//   }) {
//     return ContractEntity(
//       id: id ?? this.id,
//       bookingId: bookingId ?? this.bookingId,
//       roomId: roomId ?? this.roomId,
//       ownerId: ownerId ?? this.ownerId,
//       tenantId: tenantId ?? this.tenantId,
//       startDate: startDate ?? this.startDate,
//       endDate: endDate ?? this.endDate,
//       durationMonth: durationMonth ?? this.durationMonth,
//       monthlyRent: monthlyRent ?? this.monthlyRent,
//       description: description ?? this.description,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }
// }

import 'contract_status.dart';

class ContractEntity {
  final String id;
  final String bookingId;
  final String roomId;
  final String ownerId;
  final String tenantId;
  final DateTime startDate;
  final DateTime endDate;
  final int durationMonth;
  final double monthlyRent;
  final String description;
  final ContractStatus status;
  final DateTime createdAt;

  const ContractEntity({
    required this.id,
    required this.bookingId,
    required this.roomId,
    required this.ownerId,
    required this.tenantId,
    required this.startDate,
    required this.endDate,
    required this.durationMonth,
    required this.monthlyRent,
    required this.description,
    this.status = ContractStatus.pending,
    required this.createdAt,
  });

  /// Convenience getters for state checks
  bool get isFinalized => status == ContractStatus.active || status == ContractStatus.expired;
  bool get isEditable => status == ContractStatus.pending;

  ContractEntity copyWith({
    String? id,
    String? bookingId,
    String? roomId,
    String? ownerId,
    String? tenantId,
    DateTime? startDate,
    DateTime? endDate,
    int? durationMonth,
    double? monthlyRent,
    String? description,
    ContractStatus? status,
    DateTime? createdAt,
  }) {
    return ContractEntity(
      id: id ?? this.id,
      bookingId: bookingId ?? this.bookingId,
      roomId: roomId ?? this.roomId,
      ownerId: ownerId ?? this.ownerId,
      tenantId: tenantId ?? this.tenantId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      durationMonth: durationMonth ?? this.durationMonth,
      monthlyRent: monthlyRent ?? this.monthlyRent,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
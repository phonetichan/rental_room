import 'package:rental_room/domain/domain.dart';

extension ContractStatusX on ContractEntity {
  DateTime get _today {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day);
  }
  /// Counts toward the badge only while the contract is active and ending soon
  bool get countsForBadge =>
      status == ContractStatus.active && !isExpired && isOneMonthLeft;
  bool get isExpired => !DateTime.now().isBefore(endDate);

  int get daysLeft {
    final end = DateTime(endDate.year, endDate.month, endDate.day);
    final diff = end.difference(_today).inDays;
    return diff < 0 ? 0 : diff;
  }

  bool get isOneMonthLeft {
    if (isExpired) return false;
    final n = DateTime.now();
    final oneMonthLater = DateTime(n.year, n.month + 1, n.day);
    return !endDate.isAfter(oneMonthLater);
  }

  bool get showsCountdown =>
      (status == ContractStatus.active || status == ContractStatus.expired) &&
          (isExpired || isOneMonthLeft);
  /// Status to show in the UI, even if Firestore still says active
  ContractStatus get effectiveStatus =>
      (status == ContractStatus.active && isExpired)
          ? ContractStatus.expired
          : status;
}

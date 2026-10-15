part of 'contract_cubit.dart';

abstract class ContractState {
  const ContractState();

  const factory ContractState.initial() = ContractInitial;
  const factory ContractState.loading() = ContractLoading;
  const factory ContractState.contractLoaded(ContractEntity? contract) = ContractLoaded;
  const factory ContractState.historyLoaded({
    required List<ContractEntity> contracts,
    required Map<String, RoomEntity> roomsByRoomId,
  }) = ContractHistoryLoaded;
  const factory ContractState.revenueCalculated({
    required double totalMonthlyRevenue,
    required List<ContractEntity> contracts,
  }) = ContractRevenueCalculated;
  const factory ContractState.success({
    required String message,
    ContractEntity? contract,
  }) = ContractSuccess;
  const factory ContractState.failure(String message) = ContractFailure;

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(ContractEntity? contract) contractLoaded,
    required T Function(List<ContractEntity> contracts, Map<String, RoomEntity> roomsByRoomId) historyLoaded,
    required T Function(double totalMonthlyRevenue, List<ContractEntity> contracts) revenueCalculated,
    required T Function(String message, ContractEntity? contract) success,
    required T Function(String message) failure,
  }) {
    if (this is ContractInitial) return initial();
    if (this is ContractLoading) return loading();
    if (this is ContractLoaded) return contractLoaded((this as ContractLoaded).contract);
    if (this is ContractHistoryLoaded) {
      final s = this as ContractHistoryLoaded;
      return historyLoaded(s.contracts, s.roomsByRoomId);
    }
    if (this is ContractRevenueCalculated) {
      final s = this as ContractRevenueCalculated;
      return revenueCalculated(s.totalMonthlyRevenue, s.contracts);
    }
    if (this is ContractSuccess) {
      final s = this as ContractSuccess;
      return success(s.message, s.contract);
    }
    if (this is ContractFailure) return failure((this as ContractFailure).message);
    throw Exception('Unknown state');
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(ContractEntity? contract)? contractLoaded,
    T Function(List<ContractEntity> contracts, Map<String, RoomEntity> roomsByRoomId)? historyLoaded,
    T Function(double totalMonthlyRevenue, List<ContractEntity> contracts)? revenueCalculated,
    T Function(String message, ContractEntity? contract)? success,
    T Function(String message)? failure,
    required T Function() orElse,
  }) {
    if (this is ContractInitial && initial != null) return initial();
    if (this is ContractLoading && loading != null) return loading();
    if (this is ContractLoaded && contractLoaded != null) return contractLoaded((this as ContractLoaded).contract);
    if (this is ContractHistoryLoaded && historyLoaded != null) {
      final s = this as ContractHistoryLoaded;
      return historyLoaded(s.contracts, s.roomsByRoomId);
    }
    if (this is ContractRevenueCalculated && revenueCalculated != null) {
      final s = this as ContractRevenueCalculated;
      return revenueCalculated(s.totalMonthlyRevenue, s.contracts);
    }
    if (this is ContractSuccess && success != null) {
      final s = this as ContractSuccess;
      return success(s.message, s.contract);
    }
    if (this is ContractFailure && failure != null) return failure((this as ContractFailure).message);
    return orElse();
  }
}

class ContractInitial extends ContractState {
  const ContractInitial();
}

class ContractLoading extends ContractState {
  const ContractLoading();
}

class ContractLoaded extends ContractState {
  final ContractEntity? contract;
  const ContractLoaded(this.contract);
}

class ContractHistoryLoaded extends ContractState {
  final List<ContractEntity> contracts;
  final Map<String, RoomEntity> roomsByRoomId;
  const ContractHistoryLoaded({required this.contracts, required this.roomsByRoomId});
}

class ContractRevenueCalculated extends ContractState {
  final double totalMonthlyRevenue;
  final List<ContractEntity> contracts;
  const ContractRevenueCalculated({required this.totalMonthlyRevenue, required this.contracts});
}

class ContractSuccess extends ContractState {
  final String message;
  final ContractEntity? contract;
  const ContractSuccess({required this.message, this.contract});
}

class ContractFailure extends ContractState {
  final String message;
  const ContractFailure(this.message);
}

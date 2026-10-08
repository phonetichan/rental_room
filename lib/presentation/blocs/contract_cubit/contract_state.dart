part of 'contract_cubit.dart';

sealed class ContractState {
  const ContractState();

  const factory ContractState.initial() = ContractInitial;
  const factory ContractState.loading() = ContractLoading;
  const factory ContractState.contractLoaded(ContractEntity? contract) = ContractLoaded;
  const factory ContractState.revenueCalculated({
    required double totalMonthlyRevenue,
    required List<ContractEntity> contracts,
  }) = ContractRevenueCalculated;
  const factory ContractState.success({
    required String message,
    ContractEntity? contract,
  }) = ContractSuccess;
  const factory ContractState.failure(String message) = ContractFailure;
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

class ContractRevenueCalculated extends ContractState {
  final double totalMonthlyRevenue;
  final List<ContractEntity> contracts;
  const ContractRevenueCalculated({
    required this.totalMonthlyRevenue,
    required this.contracts,
  });
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

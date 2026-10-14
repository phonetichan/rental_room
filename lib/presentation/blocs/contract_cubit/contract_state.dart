part of 'contract_cubit.dart';

@freezed
class ContractState with _$ContractState {
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

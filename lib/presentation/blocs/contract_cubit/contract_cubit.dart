import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_room/domain/domain.dart';

part 'contract_state.dart';

class ContractCubit extends Cubit<ContractState> {
  final GetContractByBookingUseCase _getContractByBookingUseCase;
  final CreateContractUseCase _createContractUseCase;
  final UpdateContractUseCase _updateContractUseCase;
  final ContractRepository _contractRepository;

  ContractCubit(
    this._getContractByBookingUseCase,
    this._createContractUseCase,
    this._updateContractUseCase,
    this._contractRepository,
  ) : super(const ContractState.initial());

  Future<void> loadContractByBookingId(String bookingId) async {
    emit(const ContractState.loading());
    final result = await _getContractByBookingUseCase(bookingId);
    result
      ..onSuccess((contract) {
        emit(ContractState.contractLoaded(contract));
      })
      ..onError((failure) {
        emit(ContractState.failure(failure.reason));
      });
  }

  Future<void> createContract(ContractEntity contract) async {
    emit(const ContractState.loading());
    final result = await _createContractUseCase(contract);
    result
      ..onSuccess((created) {
        emit(ContractState.success(message: 'Contract created successfully!', contract: created));
      })
      ..onError((failure) {
        emit(ContractState.failure(failure.reason));
      });
  }

  Future<void> updateContract(ContractEntity contract) async {
    emit(const ContractState.loading());
    final result = await _updateContractUseCase(contract);
    result
      ..onSuccess((updated) {
        emit(ContractState.success(message: 'Contract updated successfully!', contract: updated));
      })
      ..onError((failure) {
        emit(ContractState.failure(failure.reason));
      });
  }

  /// Calculates the total monthly revenue for a given owner from their active contracts.
  Future<void> calculateOwnerMonthlyRevenue(String ownerId, {bool showLoading = true}) async {
    if (ownerId.isEmpty) {
      emit(const ContractState.revenueCalculated(totalMonthlyRevenue: 0.0, contracts: []));
      return;
    }

    // Only emit loading if requested and we don't already have calculated revenue displayed
    if (showLoading && state is! ContractRevenueCalculated) {
      emit(const ContractState.loading());
    }

    try {
      final contracts = await _contractRepository.getContractsByOwnerId(ownerId);

      // Sum monthly rent for contracts that are active
      double totalRevenue = 0.0;
      for (var contract in contracts) {
        if (contract.status == ContractStatus.active ||
            contract.status.value.toLowerCase() == 'active') {
          totalRevenue += contract.monthlyRent;
        }
      }

      emit(ContractState.revenueCalculated(
        totalMonthlyRevenue: totalRevenue,
        contracts: contracts,
      ));
    } catch (e) {
      emit(ContractState.failure(e.toString().replaceAll('Exception: ', '')));
    }
  }
}

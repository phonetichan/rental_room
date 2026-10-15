import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rental_room/di/di.dart';
import 'package:rental_room/domain/domain.dart';
import 'package:rental_room/presentation/extensions/contract/contract_extensions.dart';

part 'contract_state.dart';

@lazySingleton
class ContractCubit extends Cubit<ContractState> {
  final GetContractByBookingUseCase _getContractByBookingUseCase;
  final CreateContractUseCase _createContractUseCase;
  final UpdateContractUseCase _updateContractUseCase;
  final ContractRepository _contractRepository;

  List<ContractEntity>? _cachedContracts;
  Map<String, RoomEntity>? _cachedRoomsMap;
  List<ContractEntity>? get cachedContracts => _cachedContracts;

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

  Future<void> loadContractHistory(String userId, bool isOwner) async {
    // Only show loading state on the first load if we don't have cached contracts yet
    if (_cachedContracts == null) {
      emit(const ContractState.loading());
    } else {
      // If we already have cache, emit ready state immediately while refreshing in background
      emit(ContractState.historyLoaded(
        contracts: _cachedContracts!,
        roomsByRoomId: _cachedRoomsMap ?? {},
      ));
    }

    try {
      final expireContractUseCase = inject<ExpireContractUseCase>();
      final roomRepo = inject<RoomRepository>();

      final contractsList = isOwner
          ? await _contractRepository.getContractsByOwnerId(userId)
          : await _contractRepository.getContractsByTenantId(userId);

      final List<ContractEntity> activeContracts = [];
      for (final c in contractsList) {
        final isExpired = ContractStatusX(c).isExpired || c.status == ContractStatus.expired;
        if (isExpired) {
          try {
            await expireContractUseCase(c);
          } catch (_) {}
        } else if (c.status == ContractStatus.active) {
          activeContracts.add(c);
        }
      }

      final roomIds = activeContracts
          .map((c) => c.roomId)
          .where((id) => id.isNotEmpty)
          .toSet()
          .toList();

      final roomsList = await Future.wait(
        roomIds.map((id) => roomRepo.getRoomById(id)),
      );
      final roomsMap = {
        for (final r in roomsList.whereType<RoomEntity>()) r.id: r,
      };

      _cachedContracts = activeContracts;
      _cachedRoomsMap = roomsMap;

      emit(ContractState.historyLoaded(contracts: activeContracts, roomsByRoomId: roomsMap));
    } catch (e) {
      if (_cachedContracts != null) {
        emit(ContractState.historyLoaded(
          contracts: _cachedContracts!,
          roomsByRoomId: _cachedRoomsMap ?? {},
        ));
      } else {
        emit(ContractState.failure(e.toString().replaceAll('Exception: ', '')));
      }
    }
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

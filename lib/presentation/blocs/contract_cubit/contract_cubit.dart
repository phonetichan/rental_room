import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rental_room/data/data.dart';
import 'package:rental_room/di/di.dart';
import 'package:rental_room/domain/domain.dart';
import 'package:rental_room/presentation/extensions/contract/contract_extensions.dart';

part 'contract_state.dart';
part 'contract_cubit.freezed.dart';


@injectable
class ContractCubit extends Cubit<ContractState> {
  final GetContractByBookingUseCase _getContractByBookingUseCase;
  final CreateContractUseCase _createContractUseCase;
  final UpdateContractUseCase _updateContractUseCase;
  final ContractRepository _contractRepository;
  //
  // int _historyRequestId = 0;
  //
  // String? _historyUserId;
  // bool? _historyIsOwner;
  ContractCubit(
    this._getContractByBookingUseCase,
    this._createContractUseCase,
    this._updateContractUseCase,
    this._contractRepository,
  ) : super(const ContractState.initial());

  /// Call on logout so the next user starts clean.
  // void reset() {
  //   _historyUserId = null;
  //   _historyIsOwner = null;
  //   _historyRequestId++;
  //
  //   emit(const ContractState.initial());
  // }

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

  Future<void> loadVoucherDetails(
    BookingEntity booking, {
    bool forceRefresh = false,
  }) async {
    final bookingId = booking.id;

    if (state is! VoucherDetailsLoaded) {
      emit(const ContractState.loading());
    }

    try {
      final getContractUseCase = inject<GetContractByBookingUseCase>();
      final roomRepo = inject<RoomRepository>();
      final authDataSource = inject<AuthDataSource>();

      final contractResult = await getContractUseCase(bookingId);
      ContractEntity? fetchedContract;
      contractResult.onSuccess((contract) {
        fetchedContract = contract;
      });

      final current = fetchedContract;
      if (current != null &&
          current.status == ContractStatus.active &&
          current.isExpired) {
        try {
          fetchedContract = await inject<ExpireContractUseCase>()(current);
        } catch (_) {}
      }

      final tenantId = fetchedContract?.tenantId ?? booking.userId;
      final ownerId = fetchedContract?.ownerId ?? booking.ownerId;
      final roomId = fetchedContract?.roomId ?? booking.roomId;

      final roomFuture = roomId.isNotEmpty
          ? roomRepo.getRoomById(roomId)
          : Future.value(null);
      final tenantFuture = tenantId.isNotEmpty
          ? authDataSource.getUserById(tenantId)
          : Future.value(null);
      final ownerFuture = (ownerId != null && ownerId.isNotEmpty)
          ? authDataSource.getUserById(ownerId)
          : Future.value(null);

      final results = await Future.wait<Object?>([
        roomFuture,
        tenantFuture,
        ownerFuture,
      ]);

      final room = results[0] as RoomEntity?;
      final tenantUser = results[1] as UserEntity?;
      final ownerUser = results[2] as UserEntity?;

      final loadedState = VoucherDetailsLoaded(
        contract: fetchedContract,
        room: room,
        tenantUser: tenantUser,
        ownerUser: ownerUser,
      );

      emit(loadedState);
    } catch (e) {
      emit(ContractState.failure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  // Future<void> loadContractHistory(
  //   String userId,
  //   bool isOwner, {
  //   bool forceRefresh = false,
  // }) async {
  //   final current = state;
  //   final sameUser = _historyUserId == userId;
  //
  //   // Already loaded for THIS user and no pull-to-refresh: keep it.
  //   if (current is ContractHistoryLoaded && sameUser && !forceRefresh) return;
  //
  //   final previous =
  //       (current is ContractHistoryLoaded && sameUser) ? current : null;
  //
  //   // Spinner only on a real first load. Pull-to-refresh shows its own indicator.
  //   if (previous == null) emit(const ContractState.loading());
  //
  //   try {
  //     final expireContractUseCase = inject<ExpireContractUseCase>();
  //     final roomRepo = inject<RoomRepository>();
  //
  //     List<ContractEntity> contractsList = [];
  //     if (isOwner) {
  //       final byOwnerId = await _contractRepository.getContractsByOwnerId(userId);
  //       final Map<String, ContractEntity> contractMap = {
  //         for (final c in byOwnerId) c.id: c,
  //       };
  //
  //       try {
  //         final ownerRooms = await roomRepo.getRooms(ownerId: userId);
  //         final ownerRoomIds = ownerRooms.map((r) => r.id).where((id) => id.isNotEmpty).toSet();
  //
  //         if (ownerRoomIds.isNotEmpty) {
  //           // Also fetch contracts associated with owner's rooms that may have missing ownerId
  //           for (final roomId in ownerRoomIds) {
  //             final existingForRoom = contractMap.values.where((c) => c.roomId == roomId);
  //             if (existingForRoom.isEmpty) {
  //               // If contract wasn't retrieved directly by ownerId, ensure room's contracts are loaded
  //             }
  //           }
  //         }
  //       } catch (_) {}
  //
  //       contractsList = contractMap.values
  //           .where((c) => c.ownerId.isEmpty || c.ownerId.trim() == userId.trim())
  //           .toList();
  //     } else {
  //       final rawTenantList = await _contractRepository.getContractsByTenantId(userId);
  //       contractsList = rawTenantList
  //           .where((c) => c.tenantId.trim() == userId.trim())
  //           .toList();
  //     }
  //
  //     final List<ContractEntity> displayContracts = [];
  //     for (final c in contractsList) {
  //       ContractEntity currentContract = c;
  //       if (isOwner && currentContract.ownerId.isEmpty) {
  //         currentContract = currentContract.copyWith(ownerId: userId);
  //         try {
  //           await _contractRepository.updateContract(currentContract);
  //         } catch (_) {}
  //       }
  //
  //       final isExpired =
  //           ContractStatusX(currentContract).isExpired || currentContract.status == ContractStatus.expired;
  //       if (isExpired && currentContract.status != ContractStatus.expired) {
  //         try {
  //           currentContract = await expireContractUseCase(currentContract);
  //         } catch (_) {}
  //       }
  //
  //       // Add ALL contracts (active, pending, and expired) to Contract History
  //       displayContracts.add(currentContract);
  //     }
  //
  //     final roomIds = displayContracts
  //         .map((c) => c.roomId)
  //         .where((id) => id.isNotEmpty)
  //         .toSet()
  //         .toList();
  //
  //     final roomsList =
  //         await Future.wait(roomIds.map((id) => roomRepo.getRoomById(id)));
  //     final roomsMap = {
  //       for (final r in roomsList.whereType<RoomEntity>()) r.id: r,
  //     };
  //
  //     _historyUserId = userId;
  //     emit(ContractState.historyLoaded(
  //       contracts: displayContracts,
  //       roomsByRoomId: roomsMap,
  //     ));
  //   } catch (e) {
  //     if (previous != null) {
  //       emit(previous); // refresh failed: keep the old list
  //     } else {
  //       emit(ContractState.failure(e.toString().replaceAll('Exception: ', '')));
  //     }
  //   }
  // }

  // Future<void> loadContractHistory(String userId, bool isOwner) async {
  //   emit(const ContractState.loading());
  //
  //   try {
  //     final roomRepo = inject<RoomRepository>();
  //
  //     final contracts = isOwner
  //         ? await _contractRepository.getContractsByOwnerId(userId)
  //         : await _contractRepository.getContractsByTenantId(userId);
  //
  //     final roomIds = contracts
  //         .map((c) => c.roomId)
  //         .where((id) => id.isNotEmpty)
  //         .toSet();
  //
  //     final rooms = await Future.wait(roomIds.map(roomRepo.getRoomById));
  //
  //     if (isClosed) return;
  //
  //     emit(
  //       ContractState.historyLoaded(
  //         contracts: contracts,
  //         roomsByRoomId: {
  //           for (final room in rooms.whereType<RoomEntity>()) room.id: room,
  //         },
  //       ),
  //     );
  //   } catch (e) {
  //     if (isClosed) return;
  //     emit(ContractState.failure(e.toString().replaceAll('Exception: ', '')));
  //   }
  // }
  Future<void> loadContractHistory(String userId, bool isOwner) async {
    final previous = state;
    final isRefresh = previous is ContractHistoryLoaded;

    // Only show full-screen loading on the first load.
    if (!isRefresh) {
      emit(const ContractState.loading());
    }

    try {
      final roomRepo = inject<RoomRepository>();

      final contracts = isOwner
          ? await _contractRepository.getContractsByOwnerId(userId)
          : await _contractRepository.getContractsByTenantId(userId);

      final roomIds = contracts
          .map((c) => c.roomId)
          .where((id) => id.isNotEmpty)
          .toSet();

      final rooms = await Future.wait(roomIds.map(roomRepo.getRoomById));

      if (isClosed) return;

      emit(
        ContractState.historyLoaded(
          contracts: contracts,
          roomsByRoomId: {
            for (final room in rooms.whereType<RoomEntity>()) room.id: room,
          },
        ),
      );
    } catch (e) {
      if (isClosed) return;

      // On a failed refresh, keep showing the old list instead of an error screen.
      if (isRefresh) {
        emit(previous);
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
        emit(
          ContractState.success(
            message: 'Contract created successfully!',
            contract: created,
          ),
        );
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
        emit(
          ContractState.success(
            message: 'Contract updated successfully!',
            contract: updated,
          ),
        );
      })
      ..onError((failure) {
        emit(ContractState.failure(failure.reason));
      });
  }

  /// Calculates the total monthly revenue for a given owner from their active contracts.
  Future<void> calculateOwnerMonthlyRevenue(
    String ownerId, {
    bool showLoading = true,
  }) async {
    if (ownerId.isEmpty) {
      emit(
        const ContractState.revenueCalculated(
          totalMonthlyRevenue: 0.0,
          contracts: [],
        ),
      );
      return;
    }

    // Only emit loading if requested and we don't already have calculated revenue displayed
    if (showLoading && state is! ContractRevenueCalculated) {
      emit(const ContractState.loading());
    }

    try {
      final contracts = await _contractRepository.getContractsByOwnerId(
        ownerId,
      );

      // Sum monthly rent for contracts that are active
      double totalRevenue = 0.0;
      for (var contract in contracts) {
        if (contract.status == ContractStatus.active ||
            contract.status.value.toLowerCase() == 'active') {
          totalRevenue += contract.monthlyRent;
        }
      }

      emit(
        ContractState.revenueCalculated(
          totalMonthlyRevenue: totalRevenue,
          contracts: contracts,
        ),
      );
    } catch (e) {
      emit(ContractState.failure(e.toString().replaceAll('Exception: ', '')));
    }
  }
}

import 'package:injectable/injectable.dart';
import '../../../../core/core.dart';
import '../../entity/contract/contract_status.dart';
import '../../entity/room/room_entity.dart';
import '../../repository/contract/contract_repository.dart';
import '../../repository/room/room_repository.dart';
import '../contract/check_and_expire_contracts_usecase.dart';
import '../contract/expire_contract_usecase.dart';

class GetRoomsParams {
  final String? ownerId;
  final String? roomTypeId;
  final String? status;

  const GetRoomsParams({
    this.ownerId,
    this.roomTypeId,
    this.status,
  });
}

@lazySingleton
class GetRoomsUseCase implements UseCase<DataState<List<RoomEntity>>, GetRoomsParams> {
  final RoomRepository _repository;
  final ContractRepository _contractRepository;
  final ExpireContractUseCase _expireContractUseCase;
  final CheckAndExpireContractsUseCase _checkAndExpireContractsUseCase;

  const GetRoomsUseCase(
    this._repository,
    this._contractRepository,
    this._expireContractUseCase,
    this._checkAndExpireContractsUseCase,
  );

  @override
  Future<DataState<List<RoomEntity>>> call(GetRoomsParams param) async {
    try {
      // Run global expiration check so any expired contracts across the system are expired and rooms freed up
      await _checkAndExpireContractsUseCase();

      final rooms = await _repository.getRooms(
        ownerId: param.ownerId,
        roomTypeId: param.roomTypeId,
        status: param.status,
      );

      final now = DateTime.now();
      final updatedRooms = <RoomEntity>[];

      for (final room in rooms) {
        if (room.status == 'rented' && room.ownerId.isNotEmpty) {
          try {
            final contracts = await _contractRepository.getContractsByOwnerId(room.ownerId);
            final roomContracts = contracts.where((c) => c.roomId == room.id).toList();

            final hasActiveContract = roomContracts.any((c) {
              final statusStr = c.status.value.toLowerCase();
              final isActive = c.status == ContractStatus.active ||
                  statusStr == 'active' ||
                  c.status == ContractStatus.pending ||
                  statusStr == 'pending';
              final notExpired = c.endDate.isAfter(now);
              return isActive && notExpired;
            });

            if (!hasActiveContract) {
              for (final c in roomContracts) {
                if (c.status == ContractStatus.active && !c.endDate.isAfter(now)) {
                  try {
                    await _expireContractUseCase(c);
                  } catch (_) {}
                }
              }

              final availableRoom = room.copyWith(
                status: 'available',
                updatedAt: now,
              );
              await _repository.updateRoom(availableRoom);
              updatedRooms.add(availableRoom);
              continue;
            }
          } catch (_) {}
        }
        updatedRooms.add(room);
      }

      return Success(updatedRooms);
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}

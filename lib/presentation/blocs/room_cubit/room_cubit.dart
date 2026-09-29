import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rental_room/domain/domain.dart';

part 'room_state.dart';
part 'room_cubit.freezed.dart';

@injectable
class RoomCubit extends Cubit<RoomState> {
  final GetRoomsUseCase _getRoomsUseCase;
  final CreateRoomUseCase _createRoomUseCase;
  final UpdateRoomUseCase _updateRoomUseCase;
  final DeleteRoomUseCase _deleteRoomUseCase;

  RoomCubit(
      this._getRoomsUseCase,
      this._createRoomUseCase,
      this._updateRoomUseCase,
      this._deleteRoomUseCase,
      ) : super(const RoomState.initial());

  Future<void> fetchRooms({
    String? ownerId,
    String? roomTypeId,
    String? status,
  }) async {
    emit(const RoomState.loading());
    final res = await _getRoomsUseCase(
      GetRoomsParams(ownerId: ownerId, roomTypeId: roomTypeId, status: status),
    );

    res
      ..onSuccess((rooms) {
        emit(RoomState.loaded(rooms));
      })
      ..onError((failure) {
        emit(RoomState.failure(failure.reason));
      });
  }

  Future<void> createRoom(RoomEntity room) async {
    emit(const RoomState.loading());
    final res = await _createRoomUseCase(room);

    res
      ..onSuccess((createdRoom) {
        emit(RoomState.success(message: 'Room created successfully!', room: createdRoom));
      })
      ..onError((failure) {
        emit(RoomState.failure(failure.reason));
      });
  }

  Future<void> updateRoom(RoomEntity room) async {
    emit(const RoomState.loading());
    final res = await _updateRoomUseCase(room);

    res
      ..onSuccess((updatedRoom) {
        emit(RoomState.success(message: 'Room updated successfully!', room: updatedRoom));
      })
      ..onError((failure) {
        emit(RoomState.failure(failure.reason));
      });
  }

  Future<void> deleteRoom(String roomId) async {
    emit(const RoomState.loading());
    final res = await _deleteRoomUseCase(roomId);

    res
      ..onSuccess((_) {
        emit(const RoomState.success(message: 'Room deleted successfully!'));
      })
      ..onError((failure) {
        emit(RoomState.failure(failure.reason));
      });
  }
}
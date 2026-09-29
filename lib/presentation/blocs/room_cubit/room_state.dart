// part of 'room_cubit.dart';
//
// @freezed
// class RoomState with _$RoomState {
//   const factory RoomState.initial() = RoomInitial;
//   const factory RoomState.loading() = RoomLoading;
//   const factory RoomState.loaded(List<RoomEntity> rooms) = RoomLoaded;
//   const factory RoomState.success({required String message, RoomEntity? room}) = RoomSuccess;
//   const factory RoomState.failure(String message) = RoomFailure;
// }


part of 'room_cubit.dart';

@freezed
class RoomState with _$RoomState {
  const factory RoomState.initial() = RoomInitial;
  const factory RoomState.loading() = RoomLoading;
  const factory RoomState.loaded(List<RoomEntity> rooms) = RoomLoaded;
  const factory RoomState.success({
    required String message,
    RoomEntity? room,
  }) = RoomSuccess;
  const factory RoomState.failure(String message) = RoomFailure;
}
part of 'location_cubit.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState.initial() = _Initial;
  const factory LocationState.loading() = _Loading;
  const factory LocationState.success(UserEntity user) = _Success;
  const factory LocationState.failure(String message) = _Failure;
}
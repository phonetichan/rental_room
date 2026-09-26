part of 'edit_profile_cubit.dart';

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState.initial() = EditProfileInitial;
  const factory EditProfileState.loading() = EditProfileLoading;
  const factory EditProfileState.success(UserEntity user) = EditProfileSuccess;
  const factory EditProfileState.failure(String message) = EditProfileFailure;
}

part of 'edit_password_cubit.dart';

@freezed
class EditPasswordState with _$EditPasswordState {
  const factory EditPasswordState.initial() = EditPasswordInitial;
  const factory EditPasswordState.loading() = EditPasswordLoading;
  const factory EditPasswordState.success(String message) = EditPasswordSuccess;
  const factory EditPasswordState.failure(String message) = EditPasswordFailure;
}

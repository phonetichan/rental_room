part of 'sign_up_cubit.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState.initial() = SignUpInitial;
  const factory SignUpState.loading() = SignUpLoading;
  const factory SignUpState.success(UserEntity user) = SignUpSuccess;
  const factory SignUpState.failure(String error) = SignUpFailure;
}

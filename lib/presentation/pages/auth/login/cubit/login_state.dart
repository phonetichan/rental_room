part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginInitial;
  const factory LoginState.loading() = LoginLoading;
  const factory LoginState.success(UserEntity user) = LoginSuccess;
  const factory LoginState.failure(String error) = LoginFailure;
}

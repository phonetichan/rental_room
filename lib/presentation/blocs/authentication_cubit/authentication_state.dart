part of 'authentication_cubit.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = AuthenticationInitial;
  const factory AuthenticationState.loading() = AuthenticationLoading;

  // Persistent login state
  const factory AuthenticationState.authenticated(UserEntity user) = AuthenticationAuthenticated;
  const factory AuthenticationState.unauthenticated() = AuthenticationUnauthenticated;
}

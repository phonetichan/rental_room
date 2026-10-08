import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

part 'authentication_state.dart';
part 'authentication_cubit.freezed.dart';

@lazySingleton
class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AppStorage _storage;
  final SignOutUseCase _signOutUseCase;
  final GetUserUseCase _getUserUseCase;

  final ValueNotifier<ThemeMode> themeModeNotifier;

  AuthenticationCubit(
    this._storage,
    this._signOutUseCase,
    this._getUserUseCase,
  )   : themeModeNotifier = ValueNotifier<ThemeMode>(_storage.themeMode),
        super(const AuthenticationState.initial()) {
    // Check saved session instantly on instantiation
    loadData();
  }

  ThemeMode get themeMode => themeModeNotifier.value;

  UserEntity? get user => switch (state) {
        AuthenticationAuthenticated(user: final user) => user,
        _ => null,
      };

  void loadData() {
    final cachedUser = _storage.savedUserInfo;
    if (cachedUser != null) {
      // 1. Immediately emit cached user so UI shows dashboard instantly without waiting for network
      emit(AuthenticationState.authenticated(cachedUser));

      // 2. Fetch updated user profile from Firestore in background
      _fetchLatestUserData(cachedUser.id);
    } else {
      emit(const AuthenticationState.unauthenticated());
    }
  }

  Future<void> _fetchLatestUserData(String userId) async {
    final res = await _getUserUseCase(GetUserParam(userId: userId));

    res
      ..onSuccess((updatedUser) {
        if (updatedUser != null) {
          authenticateUser(user: updatedUser);
        }
      })
      ..onError((failure) {
        // Keep using cachedUser on network failure
      });
  }

  Future<void> toggleTheme() async {
    final newMode = themeModeNotifier.value == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    await setThemeMode(newMode);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    themeModeNotifier.value = mode;
    await _storage.setThemeMode(mode);
  }

  Future<void> authenticateUser({
    required UserEntity user,
  }) async {
    await _storage.saveUserInfo(user);

    emit(AuthenticationState.authenticated(user));
  }

  Future<void> logOut() async {
    await _storage.torchAllLocalUserData();
    await _signOutUseCase();
    emit(const AuthenticationState.unauthenticated());
  }

  Future<void> signOut() => logOut();

  @override
  Future<void> close() {
    themeModeNotifier.dispose();
    return super.close();
  }
}

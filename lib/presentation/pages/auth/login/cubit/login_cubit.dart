import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/entity/user/user_entity.dart';
import '../../../../../domain/usecase/user/sign_in_usecase.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final SignInUseCase _signInUseCase;

  LoginCubit(
    this._signInUseCase,
  ) : super(const LoginState.initial());

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(const LoginState.loading());
    try {
      final res = await _signInUseCase(
        SignInParams(
          email: email.trim(),
          password: password,
        ),
      );
      res
        ..onSuccess((user) {
          emit(LoginState.success(user));
        })
        ..onError((failure) {
          emit(LoginState.failure(failure.reason));
        });
    } catch (e) {
      final cleanMsg = e
          .toString()
          .replaceAll('Exception: ', '')
          .replaceAll(RegExp(r'\[.*?\]\s*'), '');
      emit(LoginState.failure(cleanMsg));
    }
  }
}

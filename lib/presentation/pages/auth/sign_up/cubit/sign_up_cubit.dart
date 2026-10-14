import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/domain.dart';

part 'sign_up_state.dart';
part 'sign_up_cubit.freezed.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpCubit(this._signUpUseCase) : super(const SignUpState.initial());

  Future<void> signUp({
    required String name,
    required String email,
    required String phoneNumber,
    String? image,
    required String password,
    required UserRole role,
  }) async {
    emit(const SignUpState.loading());
    try {
      final params = SignUpParams(
        name: name.trim(),
        email: email.trim(),
        phoneNumber: phoneNumber.trim(),
        image: image?.trim().isEmpty ?? true ? null : image!.trim(),
        password: password,
        role: role,
      );
      final res = await _signUpUseCase(params);
      res
        ..onSuccess((user) {
          emit(SignUpState.success(user));
        })
        ..onError((failure) {
          emit(SignUpState.failure(failure.reason));
        });
    } catch (e) {
      final cleanMsg = e
          .toString()
          .replaceAll('Exception: ', '')
          .replaceAll(RegExp(r'\[.*?\]\s*'), '');
      emit(SignUpState.failure(cleanMsg));
    }
  }
}

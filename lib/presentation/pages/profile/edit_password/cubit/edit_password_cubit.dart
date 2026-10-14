import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:rental_room/domain/usecase/user/update_password_usecase.dart';
import 'package:rental_room/presentation/blocs/authentication_cubit/authentication_cubit.dart';

part 'edit_password_state.dart';
part 'edit_password_cubit.freezed.dart';

@injectable
class EditPasswordCubit extends Cubit<EditPasswordState> {
  final UpdatePasswordUseCase _updatePasswordUseCase;
  final AuthenticationCubit _authCubit;

  EditPasswordCubit(
    this._updatePasswordUseCase,
    this._authCubit,
  ) : super(const EditPasswordInitial());

  Future<void> updatePassword(UpdatePasswordParams params) async {
    debugPrint('EditPasswordCubit: updatePassword started');
    emit(const EditPasswordLoading());

    try {
      final res = await _updatePasswordUseCase(params);
      res
        ..onSuccess((_) async {
          debugPrint('EditPasswordCubit: updatePassword SUCCESS');
          const msg = 'Password updated successfully! Please log in again.';
          emit(const EditPasswordSuccess(msg));
          await Future.delayed(const Duration(milliseconds: 800));
          await _authCubit.logOut();
        })
        ..onError((failure) async {
          debugPrint('EditPasswordCubit: updatePassword FAILED: ${failure.reason}');
          emit(EditPasswordFailure(failure.reason));
        });
    } catch (e, stackTrace) {
      debugPrint('EditPasswordCubit: updatePassword EXCEPTION: $e\n$stackTrace');
      final cleanMsg = e
          .toString()
          .replaceAll('Exception: ', '')
          .replaceAll(RegExp(r'\[.*?\]\s*'), '');
      emit(EditPasswordFailure(cleanMsg));
    }
  }
}

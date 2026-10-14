import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:rental_room/data/datasource/local/app_storage.dart';
import 'package:rental_room/domain/entity/user/user_entity.dart';
import 'package:rental_room/domain/usecase/user/update_user_profile_param.dart';
import 'package:rental_room/presentation/blocs/authentication_cubit/authentication_cubit.dart';

part 'edit_profile_state.dart';
part 'edit_profile_cubit.freezed.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final UpdateUserProfileUseCase _updateUserProfileUseCase;
  final AppStorage _storage;
  final AuthenticationCubit _authCubit;

  EditProfileCubit(
    this._updateUserProfileUseCase,
    this._storage,
    this._authCubit,
  ) : super(const EditProfileInitial());

  Future<void> updateUserProfile(UpdateUserProfileParams params) async {
    debugPrint(
      'EditProfileCubit: started with name: ${params.user.name}, email: ${params.user.email}, phone: ${params.user.phoneNumber}',
    );
    emit(const EditProfileLoading());

    try {
      final res = await _updateUserProfileUseCase(params);
      res
        ..onSuccess((userEntity) async {
          debugPrint('EditProfileCubit: SUCCESS for user: ${userEntity.id}');
          await _storage.saveUserInfo(userEntity);
          await _authCubit.authenticateUser(user: userEntity);
          emit(EditProfileSuccess(userEntity));
        })
        ..onError((failure) async {
          debugPrint('EditProfileCubit: FAILED: ${failure.reason}');
          if (_requiresReauth(failure.reason)) {
            await _authCubit.logOut();
          }
          emit(EditProfileFailure(failure.reason));
        });
    } catch (e, stackTrace) {
      debugPrint('EditProfileCubit: EXCEPTION caught: $e\n$stackTrace');
      final cleanMsg = _cleanErrorMessage(e);
      if (_requiresReauth(cleanMsg)) {
        await _authCubit.logOut();
      }
      emit(EditProfileFailure(cleanMsg));
    }
  }

  bool _requiresReauth(String reason) {
    return reason.contains('re-authentication') ||
        reason.contains('requires-recent-login') ||
        reason.contains('sensitive') ||
        reason.contains('sign in again');
  }

  String _cleanErrorMessage(dynamic e) {
    return e
        .toString()
        .replaceAll('Exception: ', '')
        .replaceAll(RegExp(r'\[.*?\]\s*'), '');
  }
}

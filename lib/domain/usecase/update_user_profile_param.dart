import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/core.dart';
import '../entity/user_entity.dart';
import '../repository/user_repository.dart';

class UpdateUserProfileParams {
  final UserEntity user;

  UpdateUserProfileParams({
    required this.user,
  });
}

@lazySingleton
class UpdateUserProfileUseCase
    implements UseCase<DataState<UserEntity>, UpdateUserProfileParams> {
  final UserRepository _repository;

  const UpdateUserProfileUseCase(this._repository);

  @override
  Future<DataState<UserEntity>> call(UpdateUserProfileParams param) async {
    debugPrint('UpdateUserProfileUseCase: executing for user id: ${param.user.id}');
    try {
      final user = await _repository.updateUserProfile(
        user: param.user,
      );
      debugPrint('UpdateUserProfileUseCase: repository succeeded for user: ${user.id}');
      return Success(user);
    } on FirebaseAuthException catch (e) {
      debugPrint('UpdateUserProfileUseCase: FirebaseAuthException: [${e.code}] ${e.message}');
      String message = e.message ?? 'Update profile failed (${e.code})';
      if (e.code == 'requires-recent-login') {
        message = 'This operation is sensitive and requires recent authentication. Please log out and log in again before updating your email.';
      }
      return Failed(DbFailure(message));
    } on RemoteException catch (e) {
      debugPrint('UpdateUserProfileUseCase: RemoteException: ${e.message}');
      return Failed(e.toFailure());
    } catch (e, st) {
      debugPrint('UpdateUserProfileUseCase: unknown error: $e\n$st');
      final cleanMsg = e
          .toString()
          .replaceAll('Exception: ', '')
          .replaceAll(RegExp(r'\[.*?\]\s*'), '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}

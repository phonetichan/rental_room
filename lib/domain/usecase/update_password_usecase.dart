import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/core.dart';
import '../repository/auth_repository.dart';

class UpdatePasswordParams {
  final String currentPassword;
  final String newPassword;

  UpdatePasswordParams({
    required this.currentPassword,
    required this.newPassword,
  });
}

@lazySingleton
class UpdatePasswordUseCase
    implements UseCase<DataState<void>, UpdatePasswordParams> {
  final AuthRepository _repository;

  const UpdatePasswordUseCase(this._repository);

  @override
  Future<DataState<void>> call(UpdatePasswordParams param) async {
    debugPrint('UpdatePasswordUseCase: executing password update');
    try {
      await _repository.updatePassword(
        currentPassword: param.currentPassword,
        newPassword: param.newPassword,
      );
      debugPrint('UpdatePasswordUseCase: password update succeeded');
      return const Success(null);
    } on FirebaseAuthException catch (e) {
      debugPrint('UpdatePasswordUseCase: FirebaseAuthException: [${e.code}] ${e.message}');
      String message = e.message ?? 'Password update failed (${e.code})';
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        message = 'The current password you entered is incorrect.';
      } else if (e.code == 'weak-password') {
        message = 'The new password is too weak.';
      } else if (e.code == 'requires-recent-login') {
        message = 'This operation is sensitive and requires re-authentication. Please log in again.';
      }
      return Failed(DbFailure(message));
    } catch (e, st) {
      debugPrint('UpdatePasswordUseCase: unknown error: $e\n$st');
      final cleanMsg = e
          .toString()
          .replaceAll('Exception: ', '')
          .replaceAll(RegExp(r'\[.*?\]\s*'), '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}

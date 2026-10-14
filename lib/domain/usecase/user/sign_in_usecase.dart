import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../entity/user/user_entity.dart';
import '../../repository/auth/auth_repository.dart';

class SignInParams {
  final String email;
  final String password;

  SignInParams({
    required this.email,
    required this.password,
  });
}

@lazySingleton
class SignInUseCase implements UseCase<DataState<UserEntity>, SignInParams> {
  final AuthRepository _repository;

  const SignInUseCase(this._repository);

  @override
  Future<DataState<UserEntity>> call(SignInParams param) async {
    try {
      final user = await _repository.signInWithEmailAndPassword(
        email: param.email,
        password: param.password,
      );
      return Success(user);
    } on FirebaseAuthException catch (e) {
      return Failed(DbFailure(e.message ?? 'Authentication failed (${e.code})'));
    } on RemoteException catch (e) {
      return Failed(e.toFailure());
    } catch (e) {
      final cleanMsg = e
          .toString()
          .replaceAll('Exception: ', '')
          .replaceAll(RegExp(r'\[.*?\]\s*'), '');
      return Failed(DbFailure(cleanMsg));
    }
  }
}

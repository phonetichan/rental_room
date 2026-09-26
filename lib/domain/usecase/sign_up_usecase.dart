import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../core/core.dart';
import '../entity/user_entity.dart';
import '../enum/role.dart';
import '../repository/auth_repository.dart';

class SignUpParams {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final String? image;
  final UserRole role;

  SignUpParams({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.image,
    required this.role,
  });
}

@lazySingleton
class SignUpUseCase implements UseCase<DataState<UserEntity>, SignUpParams> {
  final AuthRepository _repository;

  const SignUpUseCase(this._repository);

  @override
  Future<DataState<UserEntity>> call(SignUpParams param) async {
    try {
      final user = await _repository.signUpWithEmailAndPassword(
        name: param.name,
        email: param.email,
        phoneNumber: param.phoneNumber,
        password: param.password,
        image: param.image,
        role: param.role,
      );
      return Success(user);
    } on FirebaseAuthException catch (e) {
      return Failed(DbFailure(e.message ?? 'Sign up failed (${e.code})'));
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

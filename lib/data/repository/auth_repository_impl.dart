import 'package:injectable/injectable.dart';

import '../../domain/entity/user_entity.dart';
import '../../domain/enum/role.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/remote/auth_data_source.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _remoteDataSource.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserEntity> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String phoneNumber,
    String? image,
    required String password,
    required UserRole role,
  }) {
    return _remoteDataSource.signUpWithEmailAndPassword(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      image: image,
      password: password,
      role: role,
    );
  }

  @override
  Future<UserEntity?> getCurrentUser() {
    return _remoteDataSource.getCurrentUserData();
  }

  @override
  Future<void> signOut() {
    return _remoteDataSource.signOut();
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return _remoteDataSource.authStateChanges.asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;
      return await getCurrentUser();
    });
  }

  @override
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return _remoteDataSource.updatePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  @override
  Future<UserEntity> updateUserProfile({
    required UserEntity user,
  }) async {
    return _remoteDataSource.updateUserProfile(user);
  }
}

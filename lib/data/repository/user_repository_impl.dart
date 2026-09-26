import 'package:injectable/injectable.dart';

import '../../domain/entity/user_entity.dart';
import '../../domain/repository/user_repository.dart';
import '../datasource/remote/user_data_source.dart';

/// [UserRepositoryImpl] is the concrete implementation of the domain-layer
/// [UserRepository] abstract interface.
///
/// ### Why it is needed:
/// 1. **Dependency Injection & Clean Architecture:** Use cases like [UpdateUserProfileUseCase]
///    depend on the abstract `UserRepository` interface. Injectable requires a concrete 
///    implementation annotated with `@LazySingleton(as: UserRepository)` to satisfy this dependency.
/// 2. **Decoupling:** Bridges domain business rules with remote data sources 
///    ([UserRemoteDataSource]) without exposing Firebase implementation details to the domain layer.
///
/// ### Usage:
/// Automatically resolved by GetIt / Injectable when use cases request `UserRepository`.
@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserEntity> updateUserProfile({required UserEntity user}) async {
    try {
      return await _remoteDataSource.updateUserProfile(user);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _remoteDataSource.updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    } catch (e) {
      rethrow;
    }
  }
}

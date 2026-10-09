import 'package:injectable/injectable.dart';

import '../../../domain/entity/user/user_entity.dart';
import '../../../domain/repository/user/user_repository.dart';
import '../../data.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserEntity> updateUserProfile({required UserEntity user}) async {
    try {
      final updatedModel = await _remoteDataSource.updateUserProfile(user);
      return updatedModel.toEntity();
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

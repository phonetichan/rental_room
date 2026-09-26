import '../entity/user_entity.dart';

abstract class UserRepository {
  /// Updates all editable fields of an existing user profile (Name, Phone, Image, etc.).
  Future<UserEntity> updateUserProfile({
    required UserEntity user,
  });

  /// Updates the user's password.
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  });
}

import '../entity/user_entity.dart';
import '../enum/role.dart';
import 'user_repository.dart';

abstract class AuthRepository implements UserRepository {
  /// Signs in an existing user with email and password.
  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Registers a new user with email, password, and initial profile details.
  Future<UserEntity> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String phoneNumber,
    String? image,
    required String password,
    required UserRole role,
  });

  /// Updates all editable fields of an existing user profile (Name, Phone, Image, etc.).
  @override
  Future<UserEntity> updateUserProfile({
    required UserEntity user,
  });

  /// Updates the user's password.
  @override
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  });

  /// Fetches the currently authenticated user session (returns null if unauthenticated).
  Future<UserEntity?> getCurrentUser();

  /// Logs out the currently signed-in user.
  Future<void> signOut();

  /// Listens to real-time authentication state changes.
  Stream<UserEntity?> get authStateChanges;
}

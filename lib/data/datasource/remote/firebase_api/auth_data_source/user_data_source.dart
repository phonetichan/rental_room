import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/entity/user/user_entity.dart';
import 'package:rental_room/data/data.dart';

/// [UserRemoteDataSource] handles direct interaction with external remote APIs
/// and SDKs (Firebase Auth and Cloud Firestore) specifically for user profile
/// and password management operations.
///
/// ### Why it is needed:
/// In Clean Architecture, data sources isolate external service dependencies
/// (Firebase) away from business logic and repositories.
///
/// ### Usage:
/// Injected into [UserRepositoryImpl] to fetch or mutate user data in Firestore/Auth.
@lazySingleton
class UserRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRemoteDataSource(
    this._firebaseAuth,
    this._firestore,
  );

  CollectionReference get _usersCollection => _firestore.collection('users');

  Future<UserModel> updateUserProfile(UserEntity user) async {
    debugPrint('UserRemoteDataSource: updateUserProfile started for user: ${user.id}');
    final docRef = _usersCollection.doc(user.id);
    final userModel = UserModel.fromEntity(user);
    debugPrint('UserRemoteDataSource: updating Firestore document for user: ${user.id}');
    await docRef.update({
      'name': userModel.name,
      'phoneNumber': userModel.phoneNumber.trim(),
      'image': userModel.image,
    });

    debugPrint('UserRemoteDataSource: fetching updated Firestore document');
    final updatedDoc = await docRef.get();
    debugPrint('UserRemoteDataSource: updateUserProfile finished successfully');
    return UserModel.fromFirestore(updatedDoc);
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    debugPrint('UserRemoteDataSource: updatePassword started');
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null || currentUser.email == null) {
      throw Exception('No authenticated user found.');
    }

    final credential = EmailAuthProvider.credential(
      email: currentUser.email!,
      password: currentPassword,
    );

    try {
      await currentUser.reauthenticateWithCredential(credential).timeout(
        const Duration(seconds: 15),
        onTimeout: () => throw TimeoutException('Re-authentication timed out.'),
      );
    } catch (e) {
      debugPrint('UserRemoteDataSource: re-authentication error: $e');
      if (e is FirebaseAuthException &&
          (e.code == 'wrong-password' || e.code == 'invalid-credential')) {
        throw Exception('The current password you entered is incorrect.');
      }
      rethrow;
    }

    await currentUser.updatePassword(newPassword).timeout(
      const Duration(seconds: 15),
      onTimeout: () => throw TimeoutException('Password update timed out.'),
    );

    await _firebaseAuth.signOut();
    debugPrint('UserRemoteDataSource: updatePassword completed successfully');
  }
}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:rental_room/data/model/auth/user_model.dart';
import 'package:rental_room/domain/domain.dart';

@lazySingleton
class UserRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRemoteDataSource(
    this._firebaseAuth,
    this._firestore,
  );

  CollectionReference get _usersCollection => _firestore.collection('users');

  /// Helper to check if a phone number is already taken by another user
  Future<bool> _isPhoneNumberTaken(
    String phoneNumber, {
    String? excludeUserId,
  }) async {
    try {
      final querySnapshot = await _usersCollection
          .where('phoneNumber', isEqualTo: phoneNumber.trim())
          .get()
          .timeout(const Duration(seconds: 5));

      if (excludeUserId != null) {
        return querySnapshot.docs.any((doc) => doc.id != excludeUserId);
      }

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isPhoneNumberTaken(
    String phoneNumber, {
    String? excludeUserId,
  }) => _isPhoneNumberTaken(phoneNumber, excludeUserId: excludeUserId);

  Future<UserModel?> getUserById(String userId) async {
    debugPrint('🔍 Fetching user data for userId: $userId');

    if (userId.trim().isEmpty) {
      debugPrint('⚠️ Provided userId is empty.');
      return null;
    }

    try {
      final doc = await _usersCollection.doc(userId.trim()).get();

      debugPrint('📄 Doc exists for [$userId]: ${doc.exists}');

      if (!doc.exists || doc.data() == null) {
        debugPrint('❌ No document or empty data found for userId: $userId');
        return null;
      }

      return UserModel.fromFirestore(doc);
    } catch (e, stackTrace) {
      debugPrint('🚨 Error fetching user data for [$userId]: $e');
      debugPrint('📜 StackTrace: $stackTrace');
      return null;
    }
  }

  Future<UserModel?> getCurrentUserData() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) return null;

    final doc = await _usersCollection.doc(currentUser.uid).get();
    if (!doc.exists) return null;

    return UserModel.fromFirestore(doc);
  }

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

  Future<UserModel> updateUserLocation({
    required String userId,
    required double latitude,
    required double longitude,
    required String address,
  }) async {
    final ref = _usersCollection.doc(userId);
    await ref.update({
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    });
    final updatedDoc = await ref.get();
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

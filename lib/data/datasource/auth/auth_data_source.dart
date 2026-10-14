import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:rental_room/core/utils/amenity_icon_mapper.dart' as mapper;
import 'package:rental_room/data/model/auth/user_model.dart';
import 'package:rental_room/domain/entity/user/user_entity.dart';
import 'package:rental_room/domain/enum/role.dart';
import '../seed/seed_data_source.dart';
import '../user/user_data_source.dart';

@lazySingleton
class AuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final UserRemoteDataSource _userRemoteDataSource;
  final SeedDataSource _seedDataSource;

  AuthDataSource(
    this._firebaseAuth,
    this._firestore,
    this._userRemoteDataSource,
    this._seedDataSource,
  );

  CollectionReference get _usersCollection => _firestore.collection('users');

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw Exception('Authentication failed: User is null.');
    }

    final docRef = _usersCollection.doc(user.uid);
    final doc = await docRef.get();

    if (!doc.exists) {
      throw Exception('User profile record not found in Firestore.');
    }

    final now = DateTime.now();
    await docRef.update({'lastLogin': Timestamp.fromDate(now)});

    final updatedDoc = await docRef.get();
    return UserModel.fromFirestore(updatedDoc);
  }

  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String phoneNumber,
    String? image,
    required String password,
    required UserRole role,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw Exception('Sign up failed: Unable to create user.');
    }

    final isPhoneTaken = await _userRemoteDataSource.isPhoneNumberTaken(
      phoneNumber,
      excludeUserId: user.uid,
    );
    if (isPhoneTaken) {
      await user.delete();
      throw Exception(
        'This phone number is already registered by another user.',
      );
    }

    final now = DateTime.now();

    final userModel = UserModel(
      id: user.uid,
      name: name,
      email: email,
      phoneNumber: phoneNumber.trim(),
      image: image,
      role: role,
      createdAt: now,
      lastLogin: now,
    );

    await _usersCollection.doc(user.uid).set(userModel.toMap());
    await user.updateDisplayName(name);

    return userModel;
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await _userRemoteDataSource.updatePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Delegation helpers for backward compatibility
  Future<UserModel?> getUserById(String userId) =>
      _userRemoteDataSource.getUserById(userId);

  Future<UserModel?> getCurrentUserData() =>
      _userRemoteDataSource.getCurrentUserData();

  Future<UserModel> updateUserProfile(UserEntity user) =>
      _userRemoteDataSource.updateUserProfile(user);

  Future<UserModel> updateUserLocation({
    required String userId,
    required double latitude,
    required double longitude,
    required String address,
  }) =>
      _userRemoteDataSource.updateUserLocation(
        userId: userId,
        latitude: latitude,
        longitude: longitude,
        address: address,
      );

  Future<void> seedInitialData() => _seedDataSource.seedInitialData();

  IconData getAmenityIcon(String iconName) => mapper.getAmenityIcon(iconName);
}

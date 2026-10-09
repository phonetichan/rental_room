// // import 'dart:async';
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:injectable/injectable.dart';
// //
// // import '../../../domain/entity/user_entity.dart';
// // import '../../../domain/enum/role.dart';
// // import '../../model/user_model.dart';
// //
// // @lazySingleton
// // class AuthDataSource {
// //   final FirebaseAuth _firebaseAuth;
// //   final FirebaseFirestore _firestore;
// //
// //   AuthDataSource(
// //       this._firebaseAuth,
// //       this._firestore,
// //       );
// //
// //   CollectionReference get _usersCollection => _firestore.collection('users');
// //
// //   /// Helper to check if a phone number is already taken by another user
// //   Future<bool> _isPhoneNumberTaken(String phoneNumber, {String? excludeUserId}) async {
// //     try {
// //       final querySnapshot = await _usersCollection
// //           .where('phoneNumber', isEqualTo: phoneNumber.trim())
// //           .get()
// //           .timeout(const Duration(seconds: 5));
// //
// //       if (excludeUserId != null) {
// //         // Ignore the current user's document when updating profile
// //         return querySnapshot.docs.any((doc) => doc.id != excludeUserId);
// //       }
// //
// //       return querySnapshot.docs.isNotEmpty;
// //     } catch (e) {
// //       // If query times out or security rules restrict querying users, catch gracefully
// //       return false;
// //     }
// //   }
// //
// //   Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
// //
// //   Future<UserModel> signInWithEmailAndPassword({
// //     required String email,
// //     required String password,
// //   }) async {
// //     final credential = await _firebaseAuth.signInWithEmailAndPassword(
// //       email: email,
// //       password: password,
// //     );
// //
// //     final user = credential.user;
// //     if (user == null) {
// //       throw Exception('Authentication failed: User is null.');
// //     }
// //
// //     final docRef = _usersCollection.doc(user.uid);
// //     final doc = await docRef.get();
// //
// //     if (!doc.exists) {
// //       throw Exception('User profile record not found in Firestore.');
// //     }
// //
// //     final now = DateTime.now();
// //     await docRef.update({
// //       'lastLogin': Timestamp.fromDate(now),
// //     });
// //
// //     final updatedDoc = await docRef.get();
// //     return UserModel.fromFirestore(updatedDoc);
// //   }
// //
// //   Future<UserModel> signUpWithEmailAndPassword({
// //     required String name,
// //     required String email,
// //     required String phoneNumber,
// //     String? image,
// //     required String password,
// //     required UserRole role,
// //   }) async {
// //     // 1. Create Auth Account first so the user is authenticated in Firebase
// //     final credential = await _firebaseAuth.createUserWithEmailAndPassword(
// //       email: email,
// //       password: password,
// //     );
// //
// //     final user = credential.user;
// //     if (user == null) {
// //       throw Exception('Sign up failed: Unable to create user.');
// //     }
// //
// //     // 2. Check if phone number is already in use
// //     final isPhoneTaken = await _isPhoneNumberTaken(phoneNumber, excludeUserId: user.uid);
// //     if (isPhoneTaken) {
// //       await user.delete();
// //       throw Exception('This phone number is already registered by another user.');
// //      }
// //
// //     final now = DateTime.now();
// //
// //     final userModel = UserModel(
// //       id: user.uid,
// //       name: name,
// //       email: email,
// //       phoneNumber: phoneNumber.trim(),
// //       image: image,
// //       role: role,
// //       createdAt: now,
// //       lastLogin: now,
// //     );
// //
// //     await _usersCollection.doc(user.uid).set(userModel.toMap());
// //     await user.updateDisplayName(name);
// //
// //     return userModel;
// //   }
// //
// //   /// Checks and seeds master data automatically when the app launches
// //   Future<void> seedInitialData() async {
// //     try {
// //       debugPrint('⏳ Seeding room types and amenities...');
// //       final batch = _firestore.batch();
// //
// //       // 1. Predefine Amenities
// //       final List<Map<String, dynamic>> initialAmenities = [
// //         {'id': 'amenity_wifi', 'name': 'WiFi', 'icon': 'wifi'},
// //         {'id': 'amenity_ac', 'name': 'Air Conditioning', 'icon': 'ac_unit'},
// //         {'id': 'amenity_fan', 'name': 'Fan', 'icon': 'air'},
// //         {'id': 'amenity_bed', 'name': 'Bed', 'icon': 'king_bed'},
// //         {'id': 'amenity_study_desk', 'name': 'Study Desk', 'icon': 'desk'},
// //         {'id': 'amenity_elevator', 'name': 'Elevator', 'icon': 'elevator'},
// //         {'id': 'amenity_powerbank', 'name': 'Powerbank', 'icon': 'battery_charging_full'},
// //         {'id': 'amenity_balcony', 'name': 'Balcony', 'icon': 'balcony'},
// //         {'id': 'amenity_fridge', 'name': 'Refrigerator', 'icon': 'kitchen'},
// //         {'id': 'amenity_kitchen', 'name': 'Kitchen', 'icon': 'countertops'},
// //         {'id': 'amenity_shower', 'name': 'Shower Room', 'icon': 'shower'},
// //         {'id': 'amenity_toilet', 'name': 'Toilet', 'icon': 'wc'},
// //         {'id': 'amenity_water_heater', 'name': 'Water Heater', 'icon': 'hot_tub'},
// //         {'id': 'amenity_parking', 'name': 'Free Parking', 'icon': 'local_parking'},
// //         {'id': 'amenity_tv', 'name': 'Smart TV', 'icon': 'tv'},
// //         {'id': 'amenity_pool', 'name': 'Swimming Pool', 'icon': 'pool'},
// //         {'id': 'amenity_laundry', 'name': 'Laundry Service', 'icon': 'local_laundry_service'},
// //       ];
// //
// //       for (var amenity in initialAmenities) {
// //         DocumentReference docRef = _firestore.collection('amenities').doc(amenity['id']);
// //         batch.set(docRef, {
// //           'name': amenity['name'],
// //           'icon': amenity['icon'],
// //           'updatedAt': FieldValue.serverTimestamp(),
// //         }, SetOptions(merge: true));
// //       }
// //
// //       // 2. Predefine Room Types
// //       final List<Map<String, dynamic>> initialRoomTypes = [
// //         {
// //           'id': 'rt_apartment',
// //           'typeName': 'Standard Apartment',
// //           'description': 'Traditional apartment in a low-rise or mid-rise building.'
// //         },
// //         {
// //           'id': 'rt_minicondo',
// //           'typeName': 'Mini Condo',
// //           'description': 'Modern apartment building with basic facilities like lift and generator.'
// //         },
// //         {
// //           'id': 'rt_condo',
// //           'typeName': 'Full Condominium',
// //           'description': 'High-rise residence with full amenities (gym, pool, 24/7 security).'
// //         },
// //         {
// //           'id': 'rt_single_room',
// //           'typeName': 'Single Room Unit',
// //           'description': 'Private single room within a shared housing or hostel arrangement.'
// //         },
// //         {
// //           'id': 'rt_dorm',
// //           'typeName': 'Dormitory',
// //           'description': 'Shared dormitory room with bunk beds for students or budget travelers.'
// //         },
// //         {
// //           'id': 'rt_double',
// //           'typeName': 'Double Room',
// //           'description': 'Comfortable room featuring one double bed or two single beds suitable for two guests.'
// //         },
// //       ];
// //
// //       for (var type in initialRoomTypes) {
// //         DocumentReference docRef = _firestore.collection('room_types').doc(type['id']);
// //         batch.set(docRef, {
// //           'typeName': type['typeName'],
// //           'description': type['description'],
// //           'updatedAt': FieldValue.serverTimestamp(),
// //         }, SetOptions(merge: true));
// //       }
// //
// //       // Commit all writes
// //       await batch.commit();
// //       debugPrint('✅ Predefined room types and amenities successfully created/updated!');
// //     } catch (e) {
// //       debugPrint('❌ Error seeding master data: $e');
// //     }
// //   }
// //
// //   Future<UserModel> updateUserProfile(UserEntity user) async {
// //     debugPrint('AuthDataSource: updateUserProfile started for user: ${user.id}');
// //     final docRef = _usersCollection.doc(user.id);
// //     final userModel = UserModel.fromEntity(user);
// //     debugPrint('AuthDataSource: updating Firestore document for user: ${user.id}');
// //     await docRef.update({
// //       'name': userModel.name,
// //       'phoneNumber': userModel.phoneNumber.trim(),
// //       'image': userModel.image,
// //     });
// //
// //     debugPrint('AuthDataSource: fetching updated Firestore document');
// //     final updatedDoc = await docRef.get();
// //     debugPrint('AuthDataSource: updateUserProfile finished successfully');
// //     return UserModel.fromFirestore(updatedDoc);
// //   }
// //
// //   Future<UserModel?> getCurrentUserData() async {
// //     final currentUser = _firebaseAuth.currentUser;
// //     if (currentUser == null) return null;
// //
// //     final doc = await _usersCollection.doc(currentUser.uid).get();
// //     if (!doc.exists) return null;
// //
// //     return UserModel.fromFirestore(doc);
// //   }
// //
// //   Future<void> updatePassword({
// //     required String currentPassword,
// //     required String newPassword,
// //   }) async {
// //     debugPrint('AuthDataSource: updatePassword started');
// //     final currentUser = _firebaseAuth.currentUser;
// //     if (currentUser == null || currentUser.email == null) {
// //       throw Exception('No authenticated user found.');
// //     }
// //
// //     final credential = EmailAuthProvider.credential(
// //       email: currentUser.email!,
// //       password: currentPassword,
// //     );
// //
// //     try {
// //       await currentUser.reauthenticateWithCredential(credential).timeout(
// //         const Duration(seconds: 15),
// //         onTimeout: () => throw TimeoutException('Re-authentication timed out.'),
// //       );
// //     } catch (e) {
// //       debugPrint('AuthDataSource: re-authentication error: $e');
// //       if (e is FirebaseAuthException &&
// //           (e.code == 'wrong-password' || e.code == 'invalid-credential')) {
// //         throw Exception('The current password you entered is incorrect.');
// //       }
// //       rethrow;
// //     }
// //
// //     await currentUser.updatePassword(newPassword).timeout(
// //       const Duration(seconds: 15),
// //       onTimeout: () => throw TimeoutException('Password update timed out.'),
// //     );
// //
// //     await _firebaseAuth.signOut();
// //     debugPrint('AuthDataSource: updatePassword completed successfully');
// //   }
// //
// //   Future<void> signOut() async {
// //     await _firebaseAuth.signOut();
// //   }
// //
// //
// //   Future<UserModel?> getUserById(String userId) async {
// //     debugPrint('🔍 Fetching owner user data for ownerId: $userId');
// //
// //     if (userId.trim().isEmpty) {
// //       debugPrint('⚠️ Provided userId is empty.');
// //       return null;
// //     }
// //
// //     try {
// //       final doc = await _usersCollection.doc(userId.trim()).get();
// //
// //       debugPrint('📄 Doc exists for [$userId]: ${doc.exists}');
// //
// //       if (!doc.exists || doc.data() == null) {
// //         debugPrint('❌ No document or empty data found for userId: $userId');
// //         return null;
// //       }
// //
// //       return UserModel.fromFirestore(doc);
// //     } catch (e, stackTrace) {
// //       debugPrint('🚨 Error fetching owner user data for [$userId]: $e');
// //       debugPrint('📜 StackTrace: $stackTrace');
// //       return null;
// //     }
// //   }
// //
// //   IconData getAmenityIcon(String iconName) {
// //     switch (iconName) {
// //       case 'wifi':
// //         return Icons.wifi;
// //       case 'ac_unit':
// //         return Icons.ac_unit;
// //       case 'air':
// //         return Icons.air;
// //       case 'king_bed':
// //         return Icons.king_bed;
// //       case 'desk':
// //         return Icons.desk;
// //       case 'elevator':
// //         return Icons.elevator;
// //       case 'battery_charging_full':
// //         return Icons.battery_charging_full;
// //       case 'balcony':
// //         return Icons.balcony;
// //       case 'kitchen':
// //         return Icons.kitchen;
// //       case 'countertops':
// //         return Icons.countertops;
// //       case 'shower':
// //         return Icons.shower;
// //       case 'wc':
// //         return Icons.wc;
// //       case 'hot_tub':
// //         return Icons.hot_tub;
// //       case 'local_parking':
// //         return Icons.local_parking;
// //       case 'tv':
// //         return Icons.tv;
// //       case 'pool':
// //         return Icons.pool;
// //       case 'local_laundry_service':
// //         return Icons.local_laundry_service;
// //       default:
// //         return Icons.help_outline;
// //     }
// //   }
// // }
//
// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:injectable/injectable.dart';
//
// import '../../../domain/entity/user_entity.dart';
// import '../../../domain/enum/role.dart';
// import '../../model/user_model.dart';
//
// @lazySingleton
// class AuthDataSource {
//   final FirebaseAuth _firebaseAuth;
//   final FirebaseFirestore _firestore;
//
//   AuthDataSource(
//       this._firebaseAuth,
//       this._firestore,
//       );
//
//   CollectionReference get _usersCollection => _firestore.collection('users');
//
//   /// Helper to check if a phone number is already taken by another user
//   Future<bool> _isPhoneNumberTaken(String phoneNumber, {String? excludeUserId}) async {
//     try {
//       final querySnapshot = await _usersCollection
//           .where('phoneNumber', isEqualTo: phoneNumber.trim())
//           .get()
//           .timeout(const Duration(seconds: 5));
//
//       if (excludeUserId != null) {
//         // Ignore the current user's document when updating profile
//         return querySnapshot.docs.any((doc) => doc.id != excludeUserId);
//       }
//
//       return querySnapshot.docs.isNotEmpty;
//     } catch (e) {
//       // If query times out or security rules restrict querying users, catch gracefully
//       return false;
//     }
//   }
//
//   Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
//
//   Future<UserModel> signInWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     final credential = await _firebaseAuth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//
//     final user = credential.user;
//     if (user == null) {
//       throw Exception('Authentication failed: User is null.');
//     }
//
//     final docRef = _usersCollection.doc(user.uid);
//     final doc = await docRef.get();
//
//     if (!doc.exists) {
//       throw Exception('User profile record not found in Firestore.');
//     }
//
//     final now = DateTime.now();
//     await docRef.update({
//       'lastLogin': Timestamp.fromDate(now),
//     });
//
//     final updatedDoc = await docRef.get();
//     return UserModel.fromFirestore(updatedDoc);
//   }
//
//   Future<UserModel> signUpWithEmailAndPassword({
//     required String name,
//     required String email,
//     required String phoneNumber,
//     String? image,
//     required String password,
//     required UserRole role,
//   }) async {
//     // 1. Create Auth Account first so the user is authenticated in Firebase
//     final credential = await _firebaseAuth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//
//     final user = credential.user;
//     if (user == null) {
//       throw Exception('Sign up failed: Unable to create user.');
//     }
//
//     // 2. Check if phone number is already in use
//     final isPhoneTaken = await _isPhoneNumberTaken(phoneNumber, excludeUserId: user.uid);
//     if (isPhoneTaken) {
//       await user.delete();
//       throw Exception('This phone number is already registered by another user.');
//     }
//
//     final now = DateTime.now();
//
//     final userModel = UserModel(
//       id: user.uid,
//       name: name,
//       email: email,
//       phoneNumber: phoneNumber.trim(),
//       image: image,
//       role: role,
//       createdAt: now,
//       lastLogin: now,
//     );
//
//     await _usersCollection.doc(user.uid).set(userModel.toMap());
//     await user.updateDisplayName(name);
//
//     return userModel;
//   }
//
//   /// Checks and seeds master data automatically when the app launches
//   Future<void> seedInitialData() async {
//     try {
//       debugPrint('⏳ Seeding room types and amenities...');
//       final batch = _firestore.batch();
//
//       // 1. Predefine Amenities
//       final List<Map<String, dynamic>> initialAmenities = [
//         {'id': 'amenity_wifi', 'name': 'WiFi', 'icon': 'wifi'},
//         {'id': 'amenity_ac', 'name': 'Air Conditioning', 'icon': 'ac_unit'},
//         {'id': 'amenity_fan', 'name': 'Fan', 'icon': 'air'},
//         {'id': 'amenity_bed', 'name': 'Bed', 'icon': 'king_bed'},
//         {'id': 'amenity_study_desk', 'name': 'Study Desk', 'icon': 'table_restaurant'},
//         {'id': 'amenity_elevator', 'name': 'Elevator', 'icon': 'elevator'},
//         {'id': 'amenity_powerbank', 'name': 'Powerbank', 'icon': 'battery_charging_full'},
//         {'id': 'amenity_balcony', 'name': 'Balcony', 'icon': 'balcony'},
//         {'id': 'amenity_fridge', 'name': 'Refrigerator', 'icon': 'kitchen'},
//         {'id': 'amenity_kitchen', 'name': 'Kitchen', 'icon': 'soup_kitchen'},
//         {'id': 'amenity_shower', 'name': 'Shower Room', 'icon': 'shower'},
//         {'id': 'amenity_toilet', 'name': 'Toilet', 'icon': 'sanitation'},
//         {'id': 'amenity_water_heater', 'name': 'Water Heater', 'icon': 'hot_tub'},
//         {'id': 'amenity_parking', 'name': 'Free Parking', 'icon': 'local_parking'},
//         {'id': 'amenity_tv', 'name': 'Smart TV', 'icon': 'tv'},
//         {'id': 'amenity_pool', 'name': 'Swimming Pool', 'icon': 'pool'},
//         {'id': 'amenity_laundry', 'name': 'Laundry Service', 'icon': 'local_laundry_service'},
//       ];
//
//       for (var amenity in initialAmenities) {
//         DocumentReference docRef = _firestore.collection('amenities').doc(amenity['id']);
//         batch.set(docRef, {
//           'name': amenity['name'],
//           'icon': amenity['icon'],
//           'updatedAt': FieldValue.serverTimestamp(),
//         }, SetOptions(merge: true));
//       }
//
//       // 2. Predefine Room Types
//       final List<Map<String, dynamic>> initialRoomTypes = [
//         {
//           'id': 'rt_apartment',
//           'typeName': 'Standard Apartment',
//           'description': 'Traditional apartment in a low-rise or mid-rise building.'
//         },
//         {
//           'id': 'rt_minicondo',
//           'typeName': 'Mini Condo',
//           'description': 'Modern apartment building with basic facilities like lift and generator.'
//         },
//         {
//           'id': 'rt_condo',
//           'typeName': 'Full Condominium',
//           'description': 'High-rise residence with full amenities (gym, pool, 24/7 security).'
//         },
//         {
//           'id': 'rt_single_room',
//           'typeName': 'Single Room Unit',
//           'description': 'Private single room within a shared housing or hostel arrangement.'
//         },
//         {
//           'id': 'rt_dorm',
//           'typeName': 'Dormitory',
//           'description': 'Shared dormitory room with bunk beds for students or budget travelers.'
//         },
//         {
//           'id': 'rt_double',
//           'typeName': 'Double Room',
//           'description': 'Comfortable room featuring one double bed or two single beds suitable for two guests.'
//         },
//       ];
//
//       for (var type in initialRoomTypes) {
//         DocumentReference docRef = _firestore.collection('room_types').doc(type['id']);
//         batch.set(docRef, {
//           'typeName': type['typeName'],
//           'description': type['description'],
//           'updatedAt': FieldValue.serverTimestamp(),
//         }, SetOptions(merge: true));
//       }
//
//       // Commit all writes
//       await batch.commit();
//       debugPrint('✅ Predefined room types and amenities successfully created/updated!');
//     } catch (e) {
//       debugPrint('❌ Error seeding master data: $e');
//     }
//   }
//
//   Future<UserModel> updateUserProfile(UserEntity user) async {
//     debugPrint('AuthDataSource: updateUserProfile started for user: ${user.id}');
//     final docRef = _usersCollection.doc(user.id);
//     final userModel = UserModel.fromEntity(user);
//     debugPrint('AuthDataSource: updating Firestore document for user: ${user.id}');
//     await docRef.update({
//       'name': userModel.name,
//       'phoneNumber': userModel.phoneNumber.trim(),
//       'image': userModel.image,
//     });
//
//     debugPrint('AuthDataSource: fetching updated Firestore document');
//     final updatedDoc = await docRef.get();
//     debugPrint('AuthDataSource: updateUserProfile finished successfully');
//     return UserModel.fromFirestore(updatedDoc);
//   }
//
//   Future<UserModel?> getCurrentUserData() async {
//     final currentUser = _firebaseAuth.currentUser;
//     if (currentUser == null) return null;
//
//     final doc = await _usersCollection.doc(currentUser.uid).get();
//     if (!doc.exists) return null;
//
//     return UserModel.fromFirestore(doc);
//   }
//
//   Future<void> updatePassword({
//     required String currentPassword,
//     required String newPassword,
//   }) async {
//     debugPrint('AuthDataSource: updatePassword started');
//     final currentUser = _firebaseAuth.currentUser;
//     if (currentUser == null || currentUser.email == null) {
//       throw Exception('No authenticated user found.');
//     }
//
//     final credential = EmailAuthProvider.credential(
//       email: currentUser.email!,
//       password: currentPassword,
//     );
//
//     try {
//       await currentUser.reauthenticateWithCredential(credential).timeout(
//         const Duration(seconds: 15),
//         onTimeout: () => throw TimeoutException('Re-authentication timed out.'),
//       );
//     } catch (e) {
//       debugPrint('AuthDataSource: re-authentication error: $e');
//       if (e is FirebaseAuthException &&
//           (e.code == 'wrong-password' || e.code == 'invalid-credential')) {
//         throw Exception('The current password you entered is incorrect.');
//       }
//       rethrow;
//     }
//
//     await currentUser.updatePassword(newPassword).timeout(
//       const Duration(seconds: 15),
//       onTimeout: () => throw TimeoutException('Password update timed out.'),
//     );
//
//     await _firebaseAuth.signOut();
//     debugPrint('AuthDataSource: updatePassword completed successfully');
//   }
//
//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//   }
//
//   Future<UserModel?> getUserById(String userId) async {
//     debugPrint('🔍 Fetching owner user data for ownerId: $userId');
//
//     if (userId.trim().isEmpty) {
//       debugPrint('⚠️ Provided userId is empty.');
//       return null;
//     }
//
//     try {
//       final doc = await _usersCollection.doc(userId.trim()).get();
//
//       debugPrint('📄 Doc exists for [$userId]: ${doc.exists}');
//
//       if (!doc.exists || doc.data() == null) {
//         debugPrint('❌ No document or empty data found for userId: $userId');
//         return null;
//       }
//
//       return UserModel.fromFirestore(doc);
//     } catch (e, stackTrace) {
//       debugPrint('🚨 Error fetching owner user data for [$userId]: $e');
//       debugPrint('📜 StackTrace: $stackTrace');
//       return null;
//     }
//   }
//
//   IconData getAmenityIcon(String iconName) {
//     switch (iconName) {
//       case 'wifi':
//         return Icons.wifi;
//       case 'ac_unit':
//         return Icons.ac_unit;
//       case 'air':
//         return Icons.air;
//       case 'king_bed':
//         return Icons.king_bed;
//       case 'desk':
//       case 'table_restaurant':
//         return Icons.table_restaurant; // Replaced clipped 'desk'
//       case 'elevator':
//         return Icons.elevator;
//       case 'battery_charging_full':
//         return Icons.battery_charging_full;
//       case 'balcony':
//         return Icons.balcony;
//       case 'kitchen':
//         return Icons.kitchen;
//       case 'countertops':
//       case 'soup_kitchen':
//         return Icons.soup_kitchen; // Replaced top-heavy 'countertops'
//       case 'shower':
//         return Icons.shower;
//       case 'wc':
//       case 'sanitation':
//         return Icons.clean_hands_outlined; // Replaced top-heavy 'wc'
//       case 'hot_tub':
//         return Icons.hot_tub;
//       case 'local_parking':
//         return Icons.local_parking;
//       case 'tv':
//         return Icons.tv;
//       case 'pool':
//         return Icons.pool;
//       case 'local_laundry_service':
//         return Icons.local_laundry_service;
//       default:
//         return Icons.help_outline;
//     }
//   }
// }


import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/entity/user/user_entity.dart';
import '../../../../../domain/enum/role.dart';
import 'package:rental_room/data/data.dart';

@lazySingleton
class AuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthDataSource(
      this._firebaseAuth,
      this._firestore,
      );

  CollectionReference get _usersCollection => _firestore.collection('users');

  /// Helper to check if a phone number is already taken by another user
  Future<bool> _isPhoneNumberTaken(String phoneNumber, {String? excludeUserId}) async {
    try {
      final querySnapshot = await _usersCollection
          .where('phoneNumber', isEqualTo: phoneNumber.trim())
          .get()
          .timeout(const Duration(seconds: 5));

      if (excludeUserId != null) {
        // Ignore the current user's document when updating profile
        return querySnapshot.docs.any((doc) => doc.id != excludeUserId);
      }

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      // If query times out or security rules restrict querying users, catch gracefully
      return false;
    }
  }

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
    await docRef.update({
      'lastLogin': Timestamp.fromDate(now),
    });

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
    // 1. Create Auth Account first so the user is authenticated in Firebase
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw Exception('Sign up failed: Unable to create user.');
    }

    // 2. Check if phone number is already in use
    final isPhoneTaken = await _isPhoneNumberTaken(phoneNumber, excludeUserId: user.uid);
    if (isPhoneTaken) {
      await user.delete();
      throw Exception('This phone number is already registered by another user.');
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

  /// Checks and seeds master data automatically when the app launches
  Future<void> seedInitialData() async {
    try {
      debugPrint('⏳ Seeding room types and amenities...');
      final batch = _firestore.batch();

      // 1. Predefine Expanded Amenities
      final List<Map<String, dynamic>> initialAmenities = [
        // Connectivity & Tech
        {'id': 'amenity_wifi', 'name': 'WiFi', 'icon': 'wifi'},
        {'id': 'amenity_tv', 'name': 'Smart TV', 'icon': 'tv'},
        {'id': 'amenity_fingerprint_lock', 'name': 'Smart Lock', 'icon': 'door_sliding'},
        {'id': 'amenity_generator', 'name': 'Backup Generator', 'icon': 'electric_bolt'},
        {'id': 'amenity_powerbank', 'name': 'Powerbank / UPS', 'icon': 'battery_charging_full'},

        // Climate & Cooling
        {'id': 'amenity_ac', 'name': 'Air Conditioning', 'icon': 'ac_unit'},
        {'id': 'amenity_fan', 'name': 'Fan', 'icon': 'air'},

        // Bedroom & Furniture
        {'id': 'amenity_bed', 'name': 'Bed', 'icon': 'king_bed'},
        {'id': 'amenity_wardrobe', 'name': 'Wardrobe / Closet', 'icon': 'checkroom'},
        {'id': 'amenity_study_desk', 'name': 'Study Desk', 'icon': 'table_restaurant'},
        {'id': 'amenity_curtains', 'name': 'Blackout Curtains', 'icon': 'blinds'},

        // Kitchen & Dining
        {'id': 'amenity_fridge', 'name': 'Refrigerator', 'icon': 'kitchen'},
        {'id': 'amenity_kitchen', 'name': 'Kitchen', 'icon': 'soup_kitchen'},
        {'id': 'amenity_water_filter', 'name': 'Water Purifier', 'icon': 'water_drop'},

        // Bathroom & Utility
        {'id': 'amenity_shower', 'name': 'Shower Room', 'icon': 'shower'},
        {'id': 'amenity_toilet', 'name': 'Toilet', 'icon': 'sanitation'},
        {'id': 'amenity_water_heater', 'name': 'Water Heater', 'icon': 'hot_tub'},
        {'id': 'amenity_laundry', 'name': 'Washing Machine', 'icon': 'local_laundry_service'},
        {'id': 'amenity_iron', 'name': 'Ironing Facilities', 'icon': 'iron'},

        // Building & Security
        {'id': 'amenity_elevator', 'name': 'Elevator', 'icon': 'elevator'},
        {'id': 'amenity_security_24h', 'name': '24/7 Security Guard', 'icon': 'security'},
        {'id': 'amenity_cctv', 'name': 'CCTV Surveillance', 'icon': 'videocam'},
        {'id': 'amenity_balcony', 'name': 'Balcony', 'icon': 'balcony'},
        {'id': 'amenity_trash_chute', 'name': 'Garbage Disposal', 'icon': 'delete_outline'},

        // Outdoor & Facilities
        {'id': 'amenity_parking', 'name': 'Car Parking', 'icon': 'local_parking'},
        {'id': 'amenity_motorcycle_parking', 'name': 'Motorcycle Parking', 'icon': 'two_wheeler'},
        {'id': 'amenity_gym', 'name': 'Fitness Gym', 'icon': 'fitness_center'},
        {'id': 'amenity_pool', 'name': 'Swimming Pool', 'icon': 'pool'},
        {'id': 'amenity_rooftop', 'name': 'Rooftop Garden', 'icon': 'deck'},
      ];

      for (var amenity in initialAmenities) {
        DocumentReference docRef = _firestore.collection('amenities').doc(amenity['id']);
        batch.set(docRef, {
          'name': amenity['name'],
          'icon': amenity['icon'],
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      // 2. Predefine Room Types
      final List<Map<String, dynamic>> initialRoomTypes = [
        {
          'id': 'rt_apartment',
          'typeName': 'Standard Apartment',
          'description': 'Traditional apartment in a low-rise or mid-rise building.'
        },
        {
          'id': 'rt_minicondo',
          'typeName': 'Mini Condo',
          'description': 'Modern apartment building with essential facilities like elevator and backup generator.'
        },
        {
          'id': 'rt_condo',
          'typeName': 'Full Condominium',
          'description': 'High-rise luxury residence with full facilities (gym, pool, 24/7 security, car parking).'
        },
        {
          'id': 'rt_single_room',
          'typeName': 'Single Room Unit',
          'description': 'Private single room within a shared housing or hostel arrangement.'
        },
        {
          'id': 'rt_dorm',
          'typeName': 'Dormitory',
          'description': 'Shared dormitory room with bunk beds ideal for students or budget travelers.'
        },
        {
          'id': 'rt_double',
          'typeName': 'Double Room',
          'description': 'Comfortable room featuring one double bed or two single beds suitable for two guests.'
        },
      ];

      for (var type in initialRoomTypes) {
        DocumentReference docRef = _firestore.collection('room_types').doc(type['id']);
        batch.set(docRef, {
          'typeName': type['typeName'],
          'description': type['description'],
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      // Commit all writes
      await batch.commit();
      debugPrint('✅ Predefined room types and amenities successfully created/updated!');
    } catch (e) {
      debugPrint('❌ Error seeding master data: $e');
    }
  }

  Future<UserModel> updateUserProfile(UserEntity user) async {
    debugPrint('AuthDataSource: updateUserProfile started for user: ${user.id}');
    final docRef = _usersCollection.doc(user.id);
    final userModel = UserModel.fromEntity(user);
    debugPrint('AuthDataSource: updating Firestore document for user: ${user.id}');
    await docRef.update({
      'name': userModel.name,
      'phoneNumber': userModel.phoneNumber.trim(),
      'image': userModel.image,
    });

    debugPrint('AuthDataSource: fetching updated Firestore document');
    final updatedDoc = await docRef.get();
    debugPrint('AuthDataSource: updateUserProfile finished successfully');
    return UserModel.fromFirestore(updatedDoc);
  }

  Future<UserModel?> getCurrentUserData() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) return null;

    final doc = await _usersCollection.doc(currentUser.uid).get();
    if (!doc.exists) return null;

    return UserModel.fromFirestore(doc);
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    debugPrint('AuthDataSource: updatePassword started');
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
      debugPrint('AuthDataSource: re-authentication error: $e');
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
    debugPrint('AuthDataSource: updatePassword completed successfully');
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<UserModel?> getUserById(String userId) async {
    debugPrint('🔍 Fetching owner user data for ownerId: $userId');

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
      debugPrint('🚨 Error fetching owner user data for [$userId]: $e');
      debugPrint('📜 StackTrace: $stackTrace');
      return null;
    }
  }

  IconData getAmenityIcon(String iconName) {
    switch (iconName) {
      case 'wifi':
        return Icons.wifi;
      case 'ac_unit':
        return Icons.ac_unit;
      case 'air':
        return Icons.air;
      case 'king_bed':
        return Icons.king_bed;
      case 'table_restaurant':
      case 'desk':
        return Icons.table_restaurant;
      case 'checkroom':
        return Icons.checkroom;
      case 'blinds':
        return Icons.blinds;
      case 'elevator':
        return Icons.elevator;
      case 'door_sliding':
        return Icons.door_sliding;
      case 'electric_bolt':
        return Icons.electric_bolt;
      case 'battery_charging_full':
        return Icons.battery_charging_full;
      case 'balcony':
        return Icons.balcony;
      case 'kitchen':
        return Icons.kitchen;
      case 'soup_kitchen':
      case 'countertops':
        return Icons.soup_kitchen;
      case 'water_drop':
        return Icons.water_drop;
      case 'shower':
        return Icons.shower;
      case 'sanitation':
      case 'wc':
        return Icons.clean_hands_outlined;
      case 'hot_tub':
        return Icons.hot_tub;
      case 'local_parking':
        return Icons.local_parking;
      case 'two_wheeler':
        return Icons.two_wheeler;
      case 'tv':
        return Icons.tv;
      case 'fitness_center':
        return Icons.fitness_center;
      case 'pool':
        return Icons.pool;
      case 'deck':
        return Icons.deck;
      case 'security':
        return Icons.security;
      case 'videocam':
        return Icons.videocam;
      case 'iron':
        return Icons.iron;
      case 'delete_outline':
        return Icons.delete_outline;
      case 'local_laundry_service':
        return Icons.local_laundry_service;
      default:
        return Icons.help_outline;
    }
  }
}
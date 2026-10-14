import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'seed_constants.dart';

@lazySingleton
class SeedDataSource {
  final FirebaseFirestore _firestore;

  SeedDataSource(this._firestore);

  /// Checks and seeds master data automatically when the app launches
  Future<void> seedInitialData() async {
    try {
      debugPrint('⏳ Seeding room types and amenities...');
      final batch = _firestore.batch();

      for (var amenity in initialAmenities) {
        DocumentReference docRef =
            _firestore.collection('amenities').doc(amenity['id']);
        batch.set(docRef, {
          'name': amenity['name'],
          'icon': amenity['icon'],
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      for (var type in initialRoomTypes) {
        DocumentReference docRef =
            _firestore.collection('room_types').doc(type['id']);
        batch.set(docRef, {
          'typeName': type['typeName'],
          'description': type['description'],
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      await batch.commit();
      debugPrint(
        '✅ Predefined room types and amenities successfully created/updated!',
      );
    } catch (e) {
      debugPrint('❌ Error seeding master data: $e');
    }
  }
}

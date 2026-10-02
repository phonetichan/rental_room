import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../model/room_model.dart';


@lazySingleton
class RoomRemoteDataSource {
  final FirebaseFirestore _firestore;

  RoomRemoteDataSource(this._firestore);

  CollectionReference get _roomsCollection => _firestore.collection('rooms');

  Future<List<RoomModel>> getRooms({String? ownerId, String? roomTypeId, String? status}) async {
    Query query = _roomsCollection;

    if (ownerId != null && ownerId.isNotEmpty) {
      query = query.where('ownerId', isEqualTo: ownerId);
    }
    if (status != null && status.isNotEmpty) {
      query = query.where('status', isEqualTo: status);
    }

    final querySnapshot = await query.get();
    var rooms = querySnapshot.docs.map((doc) => RoomModel.fromFirestore(doc)).toList();

    if (roomTypeId != null && roomTypeId.isNotEmpty) {
      rooms = rooms.where((r) => r.roomTypeId == roomTypeId).toList();
    }

    return rooms;
  }

  Future<RoomModel?> getRoomById(String roomId) async {
    final doc = await _roomsCollection.doc(roomId).get();
    if (!doc.exists) return null;
    return RoomModel.fromFirestore(doc);
  }

  Future<RoomModel> createRoom(RoomModel roomModel) async {
    final docRef = roomModel.id.isNotEmpty
        ? _roomsCollection.doc(roomModel.id)
        : _roomsCollection.doc();

    final roomToSave = RoomModel(
      id: docRef.id,
      ownerId: roomModel.ownerId,
      roomTypeId: roomModel.roomTypeId,
      roomNumber: roomModel.roomNumber,
      name: roomModel.name,
      floor: roomModel.floor,
      maxGuests: roomModel.maxGuests,
      pricePerMonth: roomModel.pricePerMonth,
      location: roomModel.location,
      numberBedrooms: roomModel.numberBedrooms,
      roomSqft: roomModel.roomSqft,
      description: roomModel.description,
      amenityIds: roomModel.amenityIds,
      images: roomModel.images,
      latitude: roomModel.latitude,
      longitude: roomModel.longitude,
      status: roomModel.status,
      createdAt: roomModel.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await docRef.set(roomToSave.toMap());
    final createdDoc = await docRef.get();
    return RoomModel.fromFirestore(createdDoc);
  }

  Future<RoomModel> updateRoom(RoomModel roomModel) async {
    final docRef = _roomsCollection.doc(roomModel.id);
    await docRef.update(roomModel.toMap());
    final updatedDoc = await docRef.get();
    return RoomModel.fromFirestore(updatedDoc);
  }

  Future<void> deleteRoom(String roomId) async {
    await _roomsCollection.doc(roomId).delete();
  }

  Future<List<Map<String, dynamic>>> getRoomTypes() async {
    final snapshot = await _firestore.collection('room_types').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'id': doc.id,
        'name': data['typeName'] ?? data['name'] ?? doc.id,
        'description': data['description'] ?? '',
      };
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getAmenities() async {
    final snapshot = await _firestore.collection('amenities').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'id': doc.id,
        'name': data['name'] ?? doc.id,
        'icon': data['icon'] ?? 'help_outline',
      };
    }).toList();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/domain.dart';
import 'package:rental_room/data/data.dart';

@lazySingleton
class RoomRemoteDataSource {
  final FirebaseFirestore _firestore;

  RoomRemoteDataSource(this._firestore);

  CollectionReference get _roomsCollection => _firestore.collection('rooms');

  Future<List<RoomModel>> getRooms({
    String? ownerId,
    String? roomTypeId,
    String? status,
  }) async {
    Query query = _roomsCollection;

    if (ownerId != null && ownerId.isNotEmpty) {
      query = query.where('ownerId', isEqualTo: ownerId);
    }
    if (status != null && status.isNotEmpty) {
      query = query.where('status', isEqualTo: status);
    }

    final querySnapshot = await query.get();
    var rooms = querySnapshot.docs
        .map((doc) => RoomModel.fromFirestore(doc))
        .toList();

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

  /// One page of rooms, newest first. Used by All, Rooms and My Rooms lists.
  /// [cursor] is the last DocumentSnapshot of the previous page (null for page 1).
  Future<PageResult<RoomModel>> fetchRoomsPage({
    String? ownerId,
    String? roomTypeId,
    String? status,
    Object? cursor,
    required int limit,
  }) async {
    Query query = _roomsCollection;

    if (status != null && status.isNotEmpty) {
      query = query.where('status', isEqualTo: status);
    }
    if (ownerId != null && ownerId.isNotEmpty) {
      query = query.where('ownerId', isEqualTo: ownerId);
    }
    if (roomTypeId != null && roomTypeId.isNotEmpty) {
      query = query.where('roomTypeId', isEqualTo: roomTypeId);
    }

    query = query.orderBy('createdAt', descending: true).limit(limit + 1);

    if (cursor != null) {
      query = query.startAfterDocument(cursor as DocumentSnapshot);
    }

    final docs = (await query.get()).docs;
    final hasMore = docs.length > limit;
    final pageDocs = docs.take(limit).toList();

    return PageResult<RoomModel>(
      items: pageDocs.map((d) => RoomModel.fromFirestore(d)).toList(),
      cursor: pageDocs.isEmpty ? cursor : pageDocs.last,
      hasMore: hasMore,
    );
  }

  /// SAVED tab: one page of rooms from the favorite id list.
  /// [cursor] is an int offset into [allIds] (null for page 1).
  Future<PageResult<RoomModel>> fetchRoomsByIds(
    List<String> allIds,
    Object? cursor,
    int limit,
  ) async {
    final offset = (cursor as int?) ?? 0;
    final ids = allIds.skip(offset).take(limit).toList();
    final nextOffset = offset + ids.length;

    if (ids.isEmpty) {
      return PageResult<RoomModel>(
        items: const [],
        cursor: offset,
        hasMore: false,
      );
    }

    final snapshot = await _roomsCollection
        .where(FieldPath.documentId, whereIn: ids)
        .get();

    final byId = {for (final doc in snapshot.docs) doc.id: doc};

    final items = ids
        .where(byId.containsKey) // skip rooms that were deleted
        .map((id) => RoomModel.fromFirestore(byId[id]!))
        .toList();

    return PageResult<RoomModel>(
      items: items,
      cursor: nextOffset,
      hasMore: nextOffset < allIds.length,
    );
  }
}

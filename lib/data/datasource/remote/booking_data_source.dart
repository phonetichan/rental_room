import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../model/booking_model.dart';

@lazySingleton
class BookingRemoteDataSource {
  final FirebaseFirestore _firestore;

  BookingRemoteDataSource(this._firestore);

  CollectionReference get _bookingsCollection => _firestore.collection('bookings');
  CollectionReference get _roomsCollection => _firestore.collection('rooms');

  Future<List<BookingModel>> getBookings({
    String? userId,
    String? roomId,
    String? ownerId,
  }) async {
    Query query = _bookingsCollection;

    if (userId != null && userId.isNotEmpty) {
      query = query.where('userId', isEqualTo: userId);
    }
    if (roomId != null && roomId.isNotEmpty) {
      query = query.where('roomId', isEqualTo: roomId);
    }
    if (ownerId != null && ownerId.isNotEmpty) {
      query = query.where('ownerId', isEqualTo: ownerId);
    }

    final querySnapshot = await query.get();
    var bookings = querySnapshot.docs.map((doc) => BookingModel.fromFirestore(doc)).toList();

    // Fallback for ownerId if collection query returned empty (e.g. legacy bookings without ownerId field)
    if (ownerId != null && ownerId.isNotEmpty && bookings.isEmpty) {
      try {
        final roomsSnapshot = await _roomsCollection.where('ownerId', isEqualTo: ownerId).get();
        final roomIds = roomsSnapshot.docs.map((d) => d.id).toList();
        if (roomIds.isNotEmpty) {
          List<BookingModel> allOwnerBookings = [];
          for (var rId in roomIds) {
            final roomBookingsSnap = await _bookingsCollection.where('roomId', isEqualTo: rId).get();
            allOwnerBookings.addAll(roomBookingsSnap.docs.map((doc) => BookingModel.fromFirestore(doc)));
          }
          bookings = allOwnerBookings;
        }
      } catch (_) {}
    }

    return bookings;
  }

  Stream<List<BookingModel>> watchBookings({
    String? userId,
    String? roomId,
    String? ownerId,
  }) {
    Query query = _bookingsCollection;

    if (userId != null && userId.isNotEmpty) {
      query = query.where('userId', isEqualTo: userId);
    }
    if (roomId != null && roomId.isNotEmpty) {
      query = query.where('roomId', isEqualTo: roomId);
    }
    if (ownerId != null && ownerId.isNotEmpty) {
      query = query.where('ownerId', isEqualTo: ownerId);
    }

    return query.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => BookingModel.fromFirestore(doc)).toList());
  }

  Future<BookingModel?> getBookingById(String bookingId) async {
    final doc = await _bookingsCollection.doc(bookingId).get();
    if (!doc.exists) return null;
    return BookingModel.fromFirestore(doc);
  }

  Future<int> getVisitorCountForRoom(String roomId) async {
    if (roomId.isEmpty) return 0;
    try {
      final snap = await _bookingsCollection
          .where('roomId', isEqualTo: roomId)
          .where('isVisited', isEqualTo: true)
          .get();
      return snap.docs.length;
    } catch (_) {
      return 0;
    }
  }

  Future<void> cancelOtherPendingBookingsForRoom(String roomId, String exceptedBookingId) async {
    if (roomId.isEmpty) return;
    try {
      final querySnapshot = await _bookingsCollection
          .where('roomId', isEqualTo: roomId)
          .get();

      for (final doc in querySnapshot.docs) {
        if (doc.id == exceptedBookingId) continue;
        final data = doc.data() as Map<String, dynamic>?;
        final status = (data?['status'] as String? ?? '').toLowerCase();
        if (status == 'pending' || status == 'draft') {
          await deleteBooking(doc.id);
        }
      }
    } catch (e) {
      debugPrint('❌ Error cancelling other pending bookings for room $roomId: $e');
    }
  }

  Future<String?> _resolveOwnerId(String roomId, String? currentOwnerId) async {
    if (currentOwnerId != null && currentOwnerId.isNotEmpty) return currentOwnerId;
    if (roomId.isEmpty) return null;
    try {
      final roomDoc = await _roomsCollection.doc(roomId).get();
      if (roomDoc.exists) {
        return (roomDoc.data() as Map<String, dynamic>?)?['ownerId'] as String?;
      }
    } catch (_) {}
    return null;
  }

  Future<BookingModel> createBooking(BookingModel bookingModel) async {
    final resolvedOwnerId = await _resolveOwnerId(bookingModel.roomId, bookingModel.ownerId);

    // Deduplication check: If a booking document already exists for this userId & roomId, update it instead.
    if (bookingModel.id.isEmpty &&
        bookingModel.userId.isNotEmpty &&
        bookingModel.roomId.isNotEmpty) {
      final existingDocs = await _bookingsCollection
          .where('userId', isEqualTo: bookingModel.userId)
          .where('roomId', isEqualTo: bookingModel.roomId)
          .get();

      if (existingDocs.docs.isNotEmpty) {
        final existingDoc = existingDocs.docs.first;
        final docRef = _bookingsCollection.doc(existingDoc.id);

        final status = bookingModel.status;

        final updateData = {
          'isPhoneContacted': bookingModel.isPhoneContacted,
          'isVisited': bookingModel.isVisited,
          'isReadByTenant': bookingModel.isReadByTenant,
          'isReadByOwner': bookingModel.isReadByOwner,
          'status': status,
          if (resolvedOwnerId != null) 'ownerId': resolvedOwnerId,
          'updatedAt': FieldValue.serverTimestamp(),
          if (bookingModel.roomName != null) 'roomName': bookingModel.roomName,
          if (bookingModel.roomPrice != null) 'roomPrice': bookingModel.roomPrice,
          if (bookingModel.roomImageUrl != null) 'roomImageUrl': bookingModel.roomImageUrl,
          if (bookingModel.tenantName != null) 'tenantName': bookingModel.tenantName,
          if (bookingModel.tenantPhone != null) 'tenantPhone': bookingModel.tenantPhone,
        };

        await docRef.update(updateData);
        final updatedDoc = await docRef.get();
        return BookingModel.fromFirestore(updatedDoc);
      }
    }

    final docRef = bookingModel.id.isNotEmpty
        ? _bookingsCollection.doc(bookingModel.id)
        : _bookingsCollection.doc();

    final status = bookingModel.status;

    final bookingToSave = BookingModel(
      id: docRef.id,
      userId: bookingModel.userId,
      roomId: bookingModel.roomId,
      ownerId: resolvedOwnerId,
      isPhoneContacted: bookingModel.isPhoneContacted,
      isVisited: bookingModel.isVisited,
      isReadByTenant: bookingModel.isReadByTenant,
      isReadByOwner: bookingModel.isReadByOwner,
      status: status,
      createdAt: bookingModel.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
      roomName: bookingModel.roomName,
      roomPrice: bookingModel.roomPrice,
      roomImageUrl: bookingModel.roomImageUrl,
      tenantName: bookingModel.tenantName,
      tenantPhone: bookingModel.tenantPhone,
    );

    await docRef.set(bookingToSave.toMap());
    final createdDoc = await docRef.get();
    return BookingModel.fromFirestore(createdDoc);
  }

  Future<BookingModel> updateBooking(BookingModel bookingModel) async {
    final docRef = _bookingsCollection.doc(bookingModel.id);
    final resolvedOwnerId = await _resolveOwnerId(bookingModel.roomId, bookingModel.ownerId);

    final status = bookingModel.status;

    final updateData = {
      'isPhoneContacted': bookingModel.isPhoneContacted,
      'isVisited': bookingModel.isVisited,
      'isReadByTenant': bookingModel.isReadByTenant,
      'isReadByOwner': bookingModel.isReadByOwner,
      'status': status,
      if (resolvedOwnerId != null) 'ownerId': resolvedOwnerId,
      'updatedAt': FieldValue.serverTimestamp(),
      if (bookingModel.roomName != null) 'roomName': bookingModel.roomName,
      if (bookingModel.roomPrice != null) 'roomPrice': bookingModel.roomPrice,
      if (bookingModel.roomImageUrl != null) 'roomImageUrl': bookingModel.roomImageUrl,
      if (bookingModel.tenantName != null) 'tenantName': bookingModel.tenantName,
      if (bookingModel.tenantPhone != null) 'tenantPhone': bookingModel.tenantPhone,
    };

    await docRef.update(updateData);
    final updatedDoc = await docRef.get();
    return BookingModel.fromFirestore(updatedDoc);
  }

  Future<void> deleteBooking(String bookingId) async {
    if (bookingId.isNotEmpty) {
      await _bookingsCollection.doc(bookingId).delete();
    }
  }
}

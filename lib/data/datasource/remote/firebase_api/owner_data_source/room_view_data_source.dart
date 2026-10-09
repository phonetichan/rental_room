import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'package:rental_room/data/data.dart';

abstract class RoomViewRemoteDataSource {
  Future<void> recordRoomView({required String roomId, required String userId});
  Future<void> removeRoomView({required String roomId, required String userId});
  Future<int> getRoomVisitorCount(String roomId);
}

@LazySingleton(as: RoomViewRemoteDataSource)
class RoomViewRemoteDataSourceImpl implements RoomViewRemoteDataSource {
  final FirebaseFirestore _firestore;

  RoomViewRemoteDataSourceImpl(this._firestore);

  @override
  Future<void> recordRoomView({
    required String roomId,
    required String userId,
  }) async {
    if (roomId.isEmpty || userId.isEmpty) return;

    // Using userId as the document ID prevents duplicate view counts from the same user
    final docRef = _firestore
        .collection('rooms')
        .doc(roomId)
        .collection('views')
        .doc(userId);

    final viewModel = RoomViewModel(
      id: userId,
      roomId: roomId,
      userId: userId,
      viewedAt: DateTime.now(),
    );

    await docRef.set(viewModel.toFirestore(), SetOptions(merge: true));
  }

  @override
  Future<void> removeRoomView({
    required String roomId,
    required String userId,
  }) async {
    if (roomId.isEmpty || userId.isEmpty) return;

    final docRef = _firestore
        .collection('rooms')
        .doc(roomId)
        .collection('views')
        .doc(userId);

    await docRef.delete();
  }

  @override
  Future<int> getRoomVisitorCount(String roomId) async {
    if (roomId.isEmpty) return 0;
    try {
      // Using Firestore aggregation count() for optimal performance (1 document read cost)
      final aggregateQuery = await _firestore
          .collection('rooms')
          .doc(roomId)
          .collection('views')
          .count()
          .get();

      return aggregateQuery.count ?? 0;
    } catch (_) {
      return 0;
    }
  }
}
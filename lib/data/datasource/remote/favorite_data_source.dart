import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../../model/favorite_model.dart';

@lazySingleton
class FavoriteRemoteDataSource {
  final FirebaseFirestore _firestore;

  FavoriteRemoteDataSource(this._firestore);

  CollectionReference get _favoritesCollection => _firestore.collection('favorites');

  /// Toggles favorite for a room by a user.
  /// Returns `true` if added as favorite, `false` if removed.
  Future<bool> toggleFavorite(String roomId, String userId) async {
    final query = await _favoritesCollection
        .where('roomId', isEqualTo: roomId)
        .where('userId', isEqualTo: userId)
        .get();

    if (query.docs.isNotEmpty) {
      // Already favorited, so remove it
      for (final doc in query.docs) {
        await doc.reference.delete();
      }
      return false;
    } else {
      // Not favorited, so add it
      final docRef = _favoritesCollection.doc();
      final model = FavoriteModel(
        id: docRef.id,
        roomId: roomId,
        userId: userId,
        createdAt: DateTime.now(),
      );
      await docRef.set(model.toMap());
      return true;
    }
  }

  /// Gets all favorites by a specific user.
  Future<List<FavoriteModel>> getUserFavorites(String userId) async {
    final snapshot = await _favoritesCollection
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs.map((doc) => FavoriteModel.fromFirestore(doc)).toList();
  }

  /// Returns a map of roomId to number of favorites.
  Future<Map<String, int>> getFavoriteCounts() async {
    final snapshot = await _favoritesCollection.get();
    final Map<String, int> counts = {};

    for (final doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>?;
      final roomId = data?['roomId'] as String?;
      if (roomId != null && roomId.isNotEmpty) {
        counts[roomId] = (counts[roomId] ?? 0) + 1;
      }
    }

    return counts;
  }

  /// Gets total number of favorites for a specific room.
  Future<int> getFavoriteCountForRoom(String roomId) async {
    final snapshot = await _favoritesCollection
        .where('roomId', isEqualTo: roomId)
        .get();
    return snapshot.docs.length;
  }
}

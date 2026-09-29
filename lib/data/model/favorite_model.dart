import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/favorite_entity.dart';

class FavoriteModel {
  final String id;
  final String roomId;
  final String userId;
  final DateTime? createdAt;

  FavoriteModel({
    required this.id,
    required this.roomId,
    required this.userId,
    this.createdAt,
  });

  factory FavoriteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return FavoriteModel(
      id: doc.id,
      roomId: data['roomId'] as String? ?? '',
      userId: data['userId'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'roomId': roomId,
      'userId': userId,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
    };
  }

  FavoriteEntity toEntity() {
    return FavoriteEntity(
      id: id,
      roomId: roomId,
      userId: userId,
      createdAt: createdAt,
    );
  }

  factory FavoriteModel.fromEntity(FavoriteEntity entity) {
    return FavoriteModel(
      id: entity.id,
      roomId: entity.roomId,
      userId: entity.userId,
      createdAt: entity.createdAt,
    );
  }
}

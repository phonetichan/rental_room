import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entity/favorite/favorite_entity.dart';

part 'favorite_model.freezed.dart';

@freezed
class FavoriteModel with _$FavoriteModel {
  const FavoriteModel._();

  const factory FavoriteModel({
    required String id,
    required String roomId,
    required String userId,
    DateTime? createdAt,
  }) = _FavoriteModel;

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

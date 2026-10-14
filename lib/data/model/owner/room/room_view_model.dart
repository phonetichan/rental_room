import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entity/room/room_view_entity.dart';

part 'room_view_model.freezed.dart';

@freezed
class RoomViewModel with _$RoomViewModel {
  const RoomViewModel._();

  const factory RoomViewModel({
    required String id,
    required String roomId,
    required String userId,
    required DateTime viewedAt,
  }) = _RoomViewModel;

  factory RoomViewModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return RoomViewModel(
      id: doc.id,
      roomId: data['roomId'] as String? ?? '',
      userId: data['userId'] as String? ?? '',
      viewedAt: (data['viewedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'roomId': roomId,
      'userId': userId,
      'viewedAt': FieldValue.serverTimestamp(),
    };
  }

  RoomViewEntity toEntity() {
    return RoomViewEntity(
      id: id,
      roomId: roomId,
      userId: userId,
      viewedAt: viewedAt,
    );
  }

  factory RoomViewModel.fromEntity(RoomViewEntity entity) {
    return RoomViewModel(
      id: entity.id,
      roomId: entity.roomId,
      userId: entity.userId,
      viewedAt: entity.viewedAt,
    );
  }
}

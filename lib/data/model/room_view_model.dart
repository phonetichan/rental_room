import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/room_view_entity.dart';

class RoomViewModel extends RoomViewEntity {
  const RoomViewModel({
    required super.id,
    required super.roomId,
    required super.userId,
    required super.viewedAt,
  });

  factory RoomViewModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
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
}
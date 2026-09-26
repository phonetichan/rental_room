import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/enum/role.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phoneNumber,
    super.image,
    required super.role,
    required super.createdAt,
    required super.lastLogin,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    DateTime parseDateTime(dynamic value) {
      if (value is Timestamp) {
        return value.toDate();
      } else if (value is String) {
        return DateTime.tryParse(value) ?? DateTime.now();
      } else if (value is int) {
        return DateTime.fromMillisecondsSinceEpoch(value);
      }
      return DateTime.now();
    }

    return UserModel(
      id: id,
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phoneNumber: map['phoneNumber'] as String? ?? '',
      image: map['image'] as String?,
      role: UserRoleX.fromString(map['role'] as String?),
      createdAt: parseDateTime(map['createdAt']),
      lastLogin: parseDateTime(map['lastLogin']),
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return UserModel.fromMap(data, doc.id);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'image': image,
      'role': role.value,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLogin': Timestamp.fromDate(lastLogin),
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      image: entity.image,
      role: entity.role,
      createdAt: entity.createdAt,
      lastLogin: entity.lastLogin,
    );
  }
}

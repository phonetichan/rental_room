import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entity/user/user_entity.dart';
import '../../../domain/enum/role.dart';

part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String id,
    required String name,
    required String email,
    required String phoneNumber,
    String? image,
    required UserRole role,
    required DateTime createdAt,
    required DateTime lastLogin,
    double? latitude, // optional
    double? longitude, // optional
    String? address, // optional
  }) = _UserModel;

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
      // Firestore may return int or double -> go through num
      latitude: (map['latitude'] as num?)?.toDouble(),
      longitude: (map['longitude'] as num?)?.toDouble(),
      address: map['address'] as String?,
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
      // only written when the user picked a location
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (address != null) 'address': address,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      image: image,
      role: role,
      createdAt: createdAt,
      lastLogin: lastLogin,
      latitude: latitude,
      longitude: longitude,
      address: address,
    );
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
      latitude: entity.latitude,
      longitude: entity.longitude,
      address: entity.address,
    );
  }
}
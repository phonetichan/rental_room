import '../../enum/role.dart';

class UserEntity {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? image;
  final UserRole role;
  final DateTime createdAt;
  final DateTime lastLogin;
  final double? latitude; // nullable = optional
  final double? longitude;
  final String? address;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.image,
    required this.role,
    required this.createdAt,
    required this.lastLogin,
    this.latitude,
    this.longitude,
    this.address,
  });

  /// True only when the user picked a location.
  bool get hasLocation => latitude != null && longitude != null;

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? image,
    UserRole? role,
    DateTime? createdAt,
    DateTime? lastLogin,
    double? latitude,
    double? longitude,
    String? address,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      image: image ?? this.image,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UserEntity &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              email == other.email &&
              phoneNumber == other.phoneNumber &&
              image == other.image &&
              role == other.role &&
              createdAt == other.createdAt &&
              lastLogin == other.lastLogin &&
              latitude == other.latitude &&
              longitude == other.longitude &&
              address == other.address;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      image.hashCode ^
      role.hashCode ^
      createdAt.hashCode ^
      lastLogin.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      address.hashCode;
}
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

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.image,
    required this.role,
    required this.createdAt,
    required this.lastLogin,
  });

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? image,
    UserRole? role,
    DateTime? createdAt,
    DateTime? lastLogin,
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
          lastLogin == other.lastLogin;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      image.hashCode ^
      role.hashCode ^
      createdAt.hashCode ^
      lastLogin.hashCode;
}

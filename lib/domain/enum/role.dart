enum UserRole {
  owner,
  tenant,
}

extension UserRoleX on UserRole {
  String get value {
    switch (this) {
      case UserRole.owner:
        return 'owner';
      case UserRole.tenant:
        return 'tenant';
    }
  }

  static UserRole fromString(String? role) {
    switch (role?.toLowerCase()) {
      case 'owner':
        return UserRole.owner;
      case 'tenant':
      default:
        return UserRole.tenant;
    }
  }
}

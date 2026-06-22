enum UserRole {
  donor,
  hospitalAdmin,
  labTechnician,
  bloodBankManager,
}

extension UserRoleExtension on UserRole {
  String get value {
    switch (this) {
      case UserRole.donor:
        return 'donor';

      case UserRole.hospitalAdmin:
        return 'hospital_admin';

      case UserRole.labTechnician:
        return 'labTechnician';

      case UserRole.bloodBankManager:
        return 'blood_bank_manager';
    }
  }

  static UserRole fromString(String role) {
    switch (role) {
      case 'donor':
        return UserRole.donor;

      case 'hospital_admin':
        return UserRole.hospitalAdmin;

      case 'labTechnician':
        return UserRole.labTechnician;

      case 'blood_bank_manager':
        return UserRole.bloodBankManager;

      default:
        throw Exception('Invalid role: $role');
    }
  }
}
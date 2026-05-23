import 'package:vital_match/core/enums/user_role.dart';

class AppUser {
  final String userId;
  final String fullName;
  final String email;
  final String phoneNumber;
  final UserRole role;
  final DateTime createdAt;

  const AppUser({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.createdAt,
  });
}

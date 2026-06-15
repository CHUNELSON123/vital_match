import '../entities/auth_user.dart';

abstract class AuthRepository {

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
    required String role,
    String? bloodGroup,
    String? weight,
    String? dateOfBirth,
    double? latitude,
    double? longitude,
  });

  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<AuthUser?> getCurrentUser();
}
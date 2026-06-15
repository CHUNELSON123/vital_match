import '../models/auth_model.dart';

abstract class AuthRemoteDatasource {

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

  Future<AuthModel> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<AuthModel?> getCurrentUser();
}


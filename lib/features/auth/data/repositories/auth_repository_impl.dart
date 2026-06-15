import 'package:vital_match/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:vital_match/features/auth/domain/entities/auth_user.dart';
import 'package:vital_match/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl({required this.remoteDatasource});

  @override
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
  }) async {
    await remoteDatasource.register(
      fullName: fullName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      role: role,
      bloodGroup: bloodGroup,
      weight: weight,
      dateOfBirth: dateOfBirth,
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    final authModel = await remoteDatasource.login(
      email: email,
      password: password,
    );

    return authModel;
  }

  @override
  Future<void> logout() async {
    await remoteDatasource.logout();
  }

  @override
  Future<AuthUser?> getCurrentUser() async {
    final authModel = await remoteDatasource.getCurrentUser();

    return authModel;
  }
}

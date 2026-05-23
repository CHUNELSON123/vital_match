import 'package:vital_match/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:vital_match/features/auth/domain/entities/auth_user.dart';
import 'package:vital_match/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl({required this.remoteDatasource});

  @override
  Future<AuthUser> register({
    required String email,
    required String password,
  }) async {
    final authModel = await remoteDatasource.register(
      email: email,
      password: password,
    );

    return authModel;
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

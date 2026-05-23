import '../models/auth_model.dart';

abstract class AuthRemoteDatasource {
  Future<AuthModel> register({required String email, required String password});

  Future<AuthModel> login({required String email, required String password});

  Future<void> logout();

  Future<AuthModel> getCurrentUser();
}

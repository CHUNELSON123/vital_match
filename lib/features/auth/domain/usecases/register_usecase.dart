import 'package:vital_match/features/auth/domain/entities/auth_user.dart';
import 'package:vital_match/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase({required this.repository});

  Future<AuthUser> call({
    required String email,
    required String password,
  }) async {
    return await repository.register(email: email, password: password);
  }
}

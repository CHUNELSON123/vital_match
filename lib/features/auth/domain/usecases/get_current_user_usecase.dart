import 'package:vital_match/features/auth/domain/entities/auth_user.dart';
import 'package:vital_match/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUsecase {
  final AuthRepository repository;

  GetCurrentUserUsecase({required this.repository});

  Future<AuthUser?> call() async {
    return await repository.getCurrentUser();
  }
}

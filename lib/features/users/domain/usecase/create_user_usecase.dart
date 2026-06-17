import 'package:vital_match/features/users/domain/repositories/app_user_repository.dart';
import '../entities/app_user.dart';

class CreateUserUsecase {
  final AppUserRepository repository;

  CreateUserUsecase(this.repository);

  Future<void> call(AppUser user) async {
    await repository.createUser(user);
  }
}

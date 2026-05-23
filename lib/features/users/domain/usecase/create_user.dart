import 'package:vital_match/features/users/domain/repositories/app_user_repository.dart';
import '../entities/app_user.dart';

class CreateUser {
  final AppUserRepository repository;

  CreateUser(this.repository);

  Future<void> call(AppUser user) async {
    await repository.createUser(user);
  }
}

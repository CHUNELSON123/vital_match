import 'package:vital_match/features/users/domain/entities/app_user.dart';
import 'package:vital_match/features/users/domain/repositories/app_user_repository.dart';

class UpdateUser {
  final AppUserRepository repository;

  UpdateUser(this.repository);

  Future<void> call(AppUser user) async {
    await repository.updateUser(user);
  }
}

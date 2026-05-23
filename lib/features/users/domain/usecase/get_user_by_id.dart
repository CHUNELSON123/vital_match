import '../repositories/app_user_repository.dart';
import '../entities/app_user.dart';

class GetUserById {
  final AppUserRepository repository;

  GetUserById(this.repository);

  Future<AppUser?> call(String userId) async {
    return await repository.getUserById(userId);
  }
}

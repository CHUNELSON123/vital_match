import '../repositories/app_user_repository.dart';
import '../entities/app_user.dart';

class GetUserByIdUsecase {
  final AppUserRepository repository;

  GetUserByIdUsecase(this.repository);

  Future<AppUser?> call(String userId) async {
    return await repository.getUserById(userId);
  }
}

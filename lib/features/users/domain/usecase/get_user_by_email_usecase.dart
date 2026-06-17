import '../entities/app_user.dart';
import '../repositories/app_user_repository.dart';

class GetUserByEmailUsecase {

  final AppUserRepository repository;

  GetUserByEmailUsecase(
    this.repository,
  );

  Future<AppUser?> call(
    String email,
  ) async {

    return await repository
        .getUserByEmail(
      email,
    );
  }
}
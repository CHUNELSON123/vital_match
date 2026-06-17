import 'package:vital_match/features/users/domain/repositories/app_user_repository.dart';

class DeleteUserUsecase {
  final AppUserRepository repository;

  DeleteUserUsecase(this.repository);

  Future<void> call(String userId) async {
    await repository.deleteUser(userId);
  }
}

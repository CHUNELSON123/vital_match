import 'package:vital_match/features/users/domain/repositories/app_user_repository.dart';
import '../entities/app_user.dart';

class GetAllUser {
  final AppUserRepository repository;

  GetAllUser(this.repository);

  Future<List<AppUser>> call() async {
    return await repository.getAllUsers();
  }
}

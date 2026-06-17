import '../entities/app_user.dart';

abstract class AppUserRepository {
  //Create
  Future<void> createUser(AppUser user);

  //GET user by Id
  Future<AppUser?> getUserById(String userId);

  //GET all users
  Future<List<AppUser>> getAllUsers();

  //UPDATE User
  Future<void> updateUser(AppUser user);

  //DELETE  User
  Future<void> deleteUser(String userId);

  Future<AppUser?> getUserByEmail(
  String email,
);
}

import '../models/app_user_model.dart';

abstract class AppUserRemoteDatasource {

  Future<void> createUser(AppUserModel user);

  Future<AppUserModel?> getUserById(String uid);

  Future<List<AppUserModel>> getAllUsers();

  Future<void> updateUser(AppUserModel user);

  Future<void> deleteUser(String uid);

  Future<AppUserModel?> getUserByEmail(
  String email,
);
}
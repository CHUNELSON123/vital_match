import 'package:vital_match/features/users/data/datasources/app_user_remote_datasource.dart';
import 'package:vital_match/features/users/data/models/app_user_model.dart';
import 'package:vital_match/features/users/domain/repositories/app_user_repository.dart';
import '../../domain/entities/app_user.dart';

class AppUserRepositoryImpl 
    implements AppUserRepository {
  final AppUserRemoteDatasource remoteDatasource;

  AppUserRepositoryImpl(this.remoteDatasource);

  //Create User
  @override
  Future<void> createUser(AppUser user) async {
    final userModel = AppUserModel(
      userId: user.userId,
      fullName: user.fullName,
      email: user.email,
      phoneNumber: user.phoneNumber,
      role: user.role,
      createdAt: user.createdAt,
    );

    await remoteDatasource.createUser(userModel);
  }

  //GET User By Id

  @override
  Future<AppUser?> getUserById(String userId) async {
    return await remoteDatasource.getUserById(userId);
  }

  //GET ALL USERS
  @override
  Future<List<AppUser>> getAllUsers() async {
    return await remoteDatasource.getAllUsers();
  }

  //UPDATE USERS
  @override
  Future<void> updateUser(AppUser user) async {
    final userModel = AppUserModel(
      userId: user.userId,
      fullName: user.fullName,
      email: user.email,
      phoneNumber: user.phoneNumber,
      role: user.role,
      createdAt: user.createdAt,
    );

    await remoteDatasource.updateUser(userModel);
  }

//DELETE USER
  @override
  Future<void> deleteUser(String userId) async {
    await remoteDatasource.deleteUser(userId);
  }

  //GET USER BY EMAIL
  @override
Future<AppUser?> getUserByEmail(
  String email,
) async {

  return await remoteDatasource
      .getUserByEmail(
    email,
  );
}
}

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user_model.dart';
import 'app_user_remote_datasource.dart';

class AppUserRemoteDatasourceImpl
    implements AppUserRemoteDatasource {

  final FirebaseFirestore firestore;

  AppUserRemoteDatasourceImpl({
    required this.firestore,
  });

  @override
  Future<void> createUser(AppUserModel user) async {

    await firestore
        .collection('users')
        .doc(user.userId)
        .set(user.toMap());
  }

  @override
  Future<AppUserModel?> getUserById(String uid) async {

    final doc =
        await firestore
            .collection('users')
            .doc(uid)
            .get();

    if (!doc.exists) {
      return null;
    }

    return AppUserModel.fromFirestore(doc);
  }

  @override
  Future<List<AppUserModel>> getAllUsers() async {

    final snapshot =
        await firestore
            .collection('users')
            .get();

    return snapshot.docs
        .map((doc) => AppUserModel.fromFirestore(doc))
        .toList();
  }

  @override
  Future<void> updateUser(AppUserModel user) async {

    await firestore
        .collection('users')
        .doc(user.userId)
        .update(user.toMap());
  }

  @override
  Future<void> deleteUser(String uid) async {

    await firestore
        .collection('users')
        .doc(uid)
        .delete();
  }

  @override
Future<AppUserModel?> getUserByEmail(
  String email,
) async {

  final snapshot =
      await firestore
          .collection('users')
          .where(
            'email',
            isEqualTo: email,
          )
          .limit(1)
          .get();

  if (snapshot.docs.isEmpty) {
    return null;
  }

  return AppUserModel.fromFirestore(
    snapshot.docs.first,
  );
}
}
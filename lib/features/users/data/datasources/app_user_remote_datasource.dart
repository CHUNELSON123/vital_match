import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user_model.dart';

class AppUserRemoteDatasource {
  final FirebaseFirestore firestore;

  AppUserRemoteDatasource(this.firestore);

  Future<void> createUser(AppUserModel user) async {
    await firestore
        .collection('users')
        .doc(user.userId)
        .set(user.toMap());
  }

  Future<AppUserModel?> getUserById(String uid) async {
    final doc = 
        await firestore
            .collection('users')
            .doc(uid)
            .get();

    if (doc.exists) {
      return AppUserModel.fromFirestore(doc);
    }

    return null;
  }

  Future<List<AppUserModel>> getAllUsers() async {
    final snapshot = await firestore.collection('users').get();

    return snapshot.docs
        .map((doc) => AppUserModel.fromFirestore(doc))
        .toList();
  }

  Future<void> updateUser(AppUserModel user) async {
    await firestore
        .collection('users')
        .doc(user.userId).
        update(user.toMap());
  }

  Future<void> deleteUser(String uid) async {
    await firestore
        .collection('users')
        .doc(uid)
        .delete();
  }
}

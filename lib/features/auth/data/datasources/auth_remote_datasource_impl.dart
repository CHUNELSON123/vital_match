import 'auth_remote_datasource.dart';
import '../models/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDatasourceImpl
    implements AuthRemoteDatasource {

  final FirebaseAuth firebaseAuth;

  AuthRemoteDatasourceImpl({
    required this.firebaseAuth,
  });

  @override
  Future<AuthModel> register({
    required String email,
    required String password,
  }) async {

    final credential =
        await firebaseAuth
            .createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user!;

    return AuthModel(
      uid: user.uid,
      email: user.email!,
    );
  }

  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {

    final credential =
        await firebaseAuth
            .signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user!;

    return AuthModel(
      uid: user.uid,
      email: user.email!,
    );
  }

  @override
  Future<void> logout() async {

    await firebaseAuth.signOut();
  }

  @override
  Future<AuthModel?> getCurrentUser() async {

    final user = firebaseAuth.currentUser;

    if (user == null) {
      return null;
    }

    return AuthModel(
      uid: user.uid,
      email: user.email!,
    );
  }
}
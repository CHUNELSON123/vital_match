import 'package:firebase_auth/firebase_auth.dart';
import 'package:vital_match/features/auth/domain/entities/auth_user.dart';

class AuthModel extends AuthUser {
  const AuthModel({required super.uid, required super.email});

  //convert firebase user -> authusermodel
  factory AuthModel.fromFirebaseUser(User user) {
    return AuthModel(uid: user.uid, email: user.email ?? '');
  }
}

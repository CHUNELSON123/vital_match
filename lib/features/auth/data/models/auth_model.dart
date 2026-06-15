import 'package:firebase_auth/firebase_auth.dart';
import 'package:vital_match/features/auth/domain/entities/auth_user.dart';

class AuthModel extends AuthUser {
  const AuthModel({
    required super.uid,
    required super.email,
    required super.fullName,
    required super.role,
  });

  factory AuthModel.fromFirebaseUser(
    User user, {
    required String fullName,
    required String role,
  }) {
    return AuthModel(
      uid: user.uid,
      email: user.email ?? '',
      fullName: fullName,
      role: role,
    );
  }
}
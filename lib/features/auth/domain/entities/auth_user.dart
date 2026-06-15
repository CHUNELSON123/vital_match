class AuthUser {
  final String uid;
  final String email;
  final String fullName;
  final String role;

  const AuthUser({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.role
  });
}

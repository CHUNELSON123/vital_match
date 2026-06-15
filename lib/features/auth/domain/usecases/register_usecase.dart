import 'package:vital_match/features/auth/domain/repositories/auth_repository.dart';


class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase({required this.repository});

  Future<void> call({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
    required String role,
    String? bloodGroup,
    String? weight,
    String? dateOfBirth,
    double? latitude,
    double? longitude,
  }) async {
    return await repository.register(
      fullName: fullName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      role: role,
      bloodGroup: bloodGroup,
      weight: weight,
      dateOfBirth: dateOfBirth,
      latitude: latitude,
      longitude: longitude,
    );
  }
}

import 'package:vital_match/features/hospital/domain/entities/hospital.dart';
import 'package:vital_match/features/hospital/domain/repositories/hospital_repository.dart';

class UpdateHospitalUsecase {

  final HospitalRepository repository;

  UpdateHospitalUsecase(this.repository);

  Future<void> call(
    Hospital hospital,
  ) async {

    await repository.updateHospital(
      hospital,
    );
  }
}
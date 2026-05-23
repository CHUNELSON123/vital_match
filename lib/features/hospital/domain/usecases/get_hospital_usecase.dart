import 'package:vital_match/features/hospital/domain/entities/hospital.dart';
import 'package:vital_match/features/hospital/domain/repositories/hospital_repository.dart';

class GetHospitalUsecase {

  final HospitalRepository repository;

  GetHospitalUsecase(this.repository);

  Future<Hospital> call(
    String hospitalId,
  ) async {

    return await repository.getHospital(
      hospitalId,
    );
  }
}
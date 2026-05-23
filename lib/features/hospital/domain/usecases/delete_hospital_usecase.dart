import 'package:vital_match/features/hospital/domain/repositories/hospital_repository.dart';

class DeleteHospitalUsecase {

  final HospitalRepository repository;

  DeleteHospitalUsecase(this.repository);

  Future<void> call(
    String hospitalId,
  ) async {

    await repository.deleteHospital(
      hospitalId,
    );
  }
}
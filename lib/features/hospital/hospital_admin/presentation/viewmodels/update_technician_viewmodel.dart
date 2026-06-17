import 'package:vital_match/core/di/service_locator.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/entities/lab_technician.dart';

class UpdateTechnicianViewModel {

  Future<void> updateTechnician(
    LabTechnician technician,
  ) async {

    await ServiceLocator
        .updateLabTechnicianUsecase(
      technician,
    );
  }
}
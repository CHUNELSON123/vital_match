import 'package:vital_match/core/di/service_locator.dart';

class DeleteTechnicianViewModel {

  Future<void> deleteTechnician(
    String technicianId,
  ) async {

    await ServiceLocator
        .deleteLabTechnicianUsecase(
      technicianId,
    );
  }
}
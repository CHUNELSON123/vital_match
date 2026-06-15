import 'package:vital_match/core/di/service_locator.dart';

class DashboardStatisticsViewModel {

  final getAuditTrailsByHospitalUsecase =
      ServiceLocator
          .getAuditTrailsByHospitalUsecase;

  final getLabTechniciansByHospitalUsecase =
    ServiceLocator
        .getLabTechniciansByHospitalUsecase;

  Future<int> getAuditCount(
    String hospitalId,
  ) async {

    final audits =
        await getAuditTrailsByHospitalUsecase(
      hospitalId,
    );

    return audits.length;
  }

  Future<int> getTechnicianCount(
  String hospitalId,
) async {

  final technicians =
      await getLabTechniciansByHospitalUsecase(
    hospitalId,
  );

  return technicians.length;
}

}
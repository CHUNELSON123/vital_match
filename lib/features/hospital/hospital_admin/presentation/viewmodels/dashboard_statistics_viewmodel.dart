import 'package:vital_match/core/di/service_locator.dart';
import 'package:vital_match/features/audit_trail/domain/entities/audit_trail.dart';
 

class DashboardStatisticsViewModel {

  final getAuditTrailsByHospitalUsecase =
      ServiceLocator
          .getAuditTrailsByHospitalUsecase;

  final getLabTechniciansByHospitalUsecase =
    ServiceLocator
        .getLabTechniciansByHospitalUsecase;
  
  final getUserByIdUsecase =
    ServiceLocator
        .getUserByIdUsecase;

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

Future<List<AuditTrail>> getRecentActivities(
  String hospitalId,
) async {

  final activities =
      await getAuditTrailsByHospitalUsecase(
    hospitalId,
  );

  print(
    'HOSPITAL ID: $hospitalId',
  );

  print(
    'AUDIT ACTIVITIES: ${activities.length}',
  );

  return activities;
}

Future<Map<String, String>>
    getUserNamesForActivities(
  List<AuditTrail> activities,
) async {

  final Map<String, String>
      userNames = {};

  for (final activity
      in activities) {

    if (!userNames.containsKey(
      activity.userId,
    )) {

      final user =
          await getUserByIdUsecase(
        activity.userId,
      );

      userNames[
          activity.userId] =
          user?.fullName ?? 'Unknown User';
    }
  }

  return userNames;
}

}
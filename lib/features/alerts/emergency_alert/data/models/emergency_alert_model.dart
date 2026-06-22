import 'package:vital_match/core/enums/alert_status.dart';
import 'package:vital_match/core/enums/blood_type.dart';
import 'package:vital_match/features/alerts/emergency_alert/domain/entities/emergency_alert.dart';

class EmergencyAlertModel extends EmergencyAlert {
  const EmergencyAlertModel({
    required super.alertId,
    required super.hospitalId,
    required super.technicianId,
    required super.bloodGroup,
    required super.unitsNeeded,
    required super.radiusKm,
    required super.status,
    required super.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'hospitalId': hospitalId,
      'technicianId': technicianId,
      'bloodGroup': bloodGroup.name,
      'unitsNeeded': unitsNeeded,
      'radiusKm': radiusKm,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory EmergencyAlertModel.fromMap(
    Map<String, dynamic> data,
  ) {
    print('EMERGENCY ALERT FROM API');
    print(data);

    return EmergencyAlertModel(
      alertId:
          data['alertId'] ??
          data['id'] ??
          '',

      hospitalId:
          data['hospitalId'] ?? '',

      technicianId:
          data['technicianId'] ?? '',

      bloodGroup:
          BloodType.values.firstWhere(
        (bloodType) =>
            bloodType.name ==
            data['bloodGroup'],
        orElse: () =>
            BloodType.oPositive,
      ),

      unitsNeeded:
          data['unitsNeeded'] ?? 0,

      radiusKm:
          (data['radiusKm'] ?? 0)
              .toDouble(),

      status:
          AlertStatus.values.firstWhere(
        (status) =>
            status.name ==
            data['status'],
        orElse: () =>
            AlertStatus.active,
      ),

      createdAt:
          DateTime.parse(
        data['createdAt'],
      ),
    );
  }
}
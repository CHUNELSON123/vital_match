import 'package:vital_match/core/enums/alert_status.dart';
import 'package:vital_match/core/enums/blood_type.dart';

class EmergencyAlert {
  final String alertId;
  final String hospitalId;
  final String technicianId;
  final BloodType bloodGroup;
  final int unitsNeeded;
  final double radiusKm;
  final AlertStatus status;
  final DateTime createdAt;

  const EmergencyAlert({
    required this.alertId,
    required this.hospitalId,
    required this.technicianId,
    required this.bloodGroup,
    required this.unitsNeeded,
    required this.radiusKm,
    required this.status,
    required this.createdAt,
  });
}
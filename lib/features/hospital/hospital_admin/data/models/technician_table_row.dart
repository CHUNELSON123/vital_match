import 'package:vital_match/features/users/domain/entities/app_user.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/entities/lab_technician.dart';

class TechnicianTableRow {
  final AppUser user;
  final LabTechnician technician;

  const TechnicianTableRow({
    required this.user,
    required this.technician,
  });
}
import 'package:vital_match/features/hospital/lab_technician/data/models/lab_technician_model.dart';

abstract class LabTechnicianRemoteDatasource {

  Future<void> createLabTechnician(
    LabTechnicianModel technician,
  );

  Future<LabTechnicianModel>
      getLabTechnician(
    String technicianId,
  );

  Future<List<LabTechnicianModel>>
      getAllLabTechnicians();

  Future<void> updateLabTechnician(
    LabTechnicianModel technician,
  );

  Future<void> deleteLabTechnician(
    String technicianId,
  );

  Future<List<LabTechnicianModel>>
    getLabTechniciansByHospital(
  String hospitalId,
);
}
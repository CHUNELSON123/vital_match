import '../entities/lab_technician.dart';


abstract class LabTechnicianRepository {

  Future<void> createLabTechnician(
    LabTechnician technician,
  );

  Future<LabTechnician>
      getLabTechnician(
    String technicianId,
  );

  Future<List<LabTechnician>>
      getAllLabTechnicians();

  Future<void> updateLabTechnician(
    LabTechnician technician,
  );

  Future<void> deleteLabTechnician(
    String technicianId,
  );

  Future<List<LabTechnician>>
    getLabTechniciansByHospital(
  String hospitalId,
);
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vital_match/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:vital_match/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:vital_match/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:vital_match/features/auth/domain/repositories/auth_repository.dart';
import 'package:vital_match/features/auth/domain/usecases/register_usecase.dart';
import 'package:vital_match/features/auth/domain/usecases/login_usecase.dart';
import 'package:vital_match/features/hospital/domain/usecases/get_hospital_by_owner_id_usecase.dart';
import 'package:vital_match/features/hospital/data/datasources/hospital_remote_datasource.dart';
import 'package:vital_match/features/hospital/data/datasources/hospital_remote_datasource_impl.dart';
import 'package:vital_match/features/hospital/data/repositories/hospital_repository_impl.dart';
import 'package:vital_match/features/hospital/domain/repositories/hospital_repository.dart';
import 'package:vital_match/features/hospital/domain/usecases/create_hospital_usecase.dart';
import 'package:vital_match/features/audit_trail/data/datasources/audit_trail_remote_datasource.dart';
import 'package:vital_match/features/audit_trail/data/datasources/audit_trail_remote_datasource_impl.dart';
import 'package:vital_match/features/audit_trail/data/repositories/audit_trail_repository_impl.dart';
import 'package:vital_match/features/audit_trail/domain/repositories/audit_trail_repository.dart';
import 'package:vital_match/features/audit_trail/domain/usecases/get_audit_trails_by_hospital_usecase.dart';
import 'package:vital_match/features/hospital/lab_technician/data/datasources/lab_technician_remote_datasource.dart';
import 'package:vital_match/features/hospital/lab_technician/data/datasources/lab_technician_remote_datasource_impl.dart';
import 'package:vital_match/features/hospital/lab_technician/data/repositories/lab_technician_repository_impl.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/repositories/lab_technician_repository.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/usecases/get_lab_technicians_by_hospital_usecase.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/usecases/create_lab_technician_usecase.dart';

class ServiceLocator {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final AuthRemoteDatasource authRemoteDatasource =
      AuthRemoteDatasourceImpl(firebaseAuth: firebaseAuth);

  static final HospitalRemoteDatasource hospitalRemoteDatasource =
      HospitalRemoteDatasourceImpl(firestore);

  static final AuthRepository authRepository = AuthRepositoryImpl(
    remoteDatasource: authRemoteDatasource,
  );

  static final HospitalRepository hospitalRepository = HospitalRepositoryImpl(
    hospitalRemoteDatasource,
  );

  static final RegisterUsecase registerUsecase = RegisterUsecase(
    repository: authRepository,
  );

  static final LoginUsecase loginUsecase = LoginUsecase(
    repository: authRepository,
  );

  static final GetHospitalByOwnerIdUsecase getHospitalByOwnerIdUsecase =
      GetHospitalByOwnerIdUsecase(hospitalRepository);

  static final CreateHospitalUsecase createHospitalUsecase =
      CreateHospitalUsecase(hospitalRepository);

  static final AuditTrailRemoteDatasource auditTrailRemoteDatasource =
      AuditTrailRemoteDatasourceImpl(firestore);

  static final AuditTrailRepository auditTrailRepository =
      AuditTrailRepositoryImpl(auditTrailRemoteDatasource);

  static final GetAuditTrailsByHospitalUsecase getAuditTrailsByHospitalUsecase =
      GetAuditTrailsByHospitalUsecase(auditTrailRepository);

  static final LabTechnicianRemoteDatasource labTechnicianRemoteDatasource =
      LabTechnicianRemoteDatasourceImpl(firestore);

  static final LabTechnicianRepository labTechnicianRepository =
      LabTechnicianRepositoryImpl(labTechnicianRemoteDatasource);

  static final GetLabTechniciansByHospitalUsecase
  getLabTechniciansByHospitalUsecase = GetLabTechniciansByHospitalUsecase(
    labTechnicianRepository,
  );

  static final CreateLabTechnicianUsecase createLabTechnicianUsecase =
      CreateLabTechnicianUsecase(labTechnicianRepository);
}

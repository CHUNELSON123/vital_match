import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vital_match/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:vital_match/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:vital_match/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:vital_match/features/auth/domain/repositories/auth_repository.dart';
import 'package:vital_match/features/auth/domain/usecases/register_usecase.dart';
import 'package:vital_match/features/auth/domain/usecases/login_usecase.dart';
import 'package:vital_match/features/donors/domain/usecases/update_donor_profile_usecase.dart';
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
import 'package:vital_match/features/users/data/datasources/app_user_remote_datasource.dart';
import 'package:vital_match/features/users/data/datasources/app_user_remote_datasource_impl.dart';
import 'package:vital_match/features/users/data/repositories/app_user_repository_impl.dart';
import 'package:vital_match/features/users/domain/repositories/app_user_repository.dart';
import 'package:vital_match/features/users/domain/usecase/get_user_by_id_usecase.dart';
import 'package:vital_match/features/users/domain/usecase/create_user_usecase.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/usecases/delete_lab_technician_usecase.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/usecases/update_lab_technician_usecase.dart';
import 'package:vital_match/features/blood_unit/data/datasources/blood_unit_remote_datasource.dart';
import 'package:vital_match/features/blood_unit/data/datasources/blood_unit_remote_datasource_impl.dart';
import 'package:vital_match/features/blood_unit/data/repositories/blood_unit_repository_impl.dart';
import 'package:vital_match/features/blood_unit/domain/repositories/blood_unit_repository.dart';
import 'package:vital_match/features/donation_record/data/datasources/donation_record_remote_datasource.dart';
import 'package:vital_match/features/donation_record/data/datasources/donation_record_remote_datasource_impl.dart';
import 'package:vital_match/features/donation_record/data/repositories/donation_record_repository_impl.dart';
import 'package:vital_match/features/donation_record/domain/repositories/donation_record_repository.dart';
import 'package:vital_match/features/alerts/emergency_alert/data/datasources/emergency_alert_remote_datasource.dart';
import 'package:vital_match/features/alerts/emergency_alert/data/datasources/emergency_alert_remote_datasource_impl.dart';
import 'package:vital_match/features/alerts/emergency_alert/data/repositories/emergency_alert_repository_impl.dart';
import 'package:vital_match/features/alerts/emergency_alert/domain/repositories/emergency_alert_repository.dart';
import 'package:vital_match/features/transfer_order/data/datasources/transfer_order_remote_datasource.dart';
import 'package:vital_match/features/transfer_order/data/datasources/transfer_order_remote_datasource_impl.dart';
import 'package:vital_match/features/transfer_order/data/repositories/transfer_order_repository_impl.dart';
import 'package:vital_match/features/transfer_order/domain/repositories/transfer_order_repository.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/usecases/get_dashboard_blood_units_usecase.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/usecases/get_dashboard_donation_records_usecase.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/usecases/get_dashboard_emergency_alerts_usecase.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/usecases/get_dashboard_transfer_orders_usecase.dart';
import 'package:vital_match/features/hospital/lab_technician/presentation/viewmodels/donation_recording_viewmodel.dart';
import 'package:vital_match/features/donation_record/domain/usecases/create_donation_record_usecase.dart';
import 'package:vital_match/features/users/domain/usecase/get_all_user_usecase.dart';
import 'package:vital_match/features/donors/domain/usecases/get_all_donors_usecase.dart';
import 'package:vital_match/features/donors/data/datasources/donor_remote_datasource.dart';
import 'package:vital_match/features/donors/data/datasources/donor_remote_datasource_impl.dart';
import 'package:vital_match/features/donors/data/repositories/donor_repository_impl.dart';
import 'package:vital_match/features/donors/domain/repositories/donor_repository.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/usecases/get_lab_technician_usecase.dart';
import 'package:vital_match/features/hospital/lab_technician/domain/usecases/get_lab_technician_by_user_id_usecase.dart';
import '../../features/blood_unit/domain/usecases/create_blood_unit_uscase.dart';
import 'package:vital_match/features/donation_record/domain/usecases/get_pending_donation_records_usecase.dart';
import 'package:vital_match/features/hospital/lab_technician/presentation/viewmodels/donation_verification_viewmodel.dart';
import 'package:vital_match/features/donors/domain/usecases/get_donor_usecase.dart';

class ServiceLocator {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final AuthRemoteDatasource authRemoteDatasource =
      AuthRemoteDatasourceImpl(firebaseAuth: firebaseAuth);

  static final HospitalRemoteDatasource hospitalRemoteDatasource =
      HospitalRemoteDatasourceImpl();

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
      AuditTrailRemoteDatasourceImpl();

  static final AuditTrailRepository auditTrailRepository =
      AuditTrailRepositoryImpl(auditTrailRemoteDatasource);

  static final GetAuditTrailsByHospitalUsecase getAuditTrailsByHospitalUsecase =
      GetAuditTrailsByHospitalUsecase(auditTrailRepository);

  static final LabTechnicianRemoteDatasource
    labTechnicianRemoteDatasource =
        LabTechnicianRemoteDatasourceImpl();

  static final LabTechnicianRepository labTechnicianRepository =
      LabTechnicianRepositoryImpl(labTechnicianRemoteDatasource);

  static final GetLabTechnicianUsecase
    getLabTechnicianUsecase =
        GetLabTechnicianUsecase(
          labTechnicianRepository,
        );

  static final GetLabTechnicianByUserIdUsecase
    getLabTechnicianByUserIdUsecase =
        GetLabTechnicianByUserIdUsecase(
          labTechnicianRepository,
        );

  static final GetLabTechniciansByHospitalUsecase
  getLabTechniciansByHospitalUsecase = GetLabTechniciansByHospitalUsecase(
    labTechnicianRepository,
  );

  static final CreateLabTechnicianUsecase createLabTechnicianUsecase =
      CreateLabTechnicianUsecase(labTechnicianRepository);

  static final DeleteLabTechnicianUsecase
    deleteLabTechnicianUsecase =
        DeleteLabTechnicianUsecase(
          labTechnicianRepository,
        );

  static final AppUserRemoteDatasource
    appUserRemoteDatasource =
        AppUserRemoteDatasourceImpl(
          firestore: firestore,
        );

  static final AppUserRepository
    appUserRepository =
        AppUserRepositoryImpl(
          appUserRemoteDatasource,
        );

   static final CreateUserUsecase
    createUserUsecase =
        CreateUserUsecase(
          appUserRepository,
        );

  static final GetUserByIdUsecase
    getUserByIdUsecase =
        GetUserByIdUsecase(
          appUserRepository,
        );

static final UpdateLabTechnicianUsecase
    updateLabTechnicianUsecase =
        UpdateLabTechnicianUsecase(
          labTechnicianRepository,
        );

static final BloodUnitRemoteDatasource
    bloodUnitRemoteDatasource =
        BloodUnitRemoteDatasourceImpl();

static final BloodUnitRepository
    bloodUnitRepository =
        BloodUnitRepositoryImpl(
          bloodUnitRemoteDatasource,
        );

static final CreateBloodUnitUsecase
    createBloodUnitUsecase =
        CreateBloodUnitUsecase(
          bloodUnitRepository,
        );

static final DonationRecordRemoteDatasource
    donationRecordRemoteDatasource =
        DonationRecordRemoteDatasourceImpl();

static final DonationRecordRepository
    donationRecordRepository =
        DonationRecordRepositoryImpl(
          donationRecordRemoteDatasource,
        );

static final CreateDonationRecordUsecase
    createDonationRecordUsecase =
        CreateDonationRecordUsecase(
          donationRecordRepository,
        );

static final GetPendingDonationRecordsUsecase
    getPendingDonationRecordsUsecase =
        GetPendingDonationRecordsUsecase(
          donationRecordRepository,
        );
        
static final EmergencyAlertRemoteDatasource
    emergencyAlertRemoteDatasource =
        EmergencyAlertRemoteDatasourceImpl();

static final EmergencyAlertRepository
    emergencyAlertRepository =
        EmergencyAlertRepositoryImpl(
          emergencyAlertRemoteDatasource,
        );

static final TransferOrderRemoteDatasource
    transferOrderRemoteDatasource =
        TransferOrderRemoteDatasourceImpl(
          firestore,
        );

static final TransferOrderRepository
    transferOrderRepository =
        TransferOrderRepositoryImpl(
          transferOrderRemoteDatasource,
        );

static final GetDashboardBloodUnitsUsecase
    getDashboardBloodUnitsUsecase =
        GetDashboardBloodUnitsUsecase(
          bloodUnitRepository,
        );

static final GetDashboardDonationRecordsUsecase
    getDashboardDonationRecordsUsecase =
        GetDashboardDonationRecordsUsecase(
          donationRecordRepository,
        );

static final GetDashboardEmergencyAlertsUsecase
    getDashboardEmergencyAlertsUsecase =
        GetDashboardEmergencyAlertsUsecase(
          emergencyAlertRepository,
        );

static final GetDashboardTransferOrdersUsecase
    getDashboardTransferOrdersUsecase =
        GetDashboardTransferOrdersUsecase(
          transferOrderRepository,
        );

static final GetAllUserUsecase
    getAllUsersUsecase =
        GetAllUserUsecase(
          appUserRepository,
        );

static final GetDonorUsecase
    getDonorUsecase =
        GetDonorUsecase(
          donorRepository,
        );

static final DonorRemoteDatasource
    donorRemoteDatasource =
        DonorRemoteDatasourceImpl();

static final DonorRepository
    donorRepository =
        DonorRepositoryImpl(
          remoteDatasource:
              donorRemoteDatasource,
        );

  static final GetAllDonorsUsecase
    getAllDonorsUsecase =
        GetAllDonorsUsecase(
          donorRepository,
        );

static final UpdateDonorProfileUsecase
    updateDonorProfileUsecase =
        UpdateDonorProfileUsecase(
          repository: donorRepository,
        );

static final DonationVerificationViewModel
    donationVerificationViewModel =
        DonationVerificationViewModel(
          getPendingDonationRecordsUsecase:
              getPendingDonationRecordsUsecase,
          getDonorUsecase: 
              getDonorUsecase,
        );

static final DonationRecordingViewModel
    donationRecordingViewModel =
        DonationRecordingViewModel(
          createDonationRecordUsecase:
              createDonationRecordUsecase,
          getDonationRecordsUsecase:
              getDashboardDonationRecordsUsecase,
          getAllDonorsUsecase:
              getAllDonorsUsecase,
          getAllUsersUsecase:
              getAllUsersUsecase,
          updateDonorProfileUsecase: 
              updateDonorProfileUsecase,
          createBloodUnitUsecase: 
              createBloodUnitUsecase,
          getDashboardBloodUnitsUsecase: 
              getDashboardBloodUnitsUsecase,
        );
  
}

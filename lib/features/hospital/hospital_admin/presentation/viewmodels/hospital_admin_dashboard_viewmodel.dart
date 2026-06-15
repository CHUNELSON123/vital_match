import 'package:firebase_auth/firebase_auth.dart';
import 'package:vital_match/core/di/service_locator.dart';
import 'package:vital_match/features/hospital/domain/entities/hospital.dart';

class HospitalAdminDashboardViewModel {
  final getHospitalByOwnerIdUsecase =
      ServiceLocator.getHospitalByOwnerIdUsecase;

  Future<Hospital?> getHospital() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return await getHospitalByOwnerIdUsecase(uid);
  }
}

import 'package:vital_match/features/hospital/data/datasources/hospital_remote_datasource.dart';
import 'package:vital_match/features/hospital/data/models/hospital_model.dart';
import 'package:vital_match/features/hospital/domain/entities/hospital.dart';
import 'package:vital_match/features/hospital/domain/repositories/hospital_repository.dart';

class HospitalRepositoryImpl
    implements HospitalRepository {

  final HospitalRemoteDatasource remoteDatasource;

  HospitalRepositoryImpl(this.remoteDatasource);

  @override
  Future<void> createHospital(
    Hospital hospital,
  ) async {

    final hospitalModel = HospitalModel(
      hospitalId: hospital.hospitalId,
      name: hospital.name,
      address: hospital.address,
      contactNumber: hospital.contactNumber,
      latitude: hospital.latitude,
      longitude: hospital.longitude,
      geofenceRadiusKm: hospital.geofenceRadiusKm,
    );

    await remoteDatasource.createHospital(
      hospitalModel,
    );
  }

  @override
  Future<Hospital> getHospital(
    String hospitalId,
  ) async {

    return await remoteDatasource.getHospital(
      hospitalId,
    );
  }

  @override
  Future<void> updateHospital(
    Hospital hospital,
  ) async {

    final hospitalModel = HospitalModel(
      hospitalId: hospital.hospitalId,
      name: hospital.name,
      address: hospital.address,
      contactNumber: hospital.contactNumber,
      latitude: hospital.latitude,
      longitude: hospital.longitude,
      geofenceRadiusKm: hospital.geofenceRadiusKm,
    );

    await remoteDatasource.updateHospital(
      hospitalModel,
    );
  }

  @override
  Future<void> deleteHospital(
    String hospitalId,
  ) async {

    await remoteDatasource.deleteHospital(
      hospitalId,
    );
  }
}
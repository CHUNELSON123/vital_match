import '../../domain/entities/blood_unit.dart';

import '../../domain/repositories/blood_unit_repository.dart';

import '../datasources/blood_unit_remote_datasource.dart';

import '../models/blood_unit_model.dart';

class BloodUnitRepositoryImpl
    implements BloodUnitRepository {

  final BloodUnitRemoteDatasource
      remoteDatasource;

  BloodUnitRepositoryImpl(
    this.remoteDatasource,
  );


  @override
  Future<void> createBloodUnit(
    BloodUnit bloodUnit,
  ) async {

    final bloodUnitModel =
        BloodUnitModel(
      bloodUnitId:
          bloodUnit.bloodUnitId,

      recordId:
          bloodUnit.recordId,

      hospitalId:
          bloodUnit.hospitalId,

      bloodBankId:
          bloodUnit.bloodBankId,

      bloodType:
          bloodUnit.bloodType,

      componentType:
          bloodUnit.componentType,

      storageStatus:
          bloodUnit.storageStatus,

      quantity:
          bloodUnit.quantity,

      collectionDate:
          bloodUnit.collectionDate,

      expiryDate:
          bloodUnit.expiryDate,
    );

    await remoteDatasource
        .createBloodUnit(
      bloodUnitModel,
    );
  }


  @override
  Future<BloodUnit> getBloodUnit(
    String bloodUnitId,
  ) async {

    return await remoteDatasource
        .getBloodUnit(
      bloodUnitId,
    );
  }


  @override
  Future<void> updateBloodUnit(
    BloodUnit bloodUnit,
  ) async {

    final bloodUnitModel =
        BloodUnitModel(
      bloodUnitId:
          bloodUnit.bloodUnitId,

      recordId:
          bloodUnit.recordId,

      hospitalId:
          bloodUnit.hospitalId,

      bloodBankId:
          bloodUnit.bloodBankId,

      bloodType:
          bloodUnit.bloodType,

      componentType:
          bloodUnit.componentType,

      storageStatus:
          bloodUnit.storageStatus,

      quantity:
          bloodUnit.quantity,

      collectionDate:
          bloodUnit.collectionDate,

      expiryDate:
          bloodUnit.expiryDate,
    );

    await remoteDatasource
        .updateBloodUnit(
      bloodUnitModel,
    );
  }


  @override
  Future<void> deleteBloodUnit(
    String bloodUnitId,
  ) async {

    await remoteDatasource
        .deleteBloodUnit(
      bloodUnitId,
    );
  }
}
import '../../domain/entities/blood_bank.dart';

import '../../domain/repositories/blood_bank_repository.dart';

import '../datasources/blood_bank_remote_datasource.dart';

import '../models/blood_bank_model.dart';

class BloodBankRepositoryImpl
    implements BloodBankRepository {

  final BloodBankRemoteDatasource
      remoteDatasource;

  BloodBankRepositoryImpl(
    this.remoteDatasource,
  );


  @override
  Future<void> createBloodBank(
    BloodBank bloodBank,
  ) async {

    final bloodBankModel =
        BloodBankModel(
          bloodBankId: bloodBank.bloodBankId,
          name: bloodBank.name,
          address: bloodBank.address,
          latitude: bloodBank.latitude,
          longitude: bloodBank.longitude,
          regionCode: bloodBank.regionCode,
          storageCapacity:
              bloodBank.storageCapacity,
          contactNumber:
              bloodBank.contactNumber,
    );

    await remoteDatasource
        .createBloodBank(
      bloodBankModel,
    );
  }


  @override
  Future<BloodBank> getBloodBank(
    String bloodBankId,
  ) async {

    return await remoteDatasource
        .getBloodBank(
      bloodBankId,
    );
  }


  @override
  Future<void> updateBloodBank(
    BloodBank bloodBank,
  ) async {

    final bloodBankModel =
        BloodBankModel(
          bloodBankId: bloodBank.bloodBankId,
          name: bloodBank.name,
          address: bloodBank.address,
          latitude: bloodBank.latitude,
          longitude: bloodBank.longitude,
          regionCode: bloodBank.regionCode,
          storageCapacity:
              bloodBank.storageCapacity,
          contactNumber:
              bloodBank.contactNumber,
    );

    await remoteDatasource
        .updateBloodBank(
      bloodBankModel,
    );
  }


  @override
  Future<void> deleteBloodBank(
    String bloodBankId,
  ) async {

    await remoteDatasource
        .deleteBloodBank(
      bloodBankId,
    );
  }
}
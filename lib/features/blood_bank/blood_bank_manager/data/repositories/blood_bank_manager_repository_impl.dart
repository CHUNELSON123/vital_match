import '../../domain/entities/blood_bank_manager.dart';

import '../../domain/repositories/blood_bank_manager_repository.dart';

import '../datasources/blood_bank_manager_remote_datasource.dart';

import '../models/blood_bank_manager_model.dart';


class BloodBankManagerRepositoryImpl
    implements
        BloodBankManagerRepository {

  final
      BloodBankManagerRemoteDatasource
      remoteDatasource;

  BloodBankManagerRepositoryImpl(
    this.remoteDatasource,
  );



  @override
  Future<void>
      createBloodBankManager(
    BloodBankManager manager,
  ) async {

    final managerModel =
        BloodBankManagerModel(
      managerId:
          manager.managerId,

      userId:
          manager.userId,

      bloodBankId:
          manager.bloodBankId,

      staffId:
          manager.staffId,

      accessLevel:
          manager.accessLevel,
    );

    await remoteDatasource
        .createBloodBankManager(
      managerModel,
    );
  }



  @override
  Future<BloodBankManager>
      getBloodBankManager(
    String managerId,
  ) async {

    return await remoteDatasource
        .getBloodBankManager(
      managerId,
    );
  }



  @override
  Future<List<BloodBankManager>>
      getAllBloodBankManagers() async {

    return await remoteDatasource
        .getAllBloodBankManagers();
  }



  @override
  Future<void>
      updateBloodBankManager(
    BloodBankManager manager,
  ) async {

    final managerModel =
        BloodBankManagerModel(
      managerId:
          manager.managerId,

      userId:
          manager.userId,

      bloodBankId:
          manager.bloodBankId,

      staffId:
          manager.staffId,

      accessLevel:
          manager.accessLevel,
    );

    await remoteDatasource
        .updateBloodBankManager(
      managerModel,
    );
  }



  @override
  Future<void>
      deleteBloodBankManager(
    String managerId,
  ) async {

    await remoteDatasource
        .deleteBloodBankManager(
      managerId,
    );
  }
}
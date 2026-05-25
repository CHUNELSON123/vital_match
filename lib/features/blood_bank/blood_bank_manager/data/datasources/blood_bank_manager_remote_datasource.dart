import '../models/blood_bank_manager_model.dart';


abstract class
    BloodBankManagerRemoteDatasource {

  Future<void>
      createBloodBankManager(
    BloodBankManagerModel manager,
  );

  Future<BloodBankManagerModel>
      getBloodBankManager(
    String managerId,
  );

  Future<List<BloodBankManagerModel>>
      getAllBloodBankManagers();

  Future<void>
      updateBloodBankManager(
    BloodBankManagerModel manager,
  );

  Future<void>
      deleteBloodBankManager(
    String managerId,
  );
}
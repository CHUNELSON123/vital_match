import '../entities/blood_bank_manager.dart';


abstract class
    BloodBankManagerRepository {

  Future<void>
      createBloodBankManager(
    BloodBankManager manager,
  );

  Future<BloodBankManager>
      getBloodBankManager(
    String managerId,
  );

  Future<List<BloodBankManager>>
      getAllBloodBankManagers();

  Future<void>
      updateBloodBankManager(
    BloodBankManager manager,
  );

  Future<void>
      deleteBloodBankManager(
    String managerId,
  );
}
import '../models/blood_bank_model.dart';

abstract class BloodBankRemoteDatasource {

  Future<void> createBloodBank(
    BloodBankModel bloodBank,
  );

  Future<BloodBankModel> getBloodBank(
    String bloodBankId,
  );

  Future<void> updateBloodBank(
    BloodBankModel bloodBank,
  );

  Future<void> deleteBloodBank(
    String bloodBankId,
  );
}
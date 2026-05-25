import '../entities/blood_bank.dart';

abstract class BloodBankRepository {

  Future<void> createBloodBank(
    BloodBank bloodBank,
  );

  Future<BloodBank> getBloodBank(
    String bloodBankId,
  );

  Future<void> updateBloodBank(
    BloodBank bloodBank,
  );

  Future<void> deleteBloodBank(
    String bloodBankId,
  );
}
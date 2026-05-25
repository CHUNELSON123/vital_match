import '../repositories/blood_bank_repository.dart';

class DeleteBloodBankUsecase {

  final BloodBankRepository repository;

  DeleteBloodBankUsecase(
    this.repository,
  );

  Future<void> call(
    String bloodBankId,
  ) async {

    await repository.deleteBloodBank(
      bloodBankId,
    );
  }
}
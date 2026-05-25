import '../entities/blood_bank.dart';

import '../repositories/blood_bank_repository.dart';

class CreateBloodBankUsecase {

  final BloodBankRepository repository;

  CreateBloodBankUsecase(
    this.repository,
  );

  Future<void> call(
    BloodBank bloodBank,
  ) async {

    await repository.createBloodBank(
      bloodBank,
    );
  }
}
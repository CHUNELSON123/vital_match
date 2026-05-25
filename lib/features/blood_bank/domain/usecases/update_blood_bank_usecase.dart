import '../entities/blood_bank.dart';

import '../repositories/blood_bank_repository.dart';

class UpdateBloodBankUsecase {

  final BloodBankRepository repository;

  UpdateBloodBankUsecase(
    this.repository,
  );

  Future<void> call(
    BloodBank bloodBank,
  ) async {

    await repository.updateBloodBank(
      bloodBank,
    );
  }
}
import '../entities/blood_bank.dart';

import '../repositories/blood_bank_repository.dart';

class GetBloodBankUsecase {

  final BloodBankRepository repository;

  GetBloodBankUsecase(
    this.repository,
  );

  Future<BloodBank> call(
    String bloodBankId,
  ) async {

    return await repository.getBloodBank(
      bloodBankId,
    );
  }
}
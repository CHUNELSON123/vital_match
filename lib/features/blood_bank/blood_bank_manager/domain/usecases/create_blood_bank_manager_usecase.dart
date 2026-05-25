import '../entities/blood_bank_manager.dart';

import '../repositories/blood_bank_manager_repository.dart';


class CreateBloodBankManagerUsecase {

  final BloodBankManagerRepository
      repository;

  CreateBloodBankManagerUsecase(
    this.repository,
  );

  Future<void> call(
    BloodBankManager manager,
  ) async {

    await repository
        .createBloodBankManager(
      manager,
    );
  }
}
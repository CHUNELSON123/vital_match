import '../entities/blood_bank_manager.dart';

import '../repositories/blood_bank_manager_repository.dart';


class UpdateBloodBankManagerUsecase {

  final BloodBankManagerRepository
      repository;

  UpdateBloodBankManagerUsecase(
    this.repository,
  );

  Future<void> call(
    BloodBankManager manager,
  ) async {

    await repository
        .updateBloodBankManager(
      manager,
    );
  }
}
import '../entities/blood_bank_manager.dart';

import '../repositories/blood_bank_manager_repository.dart';


class
    GetAllBloodBankManagersUsecase {

  final BloodBankManagerRepository
      repository;

  GetAllBloodBankManagersUsecase(
    this.repository,
  );

  Future<List<BloodBankManager>>
      call() async {

    return await repository
        .getAllBloodBankManagers();
  }
}
import '../entities/blood_bank_manager.dart';

import '../repositories/blood_bank_manager_repository.dart';


class GetBloodBankManagerUsecase {

  final BloodBankManagerRepository
      repository;

  GetBloodBankManagerUsecase(
    this.repository,
  );

  Future<BloodBankManager>
      call(
    String managerId,
  ) async {

    return await repository
        .getBloodBankManager(
      managerId,
    );
  }
}
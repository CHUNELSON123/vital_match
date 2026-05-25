import '../repositories/blood_bank_manager_repository.dart';


class DeleteBloodBankManagerUsecase {

  final BloodBankManagerRepository
      repository;

  DeleteBloodBankManagerUsecase(
    this.repository,
  );

  Future<void> call(
    String managerId,
  ) async {

    await repository
        .deleteBloodBankManager(
      managerId,
    );
  }
}
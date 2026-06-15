import '../entities/transfer_order.dart';

import '../repositories/transfer_order_repository.dart';


class CreateTransferOrderUsecase {

  final TransferOrderRepository
      repository;

  CreateTransferOrderUsecase(
    this.repository,
  );


  Future<void> call(
    TransferOrder transferOrder,
  ) async {

    await repository
        .createTransferOrder(
      transferOrder,
    );
  }
}
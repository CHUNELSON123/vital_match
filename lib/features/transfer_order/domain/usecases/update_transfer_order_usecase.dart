import '../entities/transfer_order.dart';

import '../repositories/transfer_order_repository.dart';


class UpdateTransferOrderUsecase {

  final TransferOrderRepository
      repository;

  UpdateTransferOrderUsecase(
    this.repository,
  );


  Future<void> call(
    TransferOrder transferOrder,
  ) async {

    await repository
        .updateTransferOrder(
      transferOrder,
    );
  }
}
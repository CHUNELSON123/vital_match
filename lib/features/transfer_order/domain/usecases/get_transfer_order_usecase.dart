import '../entities/transfer_order.dart';

import '../repositories/transfer_order_repository.dart';


class GetTransferOrderUsecase {

  final TransferOrderRepository
      repository;

  GetTransferOrderUsecase(
    this.repository,
  );


  Future<TransferOrder> call(
    String orderId,
  ) async {

    return await repository
        .getTransferOrder(
      orderId,
    );
  }
}
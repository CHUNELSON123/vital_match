import '../entities/transfer_order.dart';

import '../repositories/transfer_order_repository.dart';


class GetAllTransferOrdersUsecase {

  final TransferOrderRepository
      repository;

  GetAllTransferOrdersUsecase(
    this.repository,
  );


  Future<List<TransferOrder>>
      call() async {

    return await repository
        .getAllTransferOrders();
  }
}
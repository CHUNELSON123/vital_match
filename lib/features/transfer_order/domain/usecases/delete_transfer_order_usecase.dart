import '../repositories/transfer_order_repository.dart';


class DeleteTransferOrderUsecase {

  final TransferOrderRepository
      repository;

  DeleteTransferOrderUsecase(
    this.repository,
  );


  Future<void> call(
    String orderId,
  ) async {

    await repository
        .deleteTransferOrder(
      orderId,
    );
  }
}
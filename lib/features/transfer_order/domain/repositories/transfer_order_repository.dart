import '../entities/transfer_order.dart';

abstract class TransferOrderRepository {

  Future<void> createTransferOrder(
    TransferOrder transferOrder,
  );

  Future<TransferOrder>
      getTransferOrder(
    String orderId,
  );

  Future<List<TransferOrder>>
      getAllTransferOrders();

  Future<void> updateTransferOrder(
    TransferOrder transferOrder,
  );

  Future<void> deleteTransferOrder(
    String orderId,
  );
}
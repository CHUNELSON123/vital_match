import '../models/transfer_order_model.dart';


abstract class TransferOrderRemoteDatasource {

  Future<void> createTransferOrder(
    TransferOrderModel transferOrder,
  );


  Future<TransferOrderModel>
      getTransferOrder(
    String orderId,
  );


  Future<List<TransferOrderModel>>
      getAllTransferOrders();


  Future<void> updateTransferOrder(
    TransferOrderModel transferOrder,
  );


  Future<void> deleteTransferOrder(
    String orderId,
  );
}
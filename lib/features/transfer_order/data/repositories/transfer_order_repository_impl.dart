import '../../domain/entities/transfer_order.dart';

import '../../domain/repositories/transfer_order_repository.dart';

import '../datasources/transfer_order_remote_datasource.dart';

import '../models/transfer_order_model.dart';


class TransferOrderRepositoryImpl
    implements
        TransferOrderRepository {

  final TransferOrderRemoteDatasource
      remoteDatasource;

  TransferOrderRepositoryImpl(
    this.remoteDatasource,
  );



  @override
  Future<void> createTransferOrder(
    TransferOrder transferOrder,
  ) async {

    final transferOrderModel =
        TransferOrderModel(
      orderId:
          transferOrder.orderId,
      hospitalId:
          transferOrder.hospitalId,
      bloodBankId:
          transferOrder.bloodBankId,
      managerId:
          transferOrder.managerId,
      bloodType:
          transferOrder.bloodType,
      quantity:
          transferOrder.quantity,
      status:
          transferOrder.status,
      requestDate:
          transferOrder.requestDate,
    );

    await remoteDatasource
        .createTransferOrder(
      transferOrderModel,
    );
  }



  @override
  Future<TransferOrder>
      getTransferOrder(
    String orderId,
  ) async {

    return await remoteDatasource
        .getTransferOrder(
      orderId,
    );
  }



  @override
  Future<List<TransferOrder>>
      getAllTransferOrders() async {

    return await remoteDatasource
        .getAllTransferOrders();
  }



  @override
  Future<void> updateTransferOrder(
    TransferOrder transferOrder,
  ) async {

    final transferOrderModel =
        TransferOrderModel(
      orderId:
          transferOrder.orderId,
      hospitalId:
          transferOrder.hospitalId,
      bloodBankId:
          transferOrder.bloodBankId,
      managerId:
          transferOrder.managerId,
      bloodType:
          transferOrder.bloodType,
      quantity:
          transferOrder.quantity,
      status:
          transferOrder.status,
      requestDate:
          transferOrder.requestDate,
    );

    await remoteDatasource
        .updateTransferOrder(
      transferOrderModel,
    );
  }



  @override
  Future<void> deleteTransferOrder(
    String orderId,
  ) async {

    await remoteDatasource
        .deleteTransferOrder(
      orderId,
    );
  }

  @override
Future<List<TransferOrder>>
    getTransferOrdersByHospital(
  String hospitalId,
) async {

  return await remoteDatasource
      .getTransferOrdersByHospital(
    hospitalId,
  );
}
}
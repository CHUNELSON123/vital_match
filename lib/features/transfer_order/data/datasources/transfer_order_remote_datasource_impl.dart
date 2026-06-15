import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/transfer_order_model.dart';

import 'transfer_order_remote_datasource.dart';


class TransferOrderRemoteDatasourceImpl
    implements
        TransferOrderRemoteDatasource {

  final FirebaseFirestore firestore;

  TransferOrderRemoteDatasourceImpl(
    this.firestore,
  );


  final String transferOrderCollection =
      'transfer_orders';



  @override
  Future<void> createTransferOrder(
    TransferOrderModel transferOrder,
  ) async {

    await firestore
        .collection(
          transferOrderCollection,
        )
        .doc(
          transferOrder.orderId,
        )
        .set(
          transferOrder.toMap(),
        );
  }



  @override
  Future<TransferOrderModel>
      getTransferOrder(
    String orderId,
  ) async {

    final doc =
        await firestore
            .collection(
              transferOrderCollection,
            )
            .doc(
              orderId,
            )
            .get();

    return TransferOrderModel
        .fromFirestore(
      doc,
    );
  }



  @override
  Future<List<TransferOrderModel>>
      getAllTransferOrders() async {

    final snapshot =
        await firestore
            .collection(
              transferOrderCollection,
            )
            .get();

    return snapshot.docs
        .map(
          (doc) =>
              TransferOrderModel
                  .fromFirestore(
            doc,
          ),
        )
        .toList();
  }



  @override
  Future<void> updateTransferOrder(
    TransferOrderModel transferOrder,
  ) async {

    await firestore
        .collection(
          transferOrderCollection,
        )
        .doc(
          transferOrder.orderId,
        )
        .update(
          transferOrder.toMap(),
        );
  }



  @override
  Future<void> deleteTransferOrder(
    String orderId,
  ) async {

    await firestore
        .collection(
          transferOrderCollection,
        )
        .doc(
          orderId,
        )
        .delete();
  }
}
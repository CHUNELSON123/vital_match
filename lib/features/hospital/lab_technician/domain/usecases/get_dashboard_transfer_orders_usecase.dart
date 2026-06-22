import 'package:vital_match/features/transfer_order/domain/entities/transfer_order.dart';
import 'package:vital_match/features/transfer_order/domain/repositories/transfer_order_repository.dart';

class GetDashboardTransferOrdersUsecase {
  final TransferOrderRepository
      repository;

  GetDashboardTransferOrdersUsecase(
    this.repository,
  );

  Future<List<TransferOrder>>
      call() async {

    return await repository
        .getAllTransferOrders();
  }
}
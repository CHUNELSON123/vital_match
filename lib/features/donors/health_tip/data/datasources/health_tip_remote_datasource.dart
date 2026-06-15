import '../models/health_tip_model.dart';

abstract class HealthTipRemoteDatasource {

  Future<void> createHealthTip(
    HealthTipModel healthTip,
  );

  Future<HealthTipModel> getHealthTip(
    String tipId,
  );

  Future<List<HealthTipModel>>
      getAllHealthTips();

  Future<void> updateHealthTip(
    HealthTipModel healthTip,
  );

  Future<void> deleteHealthTip(
    String tipId,
  );
}
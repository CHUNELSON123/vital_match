import '../entities/health_tip.dart';

abstract class HealthTipRepository {

  Future<void> createHealthTip(
    HealthTip healthTip,
  );

  Future<HealthTip> getHealthTip(
    String tipId,
  );

  Future<List<HealthTip>>
      getAllHealthTips();

  Future<void> updateHealthTip(
    HealthTip healthTip,
  );

  Future<void> deleteHealthTip(
    String tipId,
  );
}
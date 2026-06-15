import '../../domain/entities/health_tip.dart';

import '../../domain/repositories/health_tip_repository.dart';

import '../datasources/health_tip_remote_datasource.dart';

import '../models/health_tip_model.dart';

class HealthTipRepositoryImpl
    implements HealthTipRepository {

  final HealthTipRemoteDatasource
      remoteDatasource;

  HealthTipRepositoryImpl(
    this.remoteDatasource,
  );


  @override
  Future<void> createHealthTip(
    HealthTip healthTip,
  ) async {

    final healthTipModel =
        HealthTipModel(
      tipId: healthTip.tipId,
      title: healthTip.title,
      content: healthTip.content,
      category: healthTip.category,
    );

    await remoteDatasource
        .createHealthTip(
      healthTipModel,
    );
  }


  @override
  Future<HealthTip> getHealthTip(
    String tipId,
  ) async {

    return await remoteDatasource
        .getHealthTip(
      tipId,
    );
  }


  @override
  Future<List<HealthTip>>
      getAllHealthTips() async {

    return await remoteDatasource
        .getAllHealthTips();
  }


  @override
  Future<void> updateHealthTip(
    HealthTip healthTip,
  ) async {

    final healthTipModel =
        HealthTipModel(
      tipId: healthTip.tipId,
      title: healthTip.title,
      content: healthTip.content,
      category: healthTip.category,
    );

    await remoteDatasource
        .updateHealthTip(
      healthTipModel,
    );
  }


  @override
  Future<void> deleteHealthTip(
    String tipId,
  ) async {

    await remoteDatasource
        .deleteHealthTip(
      tipId,
    );
  }
}
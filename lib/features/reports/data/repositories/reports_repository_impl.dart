import '../../domain/entities/reports_summary.dart';

import '../../domain/repositories/reports_repository.dart';

import '../datasources/reports_remote_datasource.dart';

class ReportsRepositoryImpl
    implements ReportsRepository {

  final ReportsRemoteDatasource
      datasource;

  ReportsRepositoryImpl(
    this.datasource,
  );

  @override
  Future<ReportsSummary>
      getHospitalReports(
    String hospitalId,
  ) {
    return datasource
        .getHospitalReports(
      hospitalId,
    );
  }
}
import '../../data/datasources/reports_remote_datasource_impl.dart';

import '../../data/repositories/reports_repository_impl.dart';

import '../../domain/entities/reports_summary.dart';

import '../../domain/usecases/get_reports_summary_usecase.dart';
 
class ReportsViewModel {

  late final
      GetReportsSummaryUsecase
          getReportsSummaryUsecase;

  ReportsViewModel() {

    final repository =
        ReportsRepositoryImpl(
      ReportsRemoteDatasourceImpl(),
    );

    getReportsSummaryUsecase =
        GetReportsSummaryUsecase(
      repository,
    );
  }

  Future<ReportsSummary>
      getHospitalReports(
    String hospitalId,
  ) async {

    return await
        getReportsSummaryUsecase(
      hospitalId,
    );
  }
}
import '../entities/reports_summary.dart';

import '../repositories/reports_repository.dart';

class GetReportsSummaryUsecase {

  final ReportsRepository
      repository;

  GetReportsSummaryUsecase(
    this.repository,
  );

  Future<ReportsSummary> call(
    String hospitalId,
  ) {
    return repository
        .getHospitalReports(
      hospitalId,
    );
  }
}
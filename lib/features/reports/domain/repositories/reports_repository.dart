import '../entities/reports_summary.dart';

abstract class ReportsRepository {

  Future<ReportsSummary>
      getHospitalReports(
    String hospitalId,
  );
}
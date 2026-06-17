import '../models/reports_summary_model.dart';

abstract class ReportsRemoteDatasource {

  Future<ReportsSummaryModel>
      getHospitalReports(
    String hospitalId,
  );
}
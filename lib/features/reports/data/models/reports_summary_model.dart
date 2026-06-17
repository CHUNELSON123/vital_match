import '../../domain/entities/reports_summary.dart';

class ReportsSummaryModel
    extends ReportsSummary {

  const ReportsSummaryModel({
    required super.totalBloodUnits,
    required super.totalDonationRecords,
    required super.totalTechnicians,
    required super.recentActivity,
    required super.donationTrend,
    required super.bloodDistribution,
  });

  factory ReportsSummaryModel.fromJson(
    Map<String, dynamic> data,
  ) {
    return ReportsSummaryModel(
      totalBloodUnits:
          data['totalBloodUnits'] ?? 0,

      totalDonationRecords:
          data['totalDonationRecords'] ?? 0,

      totalTechnicians:
          data['totalTechnicians'] ?? 0,

      recentActivity:
          data['recentActivity'] ?? 0,

      donationTrend:
          data['donationTrend'] ?? [],

      bloodDistribution:
          data['bloodDistribution'] ?? [],
    );
  }
}
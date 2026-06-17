class ReportsSummary {

  final int totalBloodUnits;

  final int totalDonationRecords;

  final int totalTechnicians;

  final int recentActivity;

  final List<dynamic>
      donationTrend;

  final List<dynamic>
      bloodDistribution;

  const ReportsSummary({
    required this.totalBloodUnits,
    required this.totalDonationRecords,
    required this.totalTechnicians,
    required this.recentActivity,
    required this.donationTrend,
    required this.bloodDistribution,
  });
}
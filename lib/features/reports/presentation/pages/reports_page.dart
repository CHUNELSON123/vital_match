import 'package:flutter/material.dart';
import 'package:vital_match/features/hospital/domain/entities/hospital.dart';
import 'package:vital_match/features/hospital/hospital_admin/presentation/widgets/hospital_admin_sidebar.dart';
import '../widgets/reports_header.dart';
import '../widgets/reports_summary_grid.dart';
import '../widgets/reports_trend_chart.dart';
import '../widgets/blood_distribution_chart.dart';
import '../viewmodels/reports_viewmodel.dart';
import '../../domain/entities/reports_summary.dart';
 

class ReportsPage extends StatefulWidget {
  final Hospital hospital;

  const ReportsPage({
    super.key,
    required this.hospital,
  });

  @override
State<ReportsPage> createState() =>
    _ReportsPageState();
}

 
class _ReportsPageState
    extends State<ReportsPage> {

  final vm = ReportsViewModel();

  bool isLoading = true;

  ReportsSummary? reportsSummary;

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

Future<void> _loadReports() async {
  try {

    final result =
        await vm.getHospitalReports(
      widget.hospital.hospitalId,
    );

    print(
  'REPORT DATA => ${result.donationTrend}',
);

    setState(() {
      reportsSummary = result;
      isLoading = false;
    });

  } catch (e) {

    debugPrint(
      'REPORT ERROR: $e',
    );

    setState(() {
      isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F9FC),

      body: Row(
        children: [

          HospitalAdminSidebar(
            selectedIndex: 3,
            hospital:
                widget.hospital,
          ),

          Expanded(
            child:
                SingleChildScrollView(
              padding:
                  const EdgeInsets.all(
                24,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                const ReportsHeader(),

                  const SizedBox(
                    height: 24,
                  ),

                  if (isLoading)
                    const Center(
                      child:
                          CircularProgressIndicator(),
                    )
                  else ...[

                    if (isLoading)
                      const Center(
                        child:
                            CircularProgressIndicator(),
                      )
                    else if (reportsSummary != null)
                      ReportsSummaryGrid(
                        reportsSummary:
                            reportsSummary!,
                      )
                    else
                      const Center(
                        child: Text(
                          'Failed to load reports',
                        ),
                      ),
                    const SizedBox(
                      height: 24,
                    ),

                    LayoutBuilder(
                      builder: (
                        context,
                        constraints,
                      ) {

                        if (
                            constraints.maxWidth <
                                900) {
                          return Column(
                            children: [

                              ReportsTrendChart(
                                donationTrend:
                                    reportsSummary!
                                        .donationTrend,
                              ),

                              const SizedBox(
                                height: 24,
                              ),

                              BloodDistributionChart(),
                            ],
                          );
                        }

                        return Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Expanded(
                              flex: 3,
                              child:
                                  ReportsTrendChart(
                                    donationTrend:
                                        reportsSummary!
                                            .donationTrend,
                                  ),
                            ),

                            const SizedBox(
                              width: 24,
                            ),

                            Expanded(
                              flex: 1,
                              child:
                                  BloodDistributionChart(),
                            ),
                          ],
                        );
                      },
                    ),
                  ],

                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
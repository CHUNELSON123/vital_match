import 'package:vital_match/features/hospital/domain/entities/hospital.dart';
import 'package:flutter/material.dart';
import '../../../presentation/pages/create_hospital_page.dart';
import '../viewmodels/hospital_admin_dashboard_viewmodel.dart';
import '../widgets/hospital_admin_sidebar.dart';
import '../widgets/hospital_admin_topbar.dart';
import '../widgets/dashboard_header_section.dart';
import '../widgets/dashboard_stats_grid.dart';
import '../widgets/recent_activity_table.dart';
import '../widgets/quick_actions_section.dart';
import '../viewmodels/dashboard_statistics_viewmodel.dart';
import 'package:vital_match/features/audit_trail/domain/entities/audit_trail.dart';

class HospitalAdminDashboard extends StatefulWidget {
  const HospitalAdminDashboard({super.key});

  @override
  State<HospitalAdminDashboard> createState() => _HospitalAdminDashboardState();
}

class _HospitalAdminDashboardState extends State<HospitalAdminDashboard> {
  final vm = HospitalAdminDashboardViewModel();
  final statisticsVm = DashboardStatisticsViewModel();

  bool _isLoading = true;
  int auditCount = 0;
  int technicianCount = 0;
  List<AuditTrail> recentActivities = [];
  Map<String, String> activityUserNames = {};
  Hospital? hospital;

  @override
  void initState() {
    super.initState();
    _checkHospital();
  }

  Future<void> _checkHospital() async {
    try {
      final result = await vm.getHospital();

      setState(() {
        hospital = result;
      });

      await _loadDashboardStats();
    } catch (e) {
      print('DASHBOARD ERROR: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadDashboardStats() async {
    if (hospital == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final activities = await statisticsVm.getRecentActivities(
      hospital!.hospitalId,
    );

    final userNames = await statisticsVm.getUserNamesForActivities(activities);

    final technicians = await statisticsVm.getTechnicianCount(
      hospital!.hospitalId,
    );

    setState(() {
      auditCount = activities.length;
      technicianCount = technicians;

      recentActivities = activities;

      activityUserNames = userNames;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : hospital == null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No Hospital Found'),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CreateHospitalPage(),
                        ),
                      );
                    },

                    child: const Text('Create Hospital'),
                  ),
                ],
              )
            : Row(
                children: [
                  HospitalAdminSidebar(selectedIndex: 0, hospital: hospital!),

                  Expanded(
                    child: Column(
                      children: [
                        HospitalAdminTopbar(hospital: hospital!),

                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const DashboardHeaderSection(),

                                DashboardStatsGrid(
                                  hospital: hospital!,
                                  auditCount: auditCount,
                                  technicianCount: technicianCount,
                                ),

                                const SizedBox(height: 24),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: RecentActivityTable(
                                        activities: recentActivities,
                                        activityUserNames: activityUserNames,
                                      ),
                                    ),

                                    const SizedBox(width: 24),

                                    Expanded(
                                      flex: 1,
                                      child: QuickActionsSection(
                                        hospital: hospital!,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

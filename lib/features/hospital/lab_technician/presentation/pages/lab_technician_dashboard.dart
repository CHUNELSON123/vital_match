import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/di/service_locator.dart';

import '../viewmodels/dashboard_viewmodel.dart';

import '../widgets/lab_technician_sidebar.dart';
import '../widgets/lab_technician_topbar.dart';
import '../widgets/dashboard_stat_card.dart';
import '../widgets/inventory_overview_table.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/recent_activity_panel.dart';
import '../widgets/lab_status_card.dart';

class LabTechnicianDashboard
    extends StatelessWidget {

  const LabTechnicianDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) {

        final vm = DashboardViewModel(
          getDashboardBloodUnitsUsecase:
              ServiceLocator
                  .getDashboardBloodUnitsUsecase,

          getDashboardDonationRecordsUsecase:
              ServiceLocator
                  .getDashboardDonationRecordsUsecase,

          getDashboardEmergencyAlertsUsecase:
              ServiceLocator
                  .getDashboardEmergencyAlertsUsecase,

          updateBloodUnitUsecase:
              ServiceLocator
                  .updateBloodUnitUsecase,
        );

        vm.loadDashboard();

        return vm;
      },

      child: const _DashboardView(),
    );
  }
}

class _DashboardView
    extends StatelessWidget {

  const _DashboardView();

  @override
  Widget build(BuildContext context) {

    return Consumer<DashboardViewModel>(
      builder: (
        context,
        vm,
        child,
      ) {

        if (vm.isLoading) {

          return const Scaffold(
            body: Center(
              child:
                  CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          backgroundColor:
              const Color(
            0xFFF8F9FA,
          ),

          body: Row(
            children: [

              const LabTechnicianSidebar(
                selectedIndex: 0,
              ),

              Expanded(
                child: Column(
                  children: [

                    const LabTechnicianTopbar(),

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

                            const Text(
                              'Dashboard',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            const Text(
                              'Laboratory operations overview',
                            ),

                            const SizedBox(
                              height: 24,
                            ),

                            Row(
                              children: [

                                Expanded(
                                  child:
                                      DashboardStatCard(
                                    title:
                                        'Available Units',
                                    value: vm
                                        .totalAvailableUnits
                                        .toString(),
                                    icon:
                                        Icons.bloodtype,
                                    color:
                                        const Color(
                                      0xFF005FAF,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  width: 16,
                                ),

                                Expanded(
                                  child:
                                      DashboardStatCard(
                                    title:
                                        'Donation Records',
                                    value: vm
                                        .totalDonationRecords
                                        .toString(),
                                    icon:
                                        Icons.assignment,
                                    color:
                                        Colors.orange,
                                  ),
                                ),

                                const SizedBox(
                                  width: 16,
                                ),

                                Expanded(
                                  child:
                                      DashboardStatCard(
                                    title:
                                        'Emergency Alerts',
                                    value: vm
                                        .totalEmergencyAlerts
                                        .toString(),
                                    icon:
                                        Icons.warning,
                                    color:
                                        Colors.red,
                                  ),
                                ),

                                const SizedBox(
                                  width: 16,
                                ),

                                 
                              ],
                            ),

                            const SizedBox(
                              height: 24,
                            ),

                            const Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                Expanded(
                                  flex: 3,
                                  child:
                                      InventoryOverviewTable(),
                                ),

                                SizedBox(
                                  width: 24,
                                ),

                                Expanded(
                                  flex: 2,
                                  child:
                                      RecentActivityPanel(),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 24,
                            ),

                            const QuickActionsGrid(),

                            const SizedBox(
                              height: 24,
                            ),

                            const LabStatusCard(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

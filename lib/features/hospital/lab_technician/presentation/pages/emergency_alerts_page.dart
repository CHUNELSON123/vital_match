import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vital_match/core/di/service_locator.dart';

import '../widgets/lab_technician_sidebar.dart';
import '../widgets/lab_technician_topbar.dart';

import '../widgets/emergency_alert/emergency_alert_form_card.dart';
import '../widgets/emergency_alert/emergency_alert_preview_card.dart';
import '../widgets/emergency_alert/emergency_alert_reach_card.dart';
import '../widgets/emergency_alert/emergency_alert_map_card.dart';
import '../widgets/emergency_alert/emergency_alert_protocol_card.dart';
import '../viewmodels/emergency_alert_viewmodel.dart';

class EmergencyAlertsPage extends StatefulWidget {
  const EmergencyAlertsPage({super.key});

  @override
  State<EmergencyAlertsPage> createState() => _EmergencyAlertsPageState();
}

class _EmergencyAlertsPageState extends State<EmergencyAlertsPage> {
  late final EmergencyAlertViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ServiceLocator.emergencyAlertViewModel;
    viewModel.loadCurrentTechnician();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<EmergencyAlertViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            backgroundColor: const Color(0xFFFCF9F8),
            body: Row(
              children: [
                const LabTechnicianSidebar(selectedIndex: 3),

                Expanded(
                  child: Column(
                    children: [
                      const LabTechnicianTopbar(),

                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create Emergency Alert',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium,
                              ),

                              const SizedBox(height: 8),

                              Text(
                                'Deploy high-priority notifications to the donor network.',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),

                              const SizedBox(height: 24),

                              if (viewModel.errorMessage != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Text(
                                    viewModel.errorMessage!,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),

                              if (viewModel.isLoading)
                                const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(32),
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              else
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Expanded(
                                      flex: 7,
                                      child: EmergencyAlertFormCard(),
                                    ),

                                    const SizedBox(width: 24),

                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        children: [
                                          EmergencyAlertPreviewCard(
                                            bloodType:
                                                viewModel.selectedBloodType,
                                            unitsNeeded: viewModel
                                                .unitsNeededController
                                                .text,
                                            description: viewModel
                                                .descriptionController
                                                .text,
                                            hospitalName:
                                                viewModel
                                                    .currentTechnician
                                                    ?.hospitalId ??
                                                'Hospital',
                                          ),

                                          const SizedBox(height: 16),

                                          EmergencyAlertReachCard(
                                            estimatedDonorReach:
                                                viewModel.estimatedDonorReach,
                                          ),

                                          const SizedBox(height: 16),

                                          EmergencyAlertMapCard(
                                            radiusKm:
                                                viewModel.radiusController.text,
                                          ),

                                          const SizedBox(height: 16),

                                          const EmergencyAlertProtocolCard(),
                                        ],
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
          );
        },
      ),
    );
  }
}

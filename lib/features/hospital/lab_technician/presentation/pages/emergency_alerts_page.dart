import 'package:flutter/material.dart';

import '../widgets/lab_technician_sidebar.dart';
import '../widgets/lab_technician_topbar.dart';

import '../widgets/emergency_alert/emergency_alert_form_card.dart';
import '../widgets/emergency_alert/emergency_alert_preview_card.dart';
import '../widgets/emergency_alert/emergency_alert_reach_card.dart';
import '../widgets/emergency_alert/emergency_alert_map_card.dart';
import '../widgets/emergency_alert/emergency_alert_protocol_card.dart';

class EmergencyAlertsPage extends StatelessWidget {
  const EmergencyAlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFFCF9F8,
      ),
      body: Row(
        children: [
          const LabTechnicianSidebar(
            selectedIndex: 3,
          ),

          Expanded(
            child: Column(
              children: [
                const LabTechnicianTopbar(),

                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.all(
                      24,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Text(
                          'Create Emergency Alert',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium,
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Text(
                          'Deploy high-priority notifications to the donor network.',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium,
                        ),

                        const SizedBox(
                          height: 24,
                        ),

                        Row(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [
                            const Expanded(
                              flex: 7,
                              child:
                                  EmergencyAlertFormCard(),
                            ),

                            const SizedBox(
                              width: 24,
                            ),

                            Expanded(
                              flex: 5,
                              child: Column(
                                children: const [
                                  EmergencyAlertPreviewCard(),

                                  SizedBox(
                                    height: 16,
                                  ),

                                  EmergencyAlertReachCard(),

                                  SizedBox(
                                    height: 16,
                                  ),

                                  EmergencyAlertMapCard(),

                                  SizedBox(
                                    height: 16,
                                  ),

                                  EmergencyAlertProtocolCard(),
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
  }
}
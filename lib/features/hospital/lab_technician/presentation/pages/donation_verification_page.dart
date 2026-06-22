import 'package:flutter/material.dart';

import '../widgets/lab_technician_sidebar.dart';
import '../widgets/lab_technician_topbar.dart';
import '../widgets/verification_donor_card.dart';
import '../widgets/verification_checklist.dart';
import '../widgets/laboratory_status_panel.dart';

class DonationVerificationPage extends StatelessWidget {
  const DonationVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF9F8),

      body: Row(
        children: [

          const LabTechnicianSidebar(
            selectedIndex: 1,
          ),

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
                          'Donation Verification',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),

                        const SizedBox(height: 24),

                        LayoutBuilder(
                          builder: (context, constraints) {

                            if (constraints.maxWidth > 1000) {

                              return Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [

                                  const SizedBox(
                                    width: 350,
                                    child: VerificationDonorCard(),
                                  ),

                                  const SizedBox(width: 24),

                                  Expanded(
                                    child: Column(
                                      children: const [

                                        VerificationChecklist(),

                                        SizedBox(height: 24),

                                        LaboratoryStatusPanel(),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }

                            return const Column(
                              children: [

                                VerificationDonorCard(),

                                SizedBox(height: 24),

                                VerificationChecklist(),

                                SizedBox(height: 24),

                                LaboratoryStatusPanel(),
                              ],
                            );
                          },
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

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff005FAF),
        onPressed: () {},
        child: const Icon(Icons.support_agent),
      ),
    );
  }
}
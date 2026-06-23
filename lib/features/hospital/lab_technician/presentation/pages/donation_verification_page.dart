import 'package:flutter/material.dart';

import '../widgets/lab_technician_sidebar.dart';
import '../widgets/lab_technician_topbar.dart';
import '../widgets/verification_donor_card.dart';
import '../widgets/verification_checklist.dart';
import '../widgets/laboratory_status_panel.dart';
import '../../../../donation_record/domain/entities/donation_record.dart';

class DonationVerificationPage extends StatefulWidget {
  const DonationVerificationPage({super.key});

  @override
  State<DonationVerificationPage> createState() =>
      _DonationVerificationPageState();
}

class _DonationVerificationPageState extends State<DonationVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF9F8),

      body: Row(
        children: [
          const LabTechnicianSidebar(selectedIndex: 1),

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
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 12),

                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.bloodtype, color: Colors.red),
                              SizedBox(width: 12),
                              Text(
                                'Pending Donation Records',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        const SizedBox(height: 24),

                        ListView.builder(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(),
                          itemCount: donations.length,
                          itemBuilder: (
                            context,
                            index,
                          ) {

                            final donation =
                                donations[index];

                            return Padding(
                              padding:
                                  const EdgeInsets.only(
                                bottom: 24,
                              ),
                              child: Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [

                                  SizedBox(
                                    width: 350,
                                    child:
                                        VerificationDonorCard(
                                      donation:
                                          donation,
                                    ),
                                  ),

                                  const SizedBox(
                                    width: 24,
                                  ),

                                  Expanded(
                                    child:
                                        VerificationChecklist(
                                      donation:
                                          donation,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
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

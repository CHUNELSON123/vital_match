import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vital_match/core/di/service_locator.dart';

import '../widgets/lab_technician_sidebar.dart';
import '../widgets/lab_technician_topbar.dart';
import '../widgets/verification_donor_card.dart';
import '../widgets/verification_checklist.dart';
import '../viewmodels/donation_verification_viewmodel.dart';

class DonationVerificationPage extends StatefulWidget {
  const DonationVerificationPage({super.key});

  @override
  State<DonationVerificationPage> createState() =>
      _DonationVerificationPageState();
}

class _DonationVerificationPageState extends State<DonationVerificationPage> {
  late final DonationVerificationViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ServiceLocator.donationVerificationViewModel;
    viewModel.loadPendingDonations();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<DonationVerificationViewModel>(
        builder: (context, viewModel, _) {
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
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),

                              const SizedBox(height: 12),

                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Row(
                                  children: [
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

                              if (viewModel.isLoading)
                                const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(32),
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              else if (viewModel.pendingDonations.isEmpty)
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'No pending donation records found.',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              else
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      viewModel.pendingDonations.length,
                                  itemBuilder: (context, index) {
                                    final donation =
                                        viewModel.pendingDonations[index];

                                    final isSelected =
                                        viewModel.selectedDonation?.recordId ==
                                            donation.recordId;

                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 24),
                                      child: InkWell(
                                        onTap: () => viewModel.selectDonation(
                                          donation,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 350,
                                              child: VerificationDonorCard(
                                                donation: donation,
                                                donor: isSelected
                                                    ? viewModel.donor
                                                    : null,
                                                donorName: isSelected ? viewModel.donorName : null,
                                              ),
                                            ),

                                            const SizedBox(width: 24),

                                            Expanded(
                                              child: VerificationChecklist(
                                                donation: donation,
                                                isUpdating:
                                                    viewModel.isUpdating,
                                                onStatusChanged: (status) =>
                                                    viewModel
                                                        .updateDonationStatus(
                                                  donation,
                                                  status,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
        },
      ),
    );
  }
}

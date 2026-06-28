import 'package:flutter/material.dart';
import '../widgets/compliance_checklist_card.dart';
import '../widgets/donation_recording_form.dart';
import '../widgets/inventory_preview_card.dart';
import '../widgets/lab_technician_sidebar.dart';
import '../widgets/lab_technician_topbar.dart';
import '../widgets/recent_donations_table.dart';
import 'package:provider/provider.dart';
import 'package:vital_match/core/di/service_locator.dart';

class DonationRecordingPage extends StatefulWidget {
  const DonationRecordingPage({super.key});

  @override
  State<DonationRecordingPage> createState() => _DonationRecordingPageState();
}

class _DonationRecordingPageState extends State<DonationRecordingPage> {

  _DonationRecordingPageState() {
    print('DONATION PAGE STATE CONSTRUCTOR');
  }

  @override
  void initState() {
    super.initState();

    print('DONATION PAGE INIT');
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {

    try {

  print('BEFORE LOAD DONORS');

  await ServiceLocator
      .donationRecordingViewModel
      .loadDonors();

  print('BEFORE LOAD TECHNICIAN');

await ServiceLocator
    .donationRecordingViewModel
    .loadCurrentTechnician();

  await ServiceLocator
      .donationRecordingViewModel
      .loadRecentDonations();

  print('BEFORE LOAD INVENTORY');

await ServiceLocator
    .donationRecordingViewModel
    .loadInventory();

print('AFTER LOAD INVENTORY');

print('AFTER LOAD TECHNICIAN');
  print('AFTER LOAD DONORS');

} catch (e, stackTrace) {

  print('LOAD DONORS CRASHED');
  print(e);
  print(stackTrace);

}
  }

  @override
  Widget build(BuildContext context) {
    print('DONATION PAGE BUILD');
    return ChangeNotifierProvider.value(
      value: ServiceLocator.donationRecordingViewModel,
      child: Scaffold(
        backgroundColor: const Color(0xFFFCF9F8),
        body: Row(
          children: [
            const LabTechnicianSidebar(selectedIndex: 2),

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
                            'Donation Recording',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Log completed donation sessions with precision. Ensure all metrics are verified before finalizing stock updates.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),

                          const SizedBox(height: 24),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 8,
                                child: Column(
                                  children: const [
                                    DonationRecordingForm(),
                                    SizedBox(height: 24),
                                    RecentDonationsTable(),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 24),

                              Expanded(
                                flex: 4,
                                child: Column(
                                  children: const [
                                    InventoryPreviewCard(),
                                    SizedBox(height: 24),
                                    ComplianceChecklistCard(),
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
      ),
    );
  }
}

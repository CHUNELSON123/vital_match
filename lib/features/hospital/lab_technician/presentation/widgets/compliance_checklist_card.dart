import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/donation_recording_viewmodel.dart';

class ComplianceChecklistCard
    extends StatelessWidget {
  const ComplianceChecklistCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel =
        context.watch<
            DonationRecordingViewModel>();

    return Card(
      elevation: 0,
      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(
          16,
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Compliance Checklist',
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.w600,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            CheckboxListTile(
              contentPadding:
                  EdgeInsets.zero,
              value:
                  viewModel
                      .donorVerified,
              onChanged: (value) {
                viewModel
                    .toggleDonorVerified(
                  value ?? false,
                );
              },
              title: const Text(
                'Donor identity verified via ID',
              ),
            ),

            CheckboxListTile(
              contentPadding:
                  EdgeInsets.zero,
              value: viewModel
                  .screeningCompleted,
              onChanged: (value) {
                viewModel
                    .toggleScreeningCompleted(
                  value ?? false,
                );
              },
              title: const Text(
                'Post-donation screening complete',
              ),
            ),

            CheckboxListTile(
              contentPadding:
                  EdgeInsets.zero,
              value:
                  viewModel.bagLabeled,
              onChanged: (value) {
                viewModel
                    .toggleBagLabeled(
                  value ?? false,
                );
              },
              title: const Text(
                'Bag sealed and labeled correctly',
              ),
            ),

            CheckboxListTile(
              contentPadding:
                  EdgeInsets.zero,
              value: viewModel
                  .temperatureRecorded,
              onChanged: (value) {
                viewModel
                    .toggleTemperatureRecorded(
                  value ?? false,
                );
              },
              title: const Text(
                'Temperature log recorded',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
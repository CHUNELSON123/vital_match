import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vital_match/core/enums/blood_type.dart';
import 'package:vital_match/core/extensions/blood_type_extension.dart';

import '../../viewmodels/emergency_alert_viewmodel.dart';

class EmergencyAlertFormCard extends StatelessWidget {
  const EmergencyAlertFormCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel =
        context.watch<EmergencyAlertViewModel>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Emergency Alert Form',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<BloodType>(
                    value: viewModel.selectedBloodType,
                    decoration: const InputDecoration(
                      labelText: 'Blood Type',
                    ),
                    items: BloodType.values
                        .map(
                          (bloodType) =>
                              DropdownMenuItem(
                            value: bloodType,
                            child: Text(
                              bloodType.displayName,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (bloodType) {
                      if (bloodType == null) {
                        return;
                      }

                      viewModel.changeBloodType(
                        bloodType,
                      );
                    },
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: TextFormField(
                    controller:
                        viewModel.unitsNeededController,
                    keyboardType:
                        TextInputType.number,
                    onChanged: (_) =>
                        viewModel.refreshPreview(),
                    decoration: const InputDecoration(
                      labelText: 'Units Needed',
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              'Priority',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              children: [
                ChoiceChip(
                  label: const Text('Warning'),
                  selected:
                      viewModel.priority == 'Warning',
                  onSelected: (_) {
                    viewModel.changePriority(
                      'Warning',
                    );
                  },
                ),
                ChoiceChip(
                  label: const Text('High'),
                  selected:
                      viewModel.priority == 'High',
                  onSelected: (_) {
                    viewModel.changePriority(
                      'High',
                    );
                  },
                ),
                ChoiceChip(
                  label: const Text('Critical'),
                  selected:
                      viewModel.priority == 'Critical',
                  onSelected: (_) {
                    viewModel.changePriority(
                      'Critical',
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller:
                  viewModel.radiusController,
              keyboardType: TextInputType.number,
              onChanged: (_) =>
                  viewModel.refreshPreview(),
              decoration: const InputDecoration(
                labelText: 'Coverage Radius (km)',
              ),
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller:
                  viewModel.descriptionController,
              onChanged: (_) =>
                  viewModel.refreshPreview(),
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),

            const SizedBox(height: 24),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: viewModel.isSending
                    ? null
                    : () async {
                        final sent =
                            await viewModel
                                .sendEmergencyAlert();

                        if (!context.mounted) {
                          return;
                        }

                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          SnackBar(
                            backgroundColor:
                                sent ? Colors.green : Colors.red,
                            content: Text(
                              sent
                                  ? viewModel
                                      .successMessage!
                                  : viewModel
                                          .errorMessage ??
                                      'Failed to send emergency alert.',
                            ),
                          ),
                        );
                      },
                icon: const Icon(Icons.campaign),
                label: Text(
                  viewModel.isSending
                      ? 'Sending...'
                      : 'Send Emergency Alert',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

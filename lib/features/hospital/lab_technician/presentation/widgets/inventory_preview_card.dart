import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vital_match/core/extensions/blood_type_extension.dart';
import '../viewmodels/donation_recording_viewmodel.dart';

class InventoryPreviewCard extends StatelessWidget {
  const InventoryPreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel =
        context.watch<DonationRecordingViewModel>();

    final selectedBloodType =
        viewModel.bloodTypeController.text;

    if (selectedBloodType.isEmpty) {
      return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16),
        ),
        child: const Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Text(
              'Select a donor or blood type to preview inventory.',
            ),
          ),
        ),
      );
    }

    final bloodType =
        viewModel.stringToBloodType(
      selectedBloodType,
    );

    final currentInventory =
        viewModel
            .getCurrentInventoryForBloodType(
      bloodType,
    );

    final incomingUnits =
        int.tryParse(
              viewModel
                  .unitsCollectedController
                  .text,
            ) ??
            0;

    final projectedInventory =
        currentInventory +
            incomingUnits;

    final isCritical =
        currentInventory < 20;

    final isLow =
        currentInventory >= 20 &&
            currentInventory < 50;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Inventory Preview',
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Real-time projection for ${bloodType.displayName} stock level.',
              style: TextStyle(
                color:
                    Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Current Inventory',
              style: TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            LinearProgressIndicator(
              value: (currentInventory / 100)
                  .clamp(
                0.0,
                1.0,
              ),
              minHeight: 10,
            ),

            const SizedBox(height: 12),

            Text(
              '$currentInventory Units',
              style: const TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            const Divider(),

            const SizedBox(height: 24),

            const Text(
              'Projected Inventory',
              style: TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            LinearProgressIndicator(
              value:
                  (projectedInventory / 100)
                      .clamp(
                0.0,
                1.0,
              ),
              minHeight: 10,
            ),

            const SizedBox(height: 12),

            Text(
              '$projectedInventory Units',
              style: const TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
                color:
                    Color(0xFF1976D2),
              ),
            ),

            const SizedBox(height: 24),

            if (isCritical || isLow)
              Container(
                padding:
                    const EdgeInsets.all(
                  16,
                ),
                decoration:
                    BoxDecoration(
                  color: isCritical
                      ? Colors.red.shade50
                      : Colors.orange.shade50,
                  borderRadius:
                      BorderRadius
                          .circular(
                    12,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons
                          .warning_amber_rounded,
                      color: isCritical
                          ? Colors.red
                          : Colors.orange,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text(
                        isCritical
                            ? '${bloodType.displayName} supply is critically low ($currentInventory units remaining).'
                            : '${bloodType.displayName} supply is running low ($currentInventory units remaining).',
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
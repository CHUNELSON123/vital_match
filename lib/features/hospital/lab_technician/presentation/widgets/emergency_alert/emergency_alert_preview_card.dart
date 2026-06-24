import 'package:flutter/material.dart';
import 'package:vital_match/core/enums/blood_type.dart';
import 'package:vital_match/core/extensions/blood_type_extension.dart';

class EmergencyAlertPreviewCard extends StatelessWidget {
  final BloodType bloodType;
  final String unitsNeeded;
  final String description;
  final String hospitalName;

  const EmergencyAlertPreviewCard({
    super.key,
    required this.bloodType,
    required this.unitsNeeded,
    required this.description,
    required this.hospitalName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red.shade50,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  '${bloodType.displayName} REQUIRED',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              description.trim().isEmpty
                  ? 'Critical shortage in Emergency Unit.'
                  : description,
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      unitsNeeded.trim().isEmpty
                          ? '0'
                          : unitsNeeded,
                    ),
                    subtitle: const Text('Units'),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      hospitalName,
                    ),
                    subtitle: const Text('Location'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

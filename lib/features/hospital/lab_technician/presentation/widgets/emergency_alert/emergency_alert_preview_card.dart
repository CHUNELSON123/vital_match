import 'package:flutter/material.dart';

class EmergencyAlertPreviewCard extends StatelessWidget {
  const EmergencyAlertPreviewCard({super.key});

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
                  'O- REQUIRED',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),
              ],
            ),

            const SizedBox(height: 16),

            const Text(
              'Critical shortage in Emergency Unit.',
            ),

            const SizedBox(height: 20),

            Row(
              children: const [
                Expanded(
                  child: ListTile(
                    title: Text('12'),
                    subtitle: Text('Units'),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      'Central Hospital',
                    ),
                    subtitle: Text('Location'),
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
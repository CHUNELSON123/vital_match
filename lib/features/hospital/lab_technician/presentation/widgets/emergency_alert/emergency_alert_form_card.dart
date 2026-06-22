import 'package:flutter/material.dart';

class EmergencyAlertFormCard extends StatefulWidget {
  const EmergencyAlertFormCard({super.key});

  @override
  State<EmergencyAlertFormCard> createState() =>
      _EmergencyAlertFormCardState();
}

class _EmergencyAlertFormCardState
    extends State<EmergencyAlertFormCard> {
  String bloodType = 'O-';
  String priority = 'Critical';

  @override
  Widget build(BuildContext context) {
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
                  child: DropdownButtonFormField<String>(
                    value: bloodType,
                    decoration: const InputDecoration(
                      labelText: 'Blood Type',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'O-',
                        child: Text('O-'),
                      ),
                      DropdownMenuItem(
                        value: 'O+',
                        child: Text('O+'),
                      ),
                      DropdownMenuItem(
                        value: 'A+',
                        child: Text('A+'),
                      ),
                      DropdownMenuItem(
                        value: 'A-',
                        child: Text('A-'),
                      ),
                    ],
                    onChanged: (_) {},
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: TextFormField(
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
                  selected: priority == 'Warning',
                  onSelected: (_) {
                    setState(() {
                      priority = 'Warning';
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('High'),
                  selected: priority == 'High',
                  onSelected: (_) {
                    setState(() {
                      priority = 'High';
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('Critical'),
                  selected: priority == 'Critical',
                  onSelected: (_) {
                    setState(() {
                      priority = 'Critical';
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextFormField(
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),

            const SizedBox(height: 24),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.campaign),
                label: const Text(
                  'Send Emergency Alert',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
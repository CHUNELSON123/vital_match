import 'package:flutter/material.dart';

class InventoryPreviewCard extends StatelessWidget {
  const InventoryPreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Inventory Preview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Real-time projection for A+ stock level.',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Current Inventory',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            const LinearProgressIndicator(
              value: 0.65,
              minHeight: 10,
            ),

            const SizedBox(height: 12),

            const Text(
              '142 Units',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            const Divider(),

            const SizedBox(height: 24),

            const Text(
              'Projected Inventory',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            const LinearProgressIndicator(
              value: 0.72,
              minHeight: 10,
            ),

            const SizedBox(height: 12),

            const Text(
              '143.5 Units',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'O- Supply Warning. Critical shortage (< 12 units).',
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
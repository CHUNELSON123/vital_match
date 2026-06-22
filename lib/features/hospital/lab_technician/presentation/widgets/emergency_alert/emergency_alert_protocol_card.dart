import 'package:flutter/material.dart';

class EmergencyAlertProtocolCard
    extends StatelessWidget {
  const EmergencyAlertProtocolCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade50,
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.green,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'All emergency alerts are logged and audited. Verify blood shortage before broadcasting.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
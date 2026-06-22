import 'package:flutter/material.dart';

class ComplianceChecklistCard extends StatelessWidget {
  const ComplianceChecklistCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Compliance Checklist',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 20),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.check_box,
                color: Colors.green,
              ),
              title: Text(
                'Donor identity verified via ID',
              ),
            ),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.check_box,
                color: Colors.green,
              ),
              title: Text(
                'Post-donation screening complete',
              ),
            ),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.check_box,
                color: Colors.green,
              ),
              title: Text(
                'Bag sealed and labeled correctly',
              ),
            ),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.check_box_outline_blank,
              ),
              title: Text(
                'Temperature log recorded',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
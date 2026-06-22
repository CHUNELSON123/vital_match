import 'package:flutter/material.dart';

class EmergencyAlertReachCard
    extends StatelessWidget {
  const EmergencyAlertReachCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.groups),
        ),
        title: const Text(
          'Estimated Donor Reach',
        ),
        subtitle: const Text(
          '1,248 Potential Donors',
        ),
      ),
    );
  }
}
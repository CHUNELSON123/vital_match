import 'package:flutter/material.dart';

class EmergencyAlertReachCard extends StatelessWidget {
  final int estimatedDonorReach;

  const EmergencyAlertReachCard({super.key, required this.estimatedDonorReach});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.groups)),
        title: const Text('Estimated Donor Reach'),
        subtitle: Text('$estimatedDonorReach Potential Donors'),
      ),
    );
  }
}

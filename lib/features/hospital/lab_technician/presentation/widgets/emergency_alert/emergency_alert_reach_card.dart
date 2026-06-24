import 'package:flutter/material.dart';

class EmergencyAlertReachCard
    extends StatelessWidget {
  final String radiusKm;

  const EmergencyAlertReachCard({
    super.key,
    required this.radiusKm,
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
        subtitle: Text(
          '${_estimatedReach()} Potential Donors',
        ),
      ),
    );
  }

  int _estimatedReach() {
    final radius =
        double.tryParse(radiusKm) ?? 0;

    return (radius * 50).round();
  }
}

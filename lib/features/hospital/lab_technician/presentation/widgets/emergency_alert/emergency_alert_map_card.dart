import 'package:flutter/material.dart';

class EmergencyAlertMapCard
    extends StatelessWidget {
  final String radiusKm;

  const EmergencyAlertMapCard({
    super.key,
    required this.radiusKm,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 250,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              size: 60,
              color: Colors.red,
            ),
            const SizedBox(height: 12),
            const Text(
              'Coverage Radius Preview',
            ),
            Text(
              '${radiusKm.trim().isEmpty ? '0' : radiusKm}km Around Hospital',
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class EmergencyAlertMapCard
    extends StatelessWidget {
  const EmergencyAlertMapCard({
    super.key,
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
          children: const [
            Icon(
              Icons.location_on,
              size: 60,
              color: Colors.red,
            ),
            SizedBox(height: 12),
            Text(
              'Coverage Radius Preview',
            ),
            Text(
              '25km Around Hospital',
            ),
          ],
        ),
      ),
    );
  }
}
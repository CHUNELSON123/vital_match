import 'package:flutter/material.dart';

class TechnicianStatsCards
    extends StatelessWidget {

  const TechnicianStatsCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Row(

      children: [

        Expanded(
          child: _card(
            Icons.science,
            '85%',
            'Utilization',
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _card(
            Icons.warning,
            '3',
            'Urgent Gaps',
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _card(
            Icons.verified_user,
            '100%',
            'Certified',
          ),
        ),
      ],
    );
  }

  Widget _card(
    IconData icon,
    String value,
    String title,
  ) {

    return Container(

      padding:
          const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
        border: Border.all(
          color:
              const Color(0xFFE5E5E5),
        ),
      ),

      child: Column(

        children: [

          Icon(
            icon,
            size: 40,
            color:
                const Color(
              0xFF005DAC,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            value,

            style: const TextStyle(
              fontSize: 24,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          Text(title),
        ],
      ),
    );
  }
}
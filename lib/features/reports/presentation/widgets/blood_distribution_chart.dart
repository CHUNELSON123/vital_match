import 'package:flutter/material.dart';

class BloodDistributionChart
    extends StatelessWidget {
  const BloodDistributionChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
        border: Border.all(
          color: const Color(
            0xFFE5E5E5,
          ),
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: const [
          Text(
            'Blood Type Distribution',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 24),

          _BloodTypeRow(
            type: 'O+',
            percentage: '40%',
            color: Color(0xFF005DAC),
          ),

          _BloodTypeRow(
            type: 'A+',
            percentage: '25%',
            color: Colors.red,
          ),

          _BloodTypeRow(
            type: 'B+',
            percentage: '20%',
            color: Colors.orange,
          ),

          _BloodTypeRow(
            type: 'Others',
            percentage: '15%',
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class _BloodTypeRow extends StatelessWidget {
  final String type;
  final String percentage;
  final Color color;

  const _BloodTypeRow({
    required this.type,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 10,
      ),

      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(child: Text(type)),

          Text(
            percentage,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
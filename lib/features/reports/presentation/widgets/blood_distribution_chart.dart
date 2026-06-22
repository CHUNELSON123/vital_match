import 'package:flutter/material.dart';

class BloodDistributionChart
    extends StatelessWidget {

  final List<dynamic>
      bloodDistribution;

  const BloodDistributionChart({
    super.key,
    required this.bloodDistribution,
  });

  @override
  Widget build(BuildContext context) {

    if (bloodDistribution.isEmpty) {
      return Container(
        width: double.infinity,
        height: 300,

        alignment: Alignment.center,

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

        child: const Text(
          'No blood distribution data',
        ),
      );
    }
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

      children: [

        const Text(
          'Blood Type Distribution',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 24),

        ...bloodDistribution.map(
          (blood) {

            return _BloodTypeRow(
              type:
                  blood['bloodType']
                      .toString(),

              percentage:
                  blood['total']
                      .toString(),

              color:
                  const Color(
                0xFF005DAC,
              ),
            );
          },
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
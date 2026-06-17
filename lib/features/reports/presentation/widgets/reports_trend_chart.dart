import 'package:flutter/material.dart';

class ReportsTrendChart extends StatelessWidget {

  final List<dynamic> donationTrend;

  const ReportsTrendChart({
    super.key,
    required this.donationTrend,
  });

  @override
  Widget build(BuildContext context) {
     
    final values =
    donationTrend
        .map<int>(
          (item) =>
              item['total'] ?? 0,
        )
        .toList();

final months =
    donationTrend
        .map<String>(
          (item) =>
              item['month'] ?? '',
        )
        .toList();

  if (donationTrend.isEmpty) {
  return Container(
    height: 350,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(16),
      border: Border.all(
        color:
            const Color(0xFFE5E5E5),
      ),
    ),
    child: const Text(
      'No donation data available',
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
          color: const Color(0xFFE5E5E5),
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          const Text(
            'Donation Activity Trend',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Monthly donation activity',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 280,

            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.end,

              children: List.generate(
                values.length,
                (index) => Expanded(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.end,

                    children: [
                      Text(
                        '${values[index]}',
                        style: const TextStyle(
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Container(
                        height:
                            values[index] * 2.5,

                        margin:
                            const EdgeInsets.symmetric(
                          horizontal: 6,
                        ),

                        decoration:
                            BoxDecoration(
                          color:
                              const Color(
                            0xFF005DAC,
                          ),
                          borderRadius:
                              BorderRadius.circular(
                            8,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(months[index]),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
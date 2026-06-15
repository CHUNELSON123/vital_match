import 'package:flutter/material.dart';

class DashboardHeaderSection extends StatelessWidget {
  const DashboardHeaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(24),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        crossAxisAlignment:
            CrossAxisAlignment.end,

        children: [

          const Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                'Dashboard Overview',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              SizedBox(height: 6),

              Text(
                'Real-time status of clinical logistics and personnel.',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          Row(
            children: [

              OutlinedButton.icon(
                onPressed: () {},

                icon: const Icon(
                  Icons.download,
                ),

                label: const Text(
                  'Export PDF',
                ),

                style:
                    OutlinedButton.styleFrom(
                  foregroundColor:
                      const Color(
                    0xFF005DAC,
                  ),

                  side: const BorderSide(
                    color: Color(
                      0xFF005DAC,
                    ),
                  ),

                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              ElevatedButton.icon(
                onPressed: () {},

                icon: const Icon(
                  Icons.add,
                ),

                label: const Text(
                  'New Request',
                ),

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(
                    0xFF005DAC,
                  ),

                  foregroundColor:
                      Colors.white,

                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
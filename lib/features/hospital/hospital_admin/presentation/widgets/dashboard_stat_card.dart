import 'package:flutter/material.dart';

class DashboardStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final String? subtitle;

  const DashboardStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: const Color(
            0xFFE5E5E5,
          ),
        ),

        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              Text(
                title,
                style: const TextStyle(
                  color: Color(
                    0xFF005DAC,
                  ),
                  fontWeight:
                      FontWeight.bold,
                  fontSize: 12,
                ),
              ),

              Icon(
                icon,
                color: const Color(
                  0xFF005DAC,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          if (subtitle != null) ...[
            const SizedBox(height: 8),

            Text(
              subtitle!,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
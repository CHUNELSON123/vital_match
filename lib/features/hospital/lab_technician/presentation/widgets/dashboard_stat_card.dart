import 'package:flutter/material.dart';

class DashboardStatCard
    extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const DashboardStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,

      padding: const EdgeInsets.all(
        20,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          16,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Icon(
            icon,
            color: color,
          ),

          const Spacer(),

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight:
                  FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
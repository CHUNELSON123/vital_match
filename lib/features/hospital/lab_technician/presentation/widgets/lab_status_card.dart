import 'package:flutter/material.dart';

class LabStatusCard
    extends StatelessWidget {
  const LabStatusCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(
        24,
      ),

      decoration: BoxDecoration(
        color:
            const Color(
          0xFF005FAF,
        ),

        borderRadius:
            BorderRadius.circular(
          16,
        ),
      ),

      child: const Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 40,
          ),

          SizedBox(
            width: 16,
          ),

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                'Lab Status',
                style: TextStyle(
                  color:
                      Colors.white70,
                ),
              ),

              Text(
                'Optimal Operation',
                style: TextStyle(
                  color:
                      Colors.white,
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
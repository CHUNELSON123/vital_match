import 'package:flutter/material.dart';
import '../../domain/entities/reports_summary.dart';
class ReportsSummaryGrid
    extends StatelessWidget {

  final ReportsSummary
      reportsSummary;

  const ReportsSummaryGrid({
    super.key,
    required this.reportsSummary,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
            children:[
              _StatCard(
                title: 'Total Blood Units',
                value:
                  reportsSummary
                      .totalBloodUnits
                      .toString(),
                icon: Icons.bloodtype,
                color: Color(0xFF005DAC),
              ),

              SizedBox(height: 16),

              _StatCard(
                title: 'Donation Records',
                value:
                  reportsSummary
                      .totalDonationRecords
                      .toString(),
                icon: Icons.history_edu,
                color: Colors.red,
              ),

              SizedBox(height: 16),

              _StatCard(
                title: 'Technicians',
                value:
                  reportsSummary
                      .totalTechnicians
                      .toString(),
                icon: Icons.engineering,
                color: Colors.orange,
              ),

              SizedBox(height: 16),

              _StatCard(
                title: 'Recent Activity',
                value:
                  reportsSummary
                      .recentActivity
                      .toString(),
                icon: Icons.bolt,
                color: Colors.black87,
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Total Blood Units',
                 value: reportsSummary
                  .totalBloodUnits
                  .toString(),
                icon: Icons.bloodtype,
                color: Color(0xFF005DAC),
              ),
            ),

            SizedBox(width: 16),

            Expanded(
              child: _StatCard(
                title: 'Donation Records',
                value: reportsSummary
                .totalDonationRecords
                .toString(),
                icon: Icons.history_edu,
                color: Colors.red,
              ),
            ),

            SizedBox(width: 16),

            Expanded(
              child: _StatCard(
                title: 'Technicians',
                value: reportsSummary
                  .totalTechnicians
                  .toString(),
                icon: Icons.engineering,
                color: Colors.orange,
              ),
            ),

            SizedBox(width: 16),

            Expanded(
              child: _StatCard(
                title: 'Recent Activity',
                value: reportsSummary
                  .recentActivity
                  .toString(),
                icon: Icons.bolt,
                color: Colors.black87,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E5E5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor:
                color.withOpacity(.12),
            child: Icon(icon, color: color),
          ),

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
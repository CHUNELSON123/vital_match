import 'package:flutter/material.dart';
import 'package:vital_match/features/hospital/domain/entities/hospital.dart';
import 'dashboard_stat_card.dart';

class DashboardStatsGrid extends StatelessWidget {
  final Hospital hospital;
  final int auditCount;
  final int technicianCount;

  const DashboardStatsGrid({
    super.key,
    required this.hospital,
    required this.auditCount,
    required this.technicianCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),

      child: GridView.count(
        shrinkWrap: true,

        physics: const NeverScrollableScrollPhysics(),

        crossAxisCount: 4,

        crossAxisSpacing: 16,

        mainAxisSpacing: 16,

        childAspectRatio: 1.5,

        children: [
          DashboardStatCard(
            title: 'HOSPITAL',
            value: hospital.name,
            icon: Icons.local_hospital,
            subtitle: hospital.address,
          ),

          DashboardStatCard(
            title: 'TECHNICIANS',
            value: technicianCount.toString(),
            icon: Icons.groups,
            subtitle: 'Active Technicians',
          ),

          DashboardStatCard(
            title: 'AUDIT LOGS',
            value: auditCount.toString(),
            icon: Icons.receipt_long,
            subtitle: 'Recent Activity',
          ),

          DashboardStatCard(
            title: 'GEOFENCE',
            value: '${hospital.geofenceRadiusKm} km',
            icon: Icons.location_on,
            subtitle: 'Protection Radius',
          ),
        ],
      ),
    );
  }
}

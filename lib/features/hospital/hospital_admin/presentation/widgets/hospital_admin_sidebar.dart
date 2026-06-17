import 'package:flutter/material.dart';
import 'package:vital_match/features/hospital/domain/entities/hospital.dart';
import 'package:vital_match/features/hospital/hospital_admin/presentation/pages/hospital_admin_dashboard.dart';
import '../pages/technicians_page.dart';
import 'package:vital_match/features/audit_trail/presentation/pages/audit_trail_page.dart';
import '../../../../reports/presentation/pages/reports_page.dart';

class HospitalAdminSidebar extends StatelessWidget {
  final int selectedIndex;
  final Hospital hospital;

  const HospitalAdminSidebar({
    super.key,
    required this.selectedIndex,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: const Color(0xFF005DAC),
      child: Column(
        children: [
          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'VitalMatch',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Admin Portal',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          _navItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
            selected: selectedIndex == 0,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => HospitalAdminDashboard(
                  ),
                ),
              );
            },
          ),

          _navItem(
            icon: Icons.groups,
            title: 'Technicians',
            selected: selectedIndex == 1,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => TechniciansPage(
                    hospital: hospital,
                  ),
                ),
              );
            },
          ),

          _navItem(
            icon: Icons.receipt_long,
            title: 'Audit Trail',
            selected: selectedIndex == 2,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => AuditTrailPage(
                    hospital: hospital,
                  ),
                ),
              );
            },
          ),

          _navItem(
            icon: Icons.bar_chart,
            title: 'Reports',
            selected: selectedIndex == 3,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => ReportsPage(
                    hospital: hospital,
                  ),
                ),
              );
            },
          ),

          _navItem(
            icon: Icons.settings,
            title: 'Hospital Settings',
            selected: selectedIndex == 4,
          ),

          const Spacer(),

          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.person),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin User',
                        overflow:
                            TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Hospital Admin',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _navItem({
    required IconData icon,
    required String title,
    required bool selected,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color:
              selected
                  ? Colors.white
                  : Colors.transparent,
          borderRadius:
              BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color:
                  selected
                      ? const Color(
                          0xFF005DAC,
                        )
                      : Colors.white70,
            ),

            const SizedBox(width: 12),

            Text(
              title,
              style: TextStyle(
                color:
                    selected
                        ? const Color(
                            0xFF005DAC,
                          )
                        : Colors.white,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
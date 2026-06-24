import 'package:flutter/material.dart';
import '../pages/lab_technician_dashboard.dart';
import '../pages/donation_verification_page.dart';
import '../pages/donation_recording_page.dart';
import '../pages/emergency_alerts_page.dart';
 
 
 

class LabTechnicianSidebar
    extends StatelessWidget {

  final int selectedIndex;

  const LabTechnicianSidebar({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 260,

      color: const Color(
        0xFF005DAC,
      ),

      child: Column(
        children: [

          const SizedBox(
            height: 30,
          ),

          const Icon(
            Icons.bloodtype,
            color: Colors.white,
            size: 42,
          ),

          const SizedBox(
            height: 12,
          ),

          const Text(
            'Vital Match',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 40,
          ),

          _navItem(
            context,
            0,
            Icons.dashboard,
            'Dashboard',
            const LabTechnicianDashboard(),
          ),

         _navItem(
            context,
            1,
            Icons.verified,
            'Donation Verification',
            const DonationVerificationPage(),
          ),

          _navItem(
            context,
            2,
            Icons.edit_note,
            'Donation Recording',
            const DonationRecordingPage(),
          ),

          _navItem(
            context,
            3,
            Icons.warning,
            'Emergency Alerts',
            const EmergencyAlertsPage(),
          ),

          

          const Spacer(),

          Padding(
            padding:
                const EdgeInsets.all(
              20,
            ),
            child: SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: () {},

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.white,
                  foregroundColor:
                      const Color(
                    0xFFAF101A,
                  ),
                ),

                icon: const Icon(
                  Icons.emergency,
                ),

                label: const Text(
                  'Urgent Request',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    int index,
    IconData icon,
    String title,
    Widget page,
  ) {

    final selected =
        selectedIndex == index;

    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),

      child: ListTile(
        selected: selected,

        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(
            12,
          ),
        ),

        selectedTileColor:
            Colors.white,

        leading: Icon(
          icon,
          color: selected
              ? const Color(
                  0xFFAF101A,
                )
              : Colors.white,
        ),

        title: Text(
          title,
          style: TextStyle(
            color: selected
                ? const Color(
                    0xFFAF101A,
                  )
                : Colors.white,
            fontWeight:
                FontWeight.w600,
          ),
        ),

        onTap: () {

          if (selected) return;

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => page,
            ),
            (route) => false,
          );
        },
      ),
    );
  }
}
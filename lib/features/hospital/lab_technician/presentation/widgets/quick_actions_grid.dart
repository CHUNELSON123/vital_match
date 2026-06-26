import 'package:flutter/material.dart';
import '../pages/donation_recording_page.dart';
import '../pages/donation_verification_page.dart';
import '../pages/emergency_alerts_page.dart';

class QuickActionsGrid
    extends StatelessWidget {
  const QuickActionsGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,

      physics:
          const NeverScrollableScrollPhysics(),

      crossAxisCount: 2,

      crossAxisSpacing: 16,
      mainAxisSpacing: 16,

      childAspectRatio: 4,

      children: const [
        _ActionTile(
          title:
              'Verify Donation',
          icon:
              Icons.verified,
          page:
              DonationVerificationPage(),
        ),

        _ActionTile(
          title:
              'Record Donation',
          icon:
              Icons.edit_note,
          page:
              DonationRecordingPage(),
        ),

        _ActionTile(
          title:
              'Create Alert',
          icon:
              Icons.warning,
          page:
              EmergencyAlertsPage(),
        ),

        _ActionTile(
          title:
              'Request Transfer',
          icon:
              Icons.swap_horiz,
          message:
              'Transfer request screen is not available yet.',
        ),
      ],
    );
  }
}

class _ActionTile
    extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? page;
  final String? message;

  const _ActionTile({
    required this.title,
    required this.icon,
    this.page,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (page == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                message ?? 'This action is not available yet.',
              ),
            ),
          );
          return;
        }

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => page!,
          ),
          (route) => false,
        );
      },
      borderRadius:
          BorderRadius.circular(
        16,
      ),
      child: Container(
        padding:
            const EdgeInsets.all(
          16,
        ),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(
            16,
          ),
        ),

        child: Row(
          children: [
            Icon(icon),

            const SizedBox(
              width: 12,
            ),

            Text(
              title,
            ),
          ],
        ),
      ),
    );
  }
}

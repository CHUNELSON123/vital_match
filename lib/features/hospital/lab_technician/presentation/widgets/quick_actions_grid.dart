import 'package:flutter/material.dart';

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
        ),

        _ActionTile(
          title:
              'Record Donation',
          icon:
              Icons.edit_note,
        ),

        _ActionTile(
          title:
              'Create Alert',
          icon:
              Icons.warning,
        ),

        _ActionTile(
          title:
              'Request Transfer',
          icon:
              Icons.swap_horiz,
        ),
      ],
    );
  }
}

class _ActionTile
    extends StatelessWidget {
  final String title;
  final IconData icon;

  const _ActionTile({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
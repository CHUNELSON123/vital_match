import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/dashboard_viewmodel.dart';

class RecentActivityPanel extends StatelessWidget {
  const RecentActivityPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboard = context.watch<DashboardViewModel>();

    final activities = dashboard.activities;

    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            'Recent Activity',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          if (activities.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text('No recent activity'),
              ),
            )
          else
            ...activities.map((activity) {
              return ListTile(
                contentPadding: EdgeInsets.zero,

                leading: const CircleAvatar(child: Icon(Icons.history)),

                title: Text(activity.title),

                subtitle: Text(activity.subtitle),
              );
            }),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vital_match/features/audit_trail/domain/entities/audit_trail.dart';

class RecentActivityTable extends StatelessWidget {
  final List<AuditTrail> activities;
  final Map<String, String>
      activityUserNames;
  const RecentActivityTable({super.key, required this.activities, required this.activityUserNames});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            'Recent Activity',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Column(
            children: [
              const Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Action',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Text(
                      'User',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Text(
                      'Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Text(
                      'Status',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Divider(color: Colors.grey.shade300),

              if (activities.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 24,
                  ),
                  child: Center(
                    child: Text(
                      'No recent activity found',
                    ),
                  ),
                )
              else
                Column(
                  children: activities.take(10).map(
                    (activity) {

                      return Column(
                        children: [

                          _tableRow(
                            action: activity.action,
                            user: activityUserNames[activity.userId] ?? activity.userId,
                            date: activity.timestamp
                                .toString()
                                .split(' ')
                                .first,
                            status: 'Success',
                          ),

                          Divider(
                            color: Colors.grey.shade300,
                          ),
                        ],
                      );
                    },
                  ).toList(),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tableRow({
    required String action,
    required String user,
    required String date,
    required String status,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),

      child: Row(
        children: [
          Expanded(flex: 3, child: Text(action)),

          Expanded(flex: 2, child: Text(user)),

          Expanded(flex: 2, child: Text(date)),

          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,

              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),

                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Text(
                  status,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'create_technician_dialog.dart';
import '../../../../audit_trail/presentation/pages/audit_trail_page.dart';

import 'package:vital_match/features/hospital/domain/entities/hospital.dart';

class QuickActionsSection extends StatelessWidget {

  final Hospital hospital;

  const QuickActionsSection({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
        border: Border.all(
          color: const Color(
            0xFFE5E5E5,
          ),
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Column(
            children: [

              _actionCard(
                icon: Icons.groups,
                title: 'Add Technician',

                onTap: () async {

                  await showDialog(
                    context: context,
                    builder: (_) =>
                        const CreateTechnicianDialog(),
                  );
                },
              ),

              const SizedBox(height: 12),

              _actionCard(
                icon: Icons.receipt_long,
                title: 'View Audit Trail',

                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          AuditTrailPage(
                        hospital: hospital,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              _actionCard(
                icon: Icons.settings,
                title: 'Hospital Settings',

                onTap: () {

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Hospital Settings coming soon',
                      ),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _actionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {

    return InkWell(
      onTap: onTap,

      borderRadius:
          BorderRadius.circular(12),

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color:
              const Color(0xFFF7F9FC),
          borderRadius:
              BorderRadius.circular(
            12,
          ),
        ),

        child: Column(
          children: [

            Icon(
              icon,
              size: 32,
              color:
                  const Color(
                0xFF005DAC,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              textAlign:
                  TextAlign.center,
              style: const TextStyle(
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
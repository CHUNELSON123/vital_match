import 'package:flutter/material.dart';

import 'package:vital_match/features/hospital/domain/entities/hospital.dart';

import 'package:vital_match/features/audit_trail/domain/entities/audit_trail.dart';

import 'package:vital_match/features/audit_trail/presentation/viewmodels/audit_trail_viewmodel.dart';

import 'package:vital_match/features/hospital/hospital_admin/presentation/widgets/hospital_admin_sidebar.dart';

import 'package:vital_match/features/hospital/hospital_admin/presentation/widgets/hospital_admin_topbar.dart';

import '../widgets/audit_header.dart';
import '../widgets/audit_filters_bar.dart';
import '../widgets/audit_stats_grid.dart';
import '../widgets/audit_logs_table.dart';

class AuditTrailPage extends StatefulWidget {
  final Hospital hospital;

  const AuditTrailPage({super.key, required this.hospital});

  @override
  State<AuditTrailPage> createState() => _AuditTrailPageState();
}

class _AuditTrailPageState extends State<AuditTrailPage> {
  final vm = AuditTrailViewModel();

  bool isLoading = true;
  List<AuditTrail> auditTrails = [];
  List<AuditTrail> filteredAuditTrails = [];
  String selectedSeverity = 'All';
  String selectedAction = 'All';

  @override
  void initState() {
    super.initState();
    _loadAuditTrails();
  }

  Future<void> _loadAuditTrails() async {
    try {
      final result = await vm.getAuditTrailsByHospital(
        widget.hospital.hospitalId,
      );

      setState(() {
        auditTrails = result;
        filteredAuditTrails = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      debugPrint('AUDIT TRAIL ERROR: $e');
    }
  }

  void _applyFilters() {
    filteredAuditTrails = auditTrails.where((audit) {
      final action = audit.action.toLowerCase();

      bool matchesSeverity = true;
      bool matchesAction = true;

      if (selectedSeverity != 'All') {
        if (selectedSeverity == 'Success') {
          matchesSeverity =
              !action.contains('delete') &&
              !action.contains('failed') &&
              !action.contains('update');
        }

        if (selectedSeverity == 'Warning') {
          matchesSeverity =
              action.contains('update') || action.contains('edit');
        }

        if (selectedSeverity == 'Critical') {
          matchesSeverity =
              action.contains('delete') || action.contains('failed');
        }
      }

      if (selectedAction != 'All') {
        matchesAction = action.contains(selectedAction.toLowerCase());
      }

      return matchesSeverity && matchesAction;
    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          HospitalAdminSidebar(selectedIndex: 2, hospital: widget.hospital),

          Expanded(
            child: Column(
              children: [
                HospitalAdminTopbar(hospital: widget.hospital),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        AuditHeader(
                          onRefresh: () async {
                            setState(() {
                              isLoading = true;
                            });

                            await _loadAuditTrails();

                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Audit logs refreshed'),
                                ),
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 24),

                        AuditFiltersBar(
                          selectedSeverity: selectedSeverity,

                          selectedAction: selectedAction,

                          onSeverityChanged: (value) {
                            selectedSeverity = value;

                            _applyFilters();
                          },

                          onActionChanged: (value) {
                            selectedAction = value;

                            _applyFilters();
                          },
                        ),
                        const SizedBox(height: 24),

                        if (isLoading)
                          const Center(child: CircularProgressIndicator())
                        else ...[
                          AuditStatsGrid(auditTrails: filteredAuditTrails),

                          const SizedBox(height: 24),

                          AuditLogsTable(auditTrails: filteredAuditTrails),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AuditFiltersBar extends StatelessWidget {

  final String selectedSeverity;
  final String selectedAction;

  final ValueChanged<String>
      onSeverityChanged;

  final ValueChanged<String>
      onActionChanged;

  const AuditFiltersBar({
    super.key,
    required this.selectedSeverity,
    required this.selectedAction,
    required this.onSeverityChanged,
    required this.onActionChanged,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [

        DropdownButton<String>(
          value: selectedSeverity,

          items: const [

            DropdownMenuItem(
              value: 'All',
              child: Text(
                'All Severities',
              ),
            ),

            DropdownMenuItem(
              value: 'Success',
              child: Text(
                'Success',
              ),
            ),

            DropdownMenuItem(
              value: 'Warning',
              child: Text(
                'Warning',
              ),
            ),

            DropdownMenuItem(
              value: 'Critical',
              child: Text(
                'Critical',
              ),
            ),
          ],

          onChanged: (value) {
            if (value != null) {
              onSeverityChanged(
                value,
              );
            }
          },
        ),

        const SizedBox(width: 24),

        DropdownButton<String>(
          value: selectedAction,

          items: const [

            DropdownMenuItem(
              value: 'All',
              child: Text(
                'All Actions',
              ),
            ),

            DropdownMenuItem(
              value: 'create',
              child: Text(
                'Create',
              ),
            ),

            DropdownMenuItem(
              value: 'update',
              child: Text(
                'Update',
              ),
            ),

            DropdownMenuItem(
              value: 'delete',
              child: Text(
                'Delete',
              ),
            ),
          ],

          onChanged: (value) {
            if (value != null) {
              onActionChanged(
                value,
              );
            }
          },
        ),
      ],
    );
  }
}
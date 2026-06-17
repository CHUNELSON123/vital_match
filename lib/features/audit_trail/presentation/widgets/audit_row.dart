import 'package:flutter/material.dart';

import 'audit_severity_badge.dart';

class AuditRow extends StatelessWidget {

  final String severity;
  final String user;
  final String action;
  final String target;
  final String timestamp;

  const AuditRow({
    super.key,
    required this.severity,
    required this.user,
    required this.action,
    required this.target,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),

      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(
              0xFFEAEAEA,
            ),
          ),
        ),
      ),

      child: Row(
        children: [

          Expanded(
            flex: 2,
            child:
                AuditSeverityBadge(
              severity:
                  severity,
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(user),
          ),

          Expanded(
            flex: 3,
            child: Text(action),
          ),

          Expanded(
            flex: 2,
            child: Text(target),
          ),

          Expanded(
            flex: 2,
            child: Text(timestamp),
          ),

          const Expanded(
            child: Icon(
              Icons.visibility,
            ),
          ),
        ],
      ),
    );
  }
}
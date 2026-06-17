import 'package:flutter/material.dart';

class AuditSeverityBadge
    extends StatelessWidget {

  final String severity;

  const AuditSeverityBadge({
    super.key,
    required this.severity,
  });

  @override
  Widget build(BuildContext context) {

    Color bgColor;
    Color textColor;

    switch (severity) {

      case 'Critical':
        bgColor =
            Colors.red.shade100;

        textColor =
            Colors.red.shade700;
        break;

      case 'Warning':
        bgColor =
            Colors.orange.shade100;

        textColor =
            Colors.orange.shade700;
        break;

      default:
        bgColor =
            Colors.green.shade100;

        textColor =
            Colors.green.shade700;
    }

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),

      decoration: BoxDecoration(
        color: bgColor,

        borderRadius:
            BorderRadius.circular(20),
      ),

      child: Text(
        severity,

        style: TextStyle(
          color: textColor,
          fontWeight:
              FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
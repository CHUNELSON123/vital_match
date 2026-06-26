import 'package:flutter/material.dart';
import 'package:vital_match/core/utils/pdf_exporter.dart';

class AuditHeader extends StatelessWidget {

  final VoidCallback onRefresh;

  const AuditHeader({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

      children: [

        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: const [

            Text(
              'System > Audit Trail',
            ),

            SizedBox(height: 8),

            Text(
              'Security & Audit Logs',
              style: TextStyle(
                fontSize: 32,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),

        Row(
          children: [

            IconButton(
              tooltip: 'Refresh Audit Logs',
              onPressed: onRefresh,
              icon: const Icon(
                Icons.refresh,
              ),
            ),

            const SizedBox(width: 12),

            OutlinedButton.icon(
              onPressed: _exportAuditReport,
              icon: const Icon(
                Icons.download,
              ),
              label: const Text(
                'Export PDF',
              ),
            ),

            const SizedBox(width: 12),

            ElevatedButton.icon(
              onPressed: _exportAuditReport,
              icon: const Icon(
                Icons.print,
              ),
              label: const Text(
                'Print Report',
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _exportAuditReport() {
    PdfExporter.openReport(
      title: 'Audit Trail Report',
      lines: const [
        'Vital Match audit trail report.',
        'Open the Audit Trail page to view the current filtered audit logs.',
        'Critical alerts include emergency, failed, deleted and critical actions.',
      ],
    );
  }
}

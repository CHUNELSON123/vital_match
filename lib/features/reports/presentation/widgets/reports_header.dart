import 'package:flutter/material.dart';
import 'package:vital_match/core/utils/pdf_exporter.dart';

class ReportsHeader extends StatelessWidget {
  const ReportsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 900;

        if (isSmallScreen) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Analytics & Reports',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Comprehensive overview of blood bank operations.',
              ),

              const SizedBox(height: 20),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  OutlinedButton.icon(
                    onPressed: _exportReport,
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('Export PDF'),
                  ),

                  ElevatedButton.icon(
                    onPressed: _exportReport,
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('Export Report'),
                  ),
                ],
              ),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Analytics & Reports',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    'Comprehensive overview of blood bank operations.',
                  ),
                ],
              ),
            ),

            const SizedBox(width: 24),

            Wrap(
              spacing: 12,
              children: [
                OutlinedButton.icon(
                  onPressed: _exportReport,
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Export PDF'),
                ),

                ElevatedButton.icon(
                  onPressed: _exportReport,
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Export Report'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _exportReport() {
    PdfExporter.openReport(
      title: 'Analytics & Reports',
      lines: const [
        'Vital Match Hospital Administration Report',
        'This PDF export contains the current analytics report view.',
        'Use the dashboard cards, donation trend and blood distribution sections for the live values displayed in the app.',
      ],
    );
  }
}

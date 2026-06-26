// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

class PdfExporter {
  static void openReport({
    required String title,
    required List<String> lines,
  }) {
    final bytes = _buildSimplePdf(title: title, lines: lines);
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.window.open(url, '_blank');

    Future<void>.delayed(
      const Duration(seconds: 2),
      () => html.Url.revokeObjectUrl(url),
    );
  }

  static Uint8List _buildSimplePdf({
    required String title,
    required List<String> lines,
  }) {
    final escapedTitle = _escape(title);
    final escapedLines = lines.map(_escape).toList();
    final content = StringBuffer()
      ..writeln('BT')
      ..writeln('/F1 18 Tf')
      ..writeln('50 780 Td')
      ..writeln('($escapedTitle) Tj')
      ..writeln('/F1 11 Tf');

    for (final line in escapedLines.take(42)) {
      content
        ..writeln('0 -18 Td')
        ..writeln('($line) Tj');
    }

    content.writeln('ET');

    final stream = content.toString();
    final objects = <String>[
      '1 0 obj << /Type /Catalog /Pages 2 0 R >> endobj',
      '2 0 obj << /Type /Pages /Kids [3 0 R] /Count 1 >> endobj',
      '3 0 obj << /Type /Page /Parent 2 0 R /MediaBox [0 0 595 842] /Resources << /Font << /F1 4 0 R >> >> /Contents 5 0 R >> endobj',
      '4 0 obj << /Type /Font /Subtype /Type1 /BaseFont /Helvetica >> endobj',
      '5 0 obj << /Length ${utf8.encode(stream).length} >> stream\n$stream\nendstream endobj',
    ];

    final buffer = StringBuffer('%PDF-1.4\n');
    final offsets = <int>[0];

    for (final object in objects) {
      offsets.add(utf8.encode(buffer.toString()).length);
      buffer.writeln(object);
    }

    final xrefOffset = utf8.encode(buffer.toString()).length;
    buffer
      ..writeln('xref')
      ..writeln('0 ${objects.length + 1}')
      ..writeln('0000000000 65535 f ');

    for (final offset in offsets.skip(1)) {
      buffer.writeln('${offset.toString().padLeft(10, '0')} 00000 n ');
    }

    buffer
      ..writeln('trailer << /Size ${objects.length + 1} /Root 1 0 R >>')
      ..writeln('startxref')
      ..writeln(xrefOffset)
      ..writeln('%%EOF');

    return Uint8List.fromList(utf8.encode(buffer.toString()));
  }

  static String _escape(String value) {
    return value
        .replaceAll('\\', r'\\')
        .replaceAll('(', r'\(')
        .replaceAll(')', r'\)');
  }
}

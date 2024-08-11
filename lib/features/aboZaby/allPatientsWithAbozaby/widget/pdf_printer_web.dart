import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html;

void printPdf(pw.Document pdf) {
  final pdfBytes = pdf.save();
  final blob = html.Blob([pdfBytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  html.window.open(url, '_blank');
  html.Url.revokeObjectUrl(url);
}

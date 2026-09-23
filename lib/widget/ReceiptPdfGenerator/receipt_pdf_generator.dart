// lib/common_widget/pdf/receipt_pdf_generator.dart
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// Reusable PDF generator — receipts, invoices, any label/value document.
class ReceiptPdfGenerator {
  static Future<void> generateAndShare({
    required String documentTitle,
    required String heading,
    required String amountLabel,
    required List<MapEntry<String, String>> rows,
    String? footerNote,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Padding(
          padding: const pw.EdgeInsets.all(32),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(documentTitle, style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 16),
              pw.Text(heading, style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
              pw.SizedBox(height: 4),
              pw.Text(amountLabel, style: pw.TextStyle(fontSize: 26, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 8),
              ...rows.map(
                    (row) => pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 6),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(row.key, style: pw.TextStyle(color: PdfColors.grey700)),
                      pw.Text(row.value, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              if (footerNote != null) ...[
                pw.SizedBox(height: 20),
                pw.Text(footerNote, style: pw.TextStyle(fontSize: 10, color: PdfColors.grey500)),
              ],
            ],
          ),
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save(), name: documentTitle);
  }
}
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hotel/src/core/services/currency/app_currency_formatter.dart';
import 'package:hotel/src/features/party/domain/models/party_statement_model.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class _PdfTheme {
  const _PdfTheme({required this.theme, required this.supportsUnicode});

  final pw.ThemeData theme;
  final bool supportsUnicode;
}

class PartyStatementPdfExporter {
  PartyStatementPdfExporter._();

  static Future<_PdfTheme> _loadPdfTheme() async {
    try {
      final fontData =
          await rootBundle.load('assets/fonts/NotoSansDevanagari-Bold.ttf');
      final ttf = pw.Font.ttf(fontData);
      return _PdfTheme(
        supportsUnicode: true,
        theme: pw.ThemeData.withFont(
          base: ttf,
          bold: ttf,
          italic: ttf,
          boldItalic: ttf,
        ),
      );
    } catch (_) {
      return _PdfTheme(
        supportsUnicode: false,
        theme: pw.ThemeData.withFont(
          base: pw.Font.helvetica(),
          bold: pw.Font.helveticaBold(),
        ),
      );
    }
  }

  static String _money(bool supportsUnicode, double? value) {
    if (supportsUnicode) {
      return AppCurrencyFormatter.format(value ?? 0, decimals: 2);
    }
    return AppCurrencyFormatter.pdfMoney(value ?? 0, decimals: 2);
  }

  static Future<pw.Document> buildDocument(PartyStatementModel statement) async {
    final pdf = pw.Document();
    final pdfTheme = await _loadPdfTheme();
    final generatedAt = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    final money = (double? v) => _money(pdfTheme.supportsUnicode, v);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),
        theme: pdfTheme.theme,
        build: (context) => [
          pw.Text(
            'Party Statement',
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 4),
          pw.Text(statement.party, style: const pw.TextStyle(fontSize: 14)),
          pw.Text(
            '${statement.role} · ${statement.period}',
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
          ),
          pw.Text(
            'Generated: $generatedAt',
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
          ),
          pw.SizedBox(height: 14),
          _summaryTable(statement.summary, money),
          pw.SizedBox(height: 16),
          pw.Text(
            'Transactions',
            style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          _transactionsTable(statement, money),
        ],
      ),
    );
    return pdf;
  }

  static pw.Widget _summaryTable(
    PartyStatementSummary summary,
    String Function(double?) money,
  ) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.5),
      columnWidths: {
        0: const pw.FlexColumnWidth(2),
        1: const pw.FlexColumnWidth(1.2),
      },
      children: [
        _summaryRow('Opening balance', money(summary.openingBalance)),
        _summaryRow('Total purchases', money(summary.totalPurchases)),
        _summaryRow('Money out', money(summary.moneyOut)),
        _summaryRow('Closing balance', money(summary.closingBalance), bold: true),
        _summaryRow('Total transactions', '${summary.totalTransactions}'),
      ],
    );
  }

  static pw.TableRow _summaryRow(String label, String value, {bool bold = false}) {
    final style = pw.TextStyle(
      fontSize: 10,
      fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
    );
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(6),
          child: pw.Text(label, style: style),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(6),
          child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(value, style: style),
          ),
        ),
      ],
    );
  }

  static pw.Widget _transactionsTable(
    PartyStatementModel statement,
    String Function(double?) money,
  ) {
    final rows = <pw.TableRow>[
      pw.TableRow(
        decoration: const pw.BoxDecoration(color: PdfColors.grey300),
        children: [
          _headerCell('Date'),
          _headerCell('Particulars'),
          _headerCell('Total'),
          _headerCell('Paid'),
          _headerCell('Due'),
          _headerCell('Balance'),
        ],
      ),
    ];

    final opening = statement.openingEntry;
    if (opening != null) {
      rows.add(
        _txnRow(
          opening.date,
          opening.particulars,
          opening.total,
          opening.recPaidAmt,
          opening.due,
          opening.runningBalance,
          money,
        ),
      );
    }

    for (final txn in statement.transactions) {
      rows.add(
        _txnRow(
          txn.date,
          txn.particulars,
          txn.total,
          txn.recPaidAmt,
          txn.due,
          txn.runningBalance,
          money,
        ),
      );
      final items = txn.items;
      if (items != null && items.isNotEmpty) {
        for (final item in items) {
          rows.add(
            pw.TableRow(
              children: [
                _bodyCell(''),
                _bodyCell(
                  '  ${item.item} · ${item.quantity} ${item.unit} @ ${money(item.rate)}',
                  fontSize: 8,
                  color: PdfColors.grey700,
                ),
                _bodyCell(money(item.total), fontSize: 8),
                _bodyCell(''),
                _bodyCell(''),
                _bodyCell(''),
              ],
            ),
          );
        }
      }
    }

    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.5),
      columnWidths: {
        0: const pw.FlexColumnWidth(1.1),
        1: const pw.FlexColumnWidth(2.4),
        2: const pw.FlexColumnWidth(1),
        3: const pw.FlexColumnWidth(1),
        4: const pw.FlexColumnWidth(1),
        5: const pw.FlexColumnWidth(1),
      },
      children: rows,
    );
  }

  static pw.Widget _headerCell(String text) => pw.Padding(
        padding: const pw.EdgeInsets.all(5),
        child: pw.Text(
          text,
          style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
        ),
      );

  static pw.Widget _bodyCell(
    String text, {
    double fontSize = 9,
    PdfColor? color,
    bool bold = false,
  }) =>
      pw.Padding(
        padding: const pw.EdgeInsets.all(5),
        child: pw.Text(
          text,
          style: pw.TextStyle(
            fontSize: fontSize,
            color: color,
            fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      );

  static pw.TableRow _txnRow(
    String date,
    String particulars,
    double total,
    double? paid,
    double? due,
    double balance,
    String Function(double?) money,
  ) {
    return pw.TableRow(
      children: [
        _bodyCell(date),
        _bodyCell(particulars),
        _bodyCell(money(total)),
        _bodyCell(paid != null && paid > 0 ? money(paid) : '—'),
        _bodyCell(due != null && due > 0 ? money(due) : '—'),
        _bodyCell(money(balance), bold: true),
      ],
    );
  }

  static Future<File> saveToDownloads(
    pw.Document pdf,
    String partyName,
  ) async {
    final bytes = await pdf.save();
    final safeName = partyName.replaceAll(RegExp(r'[^\w\-]+'), '_');
    final fileName =
        'party_statement_${safeName}_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.pdf';
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future<void> openPdf(File file) => OpenFile.open(file.path);

  static Future<void> sharePdf(File file, String partyName) async {
    await Share.shareXFiles(
      [XFile(file.path)],
      subject: 'Party statement — $partyName',
    );
  }
}

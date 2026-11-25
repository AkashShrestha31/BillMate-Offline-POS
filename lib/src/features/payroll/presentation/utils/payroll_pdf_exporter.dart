import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/core/services/currency/app_currency_formatter.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../../data/models/response/payroll_model.dart';

class _PdfRow {
  const _PdfRow(this.label, this.value, {this.bold = false});

  final String label;
  final String value;
  final bool bold;
}

class _PdfTheme {
  const _PdfTheme({required this.theme, required this.supportsUnicode});

  final pw.ThemeData theme;
  final bool supportsUnicode;
}

class PayrollPdfExporter {
  PayrollPdfExporter._();

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

  static String _asciiCurrencyFallback() {
    return switch (AppCurrencyFormatter.code) {
      'NPR' => 'Rs',
      'INR' => 'Rs',
      'USD' => r'$',
      'EUR' => 'EUR',
      'GBP' => 'GBP',
      _ => AppCurrencyFormatter.code,
    };
  }

  static Future<pw.Document> buildDocument({
    required PayrollModel payroll,
    required NumberFormat currencyFormat,
  }) async {
    final pdf = pw.Document();
    final pdfTheme = await _loadPdfTheme();
    final generatedAt = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    final money = (double? value) => _money(pdfTheme.supportsUnicode, value);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        theme: pdfTheme.theme,
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Payroll Payslip',
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Generated: $generatedAt',
                  style: const pw.TextStyle(
                    fontSize: 10,
                    color: PdfColors.grey700,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 12),
          _sectionTitle('Employee'),
          pw.SizedBox(height: 6),
          _infoTable([
            _row('Name', payroll.employeeName),
            if (payroll.employeeCode.isNotEmpty)
              _row('Employee code', payroll.employeeCode),
            if (payroll.department.isNotEmpty)
              _row('Department', payroll.department),
            if (payroll.position.isNotEmpty) _row('Position', payroll.position),
            _row('Payroll month', payroll.payrollMonth),
            if (_periodLabel(payroll).isNotEmpty)
              _row('Pay period', _periodLabel(payroll)),
            _row('Payment status', payroll.paymentStatus),
          ]),
          pw.SizedBox(height: 14),
          _sectionTitle('Attendance'),
          pw.SizedBox(height: 6),
          _infoTable([
            _row('Working days', '${payroll.totalWorkingDays ?? 0}'),
            _row('Present', '${payroll.daysPresent ?? 0}'),
            _row('Absent', '${payroll.daysAbsent ?? 0}'),
            _row('Sick days', '${payroll.sickDays ?? 0}'),
            _row('Vacation days', '${payroll.vacationDays ?? 0}'),
          ]),
          pw.SizedBox(height: 14),
          _sectionTitle('Hours'),
          pw.SizedBox(height: 6),
          _infoTable([
            _row(
              'Total hours',
              _hours(payroll.totalHoursWorked),
            ),
            _row('Regular hours', _hours(payroll.regularHours)),
            _row('Overtime hours', _hours(payroll.overtimeHours)),
          ]),
          pw.SizedBox(height: 14),
          _sectionTitle('Earnings'),
          pw.SizedBox(height: 6),
          _infoTable([
            _row('Basic salary', money(payroll.basicSalary)),
            _row('Overtime pay', money(payroll.overtimePay)),
            _row('Allowances', money(payroll.allowances)),
            _row('Bonus', money(payroll.bonus)),
            _row('Gross pay', money(payroll.grossPay), bold: true),
          ]),
          pw.SizedBox(height: 14),
          _sectionTitle('Deductions'),
          pw.SizedBox(height: 6),
          _infoTable([
            _row('Tax', money(payroll.taxDeduction)),
            _row('Insurance', money(payroll.insuranceDeduction)),
            _row('Provident fund', money(payroll.providentFund)),
            _row('Other', money(payroll.otherDeductions)),
            _row(
              'Total deductions',
              money(payroll.totalDeductions),
              bold: true,
            ),
          ]),
          pw.SizedBox(height: 16),
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(14),
            decoration: pw.BoxDecoration(
              color: PdfColors.blue50,
              borderRadius: pw.BorderRadius.circular(8),
              border: pw.Border.all(color: PdfColors.blue200),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'NET PAY',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  money(payroll.netPay),
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue800,
                  ),
                ),
              ],
            ),
          ),
          if (payroll.paymentStatus == 'PAID') ...[
            pw.SizedBox(height: 14),
            _sectionTitle('Payment'),
            pw.SizedBox(height: 6),
            _infoTable([
              _row('Payment date', payroll.paymentDate ?? '—'),
              _row('Payment method', payroll.paymentMethod),
              if (payroll.bankReference != null && payroll.bankReference!.isNotEmpty)
                _row('Bank reference', payroll.bankReference!),
              if (payroll.paidBy != null && payroll.paidBy!.isNotEmpty)
                _row('Paid by', payroll.paidBy!),
            ]),
          ],
          if (payroll.notes != null && payroll.notes!.trim().isNotEmpty) ...[
            pw.SizedBox(height: 14),
            _sectionTitle('Notes'),
            pw.SizedBox(height: 6),
            pw.Text(payroll.notes!.trim()),
          ],
          if (payroll.created.isNotEmpty ||
              (payroll.generatedBy != null && payroll.generatedBy!.isNotEmpty)) ...[
            pw.SizedBox(height: 14),
            _sectionTitle('Record'),
            pw.SizedBox(height: 6),
            _infoTable([
              if (payroll.created.isNotEmpty)
                _row('Created', _formatDateTime(payroll.created)),
              if (payroll.generatedBy != null && payroll.generatedBy!.isNotEmpty)
                _row('Generated by', payroll.generatedBy!),
              if (payroll.approvedBy != null && payroll.approvedBy!.isNotEmpty)
                _row('Approved by', payroll.approvedBy!),
            ]),
          ],
        ],
      ),
    );

    return pdf;
  }

  static Future<File> saveToFile({
    required pw.Document document,
    required PayrollModel payroll,
  }) async {
    final bytes = await document.save();
    final dir = await getTemporaryDirectory();
    final safeName = payroll.employeeName
        .trim()
        .replaceAll(RegExp(r'[^\w.-]+'), '_')
        .replaceAll(RegExp(r'_+'), '_');
    final file = File(
      '${dir.path}/payroll_${safeName}_${payroll.payrollMonth}_${payroll.id}.pdf',
    );
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future<File> exportToFile({
    required PayrollModel payroll,
    required NumberFormat currencyFormat,
  }) async {
    final document = await buildDocument(
      payroll: payroll,
      currencyFormat: currencyFormat,
    );
    return saveToFile(document: document, payroll: payroll);
  }

  static Future<void> openPdf({
    required PayrollModel payroll,
    required NumberFormat currencyFormat,
  }) async {
    final file = await exportToFile(
      payroll: payroll,
      currencyFormat: currencyFormat,
    );
    await OpenFile.open(file.path);
  }

  static Future<void> sharePdf({
    required PayrollModel payroll,
    required NumberFormat currencyFormat,
  }) async {
    final file = await exportToFile(
      payroll: payroll,
      currencyFormat: currencyFormat,
    );
    await Share.shareXFiles(
      [XFile(file.path)],
      subject: 'Payroll - ${payroll.employeeName} (${payroll.payrollMonth})',
    );
  }

  static pw.Widget _sectionTitle(String text) {
    return pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: 12,
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.blue800,
      ),
    );
  }

  static _PdfRow _row(String label, String value, {bool bold = false}) =>
      _PdfRow(label, value, bold: bold);

  static pw.Widget _infoTable(List<_PdfRow> rows) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
      columnWidths: {
        0: const pw.FlexColumnWidth(2),
        1: const pw.FlexColumnWidth(3),
      },
      children: rows
          .map(
            (r) => pw.TableRow(
              children: [
                _cell(r.label, isHeader: true),
                _cell(r.value, bold: r.bold),
              ],
            ),
          )
          .toList(),
    );
  }

  static pw.Widget _cell(String text, {bool isHeader = false, bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: isHeader ? 9 : 10,
          fontWeight: isHeader || bold ? pw.FontWeight.bold : pw.FontWeight.normal,
          color: isHeader ? PdfColors.grey700 : PdfColors.black,
        ),
      ),
    );
  }

  static String _money(bool supportsUnicode, double? value) {
    final symbol =
        supportsUnicode ? currencySymbol : _asciiCurrencyFallback();
    final amount = value ?? 0;
    final formatted = NumberFormat('#,##0.00').format(amount.abs());
    final text = '$symbol $formatted';
    return amount < 0 ? '-$text' : text;
  }

  static String _hours(double? value) {
    if (value == null) return '0 hrs';
    return '${value.toStringAsFixed(1)} hrs';
  }

  static String _periodLabel(PayrollModel payroll) {
    try {
      if (payroll.payPeriodStart.isEmpty || payroll.payPeriodEnd.isEmpty) {
        return '';
      }
      final start = DateTime.parse(payroll.payPeriodStart);
      final end = DateTime.parse(payroll.payPeriodEnd);
      return '${DateFormat('MMM d').format(start)} – ${DateFormat('MMM d, y').format(end)}';
    } catch (_) {
      return '';
    }
  }

  static String _formatDateTime(String raw) {
    try {
      return DateFormat('MMM d, yyyy h:mm a').format(DateTime.parse(raw));
    } catch (_) {
      return raw;
    }
  }
}

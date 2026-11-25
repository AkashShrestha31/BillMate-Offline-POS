import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:hotel/constants.dart';
import 'package:hotel/src/core/helpers/app_brand_name_pdf.dart';
import 'package:hotel/src/core/l10n/default_l10n.dart';
import 'package:hotel/src/features/employee/data/models/response/advance_analysis_response.dart';
import 'package:hotel/src/core/l10n/platform_app_localizations.dart';
import 'package:hotel/src/core/services/display_precision/app_money_format.dart';

class EmployeeAdvancePdfExportService {
  static Future<File> generateRecipientAdvancePdf({
    required AdvanceAnalysisData recipientData,
    required String startDate,
    required String endDate,
  }) async {
    try {
      print('🔍 Starting PDF generation...');

      final pdf = pw.Document();
      final formatter = AppMoneyFormat.currency(currencySymbol);
      final dateFormatter = DateFormat('MMM dd, yyyy');
      final now = DateTime.now();
      final reportDate = DateFormat('MMMM dd, yyyy').format(now);

      // Extract employee name
      String employeeName = 'Unknown Employee';
      try {
        if (recipientData.employeeName.isNotEmpty) {
          employeeName = recipientData.employeeName;
        }
      } catch (e) {
        print('⚠️ Error extracting employee name: $e');
      }
      print('✓ Employee name: $employeeName');

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(40),
          footer: (pw.Context context) {
            return _buildFooter(context);
          },
          build: (pw.Context context) {
            return [
              // Header Section
              _buildHeader(employeeName, recipientData.employeeCode, recipientData.department, reportDate),
              pw.SizedBox(height: 20),

              // Period Information
              _buildPeriodInfo(startDate, endDate),
              pw.SizedBox(height: 20),

              // Summary Cards
              _buildSummarySection(recipientData, formatter),
              pw.SizedBox(height: 25),

              // Invoice Details Table
              _buildInvoiceTable(recipientData, formatter, dateFormatter),
            ];
          },
        ),
      );

      // Save the PDF
      print('💾 Saving PDF...');
      final output = await getTemporaryDirectory();
      final fileName =
          'Advance_${employeeName.replaceAll(' ', '_')}_${DateFormat('yyyyMMdd_HHmmss').format(now)}.pdf';
      final file = File('${output.path}/$fileName');

      final pdfBytes = await pdf.save();
      await file.writeAsBytes(pdfBytes);

      print('✅ PDF saved successfully: ${file.path}');
      return file;

    } catch (e, stackTrace) {
      print('❌ PDF Generation Error: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  static pw.Widget _buildHeader(String employeeName, String employeeCode, String department, String reportDate) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: PdfColors.blue700,
            width: 3,
          ),
        ),
      ),
      padding: const pw.EdgeInsets.only(bottom: 15),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'ADVANCE PAYMENT REPORT',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900,
                    ),
                  ),
                  pw.SizedBox(height: 5),
                  AppBrandNamePdf.text(
                    style: const pw.TextStyle(
                      fontSize: 12,
                      color: PdfColors.grey700,
                    ),
                    trackColor: PdfColors.blue900,
                  ),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    'Generated On',
                    style: pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey600,
                    ),
                  ),
                  pw.Text(
                    reportDate,
                    style: pw.TextStyle(
                      fontSize: 11,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.grey800,
                    ),
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 15),
          pw.Container(
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              color: PdfColors.blue50,
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text(
                      'Employee: ',
                      style: pw.TextStyle(
                        fontSize: 14,
                        color: PdfColors.grey700,
                      ),
                    ),
                    pw.Text(
                      employeeName,
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.blue900,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 4),
                pw.Row(
                  children: [
                    pw.Text(
                      'Employee Code: ',
                      style: pw.TextStyle(
                        fontSize: 11,
                        color: PdfColors.grey600,
                      ),
                    ),
                    pw.Text(
                      employeeCode,
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.grey800,
                      ),
                    ),
                    pw.SizedBox(width: 20),
                    pw.Text(
                      'Department: ',
                      style: pw.TextStyle(
                        fontSize: 11,
                        color: PdfColors.grey600,
                      ),
                    ),
                    pw.Text(
                      department,
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.grey800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildPeriodInfo(String startDate, String endDate) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.grey300),
      ),
      child: pw.Row(
        children: [
          pw.Text(
            'Analysis Period: ',
            style: pw.TextStyle(
              fontSize: 11,
              color: PdfColors.grey700,
            ),
          ),
          pw.Text(
            '$startDate to $endDate',
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.grey900,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildSummarySection(
      AdvanceAnalysisData recipientData,
      NumberFormat formatter,
      ) {
    print('📊 Building summary section...');

    // Calculate outstanding amount with extensive null safety
    double totalOutstanding = 0;
    try {
      for (var invoice in recipientData.invoices) {
        try {
          String outstandingStr = invoice.outstandingAmount;
          if (outstandingStr.isNotEmpty) {
            double? parsed = double.tryParse(outstandingStr);
            if (parsed != null) {
              totalOutstanding += parsed;
            }
          }
        } catch (e) {
          print('⚠️ Error parsing outstanding for invoice: $e');
        }
      }
    } catch (e) {
      print('⚠️ Error calculating total outstanding: $e');
    }

    // Get total amount
    double totalAmount = recipientData.totalAmount;

    // Get invoice count
    int invoiceCount = recipientData.invoiceCount;

    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          // Header
          pw.Container(
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              color: PdfColors.blue700,
              borderRadius: const pw.BorderRadius.only(
                topLeft: pw.Radius.circular(8),
                topRight: pw.Radius.circular(8),
              ),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'ADVANCE SUMMARY',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                  ),
                ),
              ],
            ),
          ),
          // Summary Grid
          pw.Container(
            padding: const pw.EdgeInsets.all(16),
            child: pw.Row(
              children: [
                pw.Expanded(
                  child: _buildSummaryCard(
                    'Total Advances',
                    formatter.format(totalAmount),
                    PdfColors.green700,
                  ),
                ),
                pw.SizedBox(width: 12),
                pw.Expanded(
                  child: _buildSummaryCard(
                    'Total Invoices',
                    invoiceCount.toString(),
                    PdfColors.blue700,
                  ),
                ),
                pw.SizedBox(width: 12),
                pw.Expanded(
                  child: _buildSummaryCard(
                    'Unpaid',
                    formatter.format(totalOutstanding),
                    PdfColors.orange700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildSummaryCard(
      String label,
      String value,
      PdfColor color,
      ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(6),
        border: pw.Border.all(color: PdfColors.grey300),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: 9,
              color: PdfColors.grey700,
            ),
            textAlign: pw.TextAlign.center,
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 13,
              fontWeight: pw.FontWeight.bold,
              color: color,
            ),
            textAlign: pw.TextAlign.center,
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildInvoiceTable(
      AdvanceAnalysisData recipientData,
      NumberFormat formatter,
      DateFormat dateFormatter,
      ) {
    print('📋 Building invoice table...');

    // Get invoices
    List<Invoice> invoices = recipientData.invoices;
    print('✓ Found ${invoices.length} invoices');

    // Build table rows with extensive error handling
    List<pw.TableRow> dataRows = [];
    double totalAmount = 0;
    double totalOutstanding = 0;

    for (int i = 0; i < invoices.length; i++) {
      try {
        final invoice = invoices[i];
        print('  Processing invoice ${i + 1}...');

        // Extract invoice name
        String invoiceName = invoice.invoiceName;

        // Format date
        String invoiceDate = dateFormatter.format(invoice.invoiceDate);

        // Parse grand total
        double grandTotal = double.tryParse(invoice.grandTotal) ?? 0.0;

        // Parse outstanding amount
        double outstandingAmount = double.tryParse(invoice.outstandingAmount) ?? 0.0;

        totalAmount += grandTotal;
        totalOutstanding += outstandingAmount;

        final status = outstandingAmount == 0 ? 'Paid' : 'Unpaid';
        final statusColor = status == 'Paid' ? PdfColors.green700 : PdfColors.orange700;

        dataRows.add(
          pw.TableRow(
            children: [
              _buildTableCell(invoiceName),
              _buildTableCell(invoiceDate),
              _buildTableCell(formatter.format(grandTotal)),
              _buildTableCell(
                formatter.format(outstandingAmount),
                color: outstandingAmount > 0 ? PdfColors.orange700 : PdfColors.grey800,
              ),
              _buildStatusCell(status, statusColor),
            ],
          ),
        );

        print('    ✓ Invoice processed successfully');
      } catch (e) {
        print('    ❌ Error processing invoice ${i + 1}: $e');
      }
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'INVOICE DETAILS',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.grey900,
          ),
        ),
        pw.SizedBox(height: 12),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          columnWidths: {
            0: const pw.FlexColumnWidth(1.5),
            1: const pw.FlexColumnWidth(1),
            2: const pw.FlexColumnWidth(1),
            3: const pw.FlexColumnWidth(1),
            4: const pw.FlexColumnWidth(1),
          },
          children: [
            // Header Row
            pw.TableRow(
              decoration: const pw.BoxDecoration(
                color: PdfColors.grey200,
              ),
              children: [
                _buildTableHeader('Invoice'),
                _buildTableHeader('Date'),
                _buildTableHeader('Amount'),
                _buildTableHeader('Unpaid'),
                _buildTableHeader('Status'),
              ],
            ),
            // Data Rows
            ...dataRows,
            // Total Row
            pw.TableRow(
              decoration: const pw.BoxDecoration(
                color: PdfColors.blue50,
              ),
              children: [
                _buildTableCell('TOTAL', isBold: true),
                _buildTableCell(''),
                _buildTableCell(
                  formatter.format(totalAmount),
                  isBold: true,
                  color: PdfColors.green700,
                ),
                _buildTableCell(
                  formatter.format(totalOutstanding),
                  isBold: true,
                  color: PdfColors.orange700,
                ),
                _buildTableCell(''),
              ],
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildTableHeader(String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 9,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.grey900,
        ),
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  static pw.Widget _buildTableCell(
      String text, {
        bool isBold = false,
        PdfColor? color,
      }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 8,
          fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
          color: color ?? PdfColors.grey800,
        ),
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  static pw.Widget _buildStatusCell(String status, PdfColor color) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      alignment: pw.Alignment.center,
      child: pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: pw.BoxDecoration(
          color: PdfColors.grey100,
          borderRadius: pw.BorderRadius.circular(10),
          border: pw.Border.all(color: color),
        ),
        child: pw.Text(
          status,
          style: pw.TextStyle(
            fontSize: 7,
            fontWeight: pw.FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }

  static pw.Widget _buildFooter(pw.Context context) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border(
          top: pw.BorderSide(
            color: PdfColors.grey300,
            width: 1,
          ),
        ),
      ),
      padding: const pw.EdgeInsets.only(top: 15),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          AppBrandNamePdf.replaceInText(
            text: defaultL10n.generatedByApp(defaultL10n.platformAppDisplayName),
            brandName: defaultL10n.platformAppDisplayName,
            style: pw.TextStyle(
              fontSize: 8,
              color: PdfColors.grey600,
              fontStyle: pw.FontStyle.italic,
            ),
            trackColor: PdfColors.grey600,
          ),
          pw.Text(
            'Page ${context.pageNumber} of ${context.pagesCount}',
            style: pw.TextStyle(
              fontSize: 8,
              color: PdfColors.grey600,
            ),
          ),
        ],
      ),
    );
  }
}
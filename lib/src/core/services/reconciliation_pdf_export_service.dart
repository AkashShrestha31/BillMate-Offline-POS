import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart' as ic;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:hotel/src/core/services/currency/app_currency_formatter.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/reconciliation_report_response.dart';

class ReconciliationPdfExportService {
  /// Export reconciliation report to PDF
  static Future<File> exportToPdf({
    required ReconciliationReportResponse data,
    String? filterType,
  }) async {
    final pdf = pw.Document();

    // Filter details if needed
    final details = filterType == null || filterType == 'All'
        ? data.reconciliationDetails
        : data.reconciliationDetails
        .where((detail) => detail.status == filterType)
        .toList();

    // Add pages
    _addCoverPage(pdf, data);
    _addSummaryPage(pdf, data);
    _addDetailsPages(pdf, details, data);
    _addFinalSummaryPage(pdf, data, details, filterType);

    // Save PDF
    final output = await _getOutputFile();
    await output.writeAsBytes(await pdf.save());
    return output;
  }

  /// Add final summary page
  static void _addFinalSummaryPage(
      pw.Document pdf,
      ReconciliationReportResponse data,
      List<ReconciliationReportDetail> exportedDetails,
      String? filterType,
      ) {
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
                'Export Complete',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Container(
                padding: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  color: PdfColors.blue50,
                  borderRadius: pw.BorderRadius.circular(12),
                  border: pw.Border.all(color: PdfColors.blue200),
                ),
                child: pw.Column(
                  children: [
                    _buildSummaryInfoRow(
                      'Total Items in Report',
                      data.reconciliationDetails.length.toString(),
                    ),
                    pw.SizedBox(height: 10),
                    _buildSummaryInfoRow(
                      'Items Exported',
                      exportedDetails.length.toString(),
                    ),
                    if (filterType != null && filterType != 'All') ...[
                      pw.SizedBox(height: 10),
                      _buildSummaryInfoRow(
                        'Filter Applied',
                        filterType,
                      ),
                    ],
                    pw.SizedBox(height: 10),
                    pw.Divider(color: PdfColors.blue300),
                    pw.SizedBox(height: 10),
                    _buildSummaryInfoRow(
                      'Short Stock Items',
                      data.summary.shortStockItems.toString(),
                      valueColor: PdfColors.red,
                    ),
                    pw.SizedBox(height: 8),
                    _buildSummaryInfoRow(
                      'Over Stock Items',
                      data.summary.overStockItems.toString(),
                      valueColor: PdfColors.green,
                    ),
                    pw.SizedBox(height: 8),
                    _buildSummaryInfoRow(
                      'Matching Items',
                      data.summary.matchingItems.toString(),
                      valueColor: PdfColors.orange,
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 30),
              pw.Text(
                'All ${exportedDetails.length} items have been included in this PDF export',
                style: pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.grey700,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Generated: ${DateTime.now().toString().split('.')[0]}',
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build summary info row
  static pw.Widget _buildSummaryInfoRow(
      String label,
      String value, {
        PdfColor? valueColor,
      }) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.normal,
          ),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: valueColor ?? PdfColors.black,
          ),
        ),
      ],
    );
  }

  /// Get output file path
  static Future<File> _getOutputFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final path = '${directory.path}/reconciliation_report_$timestamp.pdf';
    return File(path);
  }

  /// Add cover page
  static void _addCoverPage(
      pw.Document pdf,
      ReconciliationReportResponse data,
      ) {
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [

              pw.Text(
                'Stock Reconciliation Report',
                style: pw.TextStyle(
                  fontSize: 28,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: pw.BoxDecoration(
                  color: data.success ? PdfColors.green : PdfColors.red,
                  borderRadius: pw.BorderRadius.circular(20),
                ),
                child: pw.Text(
                  data.success ? 'Success' : 'Failed',
                  style: const pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              pw.SizedBox(height: 40),
              _buildInfoBox('Report Date', data.reportDate),
              pw.SizedBox(height: 10),
              _buildInfoBox('Period', data.period),
              pw.SizedBox(height: 10),
              _buildInfoBox('Method', data.reconciliationMethod),
              pw.SizedBox(height: 10),
              _buildInfoBox('Starting Date', data.startingStockDate),
              pw.SizedBox(height: 10),
              _buildInfoBox('Current Date', data.currentStockDate),
              pw.Spacer(),
              pw.Text(
                'Generated on ${DateTime.now().toString().split('.')[0]}',
                style: pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build info box widget
  static pw.Widget _buildInfoBox(
      String label,
      String value,
      ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: 12,
              color: PdfColors.grey700,
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Add summary page
  static void _addSummaryPage(
      pw.Document pdf,
      ReconciliationReportResponse data,
      ) {
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader('Summary Overview'),
            pw.SizedBox(height: 20),

            // Summary cards in grid
            pw.Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildSummaryCard(
                  'Total Items',
                  data.summary.totalItems.toString(),
                  PdfColors.blue,
                ),
                _buildSummaryCard(
                  'Short Stock',
                  data.summary.shortStockItems.toString(),
                  PdfColors.red,
                ),
                _buildSummaryCard(
                  'Over Stock',
                  data.summary.overStockItems.toString(),
                  PdfColors.green,
                ),
                _buildSummaryCard(
                  'Matching',
                  data.summary.matchingItems.toString(),
                  PdfColors.orange,
                ),
              ],
            ),

            pw.SizedBox(height: 30),

            // Variance section
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                color: data.summary.totalVarianceValue < 0
                    ? PdfColors.red50
                    : PdfColors.green50,
                borderRadius: pw.BorderRadius.circular(8),
                border: pw.Border.all(
                  color: data.summary.totalVarianceValue < 0
                      ? PdfColors.red
                      : PdfColors.green,
                ),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Total Variance',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    '${data.summary.totalVarianceValue < 0 ? '-' : '+'} ${AppCurrencyFormatter.pdfMoney(data.summary.totalVarianceValue.abs())}',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: data.summary.totalVarianceValue < 0
                          ? PdfColors.red
                          : PdfColors.green,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    data.summary.totalVarianceValue < 0 ? 'Loss' : 'Gain',
                    style: pw.TextStyle(
                      fontSize: 12,
                      color: PdfColors.grey700,
                    ),
                  ),
                ],
              ),
            ),

            pw.SizedBox(height: 20),

            // Variance breakdown table
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                _buildTableRow(
                  'Over Stock Value',
                  AppCurrencyFormatter.pdfMoney(data.summary.totalOverValue),
                  isHeader: false,
                  valueColor: PdfColors.green,
                ),
                _buildTableRow(
                  'Short Stock Value',
                  AppCurrencyFormatter.pdfMoney(data.summary.totalShortValue),
                  isHeader: false,
                  valueColor: PdfColors.red,
                ),
              ],
            ),

            pw.Spacer(),

            // Calculation explanation
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColors.blue50,
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Calculation Formula',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    data.calculationExplanation,
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Add details pages
  static void _addDetailsPages(
      pw.Document pdf,
      List<ReconciliationReportDetail> details,
      ReconciliationReportResponse data,
      ) {
    if (details.isEmpty) return;

    const itemsPerPage = 6; // Reduced to fit better on page
    final totalPages = (details.length / itemsPerPage).ceil();

    for (int pageIndex = 0; pageIndex < totalPages; pageIndex++) {
      final startIndex = pageIndex * itemsPerPage;
      final endIndex = (startIndex + itemsPerPage > details.length)
          ? details.length
          : startIndex + itemsPerPage;
      final pageDetails = details.sublist(startIndex, endIndex);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildHeader(
                'Item Details (Page ${pageIndex + 1} of $totalPages)',
              ),
              pw.SizedBox(height: 15),

              // Items list - Using Expanded to ensure all items are visible
              pw.Expanded(
                child: pw.ListView(
                  children: pageDetails
                      .map((detail) => pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 12),
                    child: _buildDetailItem(detail),
                  ))
                      .toList(),
                ),
              ),

              pw.SizedBox(height: 10),

              // Footer
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Page ${pageIndex + 1} of $totalPages | Items ${startIndex + 1}-$endIndex of ${details.length}',
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey700,
                    ),
                  ),
                  pw.Text(
                    data.reportDate,
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  /// Build header widget
  static pw.Widget _buildHeader(String title) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 10),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColors.grey300, width: 2),
        ),
      ),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 20,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  /// Build summary card
  static pw.Widget _buildSummaryCard(
      String label,
      String value,
      PdfColor color,
      ) {
    return pw.Container(
      width: 120,
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: color),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
              color: color,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            label,
            style: const pw.TextStyle(
              fontSize: 10,
              color: PdfColors.grey700,
            ),
          ),
        ],
      ),
    );
  }

  /// Build detail item
  static pw.Widget _buildDetailItem(
      ReconciliationReportDetail detail,
      ) {
    final statusColor = _getStatusColor(detail.status);

    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Header
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      detail.item,
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 2),
                    pw.Text(
                      detail.location,
                      style: const pw.TextStyle(
                        fontSize: 8,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 3,
                ),
                decoration: pw.BoxDecoration(
                  color: statusColor,
                  borderRadius: pw.BorderRadius.circular(10),
                ),
                child: pw.Text(
                  detail.status,
                  style: const pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 8,
                  ),
                ),
              ),
            ],
          ),

          pw.SizedBox(height: 6),
          pw.Divider(color: PdfColors.grey300, height: 1),
          pw.SizedBox(height: 6),

          // Details table - Compact version
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              // Left column
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _buildCompactDetailRow(
                      'Start',
                      detail.startingStock.toString(),
                    ),
                    _buildCompactDetailRow(
                      'Purchase',
                      detail.totalPurchases.toString(),
                    ),
                    _buildCompactDetailRow(
                      'Sales',
                      detail.totalSales.toString(),
                    ),
                    _buildCompactDetailRow(
                      'Stock In',
                      detail.totalStockIn.toString(),
                    ),
                    _buildCompactDetailRow(
                      'Stock Out',
                      detail.totalStockOut.toString(),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(width: 10),
              // Right column
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _buildCompactDetailRow(
                      'Expected',
                      detail.expectedStock.toString(),
                      isBold: true,
                    ),
                    _buildCompactDetailRow(
                      'Actual',
                      detail.actualStock.toString(),
                      isBold: true,
                    ),
                    _buildCompactDetailRow(
                      'Variance',
                      '${detail.variance > 0 ? '+' : ''}${detail.variance}',
                      isBold: true,
                      valueColor: statusColor,
                    ),
                    _buildCompactDetailRow(
                      'Value',
                      AppCurrencyFormatter.pdfMoney(detail.varianceValue.abs()),
                      isBold: true,
                      valueColor: statusColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build compact detail row for more items per page
  static pw.Widget _buildCompactDetailRow(
      String label,
      String value, {
        bool isBold = false,
        PdfColor? valueColor,
      }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 1.5),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: 8,
              color: PdfColors.grey700,
              fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 8,
              fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
              color: valueColor ?? PdfColors.black,
            ),
          ),
        ],
      ),
    );
  }

  /// Build detail row
  static pw.TableRow _buildDetailRow(
      String label,
      String value, {
        bool isBold = false,
        PdfColor? valueColor,
      }) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 2),
          child: pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: 9,
              color: PdfColors.grey700,
              fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 2),
          child: pw.Text(
            value,
            textAlign: pw.TextAlign.right,
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
              color: valueColor ?? PdfColors.black,
            ),
          ),
        ),
      ],
    );
  }

  /// Build table row
  static pw.TableRow _buildTableRow(
      String label,
      String value, {
        bool isHeader = false,
        PdfColor? valueColor,
      }) {
    return pw.TableRow(
      decoration:
      isHeader ? const pw.BoxDecoration(color: PdfColors.grey300) : null,
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(
            value,
            textAlign: pw.TextAlign.right,
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
              color: valueColor ?? PdfColors.black,
            ),
          ),
        ),
      ],
    );
  }

  /// Get status color
  static PdfColor _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'short':
        return PdfColors.red;
      case 'over':
        return PdfColors.green;
      case 'matching':
        return PdfColors.orange;
      default:
        return PdfColors.blue;
    }
  }

  /// Open PDF file
  static Future<void> openPdf(File file) async {
    await OpenFile.open(file.path);
  }

  /// Share PDF file
  static Future<void> sharePdf(File file) async {
    // Implement share functionality using share_plus package
    // Share.shareXFiles([XFile(file.path)], text: 'Reconciliation Report');
  }
}
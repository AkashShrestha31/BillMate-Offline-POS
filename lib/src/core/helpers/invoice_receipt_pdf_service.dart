import 'dart:io';
import 'dart:typed_data';
import 'package:hotel/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel/src/core/helpers/app_brand_name_pdf.dart';
import 'package:hotel/src/core/widget/estimate_invoice_sheet.dart';
import 'package:hotel/src/core/l10n/default_l10n.dart';
import 'package:hotel/src/core/services/currency/app_currency_formatter.dart';
import 'package:hotel/src/core/services/display_precision/app_money_format.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// Professional invoice-style receipt (PDF / PNG).
class InvoiceReceiptPdfService {
  InvoiceReceiptPdfService._();

  static pw.ThemeData? _unicodeTheme;

  /// Noto covers Latin and Devanagari. Built-in Helvetica drops those
  /// characters and prints a Unicode warning while the file is saved.
  static Future<pw.ThemeData> _pdfTheme() async {
    final cached = _unicodeTheme;
    if (cached != null) return cached;
    final data = await rootBundle.load('assets/fonts/NotoSansDevanagari-Bold.ttf');
    final font = pw.Font.ttf(data);
    final theme = pw.ThemeData.withFont(
      base: font,
      bold: font,
      italic: font,
      boldItalic: font,
    );
    _unicodeTheme = theme;
    return theme;
  }

  /// Body copy and values stay black; [accentColor] is for bars, logo, and brand accents.
  static const PdfColor _textBlack = PdfColors.black;
  static const PdfColor _white = PdfColors.white;
  static const PdfColor _zebra = PdfColor.fromInt(0xFFF5F5F5);

  static PdfColor _accentPdf(Color accent) => PdfColor(accent.r, accent.g, accent.b);

  static Future<Uint8List> buildPdfBytes({
    required InvoiceItem invoice,
    required InvoiceType invoiceType,
    required Color accentColor,
  }) async {
    final theme = await _pdfTheme();
    final doc = pw.Document();
    _appendInvoiceReceiptPage(
      doc,
      invoice,
      invoiceType,
      _accentPdf(accentColor),
      theme,
    );
    return doc.save();
  }

  /// One multi-page PDF: same receipt layout as [buildPdfBytes] per invoice.
  static Future<Uint8List> buildBulkPdfBytes({
    required List<InvoiceItem> invoices,
    required InvoiceType invoiceType,
    required Color accentColor,
  }) async {
    if (invoices.isEmpty) {
      throw ArgumentError.value(invoices, 'invoices', 'must not be empty');
    }
    final theme = await _pdfTheme();
    final pdf = pw.Document();
    final accent = _accentPdf(accentColor);
    for (final invoice in invoices) {
      _appendInvoiceReceiptPage(pdf, invoice, invoiceType, accent, theme);
    }
    return pdf.save();
  }

  static Future<File> exportToPdf({
    required InvoiceItem invoice,
    required InvoiceType invoiceType,
    required Color accentColor,
  }) async {
    final bytes = await buildPdfBytes(
      invoice: invoice,
      invoiceType: invoiceType,
      accentColor: accentColor,
    );
    final dir = await getTemporaryDirectory();
    final now = DateTime.now();
    final base =
        (invoice.invoiceName ?? 'receipt').replaceAll(RegExp(r'[^\w\-]+'), '_');
    final file = File(
      '${dir.path}/${base}_${DateFormat('yyyyMMdd_HHmmss').format(now)}.pdf',
    );
    await file.writeAsBytes(bytes);
    return file;
  }

  /// Renders the first PDF page to a PNG (same layout as PDF export).
  static Future<File> exportToPngFile({
    required InvoiceItem invoice,
    required InvoiceType invoiceType,
    required Color accentColor,
  }) async {
    final bytes = await buildPdfBytes(
      invoice: invoice,
      invoiceType: invoiceType,
      accentColor: accentColor,
    );
    Uint8List? png;
    await for (final page in Printing.raster(bytes, pages: [0], dpi: 180)) {
      png = await page.toPng();
      break;
    }
    if (png == null) {
      throw StateError('Could not rasterize receipt PDF');
    }
    final dir = await getTemporaryDirectory();
    final now = DateTime.now();
    final base =
        (invoice.invoiceName ?? 'receipt').replaceAll(RegExp(r'[^\w\-]+'), '_');
    final file = File(
      '${dir.path}/${base}_${DateFormat('yyyyMMdd_HHmmss').format(now)}.png',
    );
    await file.writeAsBytes(png);
    return file;
  }

  static NumberFormat _pdfCurrencyFormat() =>
      AppMoneyFormat.currency(AppCurrencyFormatter.pdfSymbol());

  static void _appendInvoiceReceiptPage(
    pw.Document pdf,
    InvoiceItem invoice,
    InvoiceType invoiceType,
    PdfColor accent,
    pw.ThemeData theme,
  ) {
    final currency = _pdfCurrencyFormat();
    final dateFmt = DateFormat('d MMM, yyyy');
    final now = DateTime.now();

    String fmtDate(String? d) {
      if (d == null || d.isEmpty) return '-';
      try {
        return dateFmt.format(DateTime.parse(d));
      } catch (_) {
        return d;
      }
    }

    final title = invoiceType == InvoiceType.sales ? 'INVOICE' : 'PURCHASE INVOICE';
    final items = invoice.items ?? [];
    final lineSum = items.fold<double>(
      0,
      (s, e) => s + (e.amount ?? 0),
    );
    final discount = invoice.totalDiscount ?? invoice.discountAmount ?? 0;
    final grandTotal = invoice.grandTotal ?? lineSum;
    final baseTotal = invoice.baseGrandTotal;
    final taxInfo = estimateTaxFromInvoiceTotals(
      baseGrandTotal: baseTotal,
      grandTotal: grandTotal,
      subTotal: lineSum,
      discountAmount: discount.toDouble(),
    );
    final taxAmount = taxInfo?.taxAmount ??
        (baseTotal != null
            ? (grandTotal - baseTotal).clamp(0.0, double.infinity)
            : (grandTotal - (lineSum - discount)).clamp(0.0, double.infinity));
    final taxLabel = taxInfo?.taxLabel ?? 'Tax';
    final paid = invoice.payment
            ?.fold<double>(0.0, (s, p) => s + (p.amount ?? 0)) ??
        0.0;
    final totalReturned = invoice.totalReturnedAgainst ?? 0;
    final netPayable = invoice.netPayable;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 48, vertical: 44),
        theme: theme,
        build: (ctx) => [
          _headerRow(title, accent),
          pw.SizedBox(height: 28),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                flex: 5,
                child: _billedToBlock(invoice.party ?? '-'),
              ),
              pw.SizedBox(width: 24),
              pw.Expanded(
                flex: 4,
                child: _invoiceMetaBlock(
                  dateStr: fmtDate(invoice.date),
                  invoiceNo: invoice.invoiceName ?? '-',
                  status: invoice.status,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 28),
          _lineItemsTable(items, currency, accent),
          if (totalReturned > 0.005) ...[
            pw.SizedBox(height: 12),
            pw.Text(
              'Returned items',
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                color: _textBlack,
              ),
            ),
            pw.SizedBox(height: 6),
            ..._returnedItemRows(items, currency),
          ],
          pw.SizedBox(height: 20),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.SizedBox(
              width: 220,
              child: _totalsBlock(
                currency: currency,
                subtotal: lineSum,
                discount: discount,
                tax: taxAmount > 0.005 ? taxAmount : null,
                taxLabel: taxLabel,
                grandTotal: grandTotal,
                totalReturned: totalReturned > 0.005 ? totalReturned : null,
                netPayable: netPayable,
                accent: accent,
              ),
            ),
          ),
          pw.SizedBox(height: 28),
          pw.Divider(color: PdfColors.grey400, thickness: 0.8),
          pw.SizedBox(height: 14),
          _paymentInformationBlock(invoice, currency, paid, accent),
          pw.SizedBox(height: 20),
          pw.Text(
            'Generated ${DateFormat('MMM dd, yyyy, HH:mm').format(now)}',
            style: pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
          ),
        ],
      ),
    );
  }

  static pw.Widget _headerRow(String title, PdfColor accent) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 28,
            fontWeight: pw.FontWeight.bold,
            color: _textBlack,
            letterSpacing: 0.5,
          ),
        ),
        _logoMark(accent),
      ],
    );
  }

  /// Minimal mark similar to reference: two parallel diagonal bars.
  static pw.Widget _logoMark(PdfColor accent) {
    return pw.SizedBox(
      width: 44,
      height: 36,
      child: pw.Stack(
        alignment: pw.Alignment.centerRight,
        children: [
          pw.Positioned(
            right: 14,
            child: pw.Transform.rotate(
              angle: -0.45,
              child: pw.Container(
                width: 5,
                height: 30,
                color: accent,
              ),
            ),
          ),
          pw.Positioned(
            right: 4,
            child: pw.Transform.rotate(
              angle: -0.45,
              child: pw.Container(
                width: 5,
                height: 30,
                color: accent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _billedToBlock(String party) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'BILLED TO:',
          style: pw.TextStyle(
            fontSize: 9,
            fontWeight: pw.FontWeight.bold,
            letterSpacing: 0.6,
            color: _textBlack,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          party,
          style: const pw.TextStyle(fontSize: 11, color: PdfColors.black),
        ),
      ],
    );
  }

  static pw.Widget _invoiceMetaBlock({
    required String dateStr,
    required String invoiceNo,
    String? status,
  }) {
    pw.Widget row(String label, String value) => pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 6),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                '$label ',
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                  letterSpacing: 0.4,
                  color: _textBlack,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  value,
                  textAlign: pw.TextAlign.right,
                  style: const pw.TextStyle(fontSize: 10, color: PdfColors.black),
                ),
              ),
            ],
          ),
        );

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        row('DATE :', dateStr),
        row('INVOICE NO.', invoiceNo),
        if (status != null && status.isNotEmpty) row('STATUS :', status),
      ],
    );
  }

  static pw.Widget _lineItemsTable(
    List<ItemDetails> items,
    NumberFormat currency,
    PdfColor accent,
  ) {
    final rows = <pw.TableRow>[
      pw.TableRow(
        decoration: pw.BoxDecoration(color: accent),
        children: [
          _tableHeaderCell('DESCRIPTION'),
          _tableHeaderCell('QUANTITY', alignRight: true),
          _tableHeaderCell('PRICE', alignRight: true),
          _tableHeaderCell('TOTAL', alignRight: true),
        ],
      ),
    ];

    if (items.isEmpty) {
      rows.add(
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: _white),
          children: [
            _tableBodyCell('-', zebra: false),
            _tableBodyCell('-', alignRight: true, zebra: false),
            _tableBodyCell('-', alignRight: true, zebra: false),
            _tableBodyCell('-', alignRight: true, zebra: false),
          ],
        ),
      );
    } else {
      for (var i = 0; i < items.length; i++) {
        final e = items[i];
        final zebra = i.isOdd;
        rows.add(
          pw.TableRow(
            decoration: pw.BoxDecoration(
              color: zebra ? _zebra : _white,
            ),
            children: [
              _tableBodyCell(e.item ?? '-', zebra: zebra),
              _tableBodyCell(
                '${e.quantity ?? 0}',
                alignRight: true,
                zebra: zebra,
              ),
              _tableBodyCell(
                currency.format(e.rate ?? 0),
                alignRight: true,
                zebra: zebra,
              ),
              _tableBodyCell(
                currency.format(e.amount ?? 0),
                alignRight: true,
                zebra: zebra,
              ),
            ],
          ),
        );
      }
    }

    return pw.Table(
      border: pw.TableBorder(
        horizontalInside: const pw.BorderSide(color: PdfColors.grey400, width: 0.35),
        bottom: pw.BorderSide(color: accent, width: 1),
      ),
      columnWidths: {
        0: const pw.FlexColumnWidth(3.2),
        1: const pw.FlexColumnWidth(1),
        2: const pw.FlexColumnWidth(1.2),
        3: const pw.FlexColumnWidth(1.2),
      },
      children: rows,
    );
  }

  static List<pw.Widget> _returnedItemRows(
    List<ItemDetails> items,
    NumberFormat currency,
  ) {
    final widgets = <pw.Widget>[];
    for (final e in items) {
      final returnedQty = (e.alreadyReturnedQuantity ?? 0).toDouble();
      if (returnedQty <= 1e-6) continue;
      final q = (e.quantity ?? 0).toDouble();
      final lineAmount = (e.amount ?? 0).toDouble();
      final unitRate = q > 0 ? lineAmount / q : (e.rate ?? 0).toDouble();
      final returnAmount = unitRate * returnedQty;
      widgets.add(
        pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 4),
          child: pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  '${e.item ?? '-'} (returned)',
                  style: const pw.TextStyle(fontSize: 9, color: PdfColors.black),
                ),
              ),
              pw.Text(
                '${returnedQty.toStringAsFixed(returnedQty == returnedQty.roundToDouble() ? 0 : 1)} · -${currency.format(returnAmount)}',
                style: const pw.TextStyle(fontSize: 9, color: PdfColors.black),
              ),
            ],
          ),
        ),
      );
    }
    return widgets;
  }

  static pw.Widget _tableHeaderCell(String text, {bool alignRight = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: pw.Align(
        alignment: alignRight ? pw.Alignment.centerRight : pw.Alignment.centerLeft,
        child: pw.Text(
          text,
          style: pw.TextStyle(
            color: _white,
            fontSize: 9,
            fontWeight: pw.FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }

  static pw.Widget _tableBodyCell(
    String text, {
    bool alignRight = false,
    required bool zebra,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: pw.Align(
        alignment: alignRight ? pw.Alignment.centerRight : pw.Alignment.centerLeft,
        child: pw.Text(
          text,
          style: pw.TextStyle(
            fontSize: 10,
            color: _textBlack,
          ),
        ),
      ),
    );
  }

  static pw.Widget _totalsBlock({
    required NumberFormat currency,
    required double subtotal,
    required double discount,
    required double grandTotal,
    required PdfColor accent,
    double? tax,
    String taxLabel = 'Tax',
    double? totalReturned,
    double? netPayable,
  }) {
    pw.Widget line(String label, String value, {bool bold = false}) => pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 6),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                label,
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
                  color: _textBlack,
                ),
              ),
              pw.Text(
                value,
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
                  color: _textBlack,
                ),
              ),
            ],
          ),
        );

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        line('Subtotal', currency.format(subtotal)),
        if (discount > 0) line('Discount', '- ${currency.format(discount)}'),
        if (tax != null && tax > 0.005) line(taxLabel, currency.format(tax)),
        if (totalReturned != null && totalReturned > 0.005)
          line('Returned against', '- ${currency.format(totalReturned)}'),
        if (netPayable != null && totalReturned != null && totalReturned > 0.005)
          line('Payable amount', currency.format(netPayable), bold: true),
        pw.SizedBox(height: 10),
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          decoration: pw.BoxDecoration(color: accent),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Grand Total',
                style: pw.TextStyle(
                  color: _white,
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                  letterSpacing: 0.4,
                ),
              ),
              pw.Text(
                currency.format(grandTotal),
                style: pw.TextStyle(
                  color: _white,
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _paymentInformationBlock(
    InvoiceItem invoice,
    NumberFormat currency,
    double paidTotal,
    PdfColor accent,
  ) {
    final payments = invoice.payment ?? [];
    final dateFmt = DateFormat('MMM d, yyyy');

    final paymentBody = <pw.Widget>[
      pw.Container(
        padding: const pw.EdgeInsets.only(bottom: 6),
        decoration: pw.BoxDecoration(
          border: pw.Border(
            bottom: pw.BorderSide(color: accent, width: 2),
          ),
        ),
        child: pw.Text(
          'PAYMENT INFORMATION',
          style: pw.TextStyle(
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
            letterSpacing: 0.8,
            color: _textBlack,
          ),
        ),
      ),
      pw.SizedBox(height: 12),
    ];

    if (payments.isEmpty) {
      paymentBody.add(
        _paymentInfoRow('Paid on this invoice', currency.format(paidTotal)),
      );
      final returnRows = estimateReturnPaymentRowsForInvoiceItem(invoice);
      if (returnRows.isNotEmpty) {
        paymentBody.add(pw.SizedBox(height: 8));
        paymentBody.add(
          pw.Text(
            'Returns',
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
              color: _textBlack,
            ),
          ),
        );
        paymentBody.add(pw.SizedBox(height: 6));
        for (final r in returnRows) {
          paymentBody.add(
            _paymentInfoRow(
              r.label,
              estimatePaymentRowAmountText(r, pdf: true),
            ),
          );
        }
      }
      paymentBody.add(
        _paymentInfoRow('Unpaid balance', currency.format(invoice.outstandingAmount ?? 0),
            emphasizeValue: true),
      );
    } else {
      final returnRows = estimateReturnPaymentRowsForInvoiceItem(invoice);
      paymentBody.add(
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.4),
          columnWidths: {
            0: const pw.FlexColumnWidth(2.2),
            1: const pw.FlexColumnWidth(2),
            2: const pw.FlexColumnWidth(1.6),
          },
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey300),
              children: [
                _paymentTableCell('Method', header: true),
                _paymentTableCell('Date', header: true, alignRight: true),
                _paymentTableCell('Amount', header: true, alignRight: true),
              ],
            ),
            ...payments.map((p) {
              final when = p.date != null ? dateFmt.format(p.date!) : '-';
              final method = p.paymentMethod ?? 'Payment';
              return pw.TableRow(
                decoration: const pw.BoxDecoration(color: _white),
                children: [
                  _paymentMethodCell(method, p.paymentId),
                  _paymentTableCell(when, alignRight: true),
                  _paymentTableCell(currency.format(p.amount ?? 0), alignRight: true, boldAmount: true),
                ],
              );
            }),
            if (returnRows.isNotEmpty) ...[
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                children: [
                  _paymentTableCell('Returns', header: true),
                  _paymentTableCell('', header: true, alignRight: true),
                  _paymentTableCell('', header: true, alignRight: true),
                ],
              ),
              ...returnRows.map((r) {
                final when = r.dateText?.trim().isNotEmpty == true ? r.dateText!.trim() : '-';
                return pw.TableRow(
                  decoration: const pw.BoxDecoration(color: _white),
                  children: [
                    _paymentMethodCell(r.label, r.returnInvoiceName),
                    _paymentTableCell(when, alignRight: true),
                    _paymentTableCell(
                      estimatePaymentRowAmountText(r, pdf: true),
                      alignRight: true,
                      boldAmount: true,
                    ),
                  ],
                );
              }),
            ],
          ],
        ),
      );
      paymentBody.add(pw.SizedBox(height: 10));
      paymentBody.add(
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: pw.BoxDecoration(
            color: _zebra,
            border: pw.Border(
              left: pw.BorderSide(color: accent, width: 3),
            ),
          ),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Unpaid balance',
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                  color: _textBlack,
                ),
              ),
              pw.Text(
                currency.format(invoice.outstandingAmount ?? 0),
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                  color: _textBlack,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 6,
          child: pw.Container(
            padding: const pw.EdgeInsets.all(14),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey100,
              border: pw.Border.all(color: PdfColors.grey400, width: 0.6),
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: paymentBody,
            ),
          ),
        ),
        pw.SizedBox(width: 18),
        pw.Expanded(
          flex: 3,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              AppBrandNamePdf.text(
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                  letterSpacing: 0.3,
                ),
                trackColor: accent,
              ),
              pw.SizedBox(height: 6),
              pw.Text(
                'Thank you for your business.',
                textAlign: pw.TextAlign.right,
                style: const pw.TextStyle(
                  fontSize: 8,
                  color: PdfColors.grey700,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _paymentInfoRow(String label, String value, {bool emphasizeValue = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            child: pw.Text(
              label,
              style: pw.TextStyle(
                fontSize: 9,
                color: PdfColors.grey800,
              ),
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: emphasizeValue ? 10 : 9,
              fontWeight: emphasizeValue ? pw.FontWeight.bold : pw.FontWeight.normal,
              color: _textBlack,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _paymentTableCell(
    String text, {
    bool header = false,
    bool alignRight = false,
    bool boldAmount = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      child: pw.Align(
        alignment: alignRight ? pw.Alignment.centerRight : pw.Alignment.centerLeft,
        child: pw.Text(
          text,
          style: pw.TextStyle(
            fontSize: header ? 8 : 9,
            fontWeight: header || boldAmount ? pw.FontWeight.bold : pw.FontWeight.normal,
            color: _textBlack,
            letterSpacing: header ? 0.4 : 0,
          ),
        ),
      ),
    );
  }

  static pw.Widget _paymentMethodCell(String method, String? paymentId) {
    final hasRef = paymentId != null && paymentId.isNotEmpty;
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            method,
            style: pw.TextStyle(fontSize: 9, color: _textBlack),
          ),
          if (hasRef) ...[
            pw.SizedBox(height: 2),
            pw.Text(
              'Ref: $paymentId',
              style: pw.TextStyle(
                fontSize: 7.5,
                color: PdfColors.grey700,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

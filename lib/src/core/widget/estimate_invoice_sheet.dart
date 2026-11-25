import 'dart:async' show unawaited;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/constants/margin_constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/services/currency/app_currency_formatter.dart';
import 'package:hotel/src/core/services/receipt_print/receipt_print_coordinator.dart';
import 'package:hotel/src/core/widget/above_sheet_snack.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

// --- Shared estimate helpers (order checkout + create invoice) ----------------

Widget estimateDashRule(Color color) {
  return LayoutBuilder(
    builder: (context, c) {
      const dashW = 5.0;
      const gap = 4.0;
      final n = ((c.maxWidth / (dashW + gap)).floor()).clamp(1, 200);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          n,
          (_) => Container(width: dashW, height: 1, color: color),
        ),
      );
    },
  );
}

String formatEstimateInvoiceDateFromRaw(String? raw) {
  if (raw != null && raw.trim().isNotEmpty) {
    final d = DateTime.tryParse(raw.trim());
    if (d != null) return DateFormat('MMM dd, yyyy').format(d);
  }
  return DateFormat('MMM dd, yyyy').format(DateTime.now());
}

String estimateDiscountPercentLabel(double subTotal, double discountAmount) {
  if (subTotal <= 0 || discountAmount <= 0) return '0';
  final p = (discountAmount / subTotal) * 100;
  if ((p - p.round()).abs() < 0.05) return '${p.round()}';
  return p.toStringAsFixed(1);
}

String estimateQtyStr(double? q) {
  if (q == null) return '0';
  if (q == q.roundToDouble()) return '${q.round()}';
  return q.toStringAsFixed(1);
}

String estimateStaffShort(String? raw) {
  final s = (raw ?? '').trim();
  if (s.isEmpty) return '';
  final at = s.indexOf('@');
  if (at > 0) return s.substring(0, at);
  if (s.contains(' ')) return s.split(' ').first;
  return s;
}

/// English words for NPR totals (rounded rupees), up to crores.
String nepaleseRupeesInWords(double amount) {
  const ones = [
    '',
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine',
    'Ten',
    'Eleven',
    'Twelve',
    'Thirteen',
    'Fourteen',
    'Fifteen',
    'Sixteen',
    'Seventeen',
    'Eighteen',
    'Nineteen',
  ];
  const tens = ['', '', 'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety'];

  String two(int n) {
    if (n < 20) return ones[n];
    final t = n ~/ 10;
    final o = n % 10;
    if (o == 0) return tens[t];
    return '${tens[t]} ${ones[o]}';
  }

  String three(int n) {
    if (n == 0) return '';
    if (n < 100) return two(n);
    final h = n ~/ 100;
    final r = n % 100;
    final tail = two(r);
    if (tail.isEmpty) return '${ones[h]} Hundred';
    return '${ones[h]} Hundred $tail';
  }

  final n = amount.round().clamp(0, 999999999);
  if (n == 0) return 'Zero Nepalese rupee Only';

  var rem = n;
  final crore = rem ~/ 10000000;
  rem %= 10000000;
  final lakh = rem ~/ 100000;
  rem %= 100000;
  final thousand = rem ~/ 1000;
  rem %= 1000;

  final parts = <String>[];
  if (crore > 0) parts.add('${two(crore)} Crore');
  if (lakh > 0) parts.add('${two(lakh)} Lakh');
  if (thousand > 0) parts.add('${three(thousand)} Thousand');
  if (rem > 0) parts.add(three(rem));

  return '${parts.join(' ')} Nepalese rupee Only';
}

// --- Data + sheet ------------------------------------------------------------

class EstimateInvoiceLine {
  const EstimateInvoiceLine({
    required this.particular,
    required this.rate,
    required this.quantity,
    required this.amount,
  });

  final String particular;
  final double rate;
  final double quantity;
  final double amount;
}

class EstimateInvoicePaymentRow {
  const EstimateInvoicePaymentRow({
    required this.label,
    required this.amount,
    this.dateText,
    this.isReturn = false,
    this.isNoRefund = false,
    this.returnInvoiceName,
  });

  final String label;
  final double amount;

  /// Shown under the method label when set (e.g. payment time from API or invoice date).
  final String? dateText;

  /// Return / refund line shown in the payment breakdown.
  final bool isReturn;

  /// Return with no cash/credit refund (balance adjusted only).
  final bool isNoRefund;

  final String? returnInvoiceName;
}

class EstimateInvoiceReturnLine {
  const EstimateInvoiceReturnLine({
    required this.particular,
    required this.quantity,
    required this.amount,
  });

  final String particular;
  final double quantity;
  final double amount;
}

class EstimateInvoiceViewData {
  const EstimateInvoiceViewData({
    required this.titleSuffix,
    required this.invoiceNumber,
    required this.invoiceDateText,
    required this.customerLabel,
    required this.lines,
    required this.subTotal,
    required this.discountAmount,
    required this.totalAfterDiscount,
    required this.paymentSummary,
    required this.billedBy,
    required this.fileBaseName,
    this.headerLine,
    this.kotLine,
    this.paymentRows,
    this.paymentPaidTotal,
    this.paymentOutstanding,
    this.returnedLines = const [],
    this.totalReturnedAgainst,
    this.netPayable,
    this.taxAmount,
    this.taxLabel,
    this.currencyCode,
  });

  final String titleSuffix;
  final String invoiceNumber;
  final String invoiceDateText;
  final String? headerLine;
  final String customerLabel;
  final List<EstimateInvoiceLine> lines;
  final double subTotal;
  final double discountAmount;
  final double totalAfterDiscount;
  final String paymentSummary;
  final String? kotLine;
  final String billedBy;
  final String fileBaseName;

  /// When non-empty, [EstimateInvoiceReceiptView] shows a payment breakdown instead of only [paymentSummary].
  final List<EstimateInvoicePaymentRow>? paymentRows;
  final double? paymentPaidTotal;
  final double? paymentOutstanding;
  final List<EstimateInvoiceReturnLine> returnedLines;
  final double? totalReturnedAgainst;
  final double? netPayable;

  /// Tax amount applied on the invoice (exclusive of [totalAfterDiscount] when already included there).
  final double? taxAmount;
  /// Display label, e.g. `Tax (13%)` or `VAT`.
  final String? taxLabel;

  /// Party / invoice ISO currency; null uses org reporting currency.
  final String? currencyCode;

  String get moneySymbol => AppCurrencyFormatter.symbolForCode(currencyCode);
}

/// Resolves tax amount/label from persisted invoice totals (`baseGrandTotal` vs `grandTotal`).
({double taxAmount, String taxLabel})? estimateTaxFromInvoiceTotals({
  required double? baseGrandTotal,
  required double? grandTotal,
  required double subTotal,
  required double discountAmount,
  String Function(String rate)? taxAmountLine,
  String fallbackTaxLabel = 'Tax',
}) {
  final taxable = baseGrandTotal ??
      (subTotal - discountAmount).clamp(0.0, double.infinity);
  final total = grandTotal ?? taxable;
  final tax = (total - taxable).clamp(0.0, double.infinity);
  if (tax < 0.005) return null;

  String label = fallbackTaxLabel;
  if (taxable > 0.005) {
    final rate = (tax / taxable) * 100;
    if (rate >= 0.05) {
      final rateText = rate == rate.roundToDouble()
          ? rate.toStringAsFixed(0)
          : rate.toStringAsFixed(1);
      label = taxAmountLine?.call(rateText) ?? 'Tax ($rateText%)';
    }
  }
  return (taxAmount: tax, taxLabel: label);
}

String? _estimatePaymentRowDateText(DateTime? d) {
  if (d == null) return null;
  return DateFormat('MMM dd, yyyy · hh:mm a').format(d);
}

String _returnRefundPaymentTypeLabel(ReturnInvoiceRef ref) {
  final status = (ref.status ?? '').toLowerCase().trim();
  if (status == 'cancelled') return '';

  final rs = (ref.refundStatus ?? ref.refund?.status ?? '').toLowerCase().trim();
  if (rs == 'no_refund') return 'Return · No refund';
  if (rs == 'credit') return 'Return · Credit note';

  final method = (ref.refund?.paymentMethod ?? '').trim();
  if (method.isNotEmpty) return 'Return refund · $method';
  if (rs == 'refunded') return 'Return refund · Cash';
  return 'Return';
}

String? _estimateReturnRowDateText(ReturnInvoiceRef ref) {
  final raw = ref.date ?? ref.refund?.date;
  if (raw == null || raw.trim().isEmpty) return null;
  final d = DateTime.tryParse(raw.trim());
  if (d == null) return raw.trim();
  return DateFormat('MMM dd, yyyy · hh:mm a').format(d);
}

List<EstimateInvoicePaymentRow> estimateReturnPaymentRowsForInvoiceItem(InvoiceItem invoice) {
  final returns = invoice.returnInvoices ?? [];
  if (returns.isEmpty) return const [];

  final rows = <EstimateInvoicePaymentRow>[];
  for (final ref in returns) {
    final label = _returnRefundPaymentTypeLabel(ref);
    if (label.isEmpty) continue;

    final rs = (ref.refundStatus ?? ref.refund?.status ?? '').toLowerCase().trim();
    final isNoRefund = rs == 'no_refund';
    final amount = ref.returnAmount ?? ref.refund?.refundAmount ?? 0;

    final dateParts = <String>[];
    final dateText = _estimateReturnRowDateText(ref);
    if (dateText != null && dateText.isNotEmpty) dateParts.add(dateText);
    final returnName = ref.name?.trim();
    if (returnName != null && returnName.isNotEmpty) dateParts.add(returnName);

    rows.add(
      EstimateInvoicePaymentRow(
        label: label,
        amount: amount,
        dateText: dateParts.isEmpty ? null : dateParts.join(' · '),
        isReturn: true,
        isNoRefund: isNoRefund,
        returnInvoiceName: returnName,
      ),
    );
  }
  return rows;
}

String estimatePaymentRowAmountText(
  EstimateInvoicePaymentRow row, {
  bool pdf = false,
  String? currencyCode,
}) {
  final sym = pdf
      ? AppCurrencyFormatter.pdfSymbolForCode(currencyCode)
      : AppCurrencyFormatter.symbolForCode(currencyCode);
  final body = row.amount.toStringAsFixed(1);
  if (row.isReturn && !row.isNoRefund && row.amount > 1e-6) {
    return '-$sym $body';
  }
  return '$sym $body';
}

/// Builds per-method / per-payment lines for a saved [InvoiceItem] (list or detail API).
List<EstimateInvoicePaymentRow>? estimatePaymentRowsForInvoiceItem(InvoiceItem invoice) {
  final rows = <EstimateInvoicePaymentRow>[];
  final payments = invoice.payment ?? [];
  final invoiceDateFallback = formatEstimateInvoiceDateFromRaw(invoice.date);
  if (payments.isNotEmpty) {
    rows.addAll(
      payments.map((p) {
        final label = (p.paymentMethod ?? 'Payment').trim();
        return EstimateInvoicePaymentRow(
          label: label.isEmpty ? 'Payment' : label,
          amount: p.amount ?? 0,
          dateText: _estimatePaymentRowDateText(p.date) ?? invoiceDateFallback,
        );
      }),
    );
  } else {
    final totals = invoice.paymentTotals;
    if (totals != null && totals.isNotEmpty) {
      for (final e in totals.entries) {
        final v = e.value;
        double? amt;
        if (v is num) {
          amt = v.toDouble();
        } else {
          amt = double.tryParse(v.toString());
        }
        if (amt == null || amt <= 0) continue;
        rows.add(EstimateInvoicePaymentRow(label: e.key, amount: amt, dateText: invoiceDateFallback));
      }
    }
  }

  rows.addAll(estimateReturnPaymentRowsForInvoiceItem(invoice));
  if (rows.isEmpty) return null;
  return rows;
}

/// Effective rate per line for estimate table / PDF (amount ÷ qty when qty > 0).
double estimateLineDisplayRate(EstimateInvoiceLine line) {
  final q = line.quantity;
  if (q > 0) return line.amount / q;
  return line.rate;
}

/// Shared by estimate receipt and invoice transaction-details sheet.
Widget estimateReceiptPaymentSection(BuildContext context, EstimateInvoiceViewData data) {
  final rows = data.paymentRows;
  final paid = data.paymentPaidTotal;
  final out = data.paymentOutstanding;
  final hasRows = rows != null && rows.isNotEmpty;
  final hasOut = out != null && out > 1e-6;
  final returnRows = hasRows ? rows.where((r) => r.isReturn).toList() : const <EstimateInvoicePaymentRow>[];
  final totalReturned = data.totalReturnedAgainst;
  if (!hasRows && !hasOut) {
    return Text(
      'Payment Mode: ${data.paymentSummary}',
      style: context.theme.textTheme.labelMedium,
    );
  }
  final paymentRows = hasRows ? rows.where((r) => !r.isReturn).toList() : const <EstimateInvoicePaymentRow>[];
  final hasPaymentRows = paymentRows.isNotEmpty;
  final hasReturnRows = returnRows.isNotEmpty;
  final rowSum = hasPaymentRows
      ? paymentRows.fold<double>(0, (a, r) => a + r.amount)
      : 0.0;
  final showPaidFooter = paid != null &&
      paid > 1e-6 &&
      (!hasPaymentRows || paymentRows.length > 1 || hasOut || (rowSum - paid).abs() > 1e-3);
  final scheme = Theme.of(context).colorScheme;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        'Payment',
        style: context.theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 6.h),
      if (hasPaymentRows)
        for (final r in paymentRows)
          Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        r.label,
                        style: context.theme.textTheme.labelMedium,
                      ),
                      if (r.dateText != null && r.dateText!.trim().isNotEmpty) ...[
                        SizedBox(height: 2.h),
                        Text(
                          r.dateText!.trim(),
                          style: context.theme.textTheme.labelSmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Text(
                  estimatePaymentRowAmountText(r, currencyCode: data.currencyCode),
                  style: context.theme.textTheme.labelMedium,
                ),
              ],
            ),
          ),
      if (hasReturnRows) ...[
        if (hasPaymentRows) SizedBox(height: 4.h),
        Text(
          'Returns',
          style: context.theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 6.h),
        for (final r in returnRows)
          Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        r.label,
                        style: context.theme.textTheme.labelMedium?.copyWith(
                          color: scheme.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (r.dateText != null && r.dateText!.trim().isNotEmpty) ...[
                        SizedBox(height: 2.h),
                        Text(
                          r.dateText!.trim(),
                          style: context.theme.textTheme.labelSmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Text(
                  estimatePaymentRowAmountText(r, currencyCode: data.currencyCode),
                  style: context.theme.textTheme.labelMedium?.copyWith(
                    color: scheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
      if (showPaidFooter) ...[
        SizedBox(height: 4.h),
        Row(
          children: [
            Expanded(
              child: Text(
                'Total paid',
                style: context.theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              '${data.moneySymbol} ${paid.toStringAsFixed(1)}',
              style: context.theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
      if (hasOut) ...[
        SizedBox(height: 4.h),
        Row(
          children: [
            Expanded(
              child: Text(
                'Unpaid',
                style: context.theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              '${data.moneySymbol} ${out.toStringAsFixed(1)}',
              style: context.theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
      if (totalReturned != null && totalReturned > 0.005 && !hasReturnRows) ...[
        SizedBox(height: 4.h),
        Row(
          children: [
            Expanded(
              child: Text(
                'Returned against',
                style: context.theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              '-${data.moneySymbol} ${totalReturned.toStringAsFixed(1)}',
              style: context.theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: scheme.error,
              ),
            ),
          ],
        ),
      ],
    ],
  );
}

/// Scrollable estimate receipt body (line items, totals, disclaimer). Used by
/// [EstimateInvoiceSheet] and the invoice transaction-details bottom sheet.
/// Column widths for the line-item table inside [EstimateInvoiceReceiptView].
///
/// On tablet, [ScreenUtil] `.w` scales to the full screen while the receipt
/// often sits in a narrow dialog — fixed logical px avoids crushing "Particular".
abstract final class _EstimateReceiptTableLayout {
  static bool isTablet(BuildContext context) => DeviceLayout.isTablet(context);

  static double rateWidth(BuildContext context) =>
      isTablet(context) ? 76 : 52.w;

  static double qtyWidth(BuildContext context) =>
      isTablet(context) ? 44 : 36.w;

  static double amountWidth(BuildContext context) =>
      isTablet(context) ? 92 : 72.w;

  static double colGap(BuildContext context) =>
      isTablet(context) ? 8 : 4.w;

  static double rowGap(BuildContext context) =>
      isTablet(context) ? 8 : 8.h;

  static double sectionGap(BuildContext context) =>
      isTablet(context) ? 12 : 12.h;
}

class _EstimateReceiptLineItemTable extends StatelessWidget {
  const _EstimateReceiptLineItemTable({
    required this.lines,
    required this.returnedLines,
    required this.currencySymbol,
  });

  final List<EstimateInvoiceLine> lines;
  final List<EstimateInvoiceReturnLine> returnedLines;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final headerStyle = theme.textTheme.labelSmall?.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: _EstimateReceiptTableLayout.isTablet(context) ? 12 : null,
    );
    final cellStyle = theme.textTheme.labelMedium?.copyWith(
      fontSize: _EstimateReceiptTableLayout.isTablet(context) ? 13 : null,
      height: 1.3,
    );
    final rateW = _EstimateReceiptTableLayout.rateWidth(context);
    final qtyW = _EstimateReceiptTableLayout.qtyWidth(context);
    final amountW = _EstimateReceiptTableLayout.amountWidth(context);
    final gap = _EstimateReceiptTableLayout.colGap(context);

    Widget numericCell(String text, double width) {
      return SizedBox(
        width: width,
        child: Text(
          text,
          textAlign: TextAlign.right,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: cellStyle,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text('Particular', style: headerStyle),
            ),
            SizedBox(width: gap),
            numericCell('Rate', rateW),
            SizedBox(width: gap),
            numericCell('QTY', qtyW),
            SizedBox(width: gap),
            numericCell('Amount', amountW),
          ],
        ),
        SizedBox(height: _EstimateReceiptTableLayout.rowGap(context)),
        for (final line in lines) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  line.particular.trim().isEmpty ? '—' : line.particular.trim(),
                  style: cellStyle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: gap),
              numericCell(
                '$currencySymbol ${estimateLineDisplayRate(line).toStringAsFixed(1)}',
                rateW,
              ),
              SizedBox(width: gap),
              numericCell(estimateQtyStr(line.quantity), qtyW),
              SizedBox(width: gap),
              numericCell(
                '$currencySymbol ${line.amount.toStringAsFixed(1)}',
                amountW,
              ),
            ],
          ),
          SizedBox(height: _EstimateReceiptTableLayout.rowGap(context)),
        ],
        if (returnedLines.isNotEmpty) ...[
          SizedBox(height: _EstimateReceiptTableLayout.isTablet(context) ? 4 : 4.h),
          Text(
            'Returned items',
            style: headerStyle,
          ),
          SizedBox(height: _EstimateReceiptTableLayout.isTablet(context) ? 6 : 6.h),
          for (final r in returnedLines) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${r.particular.trim().isEmpty ? '—' : r.particular.trim()} (returned)',
                    style: cellStyle?.copyWith(color: scheme.error),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: gap),
                Text(
                  '${estimateQtyStr(r.quantity)} · -$currencySymbol ${r.amount.toStringAsFixed(1)}',
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: cellStyle?.copyWith(color: scheme.error),
                ),
              ],
            ),
            SizedBox(height: _EstimateReceiptTableLayout.isTablet(context) ? 6 : 6.h),
          ],
        ],
      ],
    );
  }
}

class EstimateInvoiceReceiptView extends StatelessWidget {
  const EstimateInvoiceReceiptView({super.key, required this.data});

  final EstimateInvoiceViewData data;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dash = scheme.outlineVariant.withValues(alpha: 0.65);
    final lines = data.lines;
    final dishCount = lines.length;
    final qtySum = lines.fold<double>(0, (a, b) => a + b.quantity);
    final header = (data.headerLine ?? '').trim();
    final kot = (data.kotLine ?? '').trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'ESTIMATE INVOICE',
          textAlign: TextAlign.center,
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
        verticalMarginXLarge,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'Invoice No: ${data.invoiceNumber}',
                style: context.theme.textTheme.labelMedium,
              ),
            ),
            Text(
              'Date: ${data.invoiceDateText}',
              style: context.theme.textTheme.labelMedium,
            ),
          ],
        ),
        if (header.isNotEmpty) ...[
          verticalMarginSmall,
          Text(
            header,
            style: context.theme.textTheme.labelMedium,
          ),
        ],
        verticalMarginMedium,
        estimateDashRule(dash),
        verticalMarginMedium,
        Text(
          'Customer: ${data.customerLabel}',
          style: context.theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: _EstimateReceiptTableLayout.sectionGap(context)),
        _EstimateReceiptLineItemTable(
          lines: lines,
          returnedLines: data.returnedLines,
          currencySymbol: data.moneySymbol,
        ),
        verticalMarginMedium,
        estimateDashRule(dash),
        verticalMarginMedium,
        Row(
          children: [
            Expanded(
              child: Text(
                'Total (Dish/QTY): $dishCount/${estimateQtyStr(qtySum)}',
                style: context.theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              '${data.moneySymbol} ${data.subTotal.toStringAsFixed(1)}',
              style: context.theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        if (data.discountAmount > 0) ...[
          SizedBox(height: 6.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  '- Discount (${estimateDiscountPercentLabel(data.subTotal, data.discountAmount)}%)',
                  style: context.theme.textTheme.labelMedium,
                ),
              ),
              Text(
                '${data.moneySymbol} ${data.discountAmount.toStringAsFixed(1)}',
                style: context.theme.textTheme.labelMedium,
              ),
            ],
          ),
        ],
        if ((data.taxAmount ?? 0) > 0.005) ...[
          SizedBox(height: 6.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  data.taxLabel ?? 'Tax',
                  style: context.theme.textTheme.labelMedium,
                ),
              ),
              Text(
                '${data.moneySymbol} ${data.taxAmount!.toStringAsFixed(1)}',
                style: context.theme.textTheme.labelMedium,
              ),
            ],
          ),
        ],
        SizedBox(height: 8.h),
        Row(
          children: [
            const Spacer(),
            Text(
              'Total Amount',
              style: context.theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: _EstimateReceiptTableLayout.isTablet(context) ? 12 : 12.w,
            ),
            Text(
              '${data.moneySymbol} ${data.totalAfterDiscount.toStringAsFixed(1)}',
              style: context.theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        if (data.totalReturnedAgainst != null && data.totalReturnedAgainst! > 0.005) ...[
          SizedBox(height: 6.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Returned against',
                  style: context.theme.textTheme.labelMedium,
                ),
              ),
              Text(
                '-${data.moneySymbol} ${data.totalReturnedAgainst!.toStringAsFixed(1)}',
                style: context.theme.textTheme.labelMedium?.copyWith(color: scheme.error),
              ),
            ],
          ),
        ],
        if (data.netPayable != null &&
            data.totalReturnedAgainst != null &&
            data.totalReturnedAgainst! > 0.005) ...[
          SizedBox(height: 6.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Payable amount',
                  style: context.theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                '${data.moneySymbol} ${data.netPayable!.toStringAsFixed(1)}',
                style: context.theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ],
        verticalMarginMedium,
        estimateDashRule(dash),
        verticalMarginMedium,
        Text(
          nepaleseRupeesInWords(data.netPayable ?? data.totalAfterDiscount),
          textAlign: TextAlign.center,
          style: context.theme.textTheme.labelSmall?.copyWith(height: 1.35),
        ),
        verticalMarginMedium,
        estimateDashRule(dash),
        verticalMarginMedium,
        estimateReceiptPaymentSection(context, data),
        if (kot.isNotEmpty) ...[
          SizedBox(height: 6.h),
          Text(
            kot,
            style: context.theme.textTheme.labelMedium,
          ),
        ],
        SizedBox(height: 6.h),
        Text(
          'Billed By: ${data.billedBy.trim().isEmpty ? '—' : data.billedBy}',
          style: context.theme.textTheme.labelMedium,
        ),
        SizedBox(height: 14.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.6)),
            color: scheme.surfaceContainerHighest,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This is not a Tax Invoice!',
                style: context.theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 4.h),
              Text(
                'This bill is an internal working copy. For official purposes, kindly accept the '
                'original bill from the counter, as this bill is for estimate purposes only.',
                style: context.theme.textTheme.labelSmall?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Column(
          children: [
            Text(
              'Thank You',
              textAlign: TextAlign.center,
              style: context.theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 4.h),
            Text(
              'Thank you for your visit! Visit again',
              textAlign: TextAlign.center,
              style: context.theme.textTheme.labelSmall?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ],
    );
  }
}

/// PDF / print for [EstimateInvoiceViewData] (same layout as [EstimateInvoiceReceiptView]).
class EstimateInvoicePdf {
  EstimateInvoicePdf._();

  static const double _bodyFontSize = 10;
  static const double _titleFontSize = 14;

  static pw.TextStyle _textStyle({bool bold = false, double? size}) {
    return pw.TextStyle(
      fontSize: size ?? _bodyFontSize,
      fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
    );
  }

  static pw.Widget _pdfDashRule() {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 10),
      child: pw.Container(
        width: double.infinity,
        height: 1,
        color: PdfColors.grey400,
      ),
    );
  }

  static PdfPageFormat _resolvePageFormat(PdfPageFormat? requested) {
    final base = requested ?? PdfPageFormat.a4;
    final compact = base.width < 240;
    final m = compact ? 6.0 : 16.0;
    return base.copyWith(
      marginLeft: m,
      marginRight: m,
      marginTop: m,
      marginBottom: m,
    );
  }

  static pw.Widget _pdfLineRow({
    required String particular,
    required String rate,
    required String qty,
    required String amount,
    bool header = false,
    bool compact = false,
  }) {
    final style = _textStyle(bold: header, size: compact ? 8 : null);
    return pw.Padding(
      padding: pw.EdgeInsets.only(bottom: header ? 6 : (compact ? 5 : 8)),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            flex: 5,
            child: pw.Text(particular, style: style),
          ),
          pw.SizedBox(
            width: compact ? 36 : 48,
            child: pw.Text(rate, style: style, textAlign: pw.TextAlign.right),
          ),
          pw.SizedBox(
            width: compact ? 24 : 32,
            child: pw.Text(qty, style: style, textAlign: pw.TextAlign.right),
          ),
          pw.SizedBox(
            width: compact ? 48 : 64,
            child: pw.Text(amount, style: style, textAlign: pw.TextAlign.right),
          ),
        ],
      ),
    );
  }

  static pw.Widget _pdfKeyValue(String label, String value, {bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Text(
              label,
              style: pw.TextStyle(fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal),
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal),
          ),
        ],
      ),
    );
  }

  static String _pdfSafePaymentSummary(String summary, {String? currencyCode}) {
    final uiSymbol = AppCurrencyFormatter.symbolForCode(currencyCode);
    final pdfSymbol = AppCurrencyFormatter.pdfSymbolForCode(currencyCode);
    if (uiSymbol != pdfSymbol && summary.contains(uiSymbol)) {
      return summary.replaceAll(uiSymbol, pdfSymbol);
    }
    return summary;
  }

  static List<pw.Widget> _pdfPaymentSection(EstimateInvoiceViewData d) {
    final rows = d.paymentRows;
    final paid = d.paymentPaidTotal;
    final out = d.paymentOutstanding;
    final hasRows = rows != null && rows.isNotEmpty;
    final hasOut = out != null && out > 1e-6;
    if (!hasRows && !hasOut) {
      return [
        pw.Text('Payment', style: _textStyle(bold: true)),
        pw.SizedBox(height: 6),
        pw.Text('Payment Mode: ${_pdfSafePaymentSummary(d.paymentSummary, currencyCode: d.currencyCode)}', style: _textStyle()),
      ];
    }
    final paymentRows = hasRows ? rows.where((r) => !r.isReturn).toList() : const <EstimateInvoicePaymentRow>[];
    final returnRows = hasRows ? rows.where((r) => r.isReturn).toList() : const <EstimateInvoicePaymentRow>[];
    final hasPaymentRows = paymentRows.isNotEmpty;
    final hasReturnRows = returnRows.isNotEmpty;
    final rowSum = hasPaymentRows
        ? paymentRows.fold<double>(0, (a, r) => a + r.amount)
        : 0.0;
    final showPaidFooter = paid != null &&
        paid > 1e-6 &&
        (!hasPaymentRows || paymentRows.length > 1 || hasOut || (rowSum - paid).abs() > 1e-3);

    final w = <pw.Widget>[
      pw.Text('Payment', style: _textStyle(bold: true)),
      pw.SizedBox(height: 6),
    ];
    if (hasPaymentRows) {
      for (final r in paymentRows) {
        final dateLine = r.dateText?.trim();
        w.add(
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(r.label, style: _textStyle()),
                      if (dateLine != null && dateLine.isNotEmpty)
                        pw.Text(
                          dateLine,
                          style: _textStyle().copyWith(fontSize: 8, color: PdfColors.grey700),
                        ),
                    ],
                  ),
                ),
                pw.Text(estimatePaymentRowAmountText(r, pdf: true, currencyCode: d.currencyCode), style: _textStyle()),
              ],
            ),
          ),
        );
      }
    }
    if (hasReturnRows) {
      if (hasPaymentRows) w.add(pw.SizedBox(height: 4));
      w.add(pw.Text('Returns', style: _textStyle(bold: true)));
      w.add(pw.SizedBox(height: 6));
      for (final r in returnRows) {
        final dateLine = r.dateText?.trim();
        w.add(
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(r.label, style: _textStyle(bold: true)),
                      if (dateLine != null && dateLine.isNotEmpty)
                        pw.Text(
                          dateLine,
                          style: _textStyle().copyWith(fontSize: 8, color: PdfColors.grey700),
                        ),
                    ],
                  ),
                ),
                pw.Text(estimatePaymentRowAmountText(r, pdf: true, currencyCode: d.currencyCode), style: _textStyle(bold: true)),
              ],
            ),
          ),
        );
      }
    }
    if (showPaidFooter) {
      w.add(_pdfKeyValue('Total paid', AppCurrencyFormatter.pdfMoney(paid, currencyCode: d.currencyCode), bold: true));
    }
    if (hasOut) {
      w.add(_pdfKeyValue('Unpaid', AppCurrencyFormatter.pdfMoney(out, currencyCode: d.currencyCode), bold: true));
    }
    return w;
  }

  static Future<Uint8List> buildPdfBytes(
    EstimateInvoiceViewData data, {
    PdfPageFormat? pageFormat,
    String? heading,
    bool showEstimateDisclaimer = true,
  }) async {
    final doc = pw.Document();
    final lines = data.lines;
    final dishCount = lines.length;
    final qtySum = lines.fold<double>(0, (a, b) => a + b.quantity);
    pw.ThemeData? unicodeTheme;
    try {
      final fontData = await rootBundle.load('assets/fonts/NotoSansDevanagari-Bold.ttf');
      final ttf = pw.Font.ttf(fontData);
      unicodeTheme = pw.ThemeData.withFont(
        base: ttf,
        bold: ttf,
        italic: ttf,
        boldItalic: ttf,
      );
    } catch (_) {
      unicodeTheme = null;
    }

    final kot = (data.kotLine ?? '').trim();
    final header = (data.headerLine ?? '').trim();
    final resolvedFormat = _resolvePageFormat(pageFormat);
    final compact =
        (resolvedFormat.width - resolvedFormat.marginLeft - resolvedFormat.marginRight) < 200;
    final title = (heading ?? 'ESTIMATE INVOICE').trim().isEmpty
        ? 'RECEIPT'
        : (heading ?? 'ESTIMATE INVOICE');

    doc.addPage(
      pw.MultiPage(
        pageFormat: resolvedFormat,
        theme: unicodeTheme,
        build: (_) => [
          pw.Center(
            child: pw.Text(
              title,
              style: _textStyle(bold: true, size: compact ? 12 : _titleFontSize),
            ),
          ),
          pw.SizedBox(height: 14),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Text('Invoice No: ${data.invoiceNumber}', style: _textStyle()),
              ),
              pw.Text('Date: ${data.invoiceDateText}', style: _textStyle()),
            ],
          ),
          if (header.isNotEmpty) ...[
            pw.SizedBox(height: 6),
            pw.Text(header, style: _textStyle()),
          ],
          _pdfDashRule(),
          pw.Text(
            'Customer: ${data.customerLabel}',
            style: _textStyle(bold: true),
          ),
          pw.SizedBox(height: 12),
          _pdfLineRow(
            particular: 'Particular',
            rate: 'Rate',
            qty: 'QTY',
            amount: 'Amount',
            header: true,
            compact: compact,
          ),
          for (final line in lines)
            _pdfLineRow(
              particular: line.particular.trim().isEmpty ? '—' : line.particular.trim(),
              rate: AppCurrencyFormatter.pdfMoney(estimateLineDisplayRate(line), currencyCode: data.currencyCode),
              qty: estimateQtyStr(line.quantity),
              amount: AppCurrencyFormatter.pdfMoney(line.amount, currencyCode: data.currencyCode),
              compact: compact,
            ),
          if (data.returnedLines.isNotEmpty) ...[
            pw.SizedBox(height: 8),
            pw.Text('Returned items', style: _textStyle(bold: true)),
            pw.SizedBox(height: 6),
            for (final r in data.returnedLines)
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 6),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        '${r.particular.trim().isEmpty ? '—' : r.particular.trim()} (returned)',
                        style: _textStyle(),
                      ),
                    ),
                    pw.Text(
                      '${estimateQtyStr(r.quantity)} · -${AppCurrencyFormatter.pdfMoney(r.amount, currencyCode: data.currencyCode)}',
                      style: _textStyle(),
                      textAlign: pw.TextAlign.right,
                    ),
                  ],
                ),
              ),
          ],
          _pdfDashRule(),
          _pdfKeyValue(
            'Total (Dish/QTY): $dishCount/${estimateQtyStr(qtySum)}',
            AppCurrencyFormatter.pdfMoney(data.subTotal, currencyCode: data.currencyCode),
            bold: true,
          ),
          if (data.discountAmount > 0) ...[
            pw.SizedBox(height: 6),
            _pdfKeyValue(
              '- Discount (${estimateDiscountPercentLabel(data.subTotal, data.discountAmount)}%)',
              AppCurrencyFormatter.pdfMoney(data.discountAmount, currencyCode: data.currencyCode),
            ),
          ],
          if ((data.taxAmount ?? 0) > 0.005) ...[
            pw.SizedBox(height: 6),
            _pdfKeyValue(
              data.taxLabel ?? 'Tax',
              AppCurrencyFormatter.pdfMoney(data.taxAmount!, currencyCode: data.currencyCode),
            ),
          ],
          pw.SizedBox(height: 8),
          pw.Row(
            children: [
              pw.Spacer(),
              pw.Text('Total Amount', style: _textStyle(bold: true, size: 11)),
              pw.SizedBox(width: 12),
              pw.Text(
                AppCurrencyFormatter.pdfMoney(data.totalAfterDiscount, currencyCode: data.currencyCode),
                style: _textStyle(bold: true, size: 11),
              ),
            ],
          ),
          if (data.totalReturnedAgainst != null && data.totalReturnedAgainst! > 0.005) ...[
            pw.SizedBox(height: 6),
            _pdfKeyValue(
              'Returned against',
              '-${AppCurrencyFormatter.pdfMoney(data.totalReturnedAgainst!, currencyCode: data.currencyCode)}',
            ),
          ],
          if (data.netPayable != null &&
              data.totalReturnedAgainst != null &&
              data.totalReturnedAgainst! > 0.005) ...[
            pw.SizedBox(height: 6),
            _pdfKeyValue(
              'Payable amount',
              AppCurrencyFormatter.pdfMoney(data.netPayable!, currencyCode: data.currencyCode),
              bold: true,
            ),
          ],
          _pdfDashRule(),
          pw.Center(
            child: pw.Text(
              nepaleseRupeesInWords(data.netPayable ?? data.totalAfterDiscount),
              style: _textStyle().copyWith(lineSpacing: 1.35),
              textAlign: pw.TextAlign.center,
            ),
          ),
          _pdfDashRule(),
          ..._pdfPaymentSection(data),
          if (kot.isNotEmpty) ...[
            pw.SizedBox(height: 6),
            pw.Text(kot, style: _textStyle()),
          ],
          pw.SizedBox(height: 6),
          pw.Text(
            'Billed By: ${data.billedBy.trim().isEmpty ? '—' : data.billedBy}',
            style: _textStyle(),
          ),
          pw.SizedBox(height: compact ? 8 : 14),
          if (showEstimateDisclaimer) ...[
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey400, width: 0.6),
                color: PdfColors.grey100,
                borderRadius: pw.BorderRadius.circular(4),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('This is not a Tax Invoice!', style: _textStyle(bold: true)),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'This bill is an internal working copy. For official purposes, kindly accept the '
                    'original bill from the counter, as this bill is for estimate purposes only.',
                    style: _textStyle().copyWith(color: PdfColors.grey700),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 16),
          ],
          pw.Center(
            child: pw.Column(
              children: [
                pw.Text('Thank You', style: _textStyle(bold: true, size: 11)),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Thank you for your visit! Visit again',
                  style: _textStyle().copyWith(color: PdfColors.grey700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return doc.save();
  }

  static Future<File> writeTempPdf(EstimateInvoiceViewData data) async {
    final tempDir = await getTemporaryDirectory();
    final stamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final file = File('${tempDir.path}/${data.fileBaseName}_$stamp.pdf');
    final bytes = await buildPdfBytes(data);
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  static Future<void> print(
    EstimateInvoiceViewData data, {
    String? heading,
    bool showEstimateDisclaimer = true,
  }) async {
    await Printing.layoutPdf(
      onLayout: (format) => buildPdfBytes(
        data,
        pageFormat: format,
        heading: heading,
        showEstimateDisclaimer: showEstimateDisclaimer,
      ),
      name: '${data.fileBaseName}_receipt.pdf',
    );
  }
}

Rect _iosShareOrigin(BuildContext context) {
  final box = context.findRenderObject() as RenderBox?;
  if (box != null && box.attached && box.hasSize) {
    final rect = box.localToGlobal(Offset.zero) & box.size;
    if (rect.width >= 1 && rect.height >= 1) return rect;
  }
  final size = MediaQuery.sizeOf(context);
  return Rect.fromCenter(
    center: Offset(size.width / 2, size.height / 2),
    width: 2,
    height: 2,
  );
}

class EstimateInvoiceSheet extends StatelessWidget {
  const EstimateInvoiceSheet({super.key, required this.data});

  final EstimateInvoiceViewData data;

  Future<void> _sharePdf(BuildContext context) async {
    if (!await gateInvoiceExport(context)) return;
    try {
      final file = await EstimateInvoicePdf.writeTempPdf(data);
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Estimate Invoice',
        text: 'Estimate invoice PDF',
        sharePositionOrigin: _iosShareOrigin(context),
      );
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to generate PDF for sharing')),
        );
      }
    }
  }

  Future<void> _downloadPdf(BuildContext context) async {
    if (!await gateInvoiceExport(context)) return;
    try {
      final tempFile = await EstimateInvoicePdf.writeTempPdf(data);
      Directory targetDir;
      if (Platform.isAndroid) {
        final primary = Directory('/storage/emulated/0/Download');
        final secondary = Directory('/storage/emulated/0/Downloads');
        if (await primary.exists()) {
          targetDir = primary;
        } else if (await secondary.exists()) {
          targetDir = secondary;
        } else {
          targetDir = (await getExternalStorageDirectory()) ?? await getApplicationDocumentsDirectory();
        }
      } else {
        targetDir = await getApplicationDocumentsDirectory();
      }
      if (!await targetDir.exists()) {
        await targetDir.create(recursive: true);
      }
      final fileName = tempFile.path.split('/').last;
      final savePath = '${targetDir.path}/$fileName';
      final targetFile = File(savePath);
      if (await targetFile.exists()) {
        await targetFile.delete();
      }
      final saved = await tempFile.copy(savePath);
      if (context.mounted) {
        AboveSheetSnack.showSuccess(
          context,
          Platform.isIOS
              ? 'Receipt saved. Open Files, then On My iPhone, BillMate.'
              : 'PDF saved: ${saved.path}',
        );
      }
      if (!Platform.isIOS) {
        unawaited(OpenFile.open(saved.path));
      }
    } catch (e) {
      if (context.mounted) {
        AboveSheetSnack.showError(context, 'Unable to save PDF: $e');
      }
    }
  }

  Future<void> _printPdf(BuildContext context) async {
    await ReceiptPrintCoordinator.printReceipt(
      context,
      data: data,
      heading: 'ESTIMATE INVOICE',
      showEstimateDisclaimer: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isTablet = DeviceLayout.isTablet(context);
    final screenH = MediaQuery.sizeOf(context).height;
    final sheetH = isTablet
        ? (screenH * 0.82).clamp(420.0, 680.0)
        : screenH * 0.94;

    final sheet = SizedBox(
      height: sheetH,
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: isTablet
              ? BorderRadius.circular(20)
              : BorderRadius.vertical(top: Radius.circular(22.r)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              SizedBox(height: isTablet ? 8 : 8.h),
              Container(
                width: isTablet ? 40 : 56.w,
                height: isTablet ? 4 : 4.h,
                decoration: BoxDecoration(
                  color: scheme.outlineVariant.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  isTablet ? 8 : 8.w,
                  isTablet ? 6 : 6.h,
                  isTablet ? 8 : 8.w,
                  isTablet ? 4 : 4.h,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        data.titleSuffix,
                        style: context.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    isTablet ? 18 : 18.w,
                    0,
                    isTablet ? 18 : 18.w,
                    isTablet ? 12 : 12.h,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(isTablet ? 14 : 14.w),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(isTablet ? 12 : 12.r),
                      border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.6)),
                    ),
                    child: EstimateInvoiceReceiptView(data: data),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                  isTablet ? 12 : 12.w,
                  isTablet ? 10 : 10.h,
                  isTablet ? 12 : 12.w,
                  isTablet ? 12 : 12.h,
                ),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  border: Border(top: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.5))),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: isTablet ? 6 : 6.w),
                        child: CustomButtonWidget(
                          useFixedSizes: isTablet,
                          padding: EdgeInsets.symmetric(horizontal: isTablet ? 12 : 12.sp),
                          height: isTablet ? 42 : 42.h,
                          borderRadius: isTablet ? 6 : 6.r,
                          onPressed: () => _sharePdf(context),
                          icon: Icon(
                            Icons.share_outlined,
                            size: isTablet ? 16 : 16.sp,
                            color: Colors.white,
                          ),
                          title: 'Share',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: isTablet ? 3 : 3.w),
                        child: CustomButtonWidget(
                          useFixedSizes: isTablet,
                          height: isTablet ? 42 : 42.h,
                          padding: EdgeInsets.symmetric(horizontal: isTablet ? 12 : 12.sp),
                          borderRadius: isTablet ? 6 : 6.r,
                          onPressed: () => _downloadPdf(context),
                          icon: Icon(
                            Icons.download_outlined,
                            size: isTablet ? 16 : 16.sp,
                            color: Colors.white,
                          ),
                          title: 'Download',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: isTablet ? 6 : 6.w),
                        child: CustomButtonWidget.outlined(
                          useFixedSizes: isTablet,
                          height: isTablet ? 42 : 42.h,
                          padding: EdgeInsets.symmetric(horizontal: isTablet ? 12 : 12.sp),
                          borderRadius: isTablet ? 6 : 6.r,
                          onPressed: () => _printPdf(context),
                          icon: Icon(
                            Icons.print_outlined,
                            size: isTablet ? 16 : 16.sp,
                            color: context.theme.colorScheme.primary,
                          ),
                          title: 'Print Bill',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (!isTablet) return sheet;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: sheet,
          ),
        ),
      ),
    );
  }
}

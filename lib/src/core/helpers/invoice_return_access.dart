import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hotel/src/core/themes/app_colors.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';

const double kInvoiceReturnQtyTol = 0.005;

bool invoiceRowIsCancelled(InvoiceItem row) {
  if (row.cancelled == 1) return true;
  final s = row.status?.toLowerCase().trim() ?? '';
  return s == 'cancelled';
}

String _invoiceStatusKey(InvoiceItem row) => row.status?.toLowerCase().trim() ?? '';

/// Row is a return slip (including cancelled); uses `returnAgainst`, `isReturned`, or `status`.
bool invoiceIsReturnSlipRow(InvoiceItem row) {
  if ((row.returnAgainst ?? '').trim().isNotEmpty) return true;
  if ((row.isReturned ?? 0) == 1) return true;
  final s = _invoiceStatusKey(row);
  return s == 'returned' || s == 'cancelled';
}

/// Active return slip — honours API `status` (cancelled returns are not "Returned").
bool invoiceIsReturnDocument(InvoiceItem row) {
  if (invoiceRowIsCancelled(row)) return false;
  final s = _invoiceStatusKey(row);
  if (s == 'cancelled') return false;
  if ((row.returnAgainst ?? '').trim().isNotEmpty) return true;
  if ((row.isReturned ?? 0) == 1) return true;
  return s == 'returned';
}

/// Human-readable status for list / detail chips; prefers API `status`.
String invoiceStatusDisplayLabel(InvoiceItem row) {
  final s = _invoiceStatusKey(row);
  if (s == 'cancelled' || row.cancelled == 1) return 'Cancelled';
  if (invoiceIsReturnDocument(row)) return 'Returned';
  if (s == 'paid') return 'Paid';
  if (s == 'unpaid') return 'Unpaid';
  if (s == 'not_submitted' || s == 'not submitted') return 'Not submitted';
  if (s == 'returned') return 'Returned';
  if (s.isNotEmpty) {
    return s.split('_').map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}').join(' ');
  }
  if (row.submitted == 0) return 'Not submitted';
  if ((row.outstandingAmount ?? 0) <= 0.005) return 'Paid';
  return 'Unpaid';
}

({Color bg, Color fg}) invoiceStatusChipColors(BuildContext context, InvoiceItem row) {
  final scheme = Theme.of(context).colorScheme;
  final label = invoiceStatusDisplayLabel(row).toLowerCase();
  if (label == 'cancelled') {
    return (bg: scheme.surfaceContainerHighest, fg: scheme.onSurfaceVariant);
  }
  if (label == 'returned') {
    return (bg: scheme.errorContainer.withValues(alpha: 0.45), fg: scheme.error);
  }
  if (label == 'paid') {
    return (bg: scheme.successBackground.withValues(alpha: 0.55), fg: scheme.successColor);
  }
  if (label == 'unpaid') {
    return (bg: scheme.errorContainer.withValues(alpha: 0.45), fg: scheme.error);
  }
  if (label == 'not submitted') {
    return (bg: scheme.tertiaryContainer.withValues(alpha: 0.5), fg: scheme.onTertiaryContainer);
  }
  return (bg: scheme.surfaceContainerHighest, fg: scheme.onSurfaceVariant);
}

/// Return slips linked to this invoice that are not cancelled (for list badges).
int activeReturnInvoiceCount(InvoiceItem row) {
  final list = row.returnInvoices ?? [];
  return list.where((r) => !returnEntryIsCancelled(r)).length;
}

bool returnEntryIsCancelled(ReturnInvoiceRef entry) {
  final s = (entry.status ?? '').toLowerCase().trim();
  return s == 'cancelled' || s == 'canceled';
}

bool canCancelReturnEntry(ReturnInvoiceRef entry) => !returnEntryIsCancelled(entry);

bool invoiceReturnDocumentIsCancelled(InvoiceItem row) => invoiceRowIsCancelled(row);

bool invoiceHasReturnableLines(InvoiceItem row) {
  final items = row.items;
  if (items == null || items.isEmpty) return true;
  return items.any((line) {
    final available = line.availableReturnQuantity;
    if (available != null) return available > kInvoiceReturnQtyTol;
    final sold = line.quantity ?? 0;
    final returned = line.alreadyReturnedQuantity ?? 0;
    return sold - returned > kInvoiceReturnQtyTol;
  });
}

/// Shows **Create return** when accounting settings allow it ([AccountingSettingsCubit]).
/// List payloads often omit `available_return_quantity` / `total_returned_against`; the
/// GET check API validates remaining quantity ([InvoiceReturnPage]).
bool canCreateInvoiceReturn(InvoiceItem row) {
  if (invoiceIsReturnDocument(row)) return false;
  if (invoiceRowIsCancelled(row)) return false;
  if (row.submitted != 1) return false;
  if (row.fullyReturned == true) return false;
  if (!invoiceHasReturnableLines(row)) return false;
  return true;
}

bool canCancelReturnInvoice(InvoiceItem row) {
  if (!invoiceIsReturnSlipRow(row)) return false;
  if (!invoiceIsReturnDocument(row)) return false;
  if (row.submitted != 1) return false;
  return true;
}

double effectiveRefundOwed(InvoiceItem row) {
  final raw = row.refundOwed ?? 0;
  if (raw <= kInvoiceReturnQtyTol) return 0;
  var settled = 0.0;
  for (final ri in row.returnInvoices ?? const <ReturnInvoiceRef>[]) {
    if ((ri.status ?? '').toLowerCase() == 'cancelled') continue;
    final rs = (ri.refundStatus ?? '').toLowerCase();
    if (rs == 'refunded') {
      final fromPayment = (ri.refund?.refundAmount ?? 0) > kInvoiceReturnQtyTol
          ? ri.refund!.refundAmount!
          : 0;
      settled += fromPayment > kInvoiceReturnQtyTol ? fromPayment : (ri.returnAmount ?? 0);
    } else if (rs == 'no_refund') {
      settled += ri.returnAmount ?? 0;
    }
  }
  return max(0, (raw - settled).roundToDouble());
}

import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:hotel/src/features/setup/domain/local_books_schema_ensurer.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:sqflite/sqflite.dart';

/// Return metadata attached to an original sales/purchase invoice for list + detail UI.
class InvoiceReturnEnrichment {
  const InvoiceReturnEnrichment({
    this.returnInvoices = const [],
    this.totalReturnedAgainst = 0,
    this.returnedQtyByLineId = const {},
    this.fullyReturned = false,
    this.netPayable,
  });

  final List<ReturnInvoiceRef> returnInvoices;
  final double totalReturnedAgainst;
  final Map<String, double> returnedQtyByLineId;
  final bool fullyReturned;
  final double? netPayable;
}

abstract final class InvoiceReturnEnrichmentLoader {
  static Future<InvoiceReturnEnrichment> load(
    Database db, {
    required bool isPurchase,
    required String invoiceName,
    required List<Map<String, dynamic>> itemRows,
    required double grandTotal,
    required double outstandingAmount,
  }) async {
    final path = await LocalDb.databasePath();
    await LocalBooksSchemaEnsurer.ensureAllTables(db, databasePath: path);

    final returnTable = isPurchase ? 'PurchaseReturn' : 'SalesReturn';
    final returnItemTable = isPurchase ? 'PurchaseReturnItem' : 'SalesReturnItem';

    try {
      final returnRows = await db.query(
        returnTable,
        where: 'returnAgainst = ?',
        whereArgs: [invoiceName],
        orderBy: 'date DESC',
      );

      if (returnRows.isEmpty) {
        return const InvoiceReturnEnrichment();
      }

      final returnedQtyByLineId = <String, double>{};
      final returnInvoices = <ReturnInvoiceRef>[];
      var totalReturnedAgainst = 0.0;

      for (final row in returnRows) {
        final returnName = row['name']?.toString() ?? '';
        if (returnName.isEmpty) continue;

        final cancelled = _isTruthy(row['cancelled']);
        final status = row['status']?.toString();
        final refundStatus = row['refundStatus']?.toString();
        final refundMethod = row['refundMethod']?.toString();
        final returnAmount = _toDouble(row['grandTotal']);

        final itemRowsForReturn = await db.query(
          returnItemTable,
          where: 'parent = ?',
          whereArgs: [returnName],
          orderBy: 'idx ASC',
        );

        final lineItems = itemRowsForReturn
            .map(
              (item) => ReturnInvoiceLineItem(
                item: item['item']?.toString(),
                quantity: _toDouble(item['quantity']),
                rate: _toDouble(item['rate']),
                amount: _toDouble(item['amount']),
              ),
            )
            .toList();

        if (!cancelled) {
          for (final item in itemRowsForReturn) {
            final lineId = item['originalItemName']?.toString();
            if (lineId == null || lineId.isEmpty) continue;
            returnedQtyByLineId[lineId] =
                (returnedQtyByLineId[lineId] ?? 0) + _toDouble(item['quantity']);
          }
          totalReturnedAgainst += returnAmount;
        }

        final isRefunded = refundStatus == 'refunded';
        returnInvoices.add(
          ReturnInvoiceRef(
            name: returnName,
            returnAmount: returnAmount,
            date: row['date']?.toString(),
            status: status,
            refundStatus: refundStatus,
            refund: isRefunded
                ? ReturnRefundInfo(
                    refundAmount: returnAmount,
                    paymentMethod: row['refundPaymentMethod']?.toString(),
                    status: refundStatus,
                    date: row['date']?.toString(),
                  )
                : refundMethod == 'none' || refundStatus == 'no_refund'
                    ? ReturnRefundInfo(status: 'no_refund')
                    : null,
            items: lineItems,
          ),
        );
      }

      var fullyReturned = itemRows.isNotEmpty;
      for (final row in itemRows) {
        final lineId = row['name']?.toString() ?? '';
        final sold = _toDouble(row['quantity']);
        final returned = returnedQtyByLineId[lineId] ?? 0;
        if (sold - returned > 0.005) {
          fullyReturned = false;
          break;
        }
      }

      double? netPayable;
      if (totalReturnedAgainst > 0.005) {
        if (outstandingAmount > 0.005) {
          netPayable = outstandingAmount;
        } else {
          netPayable = (grandTotal - totalReturnedAgainst).clamp(0.0, grandTotal);
        }
      }

      return InvoiceReturnEnrichment(
        returnInvoices: returnInvoices,
        totalReturnedAgainst: totalReturnedAgainst,
        returnedQtyByLineId: returnedQtyByLineId,
        fullyReturned: fullyReturned,
        netPayable: netPayable,
      );
    } catch (_) {
      return const InvoiceReturnEnrichment();
    }
  }

  static List<ItemDetails> enrichLineItems(
    List<ItemDetails> items,
    Map<String, double> returnedQtyByLineId,
  ) {
    return items.map((line) {
      final lineId = line.name ?? '';
      final sold = line.quantity ?? 0;
      final returned = returnedQtyByLineId[lineId] ?? 0;
      final available = (sold - returned).clamp(0.0, sold);
      return ItemDetails(
        item: line.item,
        action: line.action,
        rate: line.rate,
        itemId: line.itemId,
        quantity: line.quantity,
        name: line.name,
        amount: line.amount,
        itemDiscountAmount: line.itemDiscountAmount,
        alreadyReturnedQuantity: returned > 0.005 ? returned : null,
        availableReturnQuantity: available,
        canReturn: available > 0.005,
      );
    }).toList();
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }

  static bool _isTruthy(dynamic value) => value == true || value == 1 || value == '1';
}

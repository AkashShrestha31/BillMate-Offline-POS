import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/settlement/data/datasources/partial_settlement_remote_data_source.dart';
import 'package:hotel/src/features/settlement/data/models/request/partial_settlement_request_params.dart';
import 'package:hotel/src/features/settlement/data/models/response/partial_settlement_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton(as: PartialSettlementRemoteDataSource)
class PartialSettlementLocalDataSource implements PartialSettlementRemoteDataSource {
  PartialSettlementLocalDataSource(this._db);
  final LocalDb _db;

  @override
  Future<PartialSettlementResponseModel> partialSettlement({
    required PartialSettlementRequestParams params,
  }) async {
    try {
      final paymentLines =
          params.payment.where((p) => p.amount > 0).toList(growable: false);
      if (paymentLines.isEmpty) {
        throw const AppException(message: 'At least one payment line is required');
      }
      final totalPaid =
          paymentLines.fold<double>(0, (sum, p) => sum + p.amount);
      final now = DateTime.now().toIso8601String();
      final db = await _db.database;

      double remainingAmount = 0;
      var paymentsRecorded = 0;

      if (params.salesInvoiceName != null && params.salesInvoiceName!.isNotEmpty) {
        final rows = await _db.query('SalesInvoice',
            where: 'name = ?', whereArgs: [params.salesInvoiceName]);
        if (rows.isNotEmpty) {
          final partyName = rows.first['party'] as String? ?? '';
          final current = _toDouble(rows.first['outstandingAmount']);
          final discount = (params.discountAmount ?? 0).toDouble();
          remainingAmount =
              (current - totalPaid - discount).clamp(0.0, double.infinity);
          await db.update('SalesInvoice', {
            'outstandingAmount': remainingAmount.toStringAsFixed(11),
            'submitted': 1,
            'modified': now,
          }, where: 'name = ?', whereArgs: [params.salesInvoiceName]);

          if (partyName.isNotEmpty) {
            await _syncPartyOutstandingFromInvoices(db, partyName);
          }

          paymentsRecorded = await _recordPaymentLines(
            db: db,
            referenceId: params.salesInvoiceName!,
            partyName: partyName,
            lines: paymentLines,
            paymentDate: params.paymentDate,
            createdBy: params.createdBy,
            now: now,
            referenceType: 'SalesInvoice',
          );
        }
      }

      if (params.purchaseInvoiceName != null &&
          params.purchaseInvoiceName!.isNotEmpty) {
        final rows = await _db.query('PurchaseInvoice',
            where: 'name = ?', whereArgs: [params.purchaseInvoiceName]);
        if (rows.isNotEmpty) {
          final partyName = rows.first['party'] as String? ?? '';
          final current = _toDouble(rows.first['outstandingAmount']);
          remainingAmount = (current - totalPaid).clamp(0.0, double.infinity);
          await db.update('PurchaseInvoice', {
            'outstandingAmount': remainingAmount.toStringAsFixed(11),
            'submitted': 1,
            'modified': now,
          }, where: 'name = ?', whereArgs: [params.purchaseInvoiceName]);

          if (partyName.isNotEmpty) {
            await _syncPartyOutstandingFromInvoices(db, partyName);
          }

          paymentsRecorded = await _recordPaymentLines(
            db: db,
            referenceId: params.purchaseInvoiceName!,
            partyName: partyName,
            lines: paymentLines,
            paymentDate: params.paymentDate,
            createdBy: params.createdBy,
            now: now,
            referenceType: 'PurchaseInvoice',
          );
        }
      }

      if (params.partyName != null && params.partyName!.isNotEmpty) {
        final rows = await _db.query('Party',
            where: 'name = ?', whereArgs: [params.partyName]);
        if (rows.isNotEmpty) {
          final current = _toDouble(rows.first['outstandingAmount']);
          remainingAmount = (current - totalPaid).clamp(0.0, double.infinity);
          await db.update('Party', {
            'outstandingAmount': remainingAmount.toStringAsFixed(11),
            'modified': now,
          }, where: 'name = ?', whereArgs: [params.partyName]);

          paymentsRecorded = await _recordPaymentLines(
            db: db,
            referenceId: params.partyName!,
            partyName: params.partyName!,
            lines: paymentLines,
            paymentDate: params.paymentDate,
            createdBy: params.createdBy,
            now: now,
            referenceType: 'Party',
          );
        }
      }

      final primaryMethod = paymentLines.length == 1
          ? paymentLines.first.paymentMethod
          : 'Multiple';

      return PartialSettlementResponseModel(
        success: true,
        message: paymentLines.length > 1
            ? '${paymentLines.length} payments totalling ${totalPaid.toStringAsFixed(2)} recorded successfully'
            : 'Payment of ${totalPaid.toStringAsFixed(2)} recorded successfully',
        summary: PartialSettlementSummary(
          requestedAmount: totalPaid,
          totalAmountSettled: totalPaid,
          remainingAmount: remainingAmount,
          paymentsCreated: paymentsRecorded,
          invoicesAffected: 1,
          fullySettledInvoices: remainingAmount == 0 ? 1 : 0,
          partiallySettledInvoices: remainingAmount > 0 ? 1 : 0,
        ),
        payments: [],
        settledInvoices: [],
        settlementDetails: PartialSettlementDetails(
          party: params.partyName ?? '',
          paymentMethod: primaryMethod,
          paymentDate: params.paymentDate,
          paymentAccount: paymentLines.first.account ?? '',
          invoiceType: params.invoiceType ?? 'SalesInvoice',
          createdBy: params.createdBy,
          createdAt: now,
        ),
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  Future<int> _recordPaymentLines({
    required dynamic db,
    required String referenceId,
    required String partyName,
    required List<PartialSettlementPaymentLine> lines,
    required String paymentDate,
    required String createdBy,
    required String now,
    required String referenceType,
  }) async {
    var recorded = 0;
    for (final line in lines) {
      if (line.amount <= 0) continue;
      await _recordPayment(
        db: db,
        referenceId: referenceId,
        partyName: partyName,
        amount: line.amount,
        paymentMethod: line.paymentMethod,
        paymentDate: paymentDate,
        createdBy: createdBy,
        now: now,
        referenceType: referenceType,
      );
      recorded++;
    }
    return recorded;
  }

  Future<void> _recordPayment({
    required dynamic db,
    required String referenceId,
    required String partyName,
    required double amount,
    required String paymentMethod,
    required String paymentDate,
    required String createdBy,
    required String now,
    required String referenceType,
  }) async {
    final countRow = await _db.rawQuery('SELECT COUNT(*) as c FROM Payment');
    final count = (countRow.first['c'] as int?) ?? 0;
    final payName = 'PAY-${count + 1001}';

    final paymentType = referenceType == 'PurchaseInvoice' ? 'Pay' : 'Receive';
    final account =
        referenceType == 'PurchaseInvoice' ? 'Creditors' : 'Debtors';

    await db.insert(
      'Payment',
      {
        'name': payName,
        'numberSeries': 'PAY-',
        'party': partyName,
        'date': paymentDate,
        'paymentType': paymentType,
        'account': account,
        'paymentAccount': paymentMethod == 'Cash' ? 'Cash In Hand' : paymentMethod,
        'paymentMethod': paymentMethod,
        'amount': amount.toStringAsFixed(11),
        'writeoff': '0.00000000000',
        'referenceType': referenceType,
        'referenceId': referenceId,
        'createdBy': createdBy,
        'modifiedBy': createdBy,
        'created': now,
        'modified': now,
        'submitted': 1,
        'cancelled': 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }

  Future<void> _syncPartyOutstandingFromInvoices(
    Database db,
    String partyName,
  ) async {
    final partyRows = await db.query(
      'Party',
      where: 'name = ?',
      whereArgs: [partyName],
      limit: 1,
    );
    if (partyRows.isEmpty) return;

    final role = (partyRows.first['role'] as String? ?? '').trim().toLowerCase();
    final table = role == 'supplier' ? 'PurchaseInvoice' : 'SalesInvoice';
    final rows = await db.rawQuery(
      '''
      SELECT COALESCE(SUM(CAST(outstandingAmount AS REAL)), 0) AS total
      FROM "$table"
      WHERE party = ?
        AND submitted = 1
        AND COALESCE(cancelled, 0) = 0
      ''',
      [partyName],
    );
    final total = _toDouble(rows.first['total']);
    await db.update(
      'Party',
      {
        'outstandingAmount': total.toStringAsFixed(11),
        'modified': DateTime.now().toIso8601String(),
      },
      where: 'name = ?',
      whereArgs: [partyName],
    );
  }
}

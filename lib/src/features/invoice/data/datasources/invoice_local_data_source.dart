import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/settings/domain/bank_account_service.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/action/data/models/request/party_request_params.dart'
    show PartyRequestParams;
import 'package:hotel/src/features/action/data/models/response/party_response_model.dart'
    as action_party;
import 'package:hotel/src/features/invoice/data/datasources/invoice_remote_data_source.dart';
import 'package:hotel/src/features/invoice/data/models/request/create_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/delete_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_dates_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/submit_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/create_invoice_response_model.dart';
import 'package:hotel/src/features/invoice/data/models/response/delete_invoice_response_model.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_dates_response_model.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_item_update_json.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:hotel/src/features/invoice/data/models/response/submit_invoice_response_model.dart';
import 'package:hotel/src/features/invoice/data/models/response/update_invoice_response_model.dart';
import 'package:hotel/src/features/invoice/data/local/invoice_return_enrichment.dart';
import 'package:hotel/src/features/loyalty/domain/loyalty_features.dart';
import 'package:hotel/src/features/loyalty/domain/loyalty_math.dart';
import 'package:hotel/src/features/loyalty/domain/loyalty_program_service.dart';
import 'package:hotel/src/features/org/domain/tax_math.dart';
import 'package:hotel/src/features/org/domain/tax_settings_service.dart';
import 'package:hotel/src/features/settings/domain/live_stock_tracking_service.dart';
import 'package:hotel/src/features/setup/domain/local_books_schema_ensurer.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton(as: InvoiceRemoteDataSource)
class InvoiceLocalDataSource implements InvoiceRemoteDataSource {
  InvoiceLocalDataSource(this._db);
  final LocalDb _db;

  LiveStockTrackingService? get _stock {
    if (!getIt.isRegistered<LiveStockTrackingService>()) return null;
    return getIt<LiveStockTrackingService>();
  }

  String get _table => 'SalesInvoice';
  String get _itemTable => 'SalesInvoiceItem';

  @override
  Future<ApiResponse<InvoiceSalesResponseModel>> invoice({
    required InvoiceRequestParams invoiceParams,
  }) async {
    try {
      final isPurchase = invoiceParams.invoiceType == InvoiceType.purchase;
      final table = isPurchase ? 'PurchaseInvoice' : 'SalesInvoice';
      final itemTable = isPurchase ? 'PurchaseInvoiceItem' : 'SalesInvoiceItem';

      final conditions = <String>['cancelled = 0'];
      final args = <dynamic>[];

      if (invoiceParams.party != null && invoiceParams.party!.isNotEmpty) {
        conditions.add('party = ?');
        args.add(invoiceParams.party);
      }
      if (invoiceParams.startDate != null) {
        conditions.add('date >= ?');
        args.add(invoiceParams.startDate);
      }
      if (invoiceParams.endDate != null) {
        conditions.add('date <= ?');
        args.add('${invoiceParams.endDate}T23:59:59');
      }
      if (invoiceParams.paymentStatus == 'paid') {
        conditions.add('CAST(outstandingAmount AS REAL) = 0 AND submitted = 1');
      } else if (invoiceParams.paymentStatus == 'unpaid') {
        conditions.add('CAST(outstandingAmount AS REAL) > 0 AND submitted = 1');
      }

      final where = conditions.join(' AND ');
      final page = invoiceParams.page ?? 1;
      final perPage = invoiceParams.perPage ?? 20;
      final offset = (page - 1) * perPage;

      final rows = await _db.query(
        table,
        where: where,
        whereArgs: args.isNotEmpty ? args : null,
        orderBy: 'date ${invoiceParams.sortOrder ?? 'desc'}',
        limit: perPage,
        offset: offset,
      );

      final total = await _db.count(table, where: where, whereArgs: args.isNotEmpty ? args : null);
      final totalPages = total == 0 ? 1 : (total / perPage).ceil();

      // Fetch items for each invoice
      final items = <InvoiceItem>[];
      final db = await _db.database;
      await LocalBooksSchemaEnsurer.ensureAllTables(
        db,
        databasePath: await LocalDb.databasePath(),
      );
      for (final row in rows) {
        final invName = row['name'] as String;
        final itemRows = await _db.query(itemTable, where: 'parent = ?', whereArgs: [invName]);
        final payments = await _paymentsForInvoice(invName);
        items.add(await _rowToInvoiceItem(
          db,
          row,
          itemRows,
          isPurchase,
          payments,
        ));
      }

      // Totals
      final totalsRow = await _db.rawQuery(
        'SELECT SUM(CAST(grandTotal AS REAL)) as total, SUM(CAST(outstandingAmount AS REAL)) as outstanding FROM "$table" WHERE $where',
        args.isNotEmpty ? args : null,
      );
      final grandTotal = _toDouble(totalsRow.first['total']);
      final outstanding = _toDouble(totalsRow.first['outstanding']);

      return ApiResponse(
        data: InvoiceSalesResponseModel(
          data: items,
          pagination: Pagination(
            current_page: page,
            per_page: perPage,
            total_pages: totalPages,
            total_groups: total,
          ),
          total_grand_total: grandTotal,
          total_outstanding_amount: outstanding,
          total_quantity: total,
        ),
        message: 'Invoices fetched',
        success: true,
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<action_party.PartyResponseModel> party({
    required PartyRequestParams params,
  }) async {
    try {
      final conditions = <String>[];
      final args = <dynamic>[];
      if (params.partyType != null && params.partyType!.isNotEmpty) {
        conditions.add('role = ?');
        args.add(params.partyType);
      }
      if (params.search != null && params.search!.isNotEmpty) {
        conditions.add('name LIKE ?');
        args.add('%${params.search}%');
      }
      final where = conditions.isNotEmpty ? conditions.join(' AND ') : null;
      final rows = await _db.query('Party',
          where: where, whereArgs: args.isNotEmpty ? args : null, orderBy: 'name ASC');
      final total = rows.length;
      return action_party.PartyResponseModel(
        data: rows.map((r) => action_party.PartyItem(
          id: r['id'] as int?,
          name: r['name'] as String?,
          outstandingAmount: _toDouble(r['outstandingAmount']),
          role: r['role'] as String?,
        )).toList(),
        pagination: action_party.Pagination(
          current_page: 1,
          per_page: total,
          total_pages: 1,
          total_rows: total,
        ),
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<CreateInvoiceResponseModel> createInvoice({
    required CreateInvoiceRequestParams params,
  }) async {
    try {
      final isPurchase = params.invoiceType == InvoiceType.purchase;
      await getIt<FreemiumGateService>().assertCan(
        isPurchase
            ? FreemiumFeature.purchaseInvoice
            : FreemiumFeature.salesInvoice,
      );
      if (!isPurchase) {
        await _assertLiveSalesStock([
          for (final item in params.items)
            StockMovementLine(
              item: item.item,
              quantity: item.quantity ?? 1,
              rate: item.rate,
              location: LiveStockTrackingService.defaultLocation,
            ),
        ]);
      }
      final table = isPurchase ? 'PurchaseInvoice' : 'SalesInvoice';
      final itemTable = isPurchase ? 'PurchaseInvoiceItem' : 'SalesInvoiceItem';
      final createdAt = DateTime.now();
      final now = createdAt.toIso8601String();
      final series = isPurchase ? 'PINV-' : 'SINV-';
      final count = await _db.count(table);
      final invName = '$series${(count + 1001).toString()}';

      double netTotal = 0;
      for (final item in params.items) {
        netTotal += (item.rate ?? 0) * (item.quantity ?? 1);
      }

      var loyaltyDiscount = 0.0;
      final redeemPoints = (LoyaltyFeatures.enabled &&
              !isPurchase &&
              params.redeemLoyaltyPoints)
          ? (params.loyaltyPoints ?? 0).clamp(0, 1 << 30)
          : 0;
      if (redeemPoints > 0) {
        final loyalty = getIt<LoyaltyProgramService>();
        final programName = params.loyaltyProgram?.trim();
        final program = (programName != null && programName.isNotEmpty)
            ? await loyalty.getProgram(programName)
            : (await loyalty.snapshotForParty(params.party)).program;
        final factor = program?.conversionFactor ?? 1.0;
        loyaltyDiscount = LoyaltyMath.amountFromPoints(redeemPoints, factor)
            .clamp(0.0, netTotal);
      }

      final discount = params.discountAmount ?? 0;
      final afterLoyalty =
          (netTotal - loyaltyDiscount).clamp(0.0, double.infinity);
      var baseGrandTotal = (afterLoyalty - discount).clamp(0.0, double.infinity);
      var grandTotal = baseGrandTotal;

      if (!isPurchase && params.applyTax) {
        final taxSettings = await getIt<TaxSettingsService>().load();
        final rate = params.taxRateOverride ?? taxSettings.defaultTaxRate;
        final breakdown = SalesInvoiceTaxCalculator(
          ratePercent: rate,
          mode: taxSettings.taxMode,
        ).calculate(
          subtotal: afterLoyalty,
          discount: discount,
        );
        baseGrandTotal = breakdown.taxable;
        grandTotal = breakdown.total;
      }

      await _db.upsert(table, {
        'name': invName,
        'numberSeries': series,
        'party': params.party,
        'account': params.account ?? (isPurchase ? 'Creditors' : 'Debtors'),
        'date': _invoiceDateWithClock(params.date, createdAt),
        'currency': params.currency,
        'entryCurrency': 'Party',
        'netTotal': netTotal.toStringAsFixed(11),
        'baseGrandTotal': baseGrandTotal.toStringAsFixed(11),
        'grandTotal': grandTotal.toStringAsFixed(11),
        'outstandingAmount': grandTotal.toStringAsFixed(11),
        'setDiscountAmount': params.setDiscountAmount == true ? 1 : 0,
        'discountAmount': (params.discountAmount ?? 0).toStringAsFixed(11),
        if (!isPurchase && params.loyaltyProgram != null)
          'loyaltyProgram': params.loyaltyProgram,
        if (!isPurchase) 'redeemLoyaltyPoints': redeemPoints > 0 ? 1 : 0,
        if (!isPurchase && redeemPoints > 0) 'loyaltyPoints': redeemPoints,
        'createdBy': params.createdBy,
        'modifiedBy': params.modifiedBy,
        'created': now,
        'modified': now,
        'submitted': 1,
        'cancelled': 0,
      });

      int itemIdx = 0;
      for (final item in params.items) {
        final amount = (item.rate ?? 0) * (item.quantity ?? 1);
        final lineAccount = (item.account != null && item.account!.trim().isNotEmpty)
            ? item.account!.trim()
            : (isPurchase ? 'Cost of Goods Sold' : 'Sales');
        await _db.upsert(itemTable, {
          'name': '${invName}-${itemIdx++}',
          'item': item.item,
          'rate': (item.rate ?? 0).toStringAsFixed(11),
          'quantity': item.quantity ?? 1,
          'unit': item.unit ?? 'Unit',
          'account': lineAccount,
          'amount': amount.toStringAsFixed(11),
          'parent': invName,
          'parentSchemaName': isPurchase ? 'PurchaseInvoice' : 'SalesInvoice',
          'parentFieldname': 'items',
          'idx': itemIdx,
        });
      }

      if (params.payment != null && params.payment!.isNotEmpty) {
        final db = await _db.database;
        final refType = isPurchase ? 'PurchaseInvoice' : 'SalesInvoice';
        var paidTotal = 0.0;
        for (final pay in params.payment!) {
          final amt = pay.amount;
          if (amt <= 0) continue;
          paidTotal += amt;
          await _recordPayment(
            db: db,
            invoiceName: invName,
            partyName: params.party,
            amount: amt,
            paymentMethod: pay.paymentMethod,
            paymentDate: pay.paymentDate,
            createdBy: params.createdBy,
            now: now,
            referenceType: refType,
          );
        }
        final outstanding = (grandTotal - paidTotal).clamp(0.0, double.infinity);
        await db.update(
          table,
          {'outstandingAmount': outstanding.toStringAsFixed(11)},
          where: 'name = ?',
          whereArgs: [invName],
        );
      }

      if (!isPurchase) {
        final eligibleForEarn =
            (afterLoyalty - discount).clamp(0.0, double.infinity);
        await getIt<LoyaltyProgramService>().applyInvoiceLoyalty(
          invoiceName: invName,
          partyName: params.party,
          eligibleAmount: eligibleForEarn,
          submitted: true,
          createdBy: params.createdBy,
          programName: params.loyaltyProgram,
          redeemPoints: redeemPoints,
        );
      }

      await _stock?.applyInvoiceByName(
        invoiceName: invName,
        isPurchase: isPurchase,
      );
      await _syncPartyOutstandingFromInvoices(params.party, isPurchase);

      final paidRows = params.payment
              ?.where((p) => p.amount > 0)
              .toList() ??
          const [];
      final status = paidRows.isEmpty ? 'Unpaid' : 'Paid';

      return CreateInvoiceResponseModel(
        message: 'Invoice created successfully',
        invoiceName: invName,
        itemsCreated: params.items.length,
        netTotal: netTotal,
        grandTotal: grandTotal,
        status: status,
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<UpdateInvoiceResponseModel> updateInvoice({required InvoiceItem params}) async {
    try {
      final now = DateTime.now().toIso8601String();
      final db = await _db.database;
      final isPurchase = params.invoiceType == InvoiceType.purchase;
      final table = isPurchase ? 'PurchaseInvoice' : 'SalesInvoice';

      final updates = <String, dynamic>{'modified': now};

      final invoiceName = params.invoiceName;
      Map<String, dynamic>? existingRow;
      if (invoiceName != null && invoiceName.isNotEmpty) {
        final existing = await _db.query(
          table,
          where: 'name = ?',
          whereArgs: [invoiceName],
          limit: 1,
        );
        if (existing.isNotEmpty) existingRow = existing.first;
      }
      final alreadySubmitted = _isTruthy(existingRow?['submitted']);

      if (params.action == 'submit') {
        if (!alreadySubmitted && !isPurchase) {
          await _assertLiveSalesStockForInvoiceName(params.invoiceName);
        }
        updates['submitted'] = 1;
        if (!alreadySubmitted && existingRow != null) {
          updates['outstandingAmount'] = existingRow['grandTotal'];
        }
      } else if (params.action == 'cancel') {
        updates['cancelled'] = 1;
        updates['submitted'] = 0;
      }

      if (params.grandTotal != null) updates['grandTotal'] = params.grandTotal.toString();
      if (params.modifiedBy != null) updates['modifiedBy'] = params.modifiedBy;

      await db.update(table, updates, where: 'name = ?', whereArgs: [params.invoiceName]);
      if (invoiceName != null && invoiceName.isNotEmpty) {
        if (params.action == 'submit') {
          await _stock?.applyInvoiceByName(
            invoiceName: invoiceName,
            isPurchase: isPurchase,
          );
          await _applyPaymentLinesToInvoice(
            db: db,
            table: table,
            invoiceName: invoiceName,
            partyName: params.party ?? existingRow?['party']?.toString() ?? '',
            isPurchase: isPurchase,
            lines: params.updatePaymentLines,
            createdBy: params.modifiedBy ?? 'local_user',
            now: now,
          );
        } else if (params.action == 'cancel') {
          await _stock?.reverseDocument(
            referenceType: isPurchase ? 'PurchaseInvoice' : 'SalesInvoice',
            referenceName: invoiceName,
          );
        }
        await _syncPartyOutstandingFromInvoices(
          params.party ?? existingRow?['party']?.toString() ?? '',
          isPurchase,
        );
      }
      return UpdateInvoiceResponseModel(message: 'Invoice updated successfully');
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<SubmitInvoiceResponseModel> submitInvoice({
    required SubmitInvoiceRequestParams params,
  }) async {
    try {
      final db = await _db.database;
      final now = DateTime.now().toIso8601String();
      await _assertLiveSalesStockForInvoiceName(params.invoiceName);
      // Try both tables
      for (final table in ['SalesInvoice', 'PurchaseInvoice']) {
        await db.update(
          table,
          {'submitted': 1, 'modified': now},
          where: 'name = ?',
          whereArgs: [params.invoiceName],
        );
      }
      await _stock?.applyInvoiceByName(
        invoiceName: params.invoiceName,
        isPurchase: false,
      );
      await _stock?.applyInvoiceByName(
        invoiceName: params.invoiceName,
        isPurchase: true,
      );
      final sales = await db.query(
        'SalesInvoice',
        where: 'name = ?',
        whereArgs: [params.invoiceName],
        limit: 1,
      );
      if (sales.isNotEmpty) {
        await _syncPartyOutstandingFromInvoices(
          sales.first['party']?.toString() ?? '',
          false,
        );
      } else {
        final purchase = await db.query(
          'PurchaseInvoice',
          where: 'name = ?',
          whereArgs: [params.invoiceName],
          limit: 1,
        );
        if (purchase.isNotEmpty) {
          await _syncPartyOutstandingFromInvoices(
            purchase.first['party']?.toString() ?? '',
            true,
          );
        }
      }
      return SubmitInvoiceResponseModel(
        message: 'Invoice submitted successfully',
        invoiceName: params.invoiceName,
        action: params.action,
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<DeleteInvoiceResponseModel> deleteInvoice({
    required DeleteInvoiceRequestParams params,
  }) async {
    try {
      final db = await _db.database;
      final isPurchase = params.invoiceType == InvoiceType.purchase;
      final table = isPurchase ? 'PurchaseInvoice' : 'SalesInvoice';
      final itemTable = isPurchase ? 'PurchaseInvoiceItem' : 'SalesInvoiceItem';
      int deleted = 0;
      for (final name in params.invoiceNames) {
        await _stock?.reverseDocument(
          referenceType: isPurchase ? 'PurchaseInvoice' : 'SalesInvoice',
          referenceName: name,
        );
        await db.delete(itemTable, where: 'parent = ?', whereArgs: [name]);
        deleted += await db.delete(table, where: 'name = ?', whereArgs: [name]);
      }
      return DeleteInvoiceResponseModel(
        success: true,
        message: '$deleted invoice(s) deleted',
        summary: DeleteInvoiceSummary(
          totalInvoicesRequested: params.invoiceNames.length,
          totalInvoicesDeleted: deleted,
          totalInvoicesNotFound: params.invoiceNames.length - deleted,
          totalItemsDeleted: 0,
          totalPaymentForDeleted: 0,
          totalPaymentsDeleted: 0,
          partiesUpdated: 0,
        ),
        deletedInvoices: [],
        partyUpdates: [],
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<InvoiceDatesResponseModel> getInvoiceDates({
    required InvoiceDatesRequestParams params,
  }) async {
    try {
      final rows = await _db.rawQuery(
        "SELECT DISTINCT substr(date,1,10) as day FROM SalesInvoice WHERE submitted=1 ORDER BY day DESC LIMIT 60",
      );
      final dates = rows.map((r) => r['day'] as String).toList();
      return InvoiceDatesResponseModel(success: true, dates: dates);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<InvoiceItem?> getInvoiceByName({
    required String invoiceName,
    required InvoiceType invoiceType,
  }) async {
    try {
      final isPurchase = invoiceType == InvoiceType.purchase;
      final table = isPurchase ? 'PurchaseInvoice' : 'SalesInvoice';
      final itemTable = isPurchase ? 'PurchaseInvoiceItem' : 'SalesInvoiceItem';

      final rows = await _db.query(
        table,
        where: 'name = ?',
        whereArgs: [invoiceName],
        limit: 1,
      );
      if (rows.isEmpty) return null;

      final db = await _db.database;
      await LocalBooksSchemaEnsurer.ensureAllTables(
        db,
        databasePath: await LocalDb.databasePath(),
      );
      final itemRows = await _db.query(itemTable, where: 'parent = ?', whereArgs: [invoiceName]);
      final payments = await _paymentsForInvoice(invoiceName);
      return _rowToInvoiceItem(db, rows.first, itemRows, isPurchase, payments);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  // ── helpers ──────────────────────────────────────────────────────────────────

  Future<InvoiceItem> _rowToInvoiceItem(
    Database db,
    Map<String, dynamic> r,
    List<Map<String, dynamic>> itemRows,
    bool isPurchase,
    List<PaymentDetails> payments,
  ) async {
    final paymentTotals = _paymentTotalsFromList(payments);
    final invName = r['name'] as String? ?? '';
    final grandTotal = _toDouble(r['grandTotal']);
    final outstanding = _toDouble(r['outstandingAmount']);
    final lineItems = itemRows.map(_itemDetailsFromRow).toList();

    final enrichment = await InvoiceReturnEnrichmentLoader.load(
      db,
      isPurchase: isPurchase,
      invoiceName: invName,
      itemRows: itemRows,
      grandTotal: grandTotal,
      outstandingAmount: outstanding,
    );

    return InvoiceItem(
      parent: invName,
      invoiceName: invName,
      party: r['party'] as String?,
      grandTotal: grandTotal,
      baseGrandTotal: _toDouble(r['baseGrandTotal']),
      date: _invoiceDateForDisplay(
        r['date']?.toString(),
        r['created']?.toString(),
      ),
      outstandingAmount: outstanding,
      submitted: r['submitted'] as int?,
      cancelled: r['cancelled'] as int?,
      invoiceType: isPurchase ? InvoiceType.purchase : InvoiceType.sales,
      status: _invoiceStatus(r),
      discountAmount: _toDouble(r['discountAmount']),
      setDiscountAmount: r['setDiscountAmount'] as int?,
      items: InvoiceReturnEnrichmentLoader.enrichLineItems(
        lineItems,
        enrichment.returnedQtyByLineId,
      ),
      payment: payments.isEmpty ? null : payments,
      paymentTotals: paymentTotals,
      totalReturnedAgainst: enrichment.totalReturnedAgainst > 0.005
          ? enrichment.totalReturnedAgainst
          : null,
      fullyReturned: enrichment.fullyReturned ? true : null,
      returnInvoices: enrichment.returnInvoices.isEmpty ? null : enrichment.returnInvoices,
      netPayable: enrichment.netPayable,
    );
  }

  ItemDetails _itemDetailsFromRow(Map<String, dynamic> ir) {
    final rate = _toDouble(ir['rate']);
    final quantity = _toDouble(ir['quantity']);
    final storedAmount = _toDouble(ir['amount']);
    final amount =
        storedAmount > 0 ? storedAmount : (rate > 0 ? rate * quantity : 0.0);
    final displayRate =
        rate > 0 ? rate : (quantity > 0 ? amount / quantity : 0.0);
    return ItemDetails(
      item: ir['item'] as String?,
      name: ir['name'] as String?,
      rate: displayRate,
      quantity: quantity,
      amount: amount,
    );
  }

  Future<List<PaymentDetails>> _paymentsForInvoice(String invoiceName) async {
    final byRef = await _db.query(
      'Payment',
      where: 'referenceId = ? AND cancelled = 0',
      whereArgs: [invoiceName],
      orderBy: 'date ASC',
    );
    if (byRef.isNotEmpty) {
      return byRef.map(_paymentDetailsFromRow).toList();
    }

    final viaPaymentFor = await _db.rawQuery(
      '''
      SELECT p.name, p.paymentMethod, p.amount, p.date, p.referenceId
      FROM Payment p
      INNER JOIN PaymentFor pf ON p.name = pf.parent
      WHERE pf.referenceName = ? AND p.cancelled = 0
      ORDER BY p.date ASC
      ''',
      [invoiceName],
    );
    return viaPaymentFor.map(_paymentDetailsFromRow).toList();
  }

  PaymentDetails _paymentDetailsFromRow(Map<String, dynamic> r) {
    final rawDate = r['date']?.toString();
    return PaymentDetails(
      paymentId: r['name'] as String?,
      paymentMethod: r['paymentMethod'] as String?,
      amount: _toDouble(r['amount']),
      date: rawDate != null ? DateTime.tryParse(rawDate) : null,
      referenceId: r['referenceId'] as String?,
    );
  }

  Map<String, dynamic>? _paymentTotalsFromList(List<PaymentDetails> payments) {
    if (payments.isEmpty) return null;
    final totals = <String, dynamic>{};
    for (final p in payments) {
      final label = (p.paymentMethod ?? 'Payment').trim();
      if (label.isEmpty) continue;
      final prev = _toDouble(totals[label]);
      totals[label] = prev + (p.amount ?? 0);
    }
    return totals.isEmpty ? null : totals;
  }

  Future<void> _applyPaymentLinesToInvoice({
    required Database db,
    required String table,
    required String invoiceName,
    required String partyName,
    required bool isPurchase,
    required List<CreateInvoicePaymentLine>? lines,
    required String createdBy,
    required String now,
  }) async {
    if (lines == null || lines.isEmpty) return;
    var paidTotal = 0.0;
    final refType = isPurchase ? 'PurchaseInvoice' : 'SalesInvoice';
    for (final pay in lines) {
      final amt = pay.amount;
      if (amt <= 0) continue;
      paidTotal += amt;
      final date = pay.paymentDate.trim().isEmpty ? now : pay.paymentDate;
      await _recordPayment(
        db: db,
        invoiceName: invoiceName,
        partyName: partyName,
        amount: amt,
        paymentMethod: pay.paymentMethod,
        paymentDate: date,
        createdBy: createdBy,
        now: now,
        referenceType: refType,
      );
    }
    if (paidTotal <= 0) return;
    final rows = await db.query(
      table,
      where: 'name = ?',
      whereArgs: [invoiceName],
      limit: 1,
    );
    if (rows.isEmpty) return;
    final current = _toDouble(rows.first['outstandingAmount']);
    final outstanding = (current - paidTotal).clamp(0.0, double.infinity);
    await db.update(
      table,
      {'outstandingAmount': outstanding.toStringAsFixed(11), 'modified': now},
      where: 'name = ?',
      whereArgs: [invoiceName],
    );
  }

  Future<void> _syncPartyOutstandingFromInvoices(
    String partyName,
    bool isPurchase,
  ) async {
    final name = partyName.trim();
    if (name.isEmpty) return;
    try {
      final db = await _db.database;
      final table = isPurchase ? 'PurchaseInvoice' : 'SalesInvoice';
      final rows = await db.rawQuery(
        '''
        SELECT COALESCE(SUM(CAST(outstandingAmount AS REAL)), 0) AS total
        FROM "$table"
        WHERE party = ?
          AND submitted = 1
          AND COALESCE(cancelled, 0) = 0
        ''',
        [name],
      );
      final total = _toDouble(rows.first['total']);
      await db.update(
        'Party',
        {
          'outstandingAmount': total.toStringAsFixed(11),
          'modified': DateTime.now().toIso8601String(),
        },
        where: 'name = ?',
        whereArgs: [name],
      );
    } catch (_) {}
  }

  bool _isTruthy(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is num) return value != 0;
    final raw = value.toString().trim().toLowerCase();
    return raw == '1' || raw == 'true';
  }

  Future<void> _recordPayment({
    required dynamic db,
    required String invoiceName,
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
    final payName = 'PAY-${(count + 1001)}';

    await db.insert(
      'Payment',
      {
        'name': payName,
        'numberSeries': 'PAY-',
        'party': partyName,
        'date': paymentDate,
        'paymentType': referenceType == 'SalesInvoice' ? 'Receive' : 'Pay',
        'account': referenceType == 'SalesInvoice' ? 'Debtors' : 'Creditors',
        'paymentAccount': await _paymentAccountFor(paymentMethod),
        'paymentMethod': paymentMethod,
        'amount': amount.toStringAsFixed(11),
        'writeoff': '0.00000000000',
        'referenceType': referenceType,
        'referenceId': invoiceName,
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

  Future<String> _paymentAccountFor(String paymentMethod) async {
    if (!getIt.isRegistered<BankAccountService>()) {
      return paymentMethod == 'Cash' ? 'Cash In Hand' : paymentMethod;
    }
    return getIt<BankAccountService>().paymentAccountForMethod(paymentMethod);
  }

  String _invoiceStatus(Map<String, dynamic> r) {
    if ((r['cancelled'] as int?) == 1) return 'Cancelled';
    if ((r['submitted'] as int?) == 1) {
      return _toDouble(r['outstandingAmount']) > 0 ? 'Unpaid' : 'Paid';
    }
    return 'Draft';
  }

  Future<void> _assertLiveSalesStock(List<StockMovementLine> lines) async {
    final tracking = _stock;
    if (tracking == null || !tracking.enabled) return;
    await tracking.refreshCache();
    final shortage = tracking.findSalesShortage(lines);
    if (shortage == null) return;
    final available = LiveStockTrackingService.formatQty(shortage.onHand);
    throw AppException(
      message: shortage.onHand <= 0
          ? '${shortage.item} is out of stock'
          : '${shortage.item} has only $available in stock',
    );
  }

  Future<void> _assertLiveSalesStockForInvoiceName(String? invoiceName) async {
    final name = invoiceName?.trim() ?? '';
    if (name.isEmpty) return;
    final items = await _db.query(
      'SalesInvoiceItem',
      where: 'parent = ?',
      whereArgs: [name],
    );
    if (items.isEmpty) return;
    await _assertLiveSalesStock([
      for (final item in items)
        StockMovementLine(
          item: item['item']?.toString() ?? '',
          quantity: _toDouble(item['quantity']),
          rate: _toDouble(item['rate']),
          location: LiveStockTrackingService.defaultLocation,
        ),
    ]);
  }

  double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }

  /// Date-only and midnight values mean "this calendar day", not 12:00 AM.
  /// When that day is today, store the actual save time.
  String _invoiceDateWithClock(String? raw, DateTime createdAt) {
    final trimmed = raw?.trim() ?? '';
    if (trimmed.isEmpty) return createdAt.toIso8601String();
    final parsed = DateTime.tryParse(trimmed.replaceFirst(' ', 'T'));
    if (parsed == null) return createdAt.toIso8601String();
    final local = parsed.toLocal();
    final hasClock = trimmed.contains(':') &&
        (local.hour != 0 || local.minute != 0 || local.second != 0);
    if (hasClock) return trimmed;
    final isToday = local.year == createdAt.year &&
        local.month == createdAt.month &&
        local.day == createdAt.day;
    if (!isToday) return trimmed;
    return createdAt.toIso8601String();
  }

  /// Older rows saved the invoice date as midnight. Show [created] when it
  /// falls on that same day so the list clock matches the save time.
  String? _invoiceDateForDisplay(String? date, String? created) {
    if (date == null || date.isEmpty) return created;
    final parsed = DateTime.tryParse(date.replaceFirst(' ', 'T'));
    if (parsed == null || created == null || created.isEmpty) return date;
    final local = parsed.toLocal();
    final midnight = local.hour == 0 && local.minute == 0 && local.second == 0;
    if (!midnight) return date;
    final createdAt = DateTime.tryParse(created.replaceFirst(' ', 'T'));
    if (createdAt == null) return date;
    final createdLocal = createdAt.toLocal();
    final sameDay = local.year == createdLocal.year &&
        local.month == createdLocal.month &&
        local.day == createdLocal.day;
    if (!sameDay) return date;
    return createdLocal.toIso8601String();
  }
}

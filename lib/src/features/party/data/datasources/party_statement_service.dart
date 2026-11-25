import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/party/domain/models/party_statement_model.dart';
import 'package:intl/intl.dart';

class PartyStatementService {
  PartyStatementService(this._db);

  final LocalDb _db;
  static final _isoDate = DateFormat('yyyy-MM-dd');
  static final _displayPeriod = DateFormat('MMM dd, yyyy');

  Future<PartyStatementModel> buildSupplierStatement({
    required String partyName,
    required DateTime dateFrom,
    required DateTime dateTo,
  }) async {
    try {
      final from = DateTime(dateFrom.year, dateFrom.month, dateFrom.day);
      final to = DateTime(dateTo.year, dateTo.month, dateTo.day, 23, 59, 59);
      final fromStr = _isoDate.format(from);
      final toStr = _isoDate.format(to);

      final partyRow = await _loadParty(partyName);
      if (partyRow == null) {
        throw AppException(message: 'Party not found');
      }

      final openingBalance = await _openingBalanceBefore(
        partyName: partyName,
        beforeDate: fromStr,
      );

      final invoices = await _loadPurchaseInvoices(
        partyName: partyName,
        from: fromStr,
        to: toStr,
      );
      final payments = await _loadPayments(
        partyName: partyName,
        from: fromStr,
        to: toStr,
      );

      final events = <_StatementEvent>[
        ...invoices.map(_StatementEvent.invoice),
        ...payments.map(_StatementEvent.payment),
      ]..sort((a, b) {
          final dateCmp = a.date.compareTo(b.date);
          if (dateCmp != 0) return dateCmp;
          return a.sortKey.compareTo(b.sortKey);
        });

      var running = openingBalance;
      final transactions = <PartyStatementTransaction>[];

      for (final event in events) {
        if (event.isInvoice) {
          running += event.total;
          transactions.add(
            PartyStatementTransaction(
              type: 'invoice',
              date: event.date,
              particulars: event.particulars,
              reference: event.reference,
              total: event.total,
              recPaidAmt: event.recPaidAmt,
              due: event.due,
              items: event.items,
              runningBalance: _round(running),
            ),
          );
        } else {
          running -= event.recPaidAmt;
          transactions.add(
            PartyStatementTransaction(
              type: 'payment',
              date: event.date,
              particulars: event.particulars,
              reference: event.reference,
              total: event.total,
              recPaidAmt: event.recPaidAmt,
              due: null,
              runningBalance: _round(running),
              paymentType: event.paymentType,
              paymentMethod: event.paymentMethod,
              remarks: event.remarks,
              references: event.references,
            ),
          );
        }
      }

      final totalPurchases = invoices.fold<double>(
        0,
        (sum, inv) => sum + inv.total,
      );
      final moneyOut = payments.fold<double>(
        0,
        (sum, pay) => sum + pay.recPaidAmt,
      );

      final role = _displayRole(partyRow['role']?.toString());
      final outstanding =
          _d(partyRow['outstandingAmount']);

      PartyStatementOpeningEntry? openingEntry;
      if (openingBalance.abs() > 0.005) {
        openingEntry = PartyStatementOpeningEntry(
          date: fromStr,
          particulars: 'Payable Opening Balance',
          total: _round(openingBalance),
          recPaidAmt: null,
          due: _round(openingBalance),
          runningBalance: _round(openingBalance),
        );
      }

      return PartyStatementModel(
        party: partyName,
        partyInfo: PartyStatementPartyInfo(
          name: partyName,
          role: role,
          email: partyRow['email']?.toString(),
          phone: partyRow['phone']?.toString(),
          address: partyRow['address']?.toString(),
          outstandingAmount: outstanding,
        ),
        role: role,
        period:
            '${_displayPeriod.format(from)} – ${_displayPeriod.format(to)}',
        dateFrom: fromStr,
        dateTo: toStr,
        summary: PartyStatementSummary(
          openingBalance: _round(openingBalance),
          totalPurchases: _round(totalPurchases),
          moneyOut: _round(moneyOut),
          closingBalance: _round(running),
          totalTransactions: transactions.length,
        ),
        openingEntry: openingEntry,
        transactions: transactions,
      );
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException(message: e.toString());
    }
  }

  Future<Map<String, dynamic>?> _loadParty(String partyName) async {
    final rows = await _db.query(
      'Party',
      where: 'name = ?',
      whereArgs: [partyName],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return rows.first;
  }

  Future<double> _openingBalanceBefore({
    required String partyName,
    required String beforeDate,
  }) async {
    final rows = await _db.rawQuery(
      '''
      SELECT
        COALESCE((
          SELECT SUM(CAST(grandTotal AS REAL))
          FROM PurchaseInvoice
          WHERE party = ?
            AND submitted = 1
            AND COALESCE(cancelled, 0) = 0
            AND substr(date, 1, 10) < ?
        ), 0) -
        COALESCE((
          SELECT SUM(CAST(amount AS REAL))
          FROM Payment
          WHERE party = ?
            AND paymentType = 'Pay'
            AND submitted = 1
            AND COALESCE(cancelled, 0) = 0
            AND date < ?
        ), 0) AS opening_balance
      ''',
      [partyName, beforeDate, partyName, beforeDate],
    );
    return _d(rows.first['opening_balance']);
  }

  Future<List<_StatementEvent>> _loadPurchaseInvoices({
    required String partyName,
    required String from,
    required String to,
  }) async {
    final rows = await _db.rawQuery(
      '''
      SELECT name, date, grandTotal, outstandingAmount
      FROM PurchaseInvoice
      WHERE party = ?
        AND submitted = 1
        AND COALESCE(cancelled, 0) = 0
        AND substr(date, 1, 10) >= ?
        AND substr(date, 1, 10) <= ?
      ORDER BY date ASC, name ASC
      ''',
      [partyName, from, to],
    );

    final events = <_StatementEvent>[];
    for (final row in rows) {
      final name = row['name']?.toString() ?? '';
      final date = _dateOnly(row['date']?.toString());
      final total = _d(row['grandTotal']);
      final outstanding = _d(row['outstandingAmount']);
      final paid = (total - outstanding).clamp(0.0, total);
      final items = await _loadInvoiceItems(name);

      events.add(
        _StatementEvent(
          isInvoice: true,
          date: date,
          sortKey: name,
          particulars: _purchaseParticulars(name),
          reference: name,
          total: total,
          recPaidAmt: paid,
          due: outstanding > 0.005 ? outstanding : null,
          items: items,
        ),
      );
    }
    return events;
  }

  Future<List<PartyStatementItem>> _loadInvoiceItems(String invoiceName) async {
    final rows = await _db.rawQuery(
      '''
      SELECT item, quantity, unit, rate, amount
      FROM PurchaseInvoiceItem
      WHERE parent = ?
      ORDER BY idx ASC
      ''',
      [invoiceName],
    );
    return rows
        .map(
          (r) => PartyStatementItem(
            item: r['item']?.toString() ?? 'Item',
            quantity: _d(r['quantity']),
            unit: r['unit']?.toString() ?? 'Unit',
            rate: _d(r['rate']),
            total: _d(r['amount']),
          ),
        )
        .toList();
  }

  Future<List<_StatementEvent>> _loadPayments({
    required String partyName,
    required String from,
    required String to,
  }) async {
    final rows = await _db.rawQuery(
      '''
      SELECT name, date, amount, paymentType, paymentMethod, referenceId
      FROM Payment
      WHERE party = ?
        AND paymentType = 'Pay'
        AND submitted = 1
        AND COALESCE(cancelled, 0) = 0
        AND date >= ?
        AND date <= ?
      ORDER BY date ASC, name ASC
      ''',
      [partyName, from, to],
    );

    final events = <_StatementEvent>[];
    for (final row in rows) {
      final name = row['name']?.toString() ?? '';
      final amount = _d(row['amount']);
      final refs = await _loadPaymentReferences(name);

      events.add(
        _StatementEvent(
          isInvoice: false,
          date: _dateOnly(row['date']?.toString()),
          sortKey: name,
          particulars: 'Payment Out (Pay)',
          reference: name,
          total: amount,
          recPaidAmt: amount,
          paymentType: row['paymentType']?.toString(),
          paymentMethod: row['paymentMethod']?.toString(),
          remarks: row['referenceId']?.toString(),
          references: refs.isEmpty ? [name] : refs,
        ),
      );
    }
    return events;
  }

  Future<List<String>> _loadPaymentReferences(String paymentName) async {
    final rows = await _db.rawQuery(
      '''
      SELECT referenceName
      FROM PaymentFor
      WHERE parent = ?
      ORDER BY idx ASC
      ''',
      [paymentName],
    );
    final refs = rows
        .map((r) => r['referenceName']?.toString() ?? '')
        .where((s) => s.isNotEmpty)
        .toList();
    return refs.isEmpty ? [paymentName] : refs;
  }

  String _purchaseParticulars(String invoiceName) {
    final stripped = invoiceName.replaceFirst(RegExp(r'^PINV-'), '');
    final number = int.tryParse(stripped);
    if (number != null) return 'Purchase #$number';
    return 'Purchase $invoiceName';
  }

  String _displayRole(String? raw) {
    final value = (raw ?? 'Supplier').trim();
    if (value.isEmpty) return 'Supplier';
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }

  String _dateOnly(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    return raw.length >= 10 ? raw.substring(0, 10) : raw;
  }

  double _d(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }

  double _round(double value) => double.parse(value.toStringAsFixed(2));
}

class _StatementEvent {
  const _StatementEvent({
    required this.isInvoice,
    required this.date,
    required this.sortKey,
    required this.particulars,
    this.reference,
    required this.total,
    required this.recPaidAmt,
    this.due,
    this.items,
    this.paymentType,
    this.paymentMethod,
    this.remarks,
    this.references,
  });

  factory _StatementEvent.invoice(_StatementEvent e) => e;
  factory _StatementEvent.payment(_StatementEvent e) => e;

  final bool isInvoice;
  final String date;
  final String sortKey;
  final String particulars;
  final String? reference;
  final double total;
  final double recPaidAmt;
  final double? due;
  final List<PartyStatementItem>? items;
  final String? paymentType;
  final String? paymentMethod;
  final String? remarks;
  final List<String>? references;
}

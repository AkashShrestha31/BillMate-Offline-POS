import 'dart:convert';

import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/helpers/session_helper.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/settings/domain/bank_account.dart';
import 'package:hotel/src/features/setup/domain/setup_field_limits.dart';

/// Bank leaf accounts from setup plus banks added in Settings.
class BankAccountService {
  BankAccountService(this._db);

  static const parentAccount = 'Bank Accounts';
  static const _detailsParent = 'BankAccountDetails';
  static const _settingsParent = 'AccountingSettings';

  final LocalDb _db;

  Future<List<BankAccount>> listBanks() async {
    await _ensureBankGroup();
    await _attachUnlinkedPaymentMethods();
    final db = await _db.database;
    final defaultName = await loadDefaultBankName();
    final rows = await db.query(
      'Account',
      where: 'accountType = ? AND COALESCE(isGroup, 0) = 0',
      whereArgs: const ['Bank'],
      orderBy: 'name ASC',
    );
    final details = await _loadAllDetails();
    return rows.map((row) {
      final name = (row['name'] as String?)?.trim() ?? '';
      final extra = details[name.toLowerCase()];
      return BankAccount(
        name: name,
        accountNumber: extra?.accountNumber,
        accountHolder: extra?.accountHolder,
        isDefault: defaultName != null &&
            defaultName.toLowerCase() == name.toLowerCase(),
      );
    }).where((bank) => bank.name.isNotEmpty).toList();
  }

  Future<String?> loadDefaultBankName() async {
    final rows = await _db.query(
      'SingleValue',
      where: 'parent = ? AND fieldname = ?',
      whereArgs: const [_settingsParent, 'bankName'],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    final value = rows.first['value']?.toString().trim();
    return (value == null || value.isEmpty) ? null : value;
  }

  Future<BankAccount> addBank({
    required String name,
    String? accountNumber,
    String? accountHolder,
    bool makeDefault = false,
  }) async {
    final trimmed = name.trim();
    SetupFieldLimits.assertBankNameLength(trimmed);
    if (trimmed.isEmpty) {
      throw const AppException(message: 'Bank name is required');
    }
    await _ensureBankGroup();
    final db = await _db.database;
    final existing = await db.query(
      'Account',
      where: 'LOWER(name) = ?',
      whereArgs: [trimmed.toLowerCase()],
      limit: 1,
    );
    if (existing.isNotEmpty) {
      throw const AppException(message: 'A bank with this name already exists');
    }

    final now = DateTime.now().toIso8601String();
    final actor =
        await SessionHelper.getUserIdentifierForPermissionsApi() ?? 'local';
    await db.insert('Account', {
      'name': trimmed,
      'rootType': 'Asset',
      'parentAccount': parentAccount,
      'accountType': 'Bank',
      'isGroup': 0,
      'createdBy': actor,
      'modifiedBy': actor,
      'created': now,
      'modified': now,
      'lft': 0,
      'rgt': 0,
    });
    await _saveDetails(
      name: trimmed,
      accountNumber: accountNumber,
      accountHolder: accountHolder,
    );

    final banks = await listBanks();
    if (makeDefault || banks.length == 1) {
      await setDefault(trimmed);
    }
    return BankAccount(
      name: trimmed,
      accountNumber: accountNumber?.trim(),
      accountHolder: accountHolder?.trim(),
      isDefault: makeDefault || banks.length == 1,
    );
  }

  Future<void> updateBank({
    required String originalName,
    required String name,
    String? accountNumber,
    String? accountHolder,
  }) async {
    final trimmed = name.trim();
    SetupFieldLimits.assertBankNameLength(trimmed);
    if (trimmed.isEmpty) {
      throw const AppException(message: 'Bank name is required');
    }
    if (trimmed.toLowerCase() != originalName.trim().toLowerCase()) {
      throw const AppException(
        message: 'Bank name cannot be changed after it is created',
      );
    }
    await _saveDetails(
      name: originalName.trim(),
      accountNumber: accountNumber,
      accountHolder: accountHolder,
    );
  }

  Future<void> setDefault(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    final previous = await loadDefaultBankName();
    final db = await _db.database;
    final now = DateTime.now().toIso8601String();
    final updated = await db.update(
      'SingleValue',
      {
        'value': trimmed,
        'modified': now,
        'modifiedBy': 'system',
      },
      where: 'parent = ? AND fieldname = ?',
      whereArgs: const [_settingsParent, 'bankName'],
    );
    if (updated == 0) {
      await db.insert('SingleValue', {
        'name': 'AccountingSettings-bankName',
        'parent': _settingsParent,
        'fieldname': 'bankName',
        'value': trimmed,
        'created': now,
        'modified': now,
        'createdBy': 'system',
        'modifiedBy': 'system',
      });
    }
    if (previous != null &&
        previous.isNotEmpty &&
        previous.toLowerCase() != trimmed.toLowerCase()) {
      await db.update(
        'PaymentMethod',
        {'account': trimmed, 'modified': now},
        where: 'account = ?',
        whereArgs: [previous],
      );
    }
    await _attachUnlinkedPaymentMethods(trimmed);
  }

  Future<void> deleteBank(String name) async {
    final remaining = await listBanks();
    if (remaining.length <= 1) {
      throw const AppException(
        message: 'At least one bank is required',
      );
    }
    final trimmed = name.trim();
    final db = await _db.database;
    final used = await db.rawQuery(
      '''
SELECT COUNT(*) AS c FROM Payment
WHERE submitted = 1
  AND (
    paymentAccount = ?
    OR paymentMethod = ?
    OR paymentMethod IN (
      SELECT name FROM PaymentMethod WHERE account = ?
    )
  )
''',
      [trimmed, trimmed, trimmed],
    );
    final count = (used.first['c'] as num?)?.toInt() ?? 0;
    if (count > 0) {
      throw const AppException(
        message: 'This bank has payments. It cannot be deleted.',
      );
    }
    await db.delete('Account', where: 'name = ?', whereArgs: [trimmed]);
    await db.delete(
      'SingleValue',
      where: 'parent = ? AND fieldname = ?',
      whereArgs: [_detailsParent, trimmed],
    );
    final defaultName = await loadDefaultBankName();
    if (defaultName != null &&
        defaultName.toLowerCase() == trimmed.toLowerCase()) {
      final remaining = await listBanks();
      if (remaining.isNotEmpty) {
        await setDefault(remaining.first.name);
      }
    }
  }

  /// Account used when posting a payment for [paymentMethod].
  Future<String> paymentAccountForMethod(String paymentMethod) async {
    final method = paymentMethod.trim();
    if (method.toLowerCase() == 'cash') return 'Cash In Hand';

    final rows = await _db.query(
      'PaymentMethod',
      where: 'name = ?',
      whereArgs: [method],
      limit: 1,
    );
    final linked = rows.isEmpty
        ? null
        : (rows.first['account'] as String?)?.trim();
    if (linked != null && linked.isNotEmpty) {
      return linked;
    }

    final defaultBank = await loadDefaultBankName();
    if (defaultBank != null && defaultBank.isNotEmpty) return defaultBank;
    return method;
  }

  Future<BankReport> reportFor(String bankName) async {
    final banks = await listBanks();
    final bank = banks.firstWhere(
      (item) => item.name.toLowerCase() == bankName.trim().toLowerCase(),
      orElse: () => BankAccount(name: bankName.trim()),
    );
    final rows = await _db.rawQuery(
      '''
SELECT p.name, p.date, p.paymentType, p.amount, p.party, p.paymentMethod,
       p.referenceId
FROM Payment p
LEFT JOIN PaymentMethod m ON m.name = p.paymentMethod
WHERE COALESCE(p.submitted, 0) = 1
  AND COALESCE(p.cancelled, 0) = 0
  AND (
    p.paymentAccount = ?
    OR p.paymentMethod = ?
    OR m.account = ?
  )
ORDER BY p.date DESC, p.created DESC
''',
      [bank.name, bank.name, bank.name],
    );

    final lines = <BankLedgerLine>[];
    var incoming = 0.0;
    var outgoing = 0.0;
    for (final row in rows) {
      final amount = double.tryParse('${row['amount'] ?? 0}') ?? 0;
      final line = BankLedgerLine(
        name: '${row['name'] ?? ''}',
        date: '${row['date'] ?? ''}',
        paymentType: '${row['paymentType'] ?? ''}',
        amount: amount,
        paymentMethod: '${row['paymentMethod'] ?? ''}',
        party: (row['party'] as String?)?.trim(),
        referenceId: (row['referenceId'] as String?)?.trim(),
      );
      if (line.isIncoming) {
        incoming += amount;
      } else {
        outgoing += amount;
      }
      lines.add(line);
    }
    return BankReport(
      bank: bank,
      incoming: incoming,
      outgoing: outgoing,
      lines: lines,
    );
  }

  Future<void> _attachUnlinkedPaymentMethods([String? bankName]) async {
    final target = (bankName ?? await loadDefaultBankName())?.trim();
    if (target == null || target.isEmpty) return;
    final now = DateTime.now().toIso8601String();
    await _db.run((db) async {
      await db.rawUpdate(
        '''
UPDATE PaymentMethod
SET account = ?, modified = ?
WHERE LOWER(TRIM(COALESCE(type, ''))) != 'cash'
  AND LOWER(TRIM(COALESCE(name, ''))) != 'cash'
  AND (
    account IS NULL
    OR TRIM(account) = ''
  )
''',
        [target, now],
      );
    });
  }

  Future<void> _ensureBankGroup() async {
    final db = await _db.database;
    final rows = await db.query(
      'Account',
      where: 'name = ?',
      whereArgs: const [parentAccount],
      limit: 1,
    );
    if (rows.isNotEmpty) return;
    final now = DateTime.now().toIso8601String();
    await db.insert('Account', {
      'name': parentAccount,
      'rootType': 'Asset',
      'parentAccount': 'Current Assets',
      'accountType': 'Bank',
      'isGroup': 1,
      'createdBy': 'system',
      'modifiedBy': 'system',
      'created': now,
      'modified': now,
      'lft': 0,
      'rgt': 0,
    });
  }

  Future<Map<String, ({String? accountNumber, String? accountHolder})>>
      _loadAllDetails() async {
    final rows = await _db.query(
      'SingleValue',
      where: 'parent = ?',
      whereArgs: const [_detailsParent],
    );
    final map = <String, ({String? accountNumber, String? accountHolder})>{};
    for (final row in rows) {
      final key = (row['fieldname'] as String?)?.trim().toLowerCase() ?? '';
      if (key.isEmpty) continue;
      map[key] = _decodeDetails(row['value']?.toString());
    }
    return map;
  }

  Future<void> _saveDetails({
    required String name,
    String? accountNumber,
    String? accountHolder,
  }) async {
    final db = await _db.database;
    final now = DateTime.now().toIso8601String();
    final value = jsonEncode({
      'accountNumber': accountNumber?.trim() ?? '',
      'accountHolder': accountHolder?.trim() ?? '',
    });
    final updated = await db.update(
      'SingleValue',
      {
        'value': value,
        'modified': now,
        'modifiedBy': 'system',
      },
      where: 'parent = ? AND fieldname = ?',
      whereArgs: [_detailsParent, name],
    );
    if (updated > 0) return;
    await db.insert('SingleValue', {
      'name': '$_detailsParent-$name',
      'parent': _detailsParent,
      'fieldname': name,
      'value': value,
      'created': now,
      'modified': now,
      'createdBy': 'system',
      'modifiedBy': 'system',
    });
  }

  ({String? accountNumber, String? accountHolder}) _decodeDetails(
    String? raw,
  ) {
    if (raw == null || raw.trim().isEmpty) {
      return (accountNumber: null, accountHolder: null);
    }
    try {
      final map = jsonDecode(raw);
      if (map is! Map) {
        return (accountNumber: null, accountHolder: null);
      }
      String? clean(Object? value) {
        final text = value?.toString().trim();
        return (text == null || text.isEmpty) ? null : text;
      }

      return (
        accountNumber: clean(map['accountNumber']),
        accountHolder: clean(map['accountHolder']),
      );
    } catch (_) {
      return (accountNumber: null, accountHolder: null);
    }
  }
}

import 'package:sqflite/sqflite.dart';

/// Creates and updates [Party] rows for staff (`role` = Employee), aligned with
/// [local_books_bootstrap] admin seeding.
class EmployeePartyHelper {
  EmployeePartyHelper._();

  static const String role = 'Employee';

  static String displayName(String fullName) => '$fullName - Employee';

  static Future<String> resolveDefaultCurrency(DatabaseExecutor db) async {
    final rows = await db.query('Currency', columns: ['name'], limit: 1);
    if (rows.isEmpty) return 'NPR';
    return rows.first['name']! as String;
  }

  static Future<int> nextPartyId(DatabaseExecutor db) async {
    final rows =
        await db.rawQuery('SELECT COALESCE(MAX(id), 0) + 1 AS nextId FROM Party');
    return rows.first['nextId']! as int;
  }

  /// Picks [baseName] or `baseName (2)`, … when another party already uses the name.
  static Future<String> uniquePartyName(
    DatabaseExecutor db,
    String baseName, {
    String? keepIfSame,
  }) async {
    var candidate = baseName;
    var suffix = 2;
    while (true) {
      final existing = await db.query(
        'Party',
        where: 'name = ?',
        whereArgs: [candidate],
        limit: 1,
      );
      if (existing.isEmpty || candidate == keepIfSame) return candidate;
      candidate = '$baseName ($suffix)';
      suffix++;
    }
  }

  static Future<void> insertParty(
    DatabaseExecutor db, {
    required String partyName,
    String? email,
    String? phone,
    String? address,
    required String createdBy,
    required String now,
  }) async {
    await db.insert('Party', {
      'id': await nextPartyId(db),
      'name': partyName,
      'role': role,
      'email': email ?? '',
      'phone': phone ?? '',
      if (address != null && address.isNotEmpty) 'address': address,
      'defaultAccount': 'Debtors',
      'currency': await resolveDefaultCurrency(db),
      'loyaltyPoints': 0,
      'outstandingAmount': '0.00000000000',
      'status': 1,
      'created': now,
      'modified': now,
      'createdBy': createdBy,
      'modifiedBy': createdBy,
    });
  }

  /// Ensures a party exists and is up to date; returns the party [name] (PK).
  static Future<String> syncPartyForEmployee(
    DatabaseExecutor db, {
    required String fullName,
    required String? currentPartyId,
    String? email,
    String? phone,
    String? address,
    required String actor,
    required String now,
    required int activeStatus,
  }) async {
    final baseName = displayName(fullName);
    final resolvedEmail = email ?? '';
    final resolvedPhone = phone ?? '';
    final resolvedAddress = address ?? '';

    if (currentPartyId == null || currentPartyId.trim().isEmpty) {
      final partyName = await uniquePartyName(db, baseName);
      await insertParty(
        db,
        partyName: partyName,
        email: resolvedEmail.isEmpty ? null : resolvedEmail,
        phone: resolvedPhone.isEmpty ? null : resolvedPhone,
        address: resolvedAddress.isEmpty ? null : resolvedAddress,
        createdBy: actor,
        now: now,
      );
      return partyName;
    }

    final existing = await db.query(
      'Party',
      where: 'name = ?',
      whereArgs: [currentPartyId],
      limit: 1,
    );
    if (existing.isEmpty) {
      final partyName = await uniquePartyName(db, baseName);
      await insertParty(
        db,
        partyName: partyName,
        email: resolvedEmail.isEmpty ? null : resolvedEmail,
        phone: resolvedPhone.isEmpty ? null : resolvedPhone,
        address: resolvedAddress.isEmpty ? null : resolvedAddress,
        createdBy: actor,
        now: now,
      );
      return partyName;
    }

    final newName = await uniquePartyName(db, baseName, keepIfSame: currentPartyId);
    await db.update(
      'Party',
      {
        'name': newName,
        'role': role,
        'email': resolvedEmail,
        'phone': resolvedPhone,
        'address': resolvedAddress,
        'status': activeStatus,
        'modified': now,
        'modifiedBy': actor,
      },
      where: 'name = ?',
      whereArgs: [currentPartyId],
    );
    return newName;
  }

  static Future<void> deactivateParty(
    DatabaseExecutor db, {
    required String partyName,
    required String actor,
    required String now,
  }) async {
    await db.update(
      'Party',
      {
        'status': 0,
        'modified': now,
        'modifiedBy': actor,
      },
      where: 'name = ?',
      whereArgs: [partyName],
    );
  }
}

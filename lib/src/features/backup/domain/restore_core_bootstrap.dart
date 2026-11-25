import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hotel/src/core/services/token_storage.dart';
import 'package:hotel/src/features/backup/domain/drive_restore_debug.dart';
import 'package:hotel/src/features/backup/domain/models/organization_backup_meta.dart';
import 'package:hotel/src/features/setup/domain/default_books_single_values.dart';
import 'package:hotel/src/features/setup/domain/local_books_database_health.dart';
import 'package:hotel/src/features/setup/domain/local_setup_storage.dart';
import 'package:sqflite/sqflite.dart';

/// Seeds missing core tables after a partial (incremental-only) Drive restore.
abstract final class RestoreCoreBootstrap {
  static const _coaAsset = 'assets/data/chart_of_accounts.json';

  /// Ensures FK targets exist for invoicing, payments, and stock flows.
  static Future<void> ensureTransactionalReferences(
    Database db, {
    required String email,
  }) async {
    final actor = email.trim().isNotEmpty ? email.trim() : 'system';
    await db.transaction((txn) async {
      await _seedNumberSeriesIfMissing(txn, email: actor);
      await _seedLocationIfMissing(txn, email: actor);
      await _seedUomIfMissing(txn, email: actor);
    });
  }

  /// Repairs a local database that exists but fails the startup health probe.
  static Future<bool> repairIfUnhealthy({
    required Database db,
    required String canonicalSlug,
    String? email,
    String? displayName,
  }) async {
    if (await LocalBooksDatabaseHealth.isHealthyDatabase(db)) return true;

    var resolvedEmail = email?.trim().toLowerCase();
    resolvedEmail ??= (await LocalSetupStorage.getSavedAdminEmail())
        ?.trim()
        .toLowerCase();
    resolvedEmail ??= (await TokenStorage.getUserLoginEmail())
        ?.trim()
        .toLowerCase();
    if (resolvedEmail == null || resolvedEmail.isEmpty) return false;

    final name = displayName?.trim().isNotEmpty == true
        ? displayName!.trim()
        : resolvedEmail.split('@').first;

    DriveRestoreDebug.log(
      'startup repair: seeding missing core rows slug=$canonicalSlug',
    );

    await DefaultBooksSingleValues.ensureMissingOnDatabase(
      db,
      overrides: {
        'Organization': {
          'organizationSlug': canonicalSlug,
        },
        'AccountingSettings': {
          'email': resolvedEmail,
          'setupComplete': '1',
        },
      },
      createdBy: resolvedEmail,
    );

    await db.transaction((txn) async {
      await _seedChartOfAccountsIfEmpty(txn, email: resolvedEmail!);
      await _seedNumberSeriesIfMissing(txn, email: resolvedEmail);
      await _seedLocationIfMissing(txn, email: resolvedEmail);
      await _seedUomIfMissing(txn, email: resolvedEmail);
      await _seedAdminEmployeeIfEmpty(
        txn,
        email: resolvedEmail,
        fullName: name,
      );
    });

    return LocalBooksDatabaseHealth.isHealthyDatabase(db);
  }

  static Future<bool> applyIfNeeded({
    required Database db,
    required OrganizationBackupMeta meta,
    required String canonicalSlug,
  }) async {
    if (await LocalBooksDatabaseHealth.isHealthyDatabase(db)) {
      return false;
    }

    DriveRestoreDebug.log('partial backup detected — seeding missing core tables');

    final email = meta.adminEmail?.trim().toLowerCase();
    if (email == null || email.isEmpty) {
      DriveRestoreDebug.log(
        'core bootstrap skipped: backup meta has no admin login email',
      );
      return false;
    }

    final displayName = meta.name.trim().isNotEmpty
        ? meta.name.trim()
        : email.split('@').first;

    await DefaultBooksSingleValues.ensureMissingOnDatabase(
      db,
      overrides: {
        'Organization': {
          'organizationSlug': canonicalSlug,
          'organizationCode': meta.code.trim().toUpperCase(),
          'organizationName': displayName,
          'companyName': displayName,
          if (meta.businessType != null && meta.businessType!.isNotEmpty)
            'businessType': meta.businessType!,
        },
        'AccountingSettings': {
          'email': email,
          'companyName': displayName,
          'setupComplete': '1',
        },
      },
      createdBy: email,
    );

    await db.transaction((txn) async {
      await _seedChartOfAccountsIfEmpty(txn, email: email);
      await _seedNumberSeriesIfMissing(txn, email: email);
      await _seedLocationIfMissing(txn, email: email);
      await _seedUomIfMissing(txn, email: email);
      await _seedAdminEmployeeIfEmpty(
        txn,
        email: email,
        fullName: displayName,
      );
    });

    final healthy = await LocalBooksDatabaseHealth.isHealthyDatabase(db);
    DriveRestoreDebug.log('core bootstrap finished healthy=$healthy');
    return healthy;
  }

  static Future<void> _seedChartOfAccountsIfEmpty(
    Transaction txn, {
    required String email,
  }) async {
    final count = Sqflite.firstIntValue(
      await txn.rawQuery('SELECT COUNT(*) FROM Account'),
    );
    if ((count ?? 0) > 0) return;

    DriveRestoreDebug.log('seeding chart of accounts (Account was empty)');
    final now = DateTime.now().toIso8601String();
    final raw = await rootBundle.loadString(_coaAsset);
    final list = jsonDecode(raw) as List<dynamic>;

    for (final item in list) {
      final map = item as Map<String, dynamic>;
      var name = map['name'] as String;
      if (name == '__BANK_PLACEHOLDER__') {
        name = 'Bank';
      }
      await txn.insert(
        'Account',
        {
          'name': name,
          'rootType': map['rootType'],
          'parentAccount': map['parentAccount'],
          'accountType': map['accountType'],
          'isGroup': map['isGroup'] ?? 0,
          'created': now,
          'modified': now,
          'createdBy': email,
          'modifiedBy': email,
          'lft': 0,
          'rgt': 0,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  static Future<void> _seedAdminEmployeeIfEmpty(
    Transaction txn, {
    required String email,
    required String fullName,
  }) async {
    final count = Sqflite.firstIntValue(
      await txn.rawQuery('SELECT COUNT(*) FROM Employee'),
    );
    if ((count ?? 0) > 0) return;

    DriveRestoreDebug.log('seeding admin Employee from backup login meta');
    final now = DateTime.now().toIso8601String();
    final parts = fullName.trim().split(RegExp(r'\s+'));
    final firstName = parts.first;
    final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : 'User';
    final partyName = '$fullName - Employee';

    final partyCount = Sqflite.firstIntValue(
      await txn.rawQuery('SELECT COUNT(*) FROM Party'),
    );
    if ((partyCount ?? 0) == 0) {
      final partyIdRows = await txn.rawQuery(
        'SELECT COALESCE(MAX(id), 0) + 1 AS nextId FROM Party',
      );
      final nextPartyId = partyIdRows.first['nextId'] as int;

      await txn.insert('Party', {
        'id': nextPartyId,
        'name': partyName,
        'role': 'Employee',
        'email': email,
        'phone': '',
        'defaultAccount': 'Debtors',
        'currency': 'NPR',
        'loyaltyPoints': 0,
        'outstandingAmount': '0.00000000000',
        'created': now,
        'modified': now,
        'createdBy': email,
        'modifiedBy': email,
      });
    }

    await txn.insert('Employee', {
      'employee_code': 'EMP001',
      'first_name': firstName,
      'last_name': lastName,
      'full_name': fullName,
      'email': email,
      'phone': '',
      'hire_date': now.substring(0, 10),
      'department': 'Management',
      'position': 'Supervisor',
      'employment_type': 'FULL_TIME',
      'employment_status': 'ACTIVE',
      'basic_salary': 0,
      'hourly_rate': 0,
      'working_hours_per_day': 8,
      'working_days_per_week': 6,
      'is_active': 1,
      'party_id': partyName,
      'notes': 'Restored administrator',
      'created_by': email,
      'modified_by': email,
      'created': now,
      'modified': now,
    });
  }

  static Future<void> _seedNumberSeriesIfMissing(
    Transaction txn, {
    required String email,
  }) async {
    const series = [
      ('SINV-', 'SalesInvoice'),
      ('PINV-', 'PurchaseInvoice'),
      ('PAY-', 'Payment'),
      ('JV-', 'JournalEntry'),
    ];
    final now = DateTime.now().toIso8601String();

    for (final entry in series) {
      final existing = await txn.query(
        'NumberSeries',
        columns: ['name'],
        where: 'name = ?',
        whereArgs: [entry.$1],
        limit: 1,
      );
      if (existing.isNotEmpty) continue;

      DriveRestoreDebug.log('seeding NumberSeries ${entry.$1}');
      await txn.insert('NumberSeries', {
        'name': entry.$1,
        'start': 1001,
        'padZeros': 4,
        'referenceType': entry.$2,
        'current': 1001,
        'created': now,
        'modified': now,
        'createdBy': email,
        'modifiedBy': email,
      });
    }
  }

  static Future<void> _seedLocationIfMissing(
    Transaction txn, {
    required String email,
  }) async {
    final count = Sqflite.firstIntValue(
      await txn.rawQuery('SELECT COUNT(*) FROM Location'),
    );
    if ((count ?? 0) > 0) return;

    DriveRestoreDebug.log('seeding default Location');
    final now = DateTime.now().toIso8601String();
    await txn.insert('Location', {
      'name': 'Stores',
      'created': now,
      'modified': now,
      'createdBy': email,
      'modifiedBy': email,
    });
  }

  static Future<void> _seedUomIfMissing(
    Transaction txn, {
    required String email,
  }) async {
    final existing = await txn.query(
      'UOM',
      columns: ['name'],
      where: 'name = ?',
      whereArgs: ['Unit'],
      limit: 1,
    );
    if (existing.isNotEmpty) return;

    DriveRestoreDebug.log('seeding default UOM Unit');
    final now = DateTime.now().toIso8601String();
    await txn.insert('UOM', {
      'name': 'Unit',
      'created': now,
      'modified': now,
      'createdBy': email,
      'modifiedBy': email,
    });
  }
}

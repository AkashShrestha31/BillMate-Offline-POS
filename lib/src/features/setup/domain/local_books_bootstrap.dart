import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/org/domain/organization_business_type.dart';
import 'package:hotel/src/features/setup/data/models/setup_complete_request.dart';
import 'package:hotel/src/features/setup/domain/business_type_default_categories.dart';
import 'package:hotel/src/features/setup/domain/currency_seed_data.dart';
import 'package:hotel/src/features/setup/domain/default_books_single_values.dart';
import 'package:hotel/src/features/setup/domain/setup_region_options.dart';
import 'package:sqflite/sqflite.dart';

/// Seeds a fresh books database (backend `insert_initial_books_data`).
class LocalBooksBootstrap {
  LocalBooksBootstrap(this._db);

  final LocalDb _db;

  static const _coaAsset = 'assets/data/chart_of_accounts.json';

  Future<void> seed(
    SetupCompleteRequest request, {
    bool enableTestDataTools = false,
  }) async {
    final now = DateTime.now().toIso8601String();
    final email = request.email.trim().toLowerCase();
    final (countryCode, locale) =
        SetupRegionOptions.localeForCountry(request.country);

    await _db.transactionIgnoringForeignKeys((txn) async {
      await _seedSingleValues(
        txn,
        request,
        email,
        now,
        locale,
        countryCode,
        enableTestDataTools: enableTestDataTools,
      );
      await _seedChartOfAccounts(txn, request.bankName, email, now);
      await _seedCurrencies(txn, email, now);
      await _seedUoms(txn, email, now);
      await _seedLocation(txn, email, now);
      await _seedNumberSeries(txn, email, now);
      await _seedAdminEmployeeAndParty(txn, request, email, now);
      await _seedPaymentMethods(txn, request.bankName, email, now);
      await _seedRoles(txn, email, now);
      await _seedCategories(txn, now, request.businessType);
      if (OrganizationBusinessType.supportsLiquorCalculator(request.businessType)) {
        await _seedLiquorCategories(txn, email, now);
      }
    });
  }

  Future<void> _seedSingleValues(
    Transaction txn,
    SetupCompleteRequest request,
    String email,
    String now,
    String locale,
    String countryCode, {
    bool enableTestDataTools = false,
  }) async {
    final instanceId =
        '${request.organizationSlug.hashCode.abs()}-${now.hashCode.abs().toRadixString(36)}';

    final allValues = await DefaultBooksSingleValues.all(
      overrides: {
        'AccountingSettings': {
          'companyName': request.companyName,
          'fullname': request.fullName,
          'email': email,
          'country': request.country,
          'bankName': request.bankName,
          'fiscalYearStart': request.fiscalYearStart,
          'fiscalYearEnd': request.fiscalYearEnd,
          'defaultTaxRate': request.defaultTaxRate.toString(),
          'taxMode': request.taxMode,
          'taxKind': request.taxKind,
          'taxIdLabel': request.taxIdLabel ?? '',
          'taxIdNumber': request.taxIdNumber ?? '',
          'setupComplete': '1',
        },
        'SystemSettings': {
          'locale': locale,
          'currency': request.currency,
          'countryCode': countryCode,
          'instanceId': instanceId,
        },
        'PrintSettings': {
          'companyName': request.companyName,
          'email': email,
          if (request.logo != null && request.logo!.trim().isNotEmpty)
            'logo': request.logo!.trim(),
        },
        'Organization': {
          'organizationCode': request.organizationCode.toUpperCase(),
          'organizationName': request.organizationName,
          'organizationSlug': request.organizationSlug,
          'companyName': request.companyName,
          'businessType': request.businessType,
          'showTestData': enableTestDataTools ? '1' : '0',
          if (request.logo != null && request.logo!.trim().isNotEmpty)
            'logo': request.logo!.trim(),
        },
      },
    );

    for (final parentEntry in allValues.entries) {
      for (final fieldEntry in parentEntry.value.entries) {
        await _insertSingleValue(
          txn,
          parent: parentEntry.key,
          fieldname: fieldEntry.key,
          value: fieldEntry.value,
          email: email,
          now: now,
        );
      }
    }
  }

  Future<void> _insertSingleValue(
    Transaction txn, {
    required String parent,
    required String fieldname,
    required String value,
    required String email,
    required String now,
  }) async {
    final name = '$parent-$fieldname-${now.hashCode.abs()}';
    await txn.insert('SingleValue', {
      'name': name,
      'parent': parent,
      'fieldname': fieldname,
      'value': value,
      'created': now,
      'modified': now,
      'createdBy': email,
      'modifiedBy': email,
    });
  }

  Future<void> _seedChartOfAccounts(
    Transaction txn,
    String bankName,
    String email,
    String now,
  ) async {
    final raw = await rootBundle.loadString(_coaAsset);
    final list = jsonDecode(raw) as List<dynamic>;

    for (final item in list) {
      final map = item as Map<String, dynamic>;
      var name = map['name'] as String;
      if (name == '__BANK_PLACEHOLDER__') {
        name = bankName;
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

  Future<void> _seedAdminEmployeeAndParty(
    Transaction txn,
    SetupCompleteRequest request,
    String email,
    String now,
  ) async {
    final parts = request.fullName.trim().split(RegExp(r'\s+'));
    final firstName = parts.first;
    final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : 'User';
    final partyName = '${request.fullName} - Employee';

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
      'currency': request.currency,
      'loyaltyPoints': 0,
      'outstandingAmount': '0.00000000000',
      'created': now,
      'modified': now,
      'createdBy': email,
      'modifiedBy': email,
    });

    final employeeId = await txn.insert('Employee', {
      'employee_code': 'EMP001',
      'first_name': firstName,
      'last_name': lastName,
      'full_name': request.fullName,
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
      'notes': 'System Administrator - Supervisor',
      'created_by': email,
      'modified_by': email,
      'created': now,
      'modified': now,
    });

    await txn.insert('EmployeeSalary', {
      'employee_id': employeeId,
      'effective_date': now.substring(0, 10),
      'basic_salary': 0,
      'hourly_rate': 0,
      'overtime_rate': 0,
      'gross_salary': 0,
      'net_salary': 0,
      'is_active': 1,
      'created_by': email,
      'modified_by': email,
      'created': now,
      'modified': now,
    });
  }

  Future<void> _seedCurrencies(Transaction txn, String email, String now) async {
    final currencies = await CurrencySeedData.loadFromAsset();
    for (final row in currencies) {
      await txn.insert(
        'Currency',
        row.toDbMap(createdBy: email, modifiedBy: email, timestamp: now),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> _seedUoms(Transaction txn, String email, String now) async {
    for (final name in ['Unit', 'Kg', 'Gram', 'Liter', 'Meter']) {
      await txn.insert('UOM', {
        'name': name,
        'isWhole': 0,
        'created': now,
        'modified': now,
        'createdBy': email,
        'modifiedBy': email,
      });
    }
  }

  Future<void> _seedLocation(Transaction txn, String email, String now) async {
    await txn.insert('Location', {
      'name': 'Stores',
      'created': now,
      'modified': now,
      'createdBy': email,
      'modifiedBy': email,
    });
  }

  Future<void> _seedNumberSeries(Transaction txn, String email, String now) async {
    const series = [
      ('SINV-', 'SalesInvoice'),
      ('PINV-', 'PurchaseInvoice'),
      ('PAY-', 'Payment'),
      ('JV-', 'JournalEntry'),
    ];
    for (final s in series) {
      await txn.insert('NumberSeries', {
        'name': s.$1,
        'start': 1001,
        'padZeros': 4,
        'referenceType': s.$2,
        'current': 1001,
        'created': now,
        'modified': now,
        'createdBy': email,
        'modifiedBy': email,
      });
    }
  }

  Future<void> _seedPaymentMethods(
    Transaction txn,
    String bankName,
    String email,
    String now,
  ) async {
    const methods = [
      ('Cash', 'Cash', 'Cash'),
      ('QR', 'Bank', null),
      ('Card', 'Bank', null),
    ];
    for (final m in methods) {
      await txn.insert('PaymentMethod', {
        'name': m.$1,
        'type': m.$2,
        'account': m.$3 ?? bankName,
        'created': now,
        'modified': now,
        'createdBy': email,
        'modifiedBy': email,
      });
    }
  }

  Future<void> _seedRoles(Transaction txn, String email, String now) async {
    const roles = [
      ('Customer', 'Parties who buy from you', 1, true),
      ('Supplier', 'Parties you purchase from', 2, true),
      ('Both', 'Shows under Customer and Supplier tabs', 3, true),
      ('Employee', 'Staff linked as a party', 4, true),
    ];
    for (final r in roles) {
      await txn.insert(
        'Role',
        {
          'name': r.$1,
          'description': r.$2,
          'sort_order': r.$3,
          'is_system': r.$4 ? 1 : 0,
          'created_by': email,
          'modified_by': email,
          'created': now,
          'modified': now,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  Future<void> _seedCategories(
    Transaction txn,
    String now,
    String businessType,
  ) async {
    for (final category in BusinessTypeDefaultCategories.forBusinessType(
      businessType,
    )) {
      await txn.insert(
        'Category',
        {
          'name': category,
          'created': now,
          'modified': now,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  Future<void> _seedLiquorCategories(
    Transaction txn,
    String email,
    String now,
  ) async {
    const cats = [
      ('Whiskey', 'Premium whiskey and scotch'),
      ('Vodka', 'Premium vodka brands'),
      ('Rum', 'White and dark rum varieties'),
      ('Beer', 'Local and imported beers'),
      ('Wine', 'Red and white wines'),
    ];
    for (final c in cats) {
      await txn.insert('LiquorCategory', {
        'name': c.$1,
        'description': c.$2,
        'isActive': 1,
        'createdBy': email,
        'created': now,
        'modified': now,
      });
    }
  }
}

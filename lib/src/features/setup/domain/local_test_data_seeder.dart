import 'dart:io';
import 'dart:math';

import 'package:hotel/src/core/constants/test_data_constants.dart';
import 'package:hotel/src/core/helpers/employee_party_helper.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/core/services/org/org_registry_storage.dart';
import 'package:hotel/src/features/org/domain/organization_business_type.dart';
import 'package:hotel/src/features/org/domain/organization_database_service.dart';
import 'package:hotel/src/features/setup/data/models/setup_complete_request.dart';
import 'package:hotel/src/features/setup/domain/demo_data_freemium_limits.dart';
import 'package:hotel/src/features/setup/domain/test_data_organization_seeder.dart';
import 'package:hotel/src/features/setup/domain/test_data_seed_log.dart';
import 'package:hotel/src/features/setup/domain/test_data_storage.dart';
import 'package:sqflite/sqflite.dart';

/// Seeds realistic demo data for offline trials (last [kDays] days).
/// On billed iOS platforms, counts match [DemoDataFreemiumLimits] (free tier).
class LocalTestDataSeeder {
  LocalTestDataSeeder(
    this._db, {
    int seed = 42,
  }) : _rng = Random(seed);

  final LocalDb _db;

  static const String marker = TestDataConstants.createdByMarker;

  static int get kMinDemoPartiesForCompleteData =>
      DemoDataFreemiumLimits.minPartiesForCompleteDemo;

  static const int kDays = 15;
  static int get kMaxSales => DemoDataFreemiumLimits.maxSalesInvoices;
  static int get kMaxPurchases => DemoDataFreemiumLimits.maxPurchaseInvoices;
  static int get kMaxParties => DemoDataFreemiumLimits.maxPartiesPerRole;
  static int get kMaxOtherParties =>
      DemoDataFreemiumLimits.maxOtherPartiesPerRole;
  static int get kMaxSalesItems => DemoDataFreemiumLimits.maxSalesItems;
  static int get kMaxPurchaseItems => DemoDataFreemiumLimits.maxPurchaseItems;
  static int get kMaxContacts => DemoDataFreemiumLimits.maxContacts;
  static int get kMaxStaff => DemoDataFreemiumLimits.maxEmployees;
  static int get kMaxAttendance => DemoDataFreemiumLimits.maxAttendance;
  static int get kMaxStockRows => DemoDataFreemiumLimits.maxStockRows;
  static int get kMaxLedgerRows => DemoDataFreemiumLimits.maxLedgerRows;
  static const String kDemoCategoryPrefix = 'Demo ';

  final Random _rng;

  Future<void> seed(
    SetupCompleteRequest request, {
    bool registerExtraOrganizations = false,
  }) async {
    final now = DateTime.now();
    final nowIso = now.toIso8601String();
    final currency = request.currency;

    TestDataSeedLog.step(
      'seed transaction start org=${request.organizationName}',
    );
    await _db.transactionIgnoringForeignKeys((txn) async {
      TestDataSeedLog.step('seed categories & items…');
      final items = await _seedCategoriesAndItems(txn, nowIso);
      await _seedContactBook(txn, nowIso);
      final customerNames = await _seedParties(txn, nowIso, currency);
      final supplierNames = customerNames.$2;
      final employeeIds = await _seedEmployees(txn, nowIso);
      final allItems = [...items.sales, ...items.purchases];
      await _seedSalesInvoices(
        txn: txn,
        now: now,
        nowIso: nowIso,
        itemNames: items.sales,
        partyNames: customerNames.$1,
      );
      await _seedPurchaseInvoices(
        txn: txn,
        now: now,
        nowIso: nowIso,
        itemNames: items.purchases,
        partyNames: supplierNames,
      );
      await _seedStandalonePayments(txn, now, nowIso, customerNames.$1, supplierNames);
      await _seedDailyCashSummaries(txn, now, nowIso);
      await _seedPreviousStock(txn, now, nowIso, allItems);
      await _seedStockLedger(txn, now, nowIso, allItems);
      await _seedAttendance(txn, nowIso, employeeIds);
      await _seedPayroll(txn, nowIso, employeeIds);
      await _seedLiquorCalculator(txn, nowIso);
      TestDataSeedLog.step('seed transaction complete');
    });

    await TestDataStorage.setEnabled(true);
    if (registerExtraOrganizations && DemoDataFreemiumLimits.extraOrganizations > 0) {
      await TestDataOrganizationSeeder.seedExtraOrganizations(
        excludeOrganizationName: request.organizationName,
      );
    }
  }

  /// Deletes leftover extra demo books from older seeds, keeping the active org.
  ///
  /// Only `demo_` database files are removed. A user organization's file is kept.
  Future<void> removeLeftoverExtraDemoOrganizations() async {
    final activeSlug = (await OrgStorage.getOrgSlug())?.trim();
    final slugs = await _demoOrganizationSlugs();
    for (final slug in slugs) {
      if (activeSlug != null && slug == activeSlug) continue;
      if (!slug.startsWith('demo_')) continue;
      await OrganizationDatabaseService.deleteDatabaseForSlug(slug);
    }

    final extraCodes = await TestDataStorage.getExtraOrgCodes();
    if (extraCodes.isEmpty) return;

    final currentCode = (await OrgStorage.getOrgCode())?.trim().toUpperCase();
    final registry = await OrgRegistryStorage.getAll();
    final protectedCodes = registry
        .where((org) => !org.slug.trim().startsWith('demo_'))
        .map((org) => org.code.trim().toUpperCase())
        .toSet();
    final codesToRemove = extraCodes.where((c) {
      final code = c.trim().toUpperCase();
      if (code == currentCode) return false;
      if (protectedCodes.contains(code)) return false;
      return true;
    }).toList();
    if (codesToRemove.isNotEmpty) {
      await OrgRegistryStorage.removeByCodes(codesToRemove);
    }
    if (currentCode != null &&
        extraCodes.any((c) => c.trim().toUpperCase() == currentCode)) {
      await TestDataStorage.setExtraOrgCodes([currentCode]);
    } else {
      await TestDataStorage.clearExtraOrgCodes();
    }
  }

  /// True when the active database already has a full demo dataset.
  Future<bool> hasCompleteDemoData() async {
    return _db.run((db) => _databaseHasCompleteDemoData(db));
  }

  static Future<bool> hasDemoContentForSlug(String slug) async {
    final path = await LocalDb.databasePathForOrg(slug);
    if (!File(path).existsSync()) return false;

    Database? db;
    try {
      db = await openDatabase(path, readOnly: true);
      final parties = await db.query(
        'Party',
        where: 'createdBy = ?',
        whereArgs: [marker],
        limit: 1,
      );
      return parties.isNotEmpty;
    } catch (_) {
      return false;
    } finally {
      await db?.close();
    }
  }

  static Future<bool> _databaseHasCompleteDemoData(Database db) async {
    try {
      final parties = Sqflite.firstIntValue(
        await db.rawQuery(
          'SELECT COUNT(*) FROM Party WHERE createdBy = ?',
          [marker],
        ),
      );
      if ((parties ?? 0) < kMinDemoPartiesForCompleteData) return false;

      final items = Sqflite.firstIntValue(
        await db.rawQuery(
          'SELECT COUNT(*) FROM Item WHERE createdBy = ?',
          [marker],
        ),
      );
      if ((items ?? 0) < 5) return false;

      final sales = Sqflite.firstIntValue(
        await db.rawQuery(
          'SELECT COUNT(*) FROM SalesInvoice WHERE createdBy = ?',
          [marker],
        ),
      );
      return (sales ?? 0) >= 1;
    } catch (_) {
      return false;
    }
  }

  Future<void> seedActiveOrganization() async {
    if (await hasCompleteDemoData()) {
      TestDataSeedLog.step('seedActiveOrganization: already complete, skipping');
      await TestDataStorage.setEnabled(true);
      return;
    }
    TestDataSeedLog.step('seedActiveOrganization: importing…');

    final currency = await _readCurrencyFromDb();
    final orgName = await _readOrganizationNameFromDb();
    final orgCode = (await OrgStorage.getOrgCode())?.trim();
    final companyName =
        (await OrgStorage.getOrgName())?.trim() ?? orgName ?? 'Demo';
    final businessType =
        (await OrgStorage.getBusinessType()) ?? OrganizationBusinessType.hotel;

    await seed(
      SetupCompleteRequest(
        organizationCode:
            orgCode != null && orgCode.isNotEmpty ? orgCode : 'DEMO01',
        organizationName: orgName ?? companyName,
        companyName: companyName,
        businessType: businessType,
        fullName: 'Demo',
        email: 'demo@local.dev',
        password: '',
        country: 'Nepal',
        currency: currency,
        bankName: 'Demo Bank',
        chartOfAccounts: 'Standard',
        fiscalYearStart: '2025-04-01',
        fiscalYearEnd: '2026-03-31',
      ),
      registerExtraOrganizations: false,
    );
  }

  Future<void> seedFromExistingBooks() async {
    if (await hasCompleteDemoData()) {
      await TestDataStorage.setEnabled(true);
      final needsLiquorSeed = await _db.run((db) async {
        final liquorRows = await db.query(
          'LiquorItem',
          where: 'createdBy = ?',
          whereArgs: [marker],
          limit: 1,
        );
        return liquorRows.isEmpty;
      });
      if (needsLiquorSeed) {
        await _db.transactionIgnoringForeignKeys((txn) async {
          await _seedLiquorCalculator(txn, DateTime.now().toIso8601String());
        });
      }
      await alignDemoActivityToToday();
      return;
    }

    await seedActiveOrganization();
  }

  /// Moves existing demo sales, purchases, payments, stock, cash, and
  /// attendance so the newest demo day is today.
  ///
  /// A complete seed is otherwise left untouched. After a few weeks the
  /// dashboard (today / this month / last 7 days) looks empty even though
  /// the rows are still in the database.
  Future<void> alignDemoActivityToToday() async {
    try {
      final shift = await _db.run((db) async {
        final rows = await db.rawQuery(
          'SELECT MAX(substr(date, 1, 10)) AS d FROM SalesInvoice WHERE createdBy = ?',
          [marker],
        );
        final raw = rows.isEmpty ? null : rows.first['d']?.toString();
        if (raw == null || raw.length < 10) return 0;
        final latest = DateTime.tryParse(raw.substring(0, 10));
        if (latest == null) return 0;
        final now = DateTime.now();
        return DateTime(now.year, now.month, now.day)
            .difference(DateTime(latest.year, latest.month, latest.day))
            .inDays;
      });
      if (shift <= 0) return;

      final modifier = '+$shift days';
      await _shiftDemoColumn(
        table: 'SalesInvoice',
        column: 'date',
        createdByColumn: 'createdBy',
        modifier: modifier,
        asDateTime: true,
      );
      await _shiftDemoColumn(
        table: 'PurchaseInvoice',
        column: 'date',
        createdByColumn: 'createdBy',
        modifier: modifier,
        asDateTime: true,
      );
      await _shiftDemoColumn(
        table: 'Payment',
        column: 'date',
        createdByColumn: 'createdBy',
        modifier: modifier,
        asDateTime: false,
      );
      await _shiftDemoColumn(
        table: 'DailyCashSummary',
        column: 'date',
        createdByColumn: 'created_by',
        modifier: modifier,
        asDateTime: false,
      );
      await _shiftDemoColumn(
        table: 'PreviousStock',
        column: 'reportingDate',
        createdByColumn: 'createdBy',
        modifier: modifier,
        asDateTime: false,
      );
      await _shiftDemoColumn(
        table: 'StockLedgerEntry',
        column: 'date',
        createdByColumn: 'createdBy',
        modifier: modifier,
        asDateTime: true,
      );
      await _shiftDemoColumn(
        table: 'EmployeeAttendance',
        column: 'attendance_date',
        createdByColumn: 'created_by',
        modifier: modifier,
        asDateTime: false,
      );
      await _shiftDemoColumn(
        table: 'EmployeeAttendance',
        column: 'check_in_time',
        createdByColumn: 'created_by',
        modifier: modifier,
        asDateTime: true,
      );
      await _shiftDemoColumn(
        table: 'EmployeeAttendance',
        column: 'check_out_time',
        createdByColumn: 'created_by',
        modifier: modifier,
        asDateTime: true,
      );
      await _shiftDemoColumn(
        table: 'EmployeePayroll',
        column: 'pay_period_start',
        createdByColumn: 'created_by',
        modifier: modifier,
        asDateTime: false,
      );
      await _shiftDemoColumn(
        table: 'EmployeePayroll',
        column: 'pay_period_end',
        createdByColumn: 'created_by',
        modifier: modifier,
        asDateTime: false,
      );
      await _shiftDemoColumn(
        table: 'EmployeePayroll',
        column: 'payment_date',
        createdByColumn: 'created_by',
        modifier: modifier,
        asDateTime: false,
      );
      try {
        await _db.run((db) {
          return db.rawUpdate(
            'UPDATE EmployeePayroll SET payroll_month = substr(pay_period_start, 1, 7) '
            'WHERE created_by = ? AND pay_period_start IS NOT NULL',
            [marker],
          );
        });
      } catch (e) {
        TestDataSeedLog.step('skip payroll month align: $e');
      }
      TestDataSeedLog.step('shifted demo activity forward by $shift day(s)');
    } catch (e, stack) {
      TestDataSeedLog.error('align demo dates failed', e, stack);
    }
  }

  Future<void> _shiftDemoColumn({
    required String table,
    required String column,
    required String createdByColumn,
    required String modifier,
    required bool asDateTime,
  }) async {
    final expr = asDateTime
        ? "replace(datetime($column, ?), ' ', 'T')"
        : 'date($column, ?)';
    try {
      await _db.run((db) {
        return db.rawUpdate(
          'UPDATE $table SET $column = $expr '
          'WHERE $createdByColumn = ? AND $column IS NOT NULL AND trim($column) != \'\'',
          [modifier, marker],
        );
      });
    } catch (e) {
      TestDataSeedLog.step('skip date align $table.$column: $e');
    }
  }

  /// Removes demo rows from the active database only (keeps prefs / registry).
  Future<void> purgeDemoRowsFromCurrentDatabase() async {
    if (!await hasAnyDemoRows()) return;
    await _db.transactionIgnoringForeignKeys(_purgeDemoRows);
  }

  Future<bool> hasAnyDemoRows() async {
    return _db.run((db) async {
      final tables = <String, String>{
        'Party': 'createdBy',
        'Item': 'createdBy',
        'SalesInvoice': 'createdBy',
        'ContactBook': 'created_by',
        'Employee': 'created_by',
      };
      for (final entry in tables.entries) {
        final count = Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(*) FROM ${entry.key} WHERE ${entry.value} = ?',
            [marker],
          ),
        );
        if ((count ?? 0) > 0) return true;
      }
      return false;
    });
  }

  Future<void> clear() async {
    final demoOrgSlugs = await _demoOrganizationSlugs();
    await _db.transactionIgnoringForeignKeys(_purgeDemoRows);
    await TestDataOrganizationSeeder.removeExtraOrganizations();
    for (final slug in demoOrgSlugs) {
      if (!slug.startsWith('demo_')) continue;
      await OrganizationDatabaseService.deleteDatabaseForSlug(slug);
    }
    await TestDataStorage.setEnabled(false);
    await TestDataStorage.setProvisionedViaOrgTestLogin(false);
    await _db.resetConnection();
  }

  Future<Set<String>> _demoOrganizationSlugs() async {
    final extraCodes = (await TestDataStorage.getExtraOrgCodes())
        .map((c) => c.trim().toUpperCase())
        .where((c) => c.isNotEmpty)
        .toSet();
    if (extraCodes.isEmpty) return {};

    final registry = await OrgRegistryStorage.getAll();
    return registry
        .where((o) => extraCodes.contains(o.code.trim().toUpperCase()))
        .map((o) => o.slug.trim())
        .where((s) => s.isNotEmpty)
        .toSet();
  }

  Future<void> _ensureCategory(
    Transaction txn,
    String name,
    String now,
  ) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    await txn.insert(
      'Category',
      {'name': trimmed, 'created': now, 'modified': now},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> _purgeDemoRows(Transaction txn) async {
    await txn.rawDelete(
      "DELETE FROM PaymentFor WHERE parent IN "
      "(SELECT name FROM Payment WHERE createdBy = ?)",
      [marker],
    );
    await txn.delete('Payment', where: 'createdBy = ?', whereArgs: [marker]);
    await txn.rawDelete(
      "DELETE FROM SalesInvoiceItem WHERE parent IN "
      "(SELECT name FROM SalesInvoice WHERE createdBy = ?)",
      [marker],
    );
    await txn.rawDelete(
      "DELETE FROM PurchaseInvoiceItem WHERE parent IN "
      "(SELECT name FROM PurchaseInvoice WHERE createdBy = ?)",
      [marker],
    );
    await txn.delete('SalesInvoice', where: 'createdBy = ?', whereArgs: [marker]);
    await txn.delete('PurchaseInvoice', where: 'createdBy = ?', whereArgs: [marker]);
    await txn.delete('DailyCashSummary', where: 'created_by = ?', whereArgs: [marker]);
    await txn.delete('EmployeeAttendance', where: 'created_by = ?', whereArgs: [marker]);
    await txn.delete('EmployeePayroll', where: 'created_by = ?', whereArgs: [marker]);
    await txn.rawDelete(
      'DELETE FROM EmployeeSalary WHERE employee_id IN '
      '(SELECT id FROM Employee WHERE created_by = ?)',
      [marker],
    );
    await txn.delete('Employee', where: 'created_by = ?', whereArgs: [marker]);
    await txn.delete('PreviousStock', where: 'createdBy = ?', whereArgs: [marker]);
    await txn.delete('StockLedgerEntry', where: 'createdBy = ?', whereArgs: [marker]);
    await txn.delete('ContactBook', where: 'created_by = ?', whereArgs: [marker]);
    await txn.delete('Party', where: 'createdBy = ?', whereArgs: [marker]);
    await txn.delete('Item', where: 'createdBy = ?', whereArgs: [marker]);
    await txn.delete(
      'Category',
      where: "name LIKE ?",
      whereArgs: ['$kDemoCategoryPrefix%'],
    );
    await txn.delete('LiquorPricing', where: 'createdBy = ?', whereArgs: [marker]);
    await txn.delete('LiquorItem', where: 'createdBy = ?', whereArgs: [marker]);
    await txn.delete('LiquorCategory', where: 'createdBy = ?', whereArgs: [marker]);
  }

  Future<String?> _readOrganizationName(Database db) async {
    final rows = await db.query(
      'SingleValue',
      where: "parent = 'Organization' AND fieldname = 'organizationName'",
      limit: 1,
    );
    if (rows.isEmpty) {
      final company = await db.query(
        'SingleValue',
        where: "parent = 'AccountingSettings' AND fieldname = 'companyName'",
        limit: 1,
      );
      if (company.isEmpty) return null;
      return company.first['value']?.toString();
    }
    return rows.first['value']?.toString();
  }

  Future<String> _readCurrency(Database db) async {
    final rows = await db.query(
      'SingleValue',
      where: 'parent = ? AND fieldname = ?',
      whereArgs: ['SystemSettings', 'currency'],
      limit: 1,
    );
    final value = rows.isNotEmpty ? rows.first['value']?.toString() : null;
    return value?.trim().isNotEmpty == true ? value!.trim() : 'NPR';
  }

  Future<String?> _readOrganizationNameFromDb() =>
      _db.run(_readOrganizationName);

  Future<String> _readCurrencyFromDb() => _db.run(_readCurrency);

  String _dateOnly(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<({List<String> sales, List<String> purchases})> _seedCategoriesAndItems(
    Transaction txn,
    String now,
  ) async {
    const demoCategories = [
      'Demo Snacks',
      'Demo Main Course',
      'Demo Beverages',
      'Demo Breakfast',
      'Demo Supplies',
    ];

    const salesSeed = <(String, String, String)>[
      ('Chicken Momo (Plate)', 'Food - Momo', '280'),
      ('Buff Momo (Plate)', 'Food - Momo', '240'),
      ('Dal Bhat Set', 'Food - Thali & Khaja Set', '450'),
      ('Veg Thali', 'Demo Main Course', '380'),
      ('Chicken Fried Rice', 'Food - Fried Rice & Noodles', '380'),
      ('Chowmein Chicken', 'Food - Chowemin', '320'),
      ('Tuborg Beer 650ml', 'Beverages - Beer', '550'),
      ('Gorkha Beer 650ml', 'Beverages - Beer', '480'),
      ('Mineral Water 1L', 'Beverages - Water & Juice', '80'),
      ('Masala Tea', 'Beverages - Tea & Coffee', '60'),
      ('Cappuccino', 'Beverages - Tea & Coffee', '180'),
      ('Plain Paratha', 'Demo Breakfast', '120'),
      ('Cheese Garlic Bread', 'Demo Snacks', '220'),
      ('Chicken Sekuwa', 'Food - Sukuti', '520'),
      ('Fish Fry', 'Food - Main Course (Fish)', '650'),
      ('Veg Spring Roll', 'Demo Snacks', '180'),
      ('Coke 250ml', 'Beverages - Soft Drinks', '90'),
      ('Lassi Sweet', 'Beverages - Lassi', '150'),
      ('Room Service Tray', 'Misc / Services', '250'),
      ('Laundry Express', 'Misc / Services', '350'),
    ];

    const purchaseSeed = <(String, String, String)>[
      ('Raw Materials - Vegetables (lot)', 'Raw Materials - Vegetables', '0'),
      ('Kitchen Gas Cylinder', 'Demo Supplies', '3200'),
      ('Napkins (pack)', 'Supplies - Stationery & Misc', '450'),
      ('Dish Wash Liquid', 'Supplies - Cleaning', '280'),
      ('Chicken Breast (kg)', 'Raw Materials - Meat', '680'),
      ('Basmati Rice (25kg)', 'Raw Materials - Dry Goods', '4200'),
      ('Sunflower Oil (15L)', 'Raw Materials - Oil & Fats', '3800'),
      ('Onion (kg)', 'Raw Materials - Vegetables', '95'),
      ('Tomato (kg)', 'Raw Materials - Vegetables', '110'),
      ('Potato (kg)', 'Raw Materials - Vegetables', '75'),
    ];

    final categories = <String>{
      ...demoCategories,
      for (final row in salesSeed) row.$2,
      for (final row in purchaseSeed) row.$2,
    }.take(DemoDataFreemiumLimits.maxCategories).toSet();
    for (final name in categories) {
      await _ensureCategory(txn, name, now);
    }

    final salesNames = await _seedItemsForPurpose(
      txn,
      now: now,
      forValue: 'Sales',
      maxCount: kMaxSalesItems,
      seed: salesSeed,
      namePrefix: 'Demo Sale Item',
      defaultCategory: 'Demo Main Course',
    );
    final purchaseNames = await _seedItemsForPurpose(
      txn,
      now: now,
      forValue: 'Purchases',
      maxCount: kMaxPurchaseItems,
      seed: purchaseSeed,
      namePrefix: 'Demo Purchase Item',
      defaultCategory: 'Demo Supplies',
    );

    return (sales: salesNames, purchases: purchaseNames);
  }

  Future<List<String>> _seedItemsForPurpose(
    Transaction txn, {
    required String now,
    required String forValue,
    required int maxCount,
    required List<(String, String, String)> seed,
    required String namePrefix,
    required String defaultCategory,
  }) async {
    final names = <String>[];
    for (var i = 0; i < maxCount; i++) {
      late final String name;
      late final String category;
      late final String rate;
      if (i < seed.length) {
        name = seed[i].$1;
        category = seed[i].$2;
        rate = seed[i].$3;
      } else {
        final n = i + 1;
        name = '$namePrefix ${n.toString().padLeft(2, '0')}';
        category = defaultCategory;
        rate = '${120 + (n * 37) % 2800}';
      }
      await _ensureCategory(txn, category, now);
      await txn.insert(
        'Item',
        {
          'name': name,
          'for': forValue,
          'itemType': 'Product',
          'unit': 'Unit',
          'rate': rate,
          'incomeAccount': 'Sales',
          'expenseAccount': 'Cost of Goods Sold',
          'category': category,
          'trackItem': 1,
          'hasBatch': 0,
          'hasSerialNumber': 0,
          'createdBy': marker,
          'modifiedBy': marker,
          'created': now,
          'modified': now,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      names.add(name);
    }
    return names;
  }

  Future<void> _seedContactBook(Transaction txn, String now) async {
    const categories = [
      'general',
      'customer',
      'vendor',
      'staff',
      'delivery',
    ];
    const companies = [
      'Royal Restro Lodge',
      'Himalayan Supplies Co.',
      'Valley Transport',
      'Everest Catering',
      'Lakeside Tours',
    ];

    for (var i = 1; i <= kMaxContacts; i++) {
      final n = i.toString().padLeft(2, '0');
      await txn.insert(
        'ContactBook',
        {
          'name': 'Demo Contact $n',
          'phone': '98${_rng.nextInt(90000000) + 10000000}',
          'email': 'demo.contact$i@local.dev',
          'address': '${10 + i} Thamel, Kathmandu',
          'category': categories[i % categories.length],
          'company': companies[i % companies.length],
          'notes': 'Seeded for offline demo',
          'is_favorite': i <= 5 ? 1 : 0,
          'created_at': now,
          'modified_at': now,
          'created_by': marker,
          'modified_by': marker,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  Future<(List<String>, List<String>)> _seedParties(
    Transaction txn,
    String now,
    String currency,
  ) async {
    final customers = <String>[];
    final suppliers = <String>[];

    for (var n = 1; n <= kMaxParties; n++) {
      final name = 'Demo Customer ${n.toString().padLeft(2, '0')}';
      customers.add(name);
      await _insertParty(txn, name: name, role: 'Customer', now: now, currency: currency);
    }
    for (var n = 1; n <= kMaxOtherParties; n++) {
      final name = 'Demo Supplier ${n.toString().padLeft(2, '0')}';
      suppliers.add(name);
      await _insertParty(txn, name: name, role: 'Supplier', now: now, currency: currency);
    }

    final extras = [
      ('Walk-in Guest', 'Customer'),
      ('Room 301 - Patel Family', 'Customer'),
      ('Tourist Group - ABC Tours', 'Customer'),
      ('Himalayan Beverages Pvt Ltd', 'Supplier'),
      ('Valley Fresh Vegetables', 'Supplier'),
    ];
    for (final (name, role) in extras) {
      final roleList = role == 'Supplier' ? suppliers : customers;
      final roleCap = role == 'Supplier' ? kMaxOtherParties : kMaxParties;
      if (roleList.length >= roleCap) break;
      await _insertParty(txn, name: name, role: role, now: now, currency: currency);
      if (role == 'Supplier') {
        suppliers.add(name);
      } else {
        customers.add(name);
      }
    }

    return (customers, suppliers);
  }

  Future<void> _insertParty(
    Transaction txn, {
    required String name,
    required String role,
    required String now,
    required String currency,
  }) async {
    await txn.insert(
      'Party',
      {
        'id': await EmployeePartyHelper.nextPartyId(txn),
        'name': name,
        'role': role,
        'email': '',
        'phone': '98${_rng.nextInt(90000000) + 10000000}',
        'defaultAccount': role == 'Supplier' ? 'Creditors' : 'Debtors',
        'currency': currency,
        'loyaltyPoints': 0,
        'outstandingAmount': '0.00000000000',
        'status': 1,
        'created': now,
        'modified': now,
        'createdBy': marker,
        'modifiedBy': marker,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<int>> _seedEmployees(Transaction txn, String now) async {
    const staff = [
      ('EMP-T01', 'Sunita', 'Gurung', 'Front Desk', 'Receptionist'),
      ('EMP-T02', 'Ram Bahadur', 'KC', 'Kitchen', 'Chef'),
      ('EMP-T03', 'Anita', 'Tamang', 'Housekeeping', 'Supervisor'),
      ('EMP-T04', 'Prakash', 'Shrestha', 'Kitchen', 'Sous Chef'),
      ('EMP-T05', 'Mina', 'Rai', 'Front Desk', 'Cashier'),
      ('EMP-T06', 'Bikash', 'Thapa', 'Bar', 'Bartender'),
      ('EMP-T07', 'Sangita', 'Lama', 'Housekeeping', 'Room Attendant'),
      ('EMP-T08', 'Dipesh', 'Poudel', 'Management', 'Duty Manager'),
      ('EMP-T09', 'Kamala', 'Magar', 'Kitchen', 'Commis'),
      ('EMP-T10', 'Nabin', 'Adhikari', 'Security', 'Guard'),
      ('EMP-T11', 'Rita', 'Karki', 'Front Desk', 'Reservation'),
      ('EMP-T12', 'Suresh', 'Bhandari', 'Kitchen', 'Tandoor Chef'),
    ];

    final hireDate = now.substring(0, 10);
    final ids = <int>[];

    for (final (code, first, last, dept, position) in staff.take(kMaxStaff)) {
      final fullName = '$first $last';
      final partyName = await EmployeePartyHelper.uniquePartyName(
        txn,
        EmployeePartyHelper.displayName(fullName),
      );
      await EmployeePartyHelper.insertParty(
        txn,
        partyName: partyName,
        email: '${code.toLowerCase()}@demo.local',
        phone: '98${_rng.nextInt(90000000) + 10000000}',
        createdBy: marker,
        now: now,
      );

      final id = await txn.insert('Employee', {
        'employee_code': code,
        'first_name': first,
        'last_name': last,
        'full_name': fullName,
        'email': '${code.toLowerCase()}@demo.local',
        'phone': '98${_rng.nextInt(90000000) + 10000000}',
        'hire_date': hireDate,
        'department': dept,
        'position': position,
        'employment_type': 'FULL_TIME',
        'employment_status': 'ACTIVE',
        'basic_salary': 25000 + _rng.nextInt(20000),
        'hourly_rate': 0.0,
        'working_hours_per_day': 8.0,
        'working_days_per_week': 6,
        'party_id': partyName,
        'is_active': 1,
        'created_by': marker,
        'modified_by': marker,
        'created': now,
        'modified': now,
      });
      ids.add(id);
    }
    return ids;
  }

  Future<void> _seedSalesInvoices({
    required Transaction txn,
    required DateTime now,
    required String nowIso,
    required List<String> itemNames,
    required List<String> partyNames,
  }) async {
    if (itemNames.isEmpty || partyNames.isEmpty) return;

    var seq = 1001;
    var created = 0;
    for (var day = 0; day < kDays && created < kMaxSales; day++) {
      final perDay = day.isEven ? 2 : 1;
      for (var p = 0; p < perDay && created < kMaxSales; p++) {
        final invName = 'SINV-TEST-$seq';
        seq++;
        created++;

        final date = now.subtract(Duration(days: day));
        final dateIso = date.toIso8601String();
        final party = partyNames[_rng.nextInt(partyNames.length)];
        final lineCount = 1 + _rng.nextInt(3);
        final lines = <(String, double, double)>[];
        for (var l = 0; l < lineCount; l++) {
          final item = itemNames[_rng.nextInt(itemNames.length)];
          final rate = 80 + _rng.nextInt(800).toDouble();
          final qty = 1 + _rng.nextInt(4).toDouble();
          lines.add((item, qty, rate));
        }

        var net = 0.0;
        for (final line in lines) {
          net += line.$2 * line.$3;
        }
        final paidFull = _rng.nextBool();
        final outstanding = paidFull ? 0.0 : net * (0.2 + _rng.nextDouble() * 0.5);
        final method = _rng.nextInt(3) == 0 ? 'QR' : 'Cash';

        await txn.insert('SalesInvoice', {
          'name': invName,
          'numberSeries': 'SINV-',
          'party': party,
          'account': 'Debtors',
          'date': dateIso,
          'netTotal': net.toStringAsFixed(11),
          'baseGrandTotal': net.toStringAsFixed(11),
          'grandTotal': net.toStringAsFixed(11),
          'outstandingAmount': outstanding.toStringAsFixed(11),
          'setDiscountAmount': 0,
          'createdBy': marker,
          'modifiedBy': marker,
          'created': nowIso,
          'modified': nowIso,
          'submitted': 1,
          'cancelled': 0,
        });

        var idx = 0;
        for (final (item, qty, rate) in lines) {
          final amount = qty * rate;
          await txn.insert('SalesInvoiceItem', {
            'name': '$invName-${idx++}',
            'item': item,
            'rate': rate.toStringAsFixed(11),
            'quantity': qty,
            'unit': 'Unit',
            'account': 'Sales',
            'amount': amount.toStringAsFixed(11),
            'parent': invName,
            'parentSchemaName': 'SalesInvoice',
            'parentFieldname': 'items',
            'idx': idx,
          });
        }

        if (paidFull && net > 0) {
          await _insertPayment(
            txn,
            name: 'PAY-TEST-S-$seq',
            party: party,
            amount: net,
            paymentType: 'Receive',
            account: 'Debtors',
            referenceType: 'SalesInvoice',
            referenceId: invName,
            date: _dateOnly(date),
            nowIso: nowIso,
            method: method,
          );
        }
      }
    }
  }

  Future<void> _seedPurchaseInvoices({
    required Transaction txn,
    required DateTime now,
    required String nowIso,
    required List<String> itemNames,
    required List<String> partyNames,
  }) async {
    if (partyNames.isEmpty) return;

    var seq = 2001;
    var created = 0;
    for (var day = 0; day < kDays && created < kMaxPurchases; day++) {
      final batches = day % 4 == 0 ? 2 : 1;
      for (var b = 0; b < batches && created < kMaxPurchases; b++) {
      final invName = 'PINV-TEST-$seq';
      seq++;
      created++;

      final date = now.subtract(Duration(days: day));
      final dateIso = date.toIso8601String();
      final party = partyNames[_rng.nextInt(partyNames.length)];

      final lines = <(String, double, double)>[];
      if (itemNames.isNotEmpty) {
        final item = itemNames[_rng.nextInt(itemNames.length)];
        final qty = 5 + _rng.nextInt(40).toDouble();
        final rate = 200 + _rng.nextInt(1200).toDouble();
        lines.add((item, qty, rate));
      } else {
        lines.add(('Raw Materials - Vegetables (lot)', 1, 12000 + _rng.nextInt(8000).toDouble()));
      }

      var net = 0.0;
      for (final line in lines) {
        net += line.$2 * line.$3;
      }
      final paid = _rng.nextBool() ? net : net * 0.6;
      final outstanding = (net - paid).clamp(0.0, double.infinity);

      await txn.insert('PurchaseInvoice', {
        'name': invName,
        'numberSeries': 'PINV-',
        'party': party,
        'account': 'Creditors',
        'date': dateIso,
        'netTotal': net.toStringAsFixed(11),
        'baseGrandTotal': net.toStringAsFixed(11),
        'grandTotal': net.toStringAsFixed(11),
        'outstandingAmount': outstanding.toStringAsFixed(11),
        'setDiscountAmount': 0,
        'createdBy': marker,
        'modifiedBy': marker,
        'created': nowIso,
        'modified': nowIso,
        'submitted': 1,
        'cancelled': 0,
      });

      var idx = 0;
      for (final (item, qty, rate) in lines) {
        final amount = qty * rate;
        await txn.insert('PurchaseInvoiceItem', {
          'name': '$invName-${idx++}',
          'item': item,
          'rate': rate.toStringAsFixed(11),
          'quantity': qty < 1 ? 1 : qty,
          'unit': 'Unit',
          'account': 'Cost of Goods Sold',
          'amount': amount.toStringAsFixed(11),
          'parent': invName,
          'parentSchemaName': 'PurchaseInvoice',
          'parentFieldname': 'items',
          'idx': idx,
        });
      }

      if (paid > 0) {
        await _insertPayment(
          txn,
          name: 'PAY-TEST-P-$seq',
          party: party,
          amount: paid,
          paymentType: 'Pay',
          account: 'Creditors',
          referenceType: 'PurchaseInvoice',
          referenceId: invName,
          date: _dateOnly(date),
          nowIso: nowIso,
          method: 'Cash',
        );
      }
      }
    }
  }

  Future<void> _seedStandalonePayments(
    Transaction txn,
    DateTime now,
    String nowIso,
    List<String> customers,
    List<String> suppliers,
  ) async {
    for (var i = 0; i < 8; i++) {
      final date = now.subtract(Duration(days: i % kDays));
      final isReceive = i.isEven;
      final party = isReceive
          ? customers[_rng.nextInt(customers.length)]
          : suppliers[_rng.nextInt(suppliers.length)];
      final amount = 500 + _rng.nextInt(4500).toDouble();
      await _insertPayment(
        txn,
        name: 'PAY-TEST-MISC-${1000 + i}',
        party: party,
        amount: amount,
        paymentType: isReceive ? 'Receive' : 'Pay',
        account: isReceive ? 'Debtors' : 'Creditors',
        referenceType: 'JournalEntry',
        referenceId: 'JV-TEST-${1000 + i}',
        date: _dateOnly(date),
        nowIso: nowIso,
        method: i % 3 == 0 ? 'QR' : 'Cash',
      );
    }
  }

  Future<void> _seedDailyCashSummaries(
    Transaction txn,
    DateTime now,
    String nowIso,
  ) async {
    var opening = 15000.0;
    for (var day = kDays - 1; day >= 0; day--) {
      final date = now.subtract(Duration(days: day));
      final dateStr = _dateOnly(date);
      final sales = 18000 + _rng.nextInt(42000).toDouble();
      final cash = sales * (0.45 + _rng.nextDouble() * 0.25);
      final qr = sales - cash;
      final expenses = 3000 + _rng.nextInt(12000).toDouble();
      final closing = opening + cash - expenses;
      await txn.insert(
        'DailyCashSummary',
        {
          'date': dateStr,
          'opening_balance': opening,
          'sales_amount': sales,
          'qr_amount': qr,
          'cash_amount': cash,
          'discount': _rng.nextInt(800).toDouble(),
          'expenses': expenses,
          'un_paid': sales * 0.08,
          'un_paid_discount': 0,
          'credit_paid_cash': 0,
          'credit_qr': 0,
          'closing_balance': closing,
          'lost_money': 0,
          'extra_money': _rng.nextInt(200).toDouble(),
          'pay_qr_get_cash_exchange': 0,
          'pay_cash_get_qr_exchange': 0,
          'created_by': marker,
          'created_at': nowIso,
          'modified_by': marker,
          'modified_at': nowIso,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      opening = closing;
    }
  }

  Future<void> _seedPreviousStock(
    Transaction txn,
    DateTime now,
    String nowIso,
    List<String> itemNames,
  ) async {
    if (itemNames.isEmpty) return;
    for (var i = 0; i < kMaxStockRows; i++) {
      final date = now.subtract(Duration(days: i % kDays));
      final item = itemNames[i % itemNames.length];
      final qty = 5 + _rng.nextInt(120).toDouble();
      final rate = 50 + _rng.nextInt(600).toDouble();
      await txn.insert(
        'PreviousStock',
        {
          'name': 'PSTK-TEST-${1000 + i}',
          'item': item,
          'location': 'Stores',
          'previousQuantity': qty,
          'reportingDate': _dateOnly(date),
          'uploadDate': nowIso,
          'uploadedBy': marker,
          'rate': rate,
          'value': qty * rate,
          'notes': 'Demo stock count',
          'isActive': 1,
          'createdBy': marker,
          'modifiedBy': marker,
          'created': nowIso,
          'modified': nowIso,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  Future<void> _seedStockLedger(
    Transaction txn,
    DateTime now,
    String nowIso,
    List<String> itemNames,
  ) async {
    if (itemNames.isEmpty) return;
    for (var i = 0; i < kMaxLedgerRows; i++) {
      final date = now.subtract(Duration(days: i % kDays));
      final item = itemNames[i % itemNames.length];
      final qty = (_rng.nextBool() ? 1 : -1) * (1 + _rng.nextInt(15)).toDouble();
      await txn.insert(
        'StockLedgerEntry',
        {
          'name': 'SLE-TEST-${1000 + i}',
          'date': date.toIso8601String(),
          'location': 'Stores',
          'item': item,
          'rate': (80 + _rng.nextInt(400)).toStringAsFixed(11),
          'quantity': qty,
          'referenceType': qty > 0 ? 'PurchaseInvoice' : 'SalesInvoice',
          'referenceName': qty > 0 ? 'PINV-TEST-2001' : 'SINV-TEST-1001',
          'createdBy': marker,
          'modifiedBy': marker,
          'created': nowIso,
          'modified': nowIso,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  Future<void> _seedAttendance(
    Transaction txn,
    String nowIso,
    List<int> employeeIds,
  ) async {
    if (employeeIds.isEmpty) return;
    const statuses = ['PRESENT', 'PRESENT', 'PRESENT', 'LATE', 'HALF_DAY', 'ABSENT'];
    var count = 0;
    for (var day = 0; day < kDays && count < kMaxAttendance; day++) {
      for (final empId in employeeIds) {
        if (count >= kMaxAttendance) break;
        final date = DateTime.now().subtract(Duration(days: day));
        final dateStr = _dateOnly(date);
        final status = statuses[_rng.nextInt(statuses.length)];
        final checkIn = DateTime(date.year, date.month, date.day, 8 + _rng.nextInt(2), 15 + _rng.nextInt(45));
        final checkOut = checkIn.add(Duration(hours: 8 + _rng.nextInt(2), minutes: _rng.nextInt(30)));
        await txn.insert(
          'EmployeeAttendance',
          {
            'employee_id': empId,
            'attendance_date': dateStr,
            'check_in_time': checkIn.toIso8601String(),
            'check_out_time': status == 'ABSENT' ? null : checkOut.toIso8601String(),
            'total_hours_worked': status == 'ABSENT' ? 0.0 : 8.0 + _rng.nextDouble(),
            'attendance_status': status,
            'late_arrival_minutes': status == 'LATE' ? 10 + _rng.nextInt(40) : 0,
            'location': 'Hotel Premises',
            'is_approved': 1,
            'created_by': marker,
            'modified_by': marker,
            'created': nowIso,
            'modified': nowIso,
          },
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
        count++;
      }
    }
  }

  Future<void> _seedPayroll(
    Transaction txn,
    String nowIso,
    List<int> employeeIds,
  ) async {
    if (employeeIds.isEmpty) return;
    final now = DateTime.now();
    final month = '${now.year}-${now.month.toString().padLeft(2, '0')}';
    final periodStart = DateTime(now.year, now.month, 1);
    final periodEnd = DateTime(now.year, now.month + 1, 0);

    for (final empId in employeeIds) {
      final basic = 25000 + _rng.nextInt(25000).toDouble();
      final overtime = _rng.nextInt(3000).toDouble();
      final gross = basic + overtime;
      final deductions = gross * 0.12;
      final net = gross - deductions;
      final paid = _rng.nextBool();

      await txn.insert(
        'EmployeePayroll',
        {
          'employee_id': empId,
          'payroll_month': month,
          'pay_period_start': _dateOnly(periodStart),
          'pay_period_end': _dateOnly(periodEnd),
          'total_working_days': 26,
          'days_present': 22 + _rng.nextInt(4),
          'days_absent': _rng.nextInt(2),
          'basic_salary': basic,
          'overtime_pay': overtime,
          'gross_pay': gross,
          'total_deductions': deductions,
          'net_pay': net,
          'payment_date': paid ? _dateOnly(now) : null,
          'payment_method': 'BANK_TRANSFER',
          'payment_status': paid ? 'PAID' : 'PENDING',
          'generated_by': marker,
          'is_approved': 1,
          'created_by': marker,
          'modified_by': marker,
          'created': nowIso,
          'modified': nowIso,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  Future<void> _seedLiquorCalculator(Transaction txn, String nowIso) async {
    const categories = ['Whiskey', 'Vodka', 'Rum', 'Beer'];
    for (final category in categories) {
      final existing = await txn.rawQuery(
        'SELECT id FROM LiquorCategory WHERE LOWER(name) = LOWER(?) LIMIT 1',
        [category],
      );
      if (existing.isEmpty) {
        await txn.insert(
          'LiquorCategory',
          {
            'name': category,
            'description': 'Demo liquor category',
            'isActive': 1,
            'createdBy': marker,
            'created': nowIso,
            'modified': nowIso,
          },
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
    }

    const products = <(String, String, String, String, int, int)>[
      ('Royal Stag', 'Whiskey', 'Royal Stag', '750ml', 1200, 1850),
      ('Black Dog', 'Whiskey', 'Black Dog', '750ml', 1500, 2300),
      ('VAT 69', 'Vodka', 'VAT 69', '750ml', 1100, 1650),
      ('Ruslan Vodka', 'Vodka', 'Ruslan', '750ml', 950, 1400),
      ('Old Monk', 'Rum', 'Old Monk', '750ml', 800, 1200),
      ('Bacardi White', 'Rum', 'Bacardi', '750ml', 1300, 1950),
      ('Tuborg Strong', 'Beer', 'Tuborg', '650ml', 280, 450),
      ('Gorkha Beer', 'Beer', 'Gorkha', '650ml', 260, 420),
      ('Signature', 'Whiskey', 'Signature', '750ml', 1400, 2100),
      ('Khukuri Rum', 'Rum', 'Khukuri', '375ml', 450, 680),
    ];

    final effectiveFrom = _dateOnly(DateTime.now());
    final effectiveTo = _dateOnly(
      DateTime(DateTime.now().year + 5, DateTime.now().month, DateTime.now().day),
    );

    for (final p in products) {
      final itemName = p.$1;
      final itemCategory = p.$2;
      final itemBrand = p.$3;
      final itemVolume = p.$4;
      final purchasePrice = p.$5;
      final sellingPrice = p.$6;

      final exists = await txn.rawQuery(
        'SELECT id FROM LiquorItem WHERE LOWER(name) = LOWER(?) LIMIT 1',
        [itemName],
      );
      if (exists.isNotEmpty) continue;

      await txn.insert(
        'LiquorItem',
        {
          'name': itemName,
          'category': itemCategory,
          'brand': itemBrand,
          'volume': itemVolume,
          'description': 'Demo product for liquor calculator',
          'isActive': 1,
          'createdBy': marker,
          'created': nowIso,
          'modified': nowIso,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

      final marginAmount = (sellingPrice - purchasePrice).toDouble();
      final marginPct = sellingPrice > 0
          ? (marginAmount / sellingPrice) * 100
          : 0.0;

      await txn.insert(
        'LiquorPricing',
        {
          'itemName': itemName,
          'purchasePrice': purchasePrice.toDouble(),
          'sellingPrice': sellingPrice.toDouble(),
          'marginAmount': marginAmount,
          'marginPercentage': double.parse(marginPct.toStringAsFixed(2)),
          'effectiveFrom': effectiveFrom,
          'effectiveTo': effectiveTo,
          'location': 'Main Bar',
          'notes': 'Demo pricing',
          'isActive': 1,
          'createdBy': marker,
          'created': nowIso,
          'modified': nowIso,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  Future<void> _insertPayment(
    Transaction txn, {
    required String name,
    required String party,
    required double amount,
    required String paymentType,
    required String account,
    required String referenceType,
    required String referenceId,
    required String date,
    required String nowIso,
    required String method,
  }) async {
    await txn.insert(
      'Payment',
      {
        'name': name,
        'numberSeries': 'PAY-',
        'party': party,
        'date': date,
        'paymentType': paymentType,
        'account': account,
        'paymentAccount': method == 'Cash' ? 'Cash In Hand' : method,
        'paymentMethod': method,
        'amount': amount.toStringAsFixed(11),
        'writeoff': '0.00000000000',
        'referenceType': referenceType,
        'referenceId': referenceId,
        'createdBy': marker,
        'modifiedBy': marker,
        'created': nowIso,
        'modified': nowIso,
        'submitted': 1,
        'cancelled': 0,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}

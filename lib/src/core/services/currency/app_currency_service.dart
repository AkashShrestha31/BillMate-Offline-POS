import 'package:flutter/foundation.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/currency/app_currency_catalog.dart';
import 'package:hotel/src/core/services/currency/app_currency_formatter.dart';
import 'package:hotel/src/core/services/currency/currency_picker_option.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/setup/domain/currency_seed_data.dart';
import 'package:hotel/src/features/setup/domain/setup_region_options.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

/// Loads and updates reporting currency from local books DB ([SystemSettings] / [Currency]).
@lazySingleton
class AppCurrencyService extends ChangeNotifier {
  AppCurrencyService(this._db);

  final LocalDb _db;

  String _code = AppCurrencyCatalog.defaultCode;
  String _symbol = AppCurrencyCatalog.symbolFor(AppCurrencyCatalog.defaultCode);
  String _country = SetupRegionOptions.defaultCountryName;
  List<String> _availableCodes = List<String>.from(AppCurrencyCatalog.codes);

  String get code => _code;
  String get symbol => _symbol;
  String get country => _country;
  List<String> get availableCodes => List.unmodifiable(_availableCodes);

  /// Reporting currency line: ISO code and symbol only.
  String get reportingLabel => '$_code · $_symbol';

  /// Currencies for pickers: country name, ISO code, and symbol.
  Future<List<CurrencyPickerOption>> listCurrenciesForPicker() async {
    try {
      final db = await _db.database;
      final countries = await CurrencySeedData.countriesByCode();
      final rows = await db.query(
        'Currency',
        columns: ['name', 'symbol'],
        orderBy: 'name ASC',
      );
      if (rows.isEmpty) {
        final fromAsset = await CurrencySeedData.pickerOptionsFromAsset();
        _registerPickerSymbols(fromAsset);
        return fromAsset;
      }
      final options = rows
          .map((r) {
            final code = r['name']?.toString().trim() ?? '';
            if (code.isEmpty) return null;
            final sym = r['symbol']?.toString().trim();
            return CurrencyPickerOption(
              code: code,
              countryName: CurrencySeedData.countryNameForCode(code, countries),
              symbol: sym != null && sym.isNotEmpty ? sym : code,
            );
          })
          .whereType<CurrencyPickerOption>()
          .toList();
      options.sort(CurrencyPickerOption.compareByCode);
      _registerPickerSymbols(options);
      return options;
    } catch (_) {
      final fromAsset = await CurrencySeedData.pickerOptionsFromAsset();
      _registerPickerSymbols(fromAsset);
      return fromAsset;
    }
  }

  void _registerPickerSymbols(List<CurrencyPickerOption> options) {
    AppCurrencyFormatter.registerSymbols({
      for (final o in options) o.code: o.displaySymbol,
    });
  }

  Future<CurrencyPickerOption?> pickerOptionForCode(String code) async {
    final normalized = code.trim().toUpperCase();
    final options = await listCurrenciesForPicker();
    for (final o in options) {
      if (o.code == normalized) return o;
    }
    return null;
  }

  Future<void> _refreshAvailableCodes(Database db) async {
    final rows = await db.query(
      'Currency',
      columns: ['name'],
      orderBy: 'name ASC',
    );
    if (rows.isNotEmpty) {
      _availableCodes = rows
          .map((r) => r['name']?.toString().trim() ?? '')
          .where((c) => c.isNotEmpty)
          .toList();
      return;
    }
    _availableCodes = await CurrencySeedData.currencyCodesFromAsset();
  }

  Future<void> load() async {
    try {
      await _db.run((db) async {
        await _refreshAvailableCodes(db);
        await _refreshSymbolCache(db);

        final countryRow = await db.query(
          'SingleValue',
          where: 'parent = ? AND fieldname = ?',
          whereArgs: ['AccountingSettings', 'country'],
          limit: 1,
        );
        var country = countryRow.isNotEmpty
            ? countryRow.first['value']?.toString().trim()
            : null;

        final currencyRows = await db.query(
          'SingleValue',
          where: 'parent = ? AND fieldname = ?',
          whereArgs: ['SystemSettings', 'currency'],
          limit: 1,
        );
        var code = currencyRows.isNotEmpty
            ? currencyRows.first['value']?.toString().trim()
            : null;
        if (code == null || code.isEmpty) {
          code = AppCurrencyCatalog.defaultCode;
        }

        if (country == null || country.isEmpty) {
          country = SetupRegionOptions.firstCountryForCurrency(code) ??
              SetupRegionOptions.defaultCountryName;
        }

        final symbol = await _readSymbolFromCurrencyTable(db, code) ??
            AppCurrencyCatalog.symbolFor(code);

        _applyLocal(country: country, code: code, symbol: symbol);
      });
      notifyListeners();
    } catch (_) {
      _applyLocal(
        country: SetupRegionOptions.defaultCountryName,
        code: AppCurrencyCatalog.defaultCode,
        symbol: AppCurrencyCatalog.symbolFor(AppCurrencyCatalog.defaultCode),
      );
      notifyListeners();
    }
  }

  Future<void> updateCountry(String countryName) async {
    final option = SetupRegionOptions.countryNamed(countryName);
    if (option == null) {
      throw ArgumentError('Unknown country: $countryName');
    }

    final db = await _db.database;
    final now = DateTime.now().toIso8601String();
    final (countryCode, locale) = SetupRegionOptions.localeForCountry(countryName);

    await _upsertSingleValue(
      db: db,
      parent: 'AccountingSettings',
      fieldname: 'country',
      value: countryName,
      now: now,
    );
    await _upsertSingleValue(
      db: db,
      parent: 'SystemSettings',
      fieldname: 'countryCode',
      value: countryCode,
      now: now,
    );
    await _upsertSingleValue(
      db: db,
      parent: 'SystemSettings',
      fieldname: 'locale',
      value: locale,
      now: now,
    );

    _country = countryName;

    // Keep reporting currency in sync with the selected country.
    final mappedCurrency =
        SetupRegionOptions.currencyCodeForCountry(countryName)?.trim().toUpperCase();
    if (mappedCurrency != null &&
        mappedCurrency.isNotEmpty &&
        mappedCurrency != _code) {
      await _refreshAvailableCodes(db);
      if (_availableCodes.contains(mappedCurrency)) {
        final symbol = await _readSymbolFromCurrencyTable(db, mappedCurrency) ??
            AppCurrencyCatalog.symbolFor(mappedCurrency);
        await _upsertSingleValue(
          db: db,
          parent: 'SystemSettings',
          fieldname: 'currency',
          value: mappedCurrency,
          now: now,
        );
        _code = mappedCurrency;
        _symbol = symbol;
        AppCurrencyFormatter.apply(newCode: mappedCurrency, newSymbol: symbol);
      }
    }

    notifyListeners();
  }

  Future<void> updateCurrency(String newCode) async {
    final code = newCode.trim().toUpperCase();
    final db = await _db.database;
    await _refreshAvailableCodes(db);
    if (!_availableCodes.contains(code)) {
      throw ArgumentError('Unknown currency: $newCode');
    }

    final now = DateTime.now().toIso8601String();
    final symbol = await _readSymbolFromCurrencyTable(db, code) ??
        AppCurrencyCatalog.symbolFor(code);

    await _upsertSingleValue(
      db: db,
      parent: 'SystemSettings',
      fieldname: 'currency',
      value: code,
      now: now,
    );

    _code = code;
    _symbol = symbol;
    AppCurrencyFormatter.apply(newCode: code, newSymbol: symbol);
    notifyListeners();
  }

  void _applyLocal({
    required String country,
    required String code,
    required String symbol,
  }) {
    _country = country;
    _code = code;
    _symbol = symbol;
    AppCurrencyFormatter.apply(newCode: code, newSymbol: symbol);
  }

  Future<String?> _readSymbolFromCurrencyTable(Database db, String code) async {
    final rows = await db.query(
      'Currency',
      columns: ['symbol'],
      where: 'name = ?',
      whereArgs: [code],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    final sym = rows.first['symbol']?.toString().trim();
    return sym == null || sym.isEmpty ? null : sym;
  }

  Future<void> _refreshSymbolCache(Database db) async {
    // Asset first so empty DB symbols (e.g. missing FJD → $) still resolve.
    final fromAsset = await CurrencySeedData.pickerOptionsFromAsset();
    _registerPickerSymbols(fromAsset);

    final rows = await db.query(
      'Currency',
      columns: ['name', 'symbol'],
    );
    if (rows.isEmpty) return;

    final map = <String, String>{};
    for (final r in rows) {
      final name = r['name']?.toString().trim() ?? '';
      final sym = r['symbol']?.toString().trim() ?? '';
      if (name.isEmpty || sym.isEmpty) continue;
      map[name.toUpperCase()] = sym;
    }
    if (map.isNotEmpty) {
      AppCurrencyFormatter.registerSymbols(map);
    }
  }

  Future<void> _upsertSingleValue({
    required Database db,
    required String parent,
    required String fieldname,
    required String value,
    required String now,
  }) async {
    final rows = await db.query(
      'SingleValue',
      where: 'parent = ? AND fieldname = ?',
      whereArgs: [parent, fieldname],
      limit: 1,
    );
    if (rows.isNotEmpty) {
      await db.update(
        'SingleValue',
        {
          'value': value,
          'modified': now,
          'modifiedBy': 'system',
        },
        where: 'parent = ? AND fieldname = ?',
        whereArgs: [parent, fieldname],
      );
      return;
    }

    await db.insert('SingleValue', {
      'name': '$parent-$fieldname',
      'parent': parent,
      'fieldname': fieldname,
      'value': value,
      'created': now,
      'modified': now,
      'createdBy': 'system',
      'modifiedBy': 'system',
    });
  }
}

/// Convenience after DI is ready.
Future<void> refreshAppCurrency() => getIt<AppCurrencyService>().load();

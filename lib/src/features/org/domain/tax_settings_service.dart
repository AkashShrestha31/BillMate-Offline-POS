import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/org/domain/country_tax_profile.dart';
import 'package:hotel/src/features/org/domain/country_tax_rate_picker.dart';
import 'package:hotel/src/features/org/domain/invoice_tax_kind.dart';
import 'package:hotel/src/features/org/domain/tax_math.dart';
import 'package:injectable/injectable.dart';

class TaxSettings {
  const TaxSettings({
    required this.defaultTaxRate,
    required this.taxMode,
    required this.taxKind,
    this.taxIdLabel,
    this.taxIdNumber,
  });

  final double defaultTaxRate;
  final TaxMode taxMode;
  final InvoiceTaxKind taxKind;
  final String? taxIdLabel;
  final String? taxIdNumber;

  SalesInvoiceTaxCalculator calculator() => SalesInvoiceTaxCalculator(
        ratePercent: defaultTaxRate,
        mode: taxMode,
      );
}

/// Reads and updates tax settings in `AccountingSettings` SingleValue rows.
@lazySingleton
class TaxSettingsService {
  TaxSettingsService(this._db);

  final LocalDb _db;

  static const minTaxRate = 0.0;
  static const maxTaxRate = 100.0;

  Future<TaxSettings> load() async {
    final db = await _db.database;
    final rateRaw = await _readField(db, 'defaultTaxRate');
    final modeRaw = await _readField(db, 'taxMode');
    final kindRaw = await _readField(db, 'taxKind');
    final label = await _readField(db, 'taxIdLabel');
    final number = await _readField(db, 'taxIdNumber');
    return TaxSettings(
      defaultTaxRate: _parseRate(rateRaw),
      taxMode: TaxModeX.parse(modeRaw),
      taxKind: InvoiceTaxKindX.parse(kindRaw),
      taxIdLabel: label,
      taxIdNumber: number,
    );
  }

  Future<void> save({
    required double defaultTaxRate,
    required TaxMode taxMode,
    required InvoiceTaxKind taxKind,
    String? taxIdLabel,
    String? taxIdNumber,
  }) async {
    _assertRate(defaultTaxRate);
    final db = await _db.database;
    final now = DateTime.now().toIso8601String();
    await _upsert(
      db,
      fieldname: 'defaultTaxRate',
      value: defaultTaxRate.toString(),
      now: now,
    );
    await _upsert(
      db,
      fieldname: 'taxMode',
      value: taxMode.storageValue,
      now: now,
    );
    await _upsert(
      db,
      fieldname: 'taxKind',
      value: taxKind.storageValue,
      now: now,
    );
    await _upsert(
      db,
      fieldname: 'taxIdLabel',
      value: taxIdLabel?.trim() ?? '',
      now: now,
    );
    await _upsert(
      db,
      fieldname: 'taxIdNumber',
      value: taxIdNumber?.trim() ?? '',
      now: now,
    );
  }

  /// Applies country defaults when country changes (setup / org edit).
  static TaxSettings defaultsForCountry(
    String country, {
    String? existingNumber,
    InvoiceTaxKind taxKind = InvoiceTaxKind.vat,
  }) {
    final profile = CountryTaxProfiles.of(country);
    return TaxSettings(
      defaultTaxRate: profile.primaryRateFor(taxKind),
      taxMode: TaxMode.exclusive,
      taxKind: taxKind,
      taxIdLabel: profile.primaryTinLabelFor(taxKind),
      taxIdNumber: existingNumber,
    );
  }

  double _parseRate(String? raw) {
    final parsed = double.tryParse(raw ?? '');
    if (parsed == null) return 0;
    return parsed.clamp(minTaxRate, maxTaxRate);
  }

  void _assertRate(double value) {
    if (value < minTaxRate || value > maxTaxRate) {
      throw ArgumentError(
        'Tax rate must be between $minTaxRate and $maxTaxRate',
      );
    }
  }

  Future<String?> _readField(dynamic db, String fieldname) async {
    final rows = await db.query(
      'SingleValue',
      columns: ['value'],
      where: 'parent = ? AND fieldname = ?',
      whereArgs: ['AccountingSettings', fieldname],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    final value = rows.first['value']?.toString().trim();
    return (value == null || value.isEmpty) ? null : value;
  }

  Future<void> _upsert(
    dynamic db, {
    required String fieldname,
    required String value,
    required String now,
  }) async {
    final updated = await db.update(
      'SingleValue',
      {
        'value': value,
        'modified': now,
        'modifiedBy': 'system',
      },
      where: 'parent = ? AND fieldname = ?',
      whereArgs: ['AccountingSettings', fieldname],
    );
    if (updated > 0) return;

    await db.insert('SingleValue', {
      'name': 'AccountingSettings-$fieldname',
      'parent': 'AccountingSettings',
      'fieldname': fieldname,
      'value': value,
      'created': now,
      'modified': now,
      'createdBy': 'system',
      'modifiedBy': 'system',
    });
  }
}

TaxSettingsService get taxSettingsService => getIt<TaxSettingsService>();

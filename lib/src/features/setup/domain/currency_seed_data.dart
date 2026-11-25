import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hotel/src/core/services/currency/currency_picker_option.dart';

/// Row from [assetPath] used to seed the local `Currency` table.
class CurrencySeedRow {
  const CurrencySeedRow({
    required this.name,
    this.fraction,
    required this.fractionUnits,
    required this.smallestValue,
    this.symbol,
  });

  final String name;
  final String? fraction;
  final int fractionUnits;
  final String smallestValue;
  final String? symbol;

  Map<String, Object?> toDbMap({
    required String createdBy,
    required String modifiedBy,
    required String timestamp,
  }) {
    return {
      'name': name,
      'fraction': fraction?.isNotEmpty == true ? fraction : null,
      'fractionUnits': fractionUnits,
      'smallestValue': smallestValue,
      'symbol': symbol?.isNotEmpty == true ? symbol : null,
      'created': timestamp,
      'modified': timestamp,
      'createdBy': createdBy,
      'modifiedBy': modifiedBy,
    };
  }
}

/// Pre-imported ISO currencies from bundled CSV.
abstract final class CurrencySeedData {
  CurrencySeedData._();

  static const assetPath = 'assets/data/currency.csv';
  static const countriesAssetPath = 'assets/data/currency_countries.json';

  static List<CurrencySeedRow>? _cached;
  static Map<String, String>? _countriesByCode;

  /// Parses [assetPath] once and caches the result for the process lifetime.
  static Future<List<CurrencySeedRow>> loadFromAsset() async {
    if (_cached != null) return _cached!;
    final raw = await rootBundle.loadString(assetPath);
    _cached = parseCsv(raw);
    return _cached!;
  }

  static Future<List<String>> currencyCodesFromAsset() async {
    final rows = await loadFromAsset();
    final codes = rows.map((r) => r.name).toList()..sort();
    return codes;
  }

  static Future<Map<String, String>> countriesByCode() async {
    if (_countriesByCode != null) return _countriesByCode!;
    final raw = await rootBundle.loadString(countriesAssetPath);
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    _countriesByCode = decoded.map(
      (key, value) => MapEntry(key.toUpperCase(), value.toString()),
    );
    return _countriesByCode!;
  }

  static String countryNameForCode(String code, Map<String, String> countries) {
    final key = code.trim().toUpperCase();
    return countries[key] ?? key;
  }

  static Future<List<CurrencyPickerOption>> pickerOptionsFromAsset() async {
    final rows = await loadFromAsset();
    final countries = await countriesByCode();
    final options = rows
        .map(
          (r) => CurrencyPickerOption(
            code: r.name,
            countryName: countryNameForCode(r.name, countries),
            symbol: r.symbol ?? r.name,
          ),
        )
        .toList();
    options.sort(CurrencyPickerOption.compareByCode);
    return options;
  }

  /// ISO currency codes sorted for pickers (setup, settings).
  static List<CurrencySeedRow> parseCsv(String raw) {
    final lines = raw.split(RegExp(r'\r?\n'));
    if (lines.isEmpty) return [];

    final rows = <CurrencySeedRow>[];
    final seen = <String>{};

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.isEmpty) continue;
      if (i == 0 && line.toLowerCase().startsWith('name,')) continue;

      final fields = _splitCsvLine(line);
      if (fields.length < 5) continue;

      final name = fields[0].trim().toUpperCase();
      if (name.isEmpty || !seen.add(name)) continue;

      final fraction = fields[1].trim();
      final fractionUnits = int.tryParse(fields[2].trim()) ?? 100;
      final smallestValue = fields[3].trim().isNotEmpty ? fields[3].trim() : '0.01';
      final symbol = fields.length > 4 ? fields[4].trim() : '';

      rows.add(
        CurrencySeedRow(
          name: name,
          fraction: fraction.isEmpty ? null : fraction,
          fractionUnits: fractionUnits,
          smallestValue: smallestValue,
          symbol: symbol.isEmpty ? null : symbol,
        ),
      );
    }

    return rows;
  }

  static List<String> _splitCsvLine(String line) {
    final fields = <String>[];
    final buffer = StringBuffer();
    for (var i = 0; i < line.length; i++) {
      final char = line[i];
      if (char == ',') {
        fields.add(buffer.toString());
        buffer.clear();
        continue;
      }
      buffer.write(char);
    }
    fields.add(buffer.toString());
    return fields;
  }
}

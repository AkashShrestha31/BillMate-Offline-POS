/// One row in the searchable currency picker (setup, settings).
class CurrencyPickerOption {
  const CurrencyPickerOption({
    required this.code,
    required this.countryName,
    required this.symbol,
  });

  final String code;
  final String countryName;
  final String symbol;

  String get displaySymbol {
    final s = symbol.trim();
    return s.isNotEmpty ? s : code;
  }

  String get fieldLabel => '$code · $displaySymbol';

  bool matchesQuery(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return countryName.toLowerCase().contains(q) ||
        code.toLowerCase().contains(q) ||
        displaySymbol.toLowerCase().contains(q);
  }

  static int compareByCode(CurrencyPickerOption a, CurrencyPickerOption b) {
    return a.code.compareTo(b.code);
  }
}

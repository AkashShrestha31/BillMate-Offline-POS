/// One UI language from [assets/l10n/languages.json].
class AppLanguageOption {
  const AppLanguageOption({
    required this.code,
    required this.name,
    required this.nativeName,
  });

  final String code;
  final String name;
  final String nativeName;

  String get listTitle => name;
  String get listSubtitle => nativeName;
  String get fieldLabel => '$name · $nativeName';

  bool matchesQuery(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return name.toLowerCase().contains(q) ||
        nativeName.toLowerCase().contains(q) ||
        code.toLowerCase().contains(q);
  }
}

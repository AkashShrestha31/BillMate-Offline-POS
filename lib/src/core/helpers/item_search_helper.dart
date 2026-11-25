import 'package:hotel/src/features/action/data/models/response/item_response_model.dart';

/// Optional SKU is stored in [ItemModel.barcode].
String? itemSku(ItemModel item) {
  final value = item.barcode?.trim();
  if (value == null || value.isEmpty) return null;
  return value;
}

bool itemFitsForFilter(ItemModel item, String? forFilter) {
  if (forFilter == null || forFilter.trim().isEmpty) return true;
  final wanted = forFilter.trim().toLowerCase();
  final stored = item.forFilter.trim().toLowerCase();
  if (stored.isEmpty || stored == 'both') return true;
  return stored == wanted;
}

/// Values to try for one camera read: the text itself, each line, a code
/// pulled out of a link, GS1 product numbers, and long digit runs.
List<String> scanLookupKeys(String raw) {
  final cleaned = raw
      .trim()
      .replaceAll(RegExp(r'[\u0000-\u001F\uFEFF]'), '')
      .replaceAll(RegExp(r'[\u200B-\u200D]'), '');
  if (cleaned.isEmpty) return const [];
  final keys = <String>[cleaned];
  void add(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) return;
    if (!keys.contains(trimmed)) keys.add(trimmed);
  }

  final withoutAim = cleaned.replaceFirst(RegExp(r'^\][A-Za-z][0-9]'), '');
  add(withoutAim == cleaned ? null : withoutAim);
  for (final line in cleaned.split(RegExp(r'[\r\n]+'))) {
    add(line);
  }

  final uri = Uri.tryParse(cleaned);
  if (uri != null && uri.hasScheme) {
    for (final segment in uri.pathSegments) {
      add(segment);
    }
    for (final name in const ['code', 'sku', 'barcode', 'item', 'id', 'name']) {
      add(uri.queryParameters[name]);
    }
  }

  for (final match in RegExp(r'(?:\(?01\)?)(\d{14})').allMatches(cleaned)) {
    add(match.group(1));
  }
  for (final match in RegExp(r'\d{6,}').allMatches(cleaned)) {
    add(match.group(0));
  }
  return keys;
}

bool scannedCodeMatchesStored(String stored, String scanned) {
  final left = stored.trim().toLowerCase();
  final right = scanned.trim().toLowerCase();
  if (left.isEmpty || right.isEmpty) return false;
  if (left == right) return true;
  final compactLeft = left.replaceAll(RegExp(r'[\s\-_]'), '');
  final compactRight = right.replaceAll(RegExp(r'[\s\-_]'), '');
  if (compactLeft.isEmpty || compactRight.isEmpty) return false;
  if (compactLeft == compactRight) return true;
  if (compactLeft.length >= 6 &&
      compactRight.length > compactLeft.length &&
      compactRight.contains(compactLeft)) {
    return true;
  }
  final digitsLeft = compactLeft.replaceAll(RegExp(r'\D'), '');
  final digitsRight = compactRight.replaceAll(RegExp(r'\D'), '');
  if (digitsLeft.length < 6 || digitsRight.length < 6) return false;
  if (digitsLeft == digitsRight) return true;
  if (digitsRight.contains(digitsLeft)) return true;
  final strippedLeft = digitsLeft.replaceFirst(RegExp(r'^0+'), '');
  final strippedRight = digitsRight.replaceFirst(RegExp(r'^0+'), '');
  return strippedLeft.isNotEmpty &&
      (strippedLeft == strippedRight || strippedRight.contains(strippedLeft));
}

/// How a scanned string relates to an item name.
///
/// 2 = the scan is exactly the name, or the name is a phrase inside the scan.
/// 1 = the scan is a phrase inside the item name.
int scannedNameMatchRank(String name, String scanned) {
  final itemName = name.trim().toLowerCase();
  final text = scanned.trim().toLowerCase();
  if (itemName.isEmpty || text.isEmpty) return 0;
  if (itemName == text) return 2;
  if (itemName.length >= 3 &&
      RegExp(
        '(?:^|[^a-z0-9])${RegExp.escape(itemName)}(?:[^a-z0-9]|\$)',
      ).hasMatch(text)) {
    return 2;
  }
  if (text.length >= 4 && itemName.contains(text)) return 1;
  return 0;
}

/// Barcode or SKU first, then HSN, then an exact item name.
ItemModel? itemMatchingScannedCode(
  Iterable<ItemModel> items,
  String code, {
  String? forFilter,
}) {
  final keys = scanLookupKeys(code);
  if (keys.isEmpty) return null;
  ItemModel? byName;
  var byNameRank = 0;
  var byNameLength = 0;
  ItemModel? otherPurpose;
  for (final item in items) {
    final fits = itemFitsForFilter(item, forFilter);
    final sku = item.barcode?.trim() ?? '';
    final hsn = item.hsnCode?.trim() ?? '';
    final description = item.description?.trim() ?? '';
    var matchedCode = false;
    var nameRank = 0;
    for (final key in keys) {
      if (sku.isNotEmpty && scannedCodeMatchesStored(sku, key)) {
        matchedCode = true;
      }
      if (hsn.isNotEmpty && scannedCodeMatchesStored(hsn, key)) {
        matchedCode = true;
      }
      if (description.isNotEmpty &&
          (scannedCodeMatchesStored(description, key) ||
              (key.trim().length >= 6 &&
                  description.toLowerCase().contains(key.trim().toLowerCase())))) {
        matchedCode = true;
      }
      final rank = scannedNameMatchRank(item.name, key);
      if (rank > nameRank) nameRank = rank;
    }
    if (matchedCode) {
      if (fits) return item;
      otherPurpose ??= item;
      continue;
    }
    if (nameRank == 0) continue;
    final length = item.name.trim().length;
    final better = nameRank > byNameRank ||
        (nameRank == byNameRank && nameRank >= 2 && length > byNameLength) ||
        (nameRank == byNameRank && nameRank < 2 && length < byNameLength);
    if (better && (fits || byName == null)) {
      byName = item;
      byNameRank = nameRank;
      byNameLength = length;
    }
  }
  return byName ?? otherPurpose;
}

bool itemMatchesSearch(ItemModel item, String query) {
  final trimmed = query.trim();
  if (trimmed.isEmpty) return true;

  final q = trimmed.toLowerCase();
  if (item.name.toLowerCase().contains(q)) return true;

  final sku = itemSku(item);
  if (sku != null && sku.toLowerCase().contains(q)) {
    return true;
  }

  final hsn = item.hsnCode?.trim();
  if (hsn != null && hsn.isNotEmpty && hsn.toLowerCase().contains(q)) {
    return true;
  }

  return false;
}

bool itemBelongsToCategory(ItemModel item, String category) {
  final stored = item.category?.trim().toLowerCase() ?? '';
  if (stored.isEmpty) return false;

  final raw = category.trim().toLowerCase();
  if (raw.isEmpty) return false;
  if (stored == raw) return true;

  final rawDisplay = _categoryDisplayName(raw);
  final storedDisplay = _categoryDisplayName(stored);
  return stored == rawDisplay ||
      storedDisplay == raw ||
      storedDisplay == rawDisplay;
}

String _categoryDisplayName(String fullName) {
  final idx = fullName.indexOf(' - ');
  if (idx >= 0 && idx + 3 < fullName.length) {
    return fullName.substring(idx + 3).trim();
  }
  return fullName;
}

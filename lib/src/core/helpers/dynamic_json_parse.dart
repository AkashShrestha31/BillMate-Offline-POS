/// Defensive parsing for dynamic numeric / list fields from API maps (reports, charts).
double safeDouble(Object? value, {double fallback = 0}) {
  if (value == null) return fallback;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString()) ?? fallback;
}

int safeInt(Object? value, {int fallback = 0}) {
  if (value == null) return fallback;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString()) ?? fallback;
}

String safeText(Object? value, {String fallback = ''}) {
  if (value == null) return fallback;
  final text = value.toString().trim();
  return text.isEmpty ? fallback : text;
}

List<Map<String, dynamic>> safeMapList(Object? value) {
  if (value is! List) return <Map<String, dynamic>>[];
  return value.whereType<Map>().map((e) => Map<String, dynamic>.from(e)).toList();
}

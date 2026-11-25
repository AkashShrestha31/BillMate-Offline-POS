/// Normalizes user input for organization lookup.
///
/// Accepts plain codes (`PSFYCF8H`) or pasted API URLs/paths and returns the code segment.
String normalizeOrganizationCode(String raw) {
  var text = raw.trim();
  if (text.isEmpty) return text;

  Iterable<String> segmentsFromPath(String path) {
    return path.split('/').where((s) => s.isNotEmpty);
  }

  String? codeAfterOrgSegment(Iterable<String> segments) {
    final list = segments.toList();
    final orgIdx = list.lastIndexWhere((s) => s.toLowerCase() == 'org');
    if (orgIdx >= 0 && orgIdx + 1 < list.length) {
      return list[orgIdx + 1];
    }
    return list.isEmpty ? null : list.last;
  }

  if (text.contains('://')) {
    final uri = Uri.tryParse(text);
    if (uri != null) {
      final extracted = codeAfterOrgSegment(segmentsFromPath(uri.path));
      if (extracted != null && extracted.isNotEmpty) return extracted;
    }
  }

  if (text.contains('/')) {
    final extracted = codeAfterOrgSegment(segmentsFromPath(text));
    if (extracted != null && extracted.isNotEmpty) return extracted;
  }

  return text.replaceAll('/', '');
}

/// Passes prefill values into [OrganizationCodePage] without route codegen.
class OrgCodePageIntent {
  OrgCodePageIntent._();

  static String? _initialCode;
  static String? _initialDisplayName;

  static void setPrefill({
    required String code,
    String? displayName,
  }) {
    _initialCode = code.trim();
    _initialDisplayName = displayName?.trim();
  }

  static void clearPrefill() {
    _initialCode = null;
    _initialDisplayName = null;
  }

  static ({String? code, String? displayName}) consumePrefill() {
    final result = (code: _initialCode, displayName: _initialDisplayName);
    _initialCode = null;
    _initialDisplayName = null;
    return result;
  }
}

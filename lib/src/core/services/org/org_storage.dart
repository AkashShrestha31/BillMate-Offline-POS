import 'package:shared_preferences/shared_preferences.dart';

/// Persisted tenant for [CustomInterceptors] `X-Org-Slug` header.
class OrgStorage {
  OrgStorage._();

  static const _slugKey = 'org_slug';
  static const _nameKey = 'org_name';
  static const _codeKey = 'org_code';
  static const _businessTypeKey = 'org_business_type';
  static const _allowedEmailDomainKey = 'org_allowed_email_domain';
  static const _activeDbSlugKey = 'org_active_db_slug';

  static String? _cachedSlug;

  static Future<bool> hasOrgSlug() async {
    final slug = await getOrgSlug();
    return slug != null && slug.isNotEmpty;
  }

  static Future<String?> getOrgSlug() async {
    if (_cachedSlug != null && _cachedSlug!.isNotEmpty) {
      return _cachedSlug;
    }
    final prefs = await SharedPreferences.getInstance();
    _cachedSlug = prefs.getString(_slugKey);
    return _cachedSlug;
  }

  static Future<String?> getOrgName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
  }

  static Future<String?> getOrgCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_codeKey);
  }

  static Future<String?> getBusinessType() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_businessTypeKey)?.trim();
    return (value == null || value.isEmpty) ? null : value;
  }

  static Future<void> saveBusinessType(String? businessType) async {
    final prefs = await SharedPreferences.getInstance();
    final trimmed = businessType?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      await prefs.remove(_businessTypeKey);
      return;
    }
    await prefs.setString(_businessTypeKey, trimmed);
  }

  static Future<String?> getActiveDatabaseSlug() async {
    final prefs = await SharedPreferences.getInstance();
    final slug = prefs.getString(_activeDbSlugKey)?.trim();
    return (slug == null || slug.isEmpty) ? null : slug;
  }

  static Future<void> saveActiveDatabaseSlug(String slug) async {
    final trimmed = slug.trim();
    if (trimmed.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_activeDbSlugKey, trimmed);
  }

  /// Domain only, without `@` — e.g. `achaju.com`.
  static Future<String?> getAllowedEmailDomain() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_allowedEmailDomainKey);
    if (raw == null) return null;
    final trimmed = raw.trim().replaceFirst(RegExp(r'^@+'), '');
    return trimmed.isEmpty ? null : trimmed;
  }

  static Future<void> saveOrganization({
    required String slug,
    required String code,
    String? name,
    String? businessType,
    String? allowedEmailDomain,
  }) async {
    final trimmedSlug = slug.trim();
    if (trimmedSlug.isEmpty) return;

    _cachedSlug = trimmedSlug;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_slugKey, trimmedSlug);
    await prefs.setString(_codeKey, code.trim());
    if (name != null && name.trim().isNotEmpty) {
      await prefs.setString(_nameKey, name.trim());
    } else {
      await prefs.remove(_nameKey);
    }
    await saveBusinessType(businessType);
    final domain = allowedEmailDomain?.trim().replaceFirst(RegExp(r'^@+'), '');
    if (domain != null && domain.isNotEmpty) {
      await prefs.setString(_allowedEmailDomainKey, domain);
    } else {
      await prefs.remove(_allowedEmailDomainKey);
    }
  }

  static Future<void> clear() async {
    _cachedSlug = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_slugKey);
    await prefs.remove(_nameKey);
    await prefs.remove(_codeKey);
    await prefs.remove(_businessTypeKey);
    await prefs.remove(_allowedEmailDomainKey);
    await prefs.remove(_activeDbSlugKey);
  }
}

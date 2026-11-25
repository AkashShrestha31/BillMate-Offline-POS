import 'package:hotel/src/features/backup/domain/models/organization_backup_meta.dart';
import 'package:sqflite/sqflite.dart';

/// Organization identity read from local `SingleValue` rows or backup metadata.
class BackupOrgIdentity {
  const BackupOrgIdentity({
    required this.slug,
    required this.code,
    required this.name,
    this.businessType,
  });

  final String slug;
  final String code;
  final String name;
  final String? businessType;

  bool get isValid => slug.isNotEmpty && code.isNotEmpty && name.isNotEmpty;
}

/// Resolves organization display fields for backup export and restore.
class BackupOrgIdentityReader {
  BackupOrgIdentityReader._();

  static Future<BackupOrgIdentity> readFromDatabase(
    Database db, {
    required String fallbackSlug,
  }) async {
    final organizationName = await _readSingleValue(
      db,
      parent: 'Organization',
      fieldname: 'organizationName',
    );
    final orgCompanyName = await _readSingleValue(
      db,
      parent: 'Organization',
      fieldname: 'companyName',
    );
    final accountingCompanyName = await _readSingleValue(
      db,
      parent: 'AccountingSettings',
      fieldname: 'companyName',
    );
    final code = await _readSingleValue(
          db,
          parent: 'Organization',
          fieldname: 'organizationCode',
        ) ??
        '';
    final slug = await _readSingleValue(
          db,
          parent: 'Organization',
          fieldname: 'organizationSlug',
        ) ??
        fallbackSlug;
    final businessType = await _readSingleValue(
      db,
      parent: 'Organization',
      fieldname: 'businessType',
    );

    final name = pickDisplayName([
      organizationName,
      orgCompanyName,
      accountingCompanyName,
    ]);

    return BackupOrgIdentity(
      slug: slug.trim().isNotEmpty ? slug.trim() : fallbackSlug,
      code: code.trim().toUpperCase(),
      name: name.isNotEmpty ? name : fallbackSlug,
      businessType: businessType,
    );
  }

  static BackupOrgIdentity merge({
    required BackupOrgIdentity fromDatabase,
    required OrganizationBackupMeta meta,
    required String fallbackSlug,
  }) {
    final slug = _firstNonEmpty([
      fromDatabase.slug,
      meta.slug,
      fallbackSlug,
    ]);
    final code = _firstNonEmpty([
      fromDatabase.code,
      meta.code.trim().toUpperCase(),
      slug,
    ]).toUpperCase();
    final name = pickDisplayName([
      fromDatabase.name,
      meta.name,
    ]);
    final businessType = _firstNonEmpty([
      fromDatabase.businessType ?? '',
      meta.businessType ?? '',
    ]);

    return BackupOrgIdentity(
      slug: slug,
      code: code,
      name: name.isNotEmpty ? name : slug,
      businessType: businessType.isEmpty ? null : businessType,
    );
  }

  static String pickDisplayName(Iterable<String?> candidates) {
    for (final candidate in candidates) {
      final trimmed = candidate?.trim() ?? '';
      if (trimmed.isEmpty) continue;
      if (looksLikeEmail(trimmed)) continue;
      return trimmed;
    }
    return '';
  }

  static bool looksLikeEmail(String value) {
    final trimmed = value.trim();
    if (!trimmed.contains('@')) return false;
    final parts = trimmed.split('@');
    if (parts.length != 2) return false;
    return parts.first.isNotEmpty && parts.last.contains('.');
  }

  static Future<String?> _readSingleValue(
    Database db, {
    required String parent,
    required String fieldname,
  }) async {
    try {
      final rows = await db.query(
        'SingleValue',
        columns: ['value'],
        where: 'parent = ? AND fieldname = ?',
        whereArgs: [parent, fieldname],
        limit: 1,
      );
      if (rows.isEmpty) return null;
      final value = rows.first['value']?.toString().trim();
      return (value == null || value.isEmpty) ? null : value;
    } catch (_) {
      return null;
    }
  }

  static String _firstNonEmpty(Iterable<String> values) {
    for (final value in values) {
      final trimmed = value.trim();
      if (trimmed.isNotEmpty) return trimmed;
    }
    return '';
  }
}

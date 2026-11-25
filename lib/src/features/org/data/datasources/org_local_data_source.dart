import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/org/org_registry_storage.dart';
import 'package:hotel/src/features/org/data/models/org_response_model.dart';
import 'package:hotel/src/features/org/domain/org_code_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

/// Resolves organizations created on this device (local setup / registry).
@lazySingleton
class OrgLocalDataSource {
  OrgLocalDataSource(this._db);

  final LocalDb _db;

  Future<OrgResponseModel?> findByCode(String rawCode) async {
    final code = normalizeOrganizationCode(rawCode).toUpperCase();
    if (code.isEmpty) return null;

    final fromRegistry = await _matchRegistry(code);
    if (fromRegistry != null) return fromRegistry;

    if (!await LocalDb.databaseFileExists()) return null;

    try {
      final db = await _db.database;
      final fromDb = await _matchOrganizationSingleValues(db, code);
      if (fromDb != null) return fromDb;

      return _matchLegacySlugPrefix(db, code);
    } catch (_) {
      return null;
    }
  }

  Future<OrgResponseModel?> _matchRegistry(String code) async {
    for (final org in await OrgRegistryStorage.getAll()) {
      if (org.code.toUpperCase() == code) {
        return OrgResponseModel(
          slug: org.slug,
          name: org.name,
          code: org.code,
          businessType: org.businessType,
        );
      }
    }
    return null;
  }

  Future<OrgResponseModel?> _matchOrganizationSingleValues(
    Database db,
    String code,
  ) async {
    final codeRows = await db.query(
      'SingleValue',
      where: "parent = 'Organization' AND fieldname = 'organizationCode' "
          "AND UPPER(TRIM(value)) = ?",
      whereArgs: [code],
      limit: 1,
    );
    if (codeRows.isEmpty) return null;

    final slug = await _readOrgField(db, 'organizationSlug');
    final name = await _readOrgField(db, 'organizationName') ??
        await _readOrgField(db, 'companyName') ??
        await _readAccountingCompanyName(db);
    final businessType = await _readOrgField(db, 'businessType');

    return OrgResponseModel(
      slug: slug ?? code,
      name: name,
      code: code,
      businessType: businessType,
    );
  }

  Future<OrgResponseModel?> _matchLegacySlugPrefix(
    Database db,
    String code,
  ) async {
    final orgName = await _readOrgField(db, 'organizationName') ??
        await _readAccountingCompanyName(db);
    if (orgName == null || orgName.isEmpty) return null;

    final slug = orgName.replaceAll(RegExp(r'\s+'), '');
    if (slug.isEmpty) return null;

    final legacyCode = slug.length >= 4
        ? slug.substring(0, 4).toUpperCase()
        : slug.toUpperCase();
    if (legacyCode != code) return null;

    return OrgResponseModel(
      slug: slug,
      name: orgName,
      code: legacyCode,
    );
  }

  Future<String?> _readOrgField(Database db, String fieldname) async {
    final rows = await db.query(
      'SingleValue',
      columns: ['value'],
      where: "parent = 'Organization' AND fieldname = ?",
      whereArgs: [fieldname],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    final value = rows.first['value']?.toString().trim();
    return (value == null || value.isEmpty) ? null : value;
  }

  Future<String?> _readAccountingCompanyName(Database db) async {
    final rows = await db.query(
      'SingleValue',
      columns: ['value'],
      where: "parent = 'AccountingSettings' AND fieldname = 'companyName'",
      limit: 1,
    );
    if (rows.isEmpty) return null;
    final value = rows.first['value']?.toString().trim();
    return (value == null || value.isEmpty) ? null : value;
  }
}

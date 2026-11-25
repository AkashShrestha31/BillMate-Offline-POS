import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/org/org_registry_storage.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/core/services/org/saved_organization.dart';
import 'package:hotel/src/features/org/domain/org_switch_coordinator.dart';
import 'package:hotel/src/features/org/domain/organization_business_type.dart';
import 'package:hotel/src/features/org/domain/organization_field_limits.dart';
import 'package:hotel/src/features/org/domain/organization_settings.dart';

/// Reads and updates organization identity stored in local `SingleValue` rows.
class OrganizationSettingsService {
  OrganizationSettingsService({LocalDb? db}) : _db = db ?? getIt<LocalDb>();

  final LocalDb _db;

  Future<OrganizationSettings> load() async {
    final database = await _db.database;
    final organizationName = await _readField(database, 'organizationName') ??
        await _readField(database, 'companyName') ??
        (await OrgStorage.getOrgName()) ??
        '';
    final companyName = await _readField(database, 'companyName') ??
        organizationName;
    final businessType = OrganizationBusinessType.normalize(
      await _readField(database, 'businessType') ??
          await OrgStorage.getBusinessType(),
    );
    final organizationCode =
        (await _readField(database, 'organizationCode') ??
                await OrgStorage.getOrgCode())
            ?.trim()
            .toUpperCase() ??
        '';
    final organizationSlug = await _readField(database, 'organizationSlug') ??
        (await OrgStorage.getOrgSlug()) ??
        '';

    final logo = await _readSingleValue(database, parent: 'Organization', fieldname: 'logo') ??
        await _readSingleValue(database, parent: 'PrintSettings', fieldname: 'logo');

    return OrganizationSettings(
      organizationName: organizationName,
      companyName: companyName,
      businessType: businessType,
      organizationCode: organizationCode,
      organizationSlug: organizationSlug,
      logo: logo,
    );
  }

  Future<void> saveLogo(String? logo) async {
    final database = await _db.database;
    final value = logo?.trim() ?? '';
    await _upsertSingleValue(
      database,
      parent: 'Organization',
      fieldname: 'logo',
      value: value,
    );
    await _upsertSingleValue(
      database,
      parent: 'PrintSettings',
      fieldname: 'logo',
      value: value,
    );
    OrgSwitchCoordinator.notifier.value++;
  }

  Future<void> save({
    required String organizationName,
    required String companyName,
    required String businessType,
  }) async {
    final trimmedOrgName = organizationName.trim();
    final trimmedCompanyName = companyName.trim();
    if (trimmedOrgName.isEmpty || trimmedCompanyName.isEmpty) {
      throw ArgumentError('Organization name and company name are required');
    }
    OrganizationFieldLimits.assertNameLength(
      trimmedOrgName,
      fieldLabel: 'Organization name',
    );
    OrganizationFieldLimits.assertNameLength(
      trimmedCompanyName,
      fieldLabel: 'Company name',
    );

    final database = await _db.database;
    final existing = await load();
    final organizationCreated = existing.organizationCode.isNotEmpty ||
        existing.organizationSlug.isNotEmpty;
    final normalizedType = organizationCreated
        ? OrganizationBusinessType.normalize(existing.businessType)
        : OrganizationBusinessType.normalize(businessType);

    await _upsertSingleValue(
      database,
      parent: 'Organization',
      fieldname: 'organizationName',
      value: trimmedOrgName,
    );
    await _upsertSingleValue(
      database,
      parent: 'Organization',
      fieldname: 'companyName',
      value: trimmedCompanyName,
    );
    await _upsertSingleValue(
      database,
      parent: 'Organization',
      fieldname: 'businessType',
      value: normalizedType,
    );
    await _upsertSingleValue(
      database,
      parent: 'AccountingSettings',
      fieldname: 'companyName',
      value: trimmedCompanyName,
    );

    final slug = existing.organizationSlug.isNotEmpty
        ? existing.organizationSlug
        : (await OrgStorage.getOrgSlug()) ?? '';
    final code = existing.organizationCode.isNotEmpty
        ? existing.organizationCode
        : (await OrgStorage.getOrgCode()) ?? '';

    if (slug.isNotEmpty && code.isNotEmpty) {
      await OrgStorage.saveOrganization(
        slug: slug,
        code: code,
        name: trimmedOrgName,
        businessType: normalizedType,
      );
      await OrgRegistryStorage.addOrUpdate(
        SavedOrganization(
          slug: slug,
          code: code,
          name: trimmedOrgName,
          businessType: normalizedType,
        ),
      );
    } else {
      await OrgStorage.saveBusinessType(normalizedType);
    }

    OrgSwitchCoordinator.notifier.value++;
  }

  Future<String?> _readField(dynamic db, String fieldname) async {
    return _readSingleValue(db, parent: 'Organization', fieldname: fieldname);
  }

  Future<String?> _readSingleValue(
    dynamic db, {
    required String parent,
    required String fieldname,
  }) async {
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
  }

  Future<void> _upsertSingleValue(
    dynamic db, {
    required String parent,
    required String fieldname,
    required String value,
  }) async {
    final updated = await db.update(
      'SingleValue',
      {
        'value': value,
        'modified': DateTime.now().toIso8601String(),
        'modifiedBy': 'system',
      },
      where: 'parent = ? AND fieldname = ?',
      whereArgs: [parent, fieldname],
    );
    if (updated > 0) return;

    final now = DateTime.now().toIso8601String();
    await db.insert('SingleValue', {
      'name': '$parent-$fieldname',
      'parent': parent,
      'fieldname': fieldname,
      'value': value,
      'created': now,
      'modified': now,
      'createdBy': 'system',
      'modifiedBy': 'system',
    });
  }
}

import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/local/single_value_upsert.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/core/services/org/saved_organization.dart';
import 'package:hotel/src/features/org/domain/organization_business_type.dart';

/// Writes the active workspace identity into the local books database.
class OrganizationMetadataService {
  OrganizationMetadataService._();

  static Future<void> applyActiveOrganization(SavedOrganization org) async {
    final db = await getIt<LocalDb>().database;
    final name = org.name.isNotEmpty ? org.name : org.slug;
    final code = org.code.trim().toUpperCase();

    final businessType = org.businessType?.trim().isNotEmpty == true
        ? OrganizationBusinessType.normalize(org.businessType)
        : OrganizationBusinessType.defaultCode;

    final orgFields = <String, String>{
      'organizationCode': code,
      'organizationName': name,
      'organizationSlug': org.slug,
      'companyName': name,
      'businessType': businessType,
    };

    await OrgStorage.saveBusinessType(businessType);

    for (final entry in orgFields.entries) {
      await SingleValueUpsert.upsert(
        db,
        parent: 'Organization',
        fieldname: entry.key,
        value: entry.value,
        preferredName: 'Organization-${entry.key}',
        actor: 'Administrator',
      );
    }

    await SingleValueUpsert.upsert(
      db,
      parent: 'AccountingSettings',
      fieldname: 'companyName',
      value: name,
      preferredName: 'AccountingSettings-companyName',
      actor: 'Administrator',
    );
  }
}

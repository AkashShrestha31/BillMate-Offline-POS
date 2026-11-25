import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/features/org/domain/organization_business_type.dart';

/// Reads `businessType` from org prefs or the active books database.
abstract final class OrganizationBusinessTypeReader {
  static Future<String?> current() async {
    final cached = await OrgStorage.getBusinessType();
    if (cached != null && cached.isNotEmpty) return cached;
    return readFromDatabase(getIt<LocalDb>());
  }

  static Future<String?> readFromDatabase(LocalDb db) async {
    try {
      final database = await db.database;
      final rows = await database.query(
        'SingleValue',
        columns: ['value'],
        where: "parent = 'Organization' AND fieldname = 'businessType'",
        limit: 1,
      );
      if (rows.isEmpty) return null;
      final value = rows.first['value']?.toString().trim();
      return (value == null || value.isEmpty) ? null : value;
    } catch (_) {
      return null;
    }
  }

  static Future<void> syncToOrgStorage(LocalDb db) async {
    final value = await readFromDatabase(db);
    if (value == null || value.isEmpty) return;
    await OrgStorage.saveBusinessType(value);
  }

  static String normalizedOrDefault(String? raw) =>
      OrganizationBusinessType.normalize(raw);
}

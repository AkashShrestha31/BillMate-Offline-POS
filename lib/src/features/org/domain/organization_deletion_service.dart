import 'dart:io';

import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/helpers/session_helper.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/org/org_registry_storage.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/core/services/org/saved_organization.dart';
import 'package:hotel/src/features/org/domain/organization_database_service.dart';
import 'package:hotel/src/features/setup/domain/local_setup_storage.dart';
import 'package:hotel/src/features/setup/domain/test_data_organization_seeder.dart';
import 'package:hotel/src/features/setup/domain/test_data_storage.dart';
import 'package:sqflite/sqflite.dart';

/// Removes a saved organization and any on-device data tied to it.
class OrganizationDeletionService {
  OrganizationDeletionService({LocalDb? db}) : _db = db ?? getIt<LocalDb>();

  final LocalDb _db;

  /// Deletes [org] from the registry. Wipes the local books DB when [org] owns it.
  /// Returns `true` when the active org was removed and the session was cleared.
  Future<bool> deleteOrganization(SavedOrganization org) async {
    final currentSlug = (await OrgStorage.getOrgSlug())?.trim() ?? '';
    final currentCode = (await OrgStorage.getOrgCode())?.trim().toUpperCase() ?? '';
    final orgCode = org.code.trim().toUpperCase();
    final isCurrent = (currentSlug.isNotEmpty && currentSlug == org.slug) ||
        (currentCode.isNotEmpty && currentCode == orgCode);

    await OrganizationDatabaseService.deleteStoredDatabase(org);

    final isExtraDemo =
        await TestDataOrganizationSeeder.isDemoGeneratedOrganizationCode(org.code);
    if (isExtraDemo) {
      await TestDataOrganizationSeeder.removeExtraOrganizationByCode(org.code);
    }
    await OrgRegistryStorage.removeByCodes([org.code]);

    if (isCurrent) {
      await _wipeLocalBooksInstall();
      await SessionHelper.clearSessionData();
      await OrgStorage.clear();
      return true;
    }
    return false;
  }

  Future<void> _wipeLocalBooksInstall() async {
    await _db.resetConnection();
    final activeDbSlug = await OrgStorage.getActiveDatabaseSlug();
    final orgSlug = await OrgStorage.getOrgSlug();
    for (final slug in {activeDbSlug, orgSlug}) {
      if (slug != null && slug.isNotEmpty) {
        await OrganizationDatabaseService.deleteDatabaseForSlug(slug);
      }
    }
    final legacy = await LocalDb.legacyDatabasePath();
    if (await File(legacy).exists()) {
      await deleteDatabase(legacy);
    }
    await LocalSetupStorage.clearAll();
    await TestDataStorage.setEnabled(false);
    await TestDataStorage.setProvisionedViaOrgTestLogin(false);
  }
}

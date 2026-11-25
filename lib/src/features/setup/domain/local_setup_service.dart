import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:hotel/src/core/services/currency/app_currency_service.dart';
import 'package:hotel/src/core/services/display_precision/app_display_precision_service.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/org/org_registry_storage.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/core/services/org/saved_organization.dart';
import 'package:hotel/src/features/setup/data/models/setup_complete_request.dart';
import 'package:hotel/src/features/org/domain/organization_database_service.dart';
import 'package:hotel/src/features/org/domain/organization_field_limits.dart';
import 'package:hotel/src/features/setup/domain/local_books_database_health.dart';
import 'package:hotel/src/features/setup/domain/local_books_bootstrap.dart';
import 'package:hotel/src/features/setup/domain/local_books_database_creator.dart';
import 'package:hotel/src/core/services/org/org_test_data_visibility_storage.dart';
import 'package:hotel/src/features/setup/domain/local_setup_storage.dart';
import 'package:hotel/src/features/setup/domain/local_test_data_seeder.dart';
import 'package:hotel/src/features/setup/domain/test_data_seed_log.dart';
import 'package:hotel/src/features/setup/domain/setup_field_limits.dart';
import 'package:hotel/src/features/setup/domain/test_data_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LocalSetupService {
  LocalSetupService(this._db);

  final LocalDb _db;

  static Future<bool> needsSetup() async {
    if (await LocalSetupStorage.isCompleted()) {
      if (await LocalDb.databaseFileExists()) return false;
    }

    if (await _hasHealthyOrganizationInRegistry()) return false;

    final fileExists = await LocalDb.databaseFileExists();
    if (!fileExists) return true;
    if (await LocalSetupStorage.isCompleted()) return false;

    // App versions that auto-copied the asset DB already have setupComplete=1.
    try {
      final db = await getIt<LocalDb>().database;
      final rows = await db.query(
        'SingleValue',
        where: 'parent = ? AND fieldname = ?',
        whereArgs: ['AccountingSettings', 'setupComplete'],
        limit: 1,
      );
      final value = rows.isNotEmpty ? rows.first['value']?.toString() : null;
      if (value == '1' || value == '1.0') {
        await LocalSetupStorage.markLegacyMigrated();
        return false;
      }
    } catch (_) {
      // DB unreadable — run setup again.
    }
    return true;
  }

  /// True when a Drive restore (or prior setup) left a usable org database.
  static Future<bool> _hasHealthyOrganizationInRegistry() async {
    final orgs = await OrgRegistryStorage.getAll();
    for (final org in orgs) {
      if (!org.isValid) continue;
      final path = await LocalDb.databasePathForOrg(org.slug);
      if (!await LocalBooksDatabaseHealth.isHealthyAtPath(path)) continue;

      await LocalSetupStorage.markLegacyMigrated();
      if (!await OrgStorage.hasOrgSlug()) {
        await OrgStorage.saveOrganization(
          slug: org.slug,
          code: org.code,
          name: org.name,
          businessType: org.businessType,
        );
        await OrgStorage.saveActiveDatabaseSlug(org.slug);
      }
      return true;
    }
    return false;
  }

  Future<void> completeSetup(
    SetupCompleteRequest request, {
    bool loadTestData = false,
  }) async {
    OrganizationFieldLimits.assertNameLength(
      request.organizationName,
      fieldLabel: 'Organization name',
    );
    OrganizationFieldLimits.assertNameLength(
      request.companyName,
      fieldLabel: 'Company name',
    );
    SetupFieldLimits.assertFullNameLength(request.fullName);
    SetupFieldLimits.assertEmailLength(request.email);
    SetupFieldLimits.assertBankNameLength(request.bankName);
    final slug = request.organizationSlug;
    if (slug.isNotEmpty) {
      final existingOrgs = await OrgRegistryStorage.getAll();
      final isNewOrg = !existingOrgs.any((o) => o.slug == slug);
      if (isNewOrg) {
        await getIt<FreemiumGateService>().assertCan(
          FreemiumFeature.organization,
        );
      }
    }
    await OrganizationDatabaseService.archiveActiveDatabase();
    await _db.resetConnection();

    // LocalBooksDatabaseCreator.createFresh creates the SQLite file for [slug],
    // but LocalDb chooses its DB path based on OrgStorage. Set it early so
    // bootstrap/seed open the correct database.
    if (slug.isNotEmpty) {
      await OrgStorage.saveActiveDatabaseSlug(slug);
    }

    await LocalBooksDatabaseCreator.createFresh(orgSlug: slug);
    await LocalBooksBootstrap(_db).seed(
      request,
      enableTestDataTools: loadTestData,
    );
    if (loadTestData) {
      final seed = request.organizationCode.trim().toUpperCase().hashCode;
      await LocalTestDataSeeder(_db, seed: seed).seed(
        request,
        registerExtraOrganizations: false,
      );
    } else {
      await TestDataStorage.setEnabled(false);
      await TestDataStorage.clearExtraOrgCodes();
      await TestDataStorage.setProvisionedViaOrgTestLogin(false);
    }
    await LocalSetupStorage.markCompleted(
      adminEmail: request.email,
      adminPassword: request.password,
    );
    await Future.wait([
      getIt<AppCurrencyService>().load(),
      getIt<AppDisplayPrecisionService>().load(),
    ]);

    if (slug.isNotEmpty) {
      final code = request.organizationCode;
      await OrgStorage.saveOrganization(
        slug: slug,
        code: code,
        name: request.companyName,
        businessType: request.businessType,
        allowedEmailDomain: request.email.contains('@')
            ? request.email.split('@').last
            : null,
      );
      await OrgStorage.saveActiveDatabaseSlug(slug);
      await OrgRegistryStorage.addOrUpdate(
        SavedOrganization(
          slug: slug,
          code: code,
          name: request.companyName,
          businessType: request.businessType,
        ),
      );
      await OrgTestDataVisibilityStorage.setShow(true, orgSlug: slug);
    }

  }

  /// Creates and seeds a database for [request.organizationSlug] without
  /// changing the saved active organization identity in [OrgStorage].
  Future<void> provisionIsolatedOrganizationDatabase(
    SetupCompleteRequest request, {
    bool loadTestData = false,
    String? databaseSlug,
  }) async {
    OrganizationFieldLimits.assertNameLength(
      request.organizationName,
      fieldLabel: 'Organization name',
    );
    OrganizationFieldLimits.assertNameLength(
      request.companyName,
      fieldLabel: 'Company name',
    );
    SetupFieldLimits.assertFullNameLength(request.fullName);
    SetupFieldLimits.assertEmailLength(request.email);
    SetupFieldLimits.assertBankNameLength(request.bankName);
    final slug = databaseSlug?.trim() ?? request.organizationSlug;
    if (slug.isEmpty) return;

    TestDataSeedLog.step(
      'provisionIsolatedOrganizationDatabase slug=$slug code=${request.organizationCode}',
    );
    await _db.runForOrganizationSlug(slug, () async {
      TestDataSeedLog.step('createFresh db for $slug…');
      await LocalBooksDatabaseCreator.createFresh(orgSlug: slug);
      TestDataSeedLog.step('bootstrap $slug…');
      await LocalBooksBootstrap(_db).seed(
        request,
        enableTestDataTools: loadTestData,
      );
      if (loadTestData) {
        TestDataSeedLog.step('seed demo data into $slug…');
        final seed = request.organizationCode.trim().toUpperCase().hashCode;
        await LocalTestDataSeeder(_db, seed: seed).seed(
          request,
          registerExtraOrganizations: false,
        );
      }
      TestDataSeedLog.step('finished isolated provision for $slug');
    });
  }
}

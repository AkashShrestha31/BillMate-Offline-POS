import 'dart:io';

import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/currency/app_currency_service.dart';
import 'package:hotel/src/core/services/display_precision/app_display_precision_service.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/org/org_registry_storage.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/core/services/org/saved_organization.dart';
import 'package:hotel/src/core/services/token_storage.dart';
import 'package:hotel/src/features/login/data/datasources/login_remote_data_source.dart';
import 'package:hotel/src/features/login/data/models/login_request_params.dart';
import 'package:hotel/src/features/org/domain/organization_business_type.dart';
import 'package:hotel/src/features/org/domain/organization_database_service.dart';
import 'package:hotel/src/features/org/domain/org_switch_coordinator.dart';
import 'package:hotel/src/features/setup/data/models/setup_complete_request.dart';
import 'package:hotel/src/features/setup/domain/local_setup_service.dart';
import 'package:hotel/src/features/setup/domain/local_setup_storage.dart';
import 'package:hotel/src/features/setup/domain/local_test_data_seeder.dart';
import 'package:hotel/src/features/setup/domain/setup_region_options.dart';
import 'package:hotel/src/features/setup/domain/test_data_organization_seeder.dart';
import 'package:hotel/src/features/setup/domain/test_data_seed_log.dart';
import 'package:hotel/src/features/setup/domain/test_data_storage.dart';
import 'package:hotel/src/core/helpers/session_helper.dart';
import 'package:sqflite/sqflite.dart';

import 'package:hotel/src/core/config/app_platform_config.dart';

/// Demo credentials used when provisioning a fresh offline install via test data.
abstract final class TestDataLoginDefaults {
  static String get organizationName => '${AppPlatformConfig.appName} Demo Hotel';

  static String get companyName => organizationName;
  static const fullName = 'Demo Admin';
  static const email = 'demo@local.dev';
  static const password = 'demo1234';
  static const organizationCode = 'DEMO01';
  static const businessType = OrganizationBusinessType.hotel;
}

/// Provisions demo books (if needed), seeds test data, selects org, and signs in.
class TestDataLoginService {
  TestDataLoginService({
    LocalSetupService? setupService,
    LocalDb? db,
    AppCurrencyService? currencyService,
  })  : _setupService = setupService ?? getIt<LocalSetupService>(),
        _db = db ?? getIt<LocalDb>(),
        _currencyService = currencyService ?? getIt<AppCurrencyService>();

  final LocalSetupService _setupService;
  final LocalDb _db;
  final AppCurrencyService _currencyService;

  /// Returns the email used for the offline session.
  ///
  /// Opens a separate demo organization. An organization the user already
  /// created stays in the registry and its database is left as-is.
  Future<String> loginWithTestData() async {
    await _migrateLegacyBizTrackDemoBranding();

    final userOrganizations = await _userOrganizations();
    final needsSetup = await LocalSetupService.needsSetup();
    late final String loginEmail;

    if (userOrganizations.isEmpty && needsSetup) {
      loginEmail = TestDataLoginDefaults.email;
      final loginPassword = TestDataLoginDefaults.password;

      final now = DateTime.now();
      final fiscalStart = DateTime(now.year, 4, 1);
      final fiscalEnd = DateTime(now.year + 1, 3, 31);

      await _setupService.completeSetup(
        SetupCompleteRequest(
          organizationCode: TestDataLoginDefaults.organizationCode,
          organizationName: TestDataLoginDefaults.organizationName,
          companyName: TestDataLoginDefaults.companyName,
          businessType: TestDataLoginDefaults.businessType,
          fullName: TestDataLoginDefaults.fullName,
          email: loginEmail,
          password: loginPassword,
          country: SetupRegionOptions.defaultCountryName,
          currency: SetupRegionOptions.defaultCurrencyCode,
          bankName: 'Demo Bank',
          chartOfAccounts: SetupCompleteRequest.chartOfAccountsOptions.first,
          fiscalYearStart: _formatDate(fiscalStart),
          fiscalYearEnd: _formatDate(fiscalEnd),
        ),
        loadTestData: true,
      );
      await TestDataStorage.setProvisionedViaOrgTestLogin(true);
    } else {
      final demo = await _openOrCreateDemoOrganization();
      await OrganizationDatabaseService.switchTo(demo);
      await _restoreUserOrganizations(userOrganizations);
      loginEmail =
          await readAdminEmailFromActiveDatabase() ?? TestDataLoginDefaults.email;
    }

    await TokenStorage.saveUserLoginEmail(loginEmail);
    await LocalTestDataSeeder(_db).alignDemoActivityToToday();
    await Future.wait([
      _currencyService.load(),
      getIt<AppDisplayPrecisionService>().load(),
    ]);
    return loginEmail;
  }

  /// Opens or creates the SQLite file for the active organization when missing.
  Future<void> ensureActiveOrganizationDatabase() async {
    await OrganizationDatabaseService.ensureMigrated();
    await OrganizationDatabaseService.reconcileOrgStorageWithDatabase();

    final slug = await OrganizationDatabaseService.resolveActiveDatabaseSlug();
    if (slug == null || slug.isEmpty) {
      throw StateError('No organization selected.');
    }

    if (await LocalDb.databaseExistsForOrg(slug)) {
      await OrganizationDatabaseService.syncActiveDatabaseSlugWithCurrentOrg();
      return;
    }

    final org = await _findSavedOrganization(slug);
    final orgCode = org?.code ?? (await OrgStorage.getOrgCode());

    if (await isTestDataOrganization(orgCode)) {
      await ensureDemoOrganizationDatabase(
        org ??
            SavedOrganization(
              slug: slug,
              code: orgCode ?? '',
              name: (await OrgStorage.getOrgName()) ?? slug,
            ),
      );
      await OrgStorage.saveActiveDatabaseSlug(slug);
      await _db.resetConnection();
      return;
    }

    throw StateError(
      'Local database is not initialized for organization $slug.',
    );
  }

  Future<SavedOrganization?> _findSavedOrganization(String slug) async {
    for (final org in await OrgRegistryStorage.getAll()) {
      if (org.slug.trim() == slug) return org;
    }
    final code = (await OrgStorage.getOrgCode())?.trim().toUpperCase();
    if (code != null && code.isNotEmpty) {
      for (final org in await OrgRegistryStorage.getAll()) {
        if (org.code.toUpperCase() == code) return org;
      }
    }
    return null;
  }

  /// Seeds demo data into the active organization only — never creates extra orgs.
  Future<void> seedForActiveOrganization() async {
    final orgSlug = await OrgStorage.getOrgSlug();
    final activeSlug = await OrgStorage.getActiveDatabaseSlug();
    TestDataSeedLog.step(
      'start seedForActiveOrganization orgSlug=$orgSlug activeSlug=$activeSlug',
    );

    TestDataSeedLog.step('ensureActiveOrganizationDatabase…');
    await ensureActiveOrganizationDatabase();
    TestDataSeedLog.step('syncActiveDatabaseSlugWithCurrentOrg…');
    await OrganizationDatabaseService.syncActiveDatabaseSlugWithCurrentOrg();
    final dbPath = await LocalDb.databasePath();
    TestDataSeedLog.step('active database file: $dbPath');

    final orgCode = await OrgStorage.getOrgCode();
    TestDataSeedLog.step('orgCode=$orgCode seed current organization only');

    final seed = orgCode?.trim().toUpperCase().hashCode ?? 42;
    final seeder = LocalTestDataSeeder(_db, seed: seed);
    TestDataSeedLog.step('remove leftover extra demo organizations…');
    await seeder.removeLeftoverExtraDemoOrganizations();
    TestDataSeedLog.step('seedFromExistingBooks…');
    await seeder.seedFromExistingBooks();
    TestDataSeedLog.step('finalize…');
    await _finalizeActiveOrganizationAfterSeed();
    TestDataSeedLog.step('done seedForActiveOrganization');
  }

  Future<void> _finalizeActiveOrganizationAfterSeed() async {
    await OrganizationDatabaseService.syncActiveDatabaseSlugWithCurrentOrg();
    await _db.resetConnection();
    await Future.wait([
      _currencyService.load(),
      getIt<AppDisplayPrecisionService>().load(),
    ]);
    OrgSwitchCoordinator.notifier.value++;
  }

  Future<void> ensureDemoOrganizationDatabase(SavedOrganization org) async {
    await OrganizationDatabaseService.ensureMigrated();
    final slug = org.slug.trim();
    if (slug.isEmpty) return;

    final dedicatedDemoFile = isDemoOrganizationSlug(slug);
    if (await LocalDb.databaseExistsForOrg(slug)) {
      // A file that is not the dedicated demo sandbox is never replaced.
      // That keeps a real organization's books when this org is opened.
      if (!dedicatedDemoFile ||
          await LocalTestDataSeeder.hasDemoContentForSlug(slug)) {
        return;
      }
      await OrganizationDatabaseService.deleteDatabaseForSlug(slug);
    }

    // Provision a fresh DB for this demo org with a unique seed so content differs per org.
    const email = TestDataLoginDefaults.email;
    const password = TestDataLoginDefaults.password;

    final now = DateTime.now();
    final fiscalStart = DateTime(now.year, 4, 1);
    final fiscalEnd = DateTime(now.year + 1, 3, 31);

    await _setupService.provisionIsolatedOrganizationDatabase(
      SetupCompleteRequest(
        organizationCode: org.code,
        organizationName: org.name.isNotEmpty ? org.name : org.slug,
        companyName: org.name.isNotEmpty ? org.name : org.slug,
        businessType:
            org.businessType ?? TestDataLoginDefaults.businessType,
        fullName: TestDataLoginDefaults.fullName,
        email: email,
        password: password,
        country: SetupRegionOptions.defaultCountryName,
        currency: SetupRegionOptions.defaultCurrencyCode,
        bankName: 'Demo Bank',
        chartOfAccounts: SetupCompleteRequest.chartOfAccountsOptions.first,
        fiscalYearStart: _formatDate(fiscalStart),
        fiscalYearEnd: _formatDate(fiscalEnd),
      ),
      loadTestData: true,
      databaseSlug: org.slug,
    );
  }

  /// Organizations the user created. Demo books are not included.
  Future<List<SavedOrganization>> _userOrganizations() async {
    final demoInstall = await isOrgTestLoginInstall();
    final kept = <SavedOrganization>[];
    for (final org in await OrgRegistryStorage.getAll()) {
      if (isDemoOrganizationSlug(org.slug)) continue;
      if (demoInstall &&
          org.code.trim().toUpperCase() ==
              TestDataLoginDefaults.organizationCode) {
        continue;
      }
      if (await isDemoOrganization(orgCode: org.code, orgSlug: org.slug)) {
        continue;
      }
      kept.add(org);
    }
    return kept;
  }

  /// Puts user organizations back if demo provisioning dropped them.
  Future<void> _restoreUserOrganizations(
    List<SavedOrganization> userOrganizations,
  ) async {
    if (userOrganizations.isEmpty) return;
    final current = await OrgRegistryStorage.getAll();
    for (final org in userOrganizations) {
      final stillThere = current.any(
        (saved) =>
            saved.slug == org.slug ||
            saved.code.trim().toUpperCase() == org.code.trim().toUpperCase(),
      );
      if (!stillThere) {
        await OrgRegistryStorage.addOrUpdate(org);
      }
    }
  }

  Future<SavedOrganization?> _findExistingDemoLoginOrganization() async {
    final all = await OrgRegistryStorage.getAll();
    for (final org in all) {
      if (isDemoOrganizationSlug(org.slug)) return org;
    }
    if (await isOrgTestLoginInstall()) {
      for (final org in all) {
        if (org.code.trim().toUpperCase() ==
            TestDataLoginDefaults.organizationCode) {
          return org;
        }
      }
    }
    return null;
  }

  /// Demo books live in their own database (`demo_DEMO01`).
  Future<SavedOrganization> _openOrCreateDemoOrganization() async {
    final existing = await _findExistingDemoLoginOrganization();
    if (existing != null) {
      await ensureDemoOrganizationDatabase(existing);
      return existing;
    }

    final demo = SavedOrganization(
      slug: TestDataOrganizationSeeder.slugForDemoOrganization(
        TestDataLoginDefaults.organizationCode,
      ),
      code: TestDataLoginDefaults.organizationCode,
      name: TestDataLoginDefaults.organizationName,
      businessType: TestDataLoginDefaults.businessType,
    );
    await ensureDemoOrganizationDatabase(demo);
    await OrgRegistryStorage.addOrUpdate(demo);
    return demo;
  }

  /// True when the device was provisioned only via org-code **Login with test data**.
  static Future<bool> isOrgTestLoginInstall() async {
    if (await TestDataStorage.isProvisionedViaOrgTestLogin()) return true;

    final code = (await OrgStorage.getOrgCode())?.trim().toUpperCase();
    if (code != TestDataLoginDefaults.organizationCode) return false;

    final email =
        (await LocalSetupStorage.getSavedAdminEmail())?.trim().toLowerCase();
    return email == TestDataLoginDefaults.email;
  }

  /// True when [orgCode] is a demo / test-data organization on this device.
  static Future<bool> isTestDataOrganization(String? orgCode) async {
    if (orgCode == null || orgCode.trim().isEmpty) return false;

    if (await TestDataOrganizationSeeder.isDemoGeneratedOrganizationCode(orgCode)) {
      return true;
    }

    if (orgCode.trim().toUpperCase() == TestDataLoginDefaults.organizationCode) {
      return isOrgTestLoginInstall();
    }

    return false;
  }

  /// Demo org databases created by the test-data seeder use slug `demo_<CODE>`.
  static bool isDemoOrganizationSlug(String? slug) {
    final normalized = slug?.trim();
    return normalized != null &&
        normalized.isNotEmpty &&
        normalized.startsWith('demo_');
  }

  /// True when the active workspace is a demo / test-data organization.
  static Future<bool> isActiveOrganizationDemo() async {
    if (isDemoOrganizationSlug(await OrgStorage.getOrgSlug())) return true;
    return isTestDataOrganization(await OrgStorage.getOrgCode());
  }

  /// True when [orgCode] or [orgSlug] identifies a demo organization.
  static Future<bool> isDemoOrganization({
    String? orgCode,
    String? orgSlug,
  }) async {
    if (isDemoOrganizationSlug(orgSlug)) return true;
    return isTestDataOrganization(orgCode);
  }

  /// Fixed admin credentials shown on the login screen for demo organizations.
  static ({String email, String password}) get defaultDemoCredentials => (
        email: TestDataLoginDefaults.email,
        password: TestDataLoginDefaults.password,
      );

  /// Reads the admin email stored in the active organization database.
  static Future<String?> readAdminEmailFromActiveDatabase([LocalDb? db]) async {
    final localDb = db ?? getIt<LocalDb>();
    try {
      return localDb.run((database) async {
        final settings = await database.query(
          'SingleValue',
          where: 'parent = ? AND fieldname = ?',
          whereArgs: ['AccountingSettings', 'email'],
          limit: 1,
        );
        final value = settings.isNotEmpty
            ? settings.first['value']?.toString().trim().toLowerCase()
            : null;
        return value != null && value.isNotEmpty ? value : null;
      });
    } catch (_) {
      return null;
    }
  }

  /// Credentials that authenticate against the currently active workspace.
  static Future<({String email, String password})>
      resolveCredentialsForActiveOrganization() async {
    if (await isActiveOrganizationDemo()) {
      final email =
          await readAdminEmailFromActiveDatabase() ?? TestDataLoginDefaults.email;
      if (email == TestDataLoginDefaults.email) {
        return defaultDemoCredentials;
      }

      // Legacy demo databases were provisioned with the primary user's email.
      final password =
          await LocalSetupStorage.getSavedAdminPassword() ??
              TestDataLoginDefaults.password;
      return (email: email, password: password);
    }

    return resolveLoginCredentials();
  }

  /// @deprecated Use [isTestDataOrganization].
  static Future<bool> shouldAutofillLoginForOrganization(String? orgCode) =>
      isTestDataOrganization(orgCode);

  /// Activates a saved demo org and signs in without opening the login screen.
  Future<String> signInToSavedOrganization(SavedOrganization org) async {
    if (!await isDemoOrganization(orgCode: org.code, orgSlug: org.slug)) {
      throw StateError('Organization is not a test-data org');
    }

    if (await LocalSetupService.needsSetup()) {
      return loginWithTestData();
    }

    await ensureDemoOrganizationDatabase(org);

    await OrgRegistryStorage.addOrUpdate(org);
    await OrganizationDatabaseService.switchTo(org);

    final creds = await resolveCredentialsForActiveOrganization();
    await getIt<LoginRemoteDataSource>().postLoginToken(
      LoginRequestParams(email: creds.email, password: creds.password),
    );

    await TokenStorage.saveUserLoginEmail(creds.email);
    await LocalTestDataSeeder(_db).alignDemoActivityToToday();
    await Future.wait([
      _currencyService.load(),
      getIt<AppDisplayPrecisionService>().load(),
    ]);
    return creds.email;
  }

  /// Admin credentials for a test-data organization on this device.
  static Future<({String email, String password})> resolveLoginCredentials() async {
    final email =
        (await LocalSetupStorage.getSavedAdminEmail())?.trim().toLowerCase() ??
            TestDataLoginDefaults.email;
    final password =
        await LocalSetupStorage.getSavedAdminPassword() ??
            TestDataLoginDefaults.password;
    return (email: email, password: password);
  }

  /// Wipes the demo install created from the org code page (DB + prefs + session).
  static Future<void> resetOrgTestLoginInstall({
    LocalDb? db,
  }) async {
    final localDb = db ?? getIt<LocalDb>();
    await localDb.resetConnection();

    final path = await LocalDb.databasePath();
    if (await File(path).exists()) {
      await deleteDatabase(path);
    }
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
    await OrgStorage.clear();
    await OrgRegistryStorage.clearAll();
    await TestDataStorage.clearAll();
    await SessionHelper.clearSessionData();
  }

  Future<void> _migrateLegacyBizTrackDemoBranding() async {
    String rename(String value) =>
        value.replaceAll('BizTrack', AppPlatformConfig.appName);

    final registry = await OrgRegistryStorage.getAll();
    for (final org in registry) {
      if (!org.name.contains('BizTrack')) continue;
      if (!await isTestDataOrganization(org.code)) continue;
      await OrgRegistryStorage.addOrUpdate(
        SavedOrganization(
          slug: org.slug,
          code: org.code,
          name: rename(org.name),
          businessType: org.businessType,
        ),
      );
    }

    final slug = await OrgStorage.getOrgSlug();
    final code = await OrgStorage.getOrgCode();
    final name = await OrgStorage.getOrgName();
    if (slug != null &&
        code != null &&
        name != null &&
        name.contains('BizTrack') &&
        await isTestDataOrganization(code)) {
      await OrgStorage.saveOrganization(
        slug: slug,
        code: code,
        name: rename(name),
        businessType: await OrgStorage.getBusinessType(),
      );
    }

    try {
      await OrganizationDatabaseService.ensureMigrated();
      final database = await _db.database;
      for (final field in ['organizationName', 'companyName']) {
        final rows = await database.query(
          'SingleValue',
          where: 'fieldname = ? AND value LIKE ?',
          whereArgs: [field, '%BizTrack%'],
        );
        for (final row in rows) {
          final value = row['value']?.toString();
          final parent = row['parent']?.toString();
          if (value == null ||
              parent == null ||
              !value.contains('BizTrack')) {
            continue;
          }
          await database.update(
            'SingleValue',
            {'value': rename(value)},
            where: 'parent = ? AND fieldname = ?',
            whereArgs: [parent, field],
          );
        }
      }
    } catch (_) {
      // Best-effort migration for demo branding only.
    }
  }

  static String _formatDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';
}

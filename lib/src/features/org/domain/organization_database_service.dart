import 'dart:io';

import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/features/backup/domain/backup_org_identity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hotel/src/core/l10n/default_l10n.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/org/org_registry_storage.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/core/services/org/saved_organization.dart';
import 'package:hotel/src/features/org/domain/organization_business_type_reader.dart';
import 'package:hotel/src/features/org/domain/organization_metadata_service.dart';
import 'package:hotel/src/features/backup/domain/drive_restore_debug.dart';
import 'package:hotel/src/features/backup/domain/restore_core_bootstrap.dart';
import 'package:hotel/src/features/setup/domain/local_books_database_health.dart';
import 'package:hotel/src/features/setup/domain/test_data_login_service.dart';
import 'package:hotel/src/features/setup/domain/test_data_organization_seeder.dart';
import 'package:sqflite/sqflite.dart';

/// Maps saved organizations to on-device SQLite files and switches between them.
class OrganizationDatabaseService {
  OrganizationDatabaseService._();

  static bool _migrated = false;

  static Future<void> ensureMigrated() async {
    if (_migrated) return;
    await _migrateLegacyDatabaseIfNeeded();
    _migrated = true;
  }

  static Future<void> _migrateLegacyDatabaseIfNeeded() async {
    final legacyPath = await LocalDb.legacyDatabasePath();
    final legacy = File(legacyPath);
    if (!legacy.existsSync()) return;

    var slug = (await OrgStorage.getOrgSlug())?.trim();
    slug = slug?.isNotEmpty == true ? slug : await _readSlugFromDatabase(legacyPath);
    if (slug == null || slug.isEmpty) return;

    final targetPath = await LocalDb.databasePathForOrg(slug);
    if (File(targetPath).existsSync()) {
      await legacy.delete();
      return;
    }

    await getIt<LocalDb>().resetConnection();
    await legacy.rename(targetPath);
  }

  static Future<String?> _readSlugFromDatabase(String path) async {
    try {
      final db = await openDatabase(path, readOnly: true);
      try {
        final rows = await db.query(
          'SingleValue',
          columns: ['value'],
          where: "parent = 'Organization' AND fieldname = 'organizationSlug'",
          limit: 1,
        );
        if (rows.isEmpty) return null;
        final value = rows.first['value']?.toString().trim();
        return (value == null || value.isEmpty) ? null : value;
      } finally {
        await db.close();
      }
    } catch (_) {
      return null;
    }
  }

  /// Copies the active books database to a slug-specific file before provisioning another org.
  static Future<void> archiveActiveDatabase() async {
    await ensureMigrated();

    final slug = (await OrgStorage.getOrgSlug())?.trim();
    if (slug == null || slug.isEmpty) return;

    final targetPath = await LocalDb.databasePathForOrg(slug);
    if (File(targetPath).existsSync()) return;

    final currentPath = await LocalDb.databasePath();
    if (!File(currentPath).existsSync() || currentPath == targetPath) return;

    await getIt<LocalDb>().resetConnection();
    await File(currentPath).rename(targetPath);
  }

  static Future<String> resolveDatabaseSlug(SavedOrganization org) async {
    // Each organization (including demo orgs) has its own SQLite file so that
    // switching changes the actual content, not just labels.
    return org.slug;
  }

  static Future<bool> hasDatabaseForOrganization(SavedOrganization org) async {
    await ensureMigrated();
    final dbSlug = await resolveDatabaseSlug(org);
    if (await LocalDb.databaseExistsForOrg(dbSlug)) return true;

    final legacy = File(await LocalDb.legacyDatabasePath());
    if (!legacy.existsSync()) return false;

    final legacySlug = await _readSlugFromDatabase(legacy.path);
    return legacySlug != null &&
        legacySlug.isNotEmpty &&
        legacySlug == dbSlug;
  }

  /// True when the org has a complete local database (core tables + employee data).
  static Future<bool> isOrganizationUsable(SavedOrganization org) async {
    if (await TestDataLoginService.isTestDataOrganization(org.code)) {
      return true;
    }

    final path = await _resolveDatabasePathForOrganization(org);
    if (path == null) return false;

    final local = getIt<LocalDb>();
    if (local.isOpenAtPath(path)) {
      try {
        return await local.run(LocalBooksDatabaseHealth.isHealthyDatabase);
      } catch (_) {}
    }
    return LocalBooksDatabaseHealth.isHealthyAtPath(path);
  }

  /// Slug of the SQLite file that should back the current session.
  ///
  /// Checks [OrgStorage], the org registry, and legacy DB paths so a restored
  /// database is found even when stored slugs drift apart after cold start.
  static Future<String?> resolveActiveDatabaseSlug() async {
    await ensureMigrated();

    final candidates = <String>[];
    void addCandidate(String? value) {
      final trimmed = value?.trim();
      if (trimmed == null || trimmed.isEmpty) return;
      if (!candidates.contains(trimmed)) candidates.add(trimmed);
    }

    addCandidate(await OrgStorage.getOrgSlug());
    addCandidate(await OrgStorage.getActiveDatabaseSlug());

    final code = (await OrgStorage.getOrgCode())?.trim().toUpperCase();
    if (code != null && code.isNotEmpty) {
      for (final org in await OrgRegistryStorage.getAll()) {
        if (org.code.toUpperCase() == code) addCandidate(org.slug);
      }
    }

    for (final slug in candidates) {
      if (await LocalDb.databaseExistsForOrg(slug)) return slug;
    }

    final legacy = File(await LocalDb.legacyDatabasePath());
    if (legacy.existsSync()) {
      final legacySlug = await _readSlugFromDatabase(legacy.path);
      if (legacySlug != null && legacySlug.isNotEmpty) return legacySlug;
    }

    return null;
  }

  /// Aligns [OrgStorage] with the on-device SQLite file for the signed-in org.
  static Future<bool> reconcileOrgStorageWithDatabase() async {
    await ensureMigrated();
    final initialSlug = await resolveActiveDatabaseSlug();
    if (initialSlug == null ||
        !await LocalDb.databaseExistsForOrg(initialSlug)) {
      return false;
    }
    var dbSlug = initialSlug;

    SavedOrganization? registryOrg;
    for (final org in await OrgRegistryStorage.getAll()) {
      if (org.slug == dbSlug) {
        registryOrg = org;
        break;
      }
    }
    if (registryOrg == null) {
      final code = (await OrgStorage.getOrgCode())?.trim().toUpperCase();
      if (code != null && code.isNotEmpty) {
        for (final org in await OrgRegistryStorage.getAll()) {
          if (org.code.toUpperCase() == code) {
            registryOrg = org;
            dbSlug = org.slug;
            break;
          }
        }
      }
    }

    final orgSlug = (await OrgStorage.getOrgSlug())?.trim();
    final needsOrgUpdate =
        orgSlug == null || orgSlug.isEmpty || orgSlug != dbSlug;

    if (registryOrg != null && needsOrgUpdate) {
      await OrgStorage.saveOrganization(
        slug: registryOrg.slug,
        code: registryOrg.code,
        name: registryOrg.name,
        businessType: registryOrg.businessType,
      );
      dbSlug = registryOrg.slug;
    } else if (needsOrgUpdate) {
      await OrgStorage.saveOrganization(
        slug: dbSlug,
        code: (await OrgStorage.getOrgCode()) ?? dbSlug,
        name: await OrgStorage.getOrgName(),
        businessType: await OrgStorage.getBusinessType(),
      );
    }

    final activeSlug = (await OrgStorage.getActiveDatabaseSlug())?.trim();
    if (activeSlug != dbSlug) {
      await OrgStorage.saveActiveDatabaseSlug(dbSlug);
      await getIt<LocalDb>().resetConnection();
    }

    return true;
  }

  static Future<bool> isActiveOrganizationUsable() async {
    await ensureMigrated();
    final slug = await resolveActiveDatabaseSlug();
    if (slug == null) return false;

    final path = await LocalDb.databasePathForOrg(slug);
    if (File(path).existsSync()) {
      return LocalBooksDatabaseHealth.isHealthyAtPath(path);
    }

    final legacy = File(await LocalDb.legacyDatabasePath());
    if (legacy.existsSync()) {
      return LocalBooksDatabaseHealth.isHealthyAtPath(legacy.path);
    }
    return false;
  }

  /// Attempts to seed missing core rows when the on-device DB fails health checks.
  static Future<bool> tryRepairActiveDatabaseHealth() async {
    await ensureMigrated();
    final slug = await resolveActiveDatabaseSlug();
    if (slug == null) return false;

    final path = await LocalDb.databasePathForOrg(slug);
    if (await LocalBooksDatabaseHealth.isHealthyAtPath(path)) return true;

    try {
      return await getIt<LocalDb>().runForOrganizationSlug(slug, () async {
        final db = await getIt<LocalDb>().database;
        return RestoreCoreBootstrap.repairIfUnhealthy(
          db: db,
          canonicalSlug: slug,
        );
      });
    } catch (e) {
      DriveRestoreDebug.log('startup repair failed slug=$slug error=$e');
      return false;
    }
  }

  static Future<List<SavedOrganization>> filterListableOrganizations(
    List<SavedOrganization> organizations,
  ) async {
    final listable = <SavedOrganization>[];
    for (final org in organizations) {
      if (await isOrganizationUsable(org)) {
        listable.add(org);
      }
    }
    return listable;
  }

  /// Reads on-device books files and adds any organization missing from the registry.
  ///
  /// The More page can show a name from the open database while the saved
  /// registry is empty, which left the organization list blank.
  static Future<void> _registerOrganizationsFromDeviceDatabases() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final dir = Directory(docsDir.path);
    if (!dir.existsSync()) return;

    final paths = <String>[];
    await for (final entity in dir.list()) {
      if (entity is! File) continue;
      final name = entity.path.split(Platform.pathSeparator).last;
      final isOrgFile = name.startsWith('hotel_org_') && name.endsWith('.db');
      final isLegacy = name == LocalDb.legacyDbFileName;
      if (isOrgFile || isLegacy) paths.add(entity.path);
    }

    for (final path in paths) {
      final fileName = path.split(Platform.pathSeparator).last;
      final fallbackSlug = fileName == LocalDb.legacyDbFileName
          ? ((await _readSlugFromDatabase(path)) ?? '')
          : fileName
              .substring('hotel_org_'.length, fileName.length - '.db'.length);
      if (fallbackSlug.isEmpty) continue;

      final org = await _savedOrganizationFromDatabaseFile(
        path,
        fallbackSlug: fallbackSlug,
      );
      if (org == null || !org.isValid) continue;
      await OrgRegistryStorage.addOrUpdate(org);
    }
  }

  static Future<SavedOrganization?> _savedOrganizationFromDatabaseFile(
    String path, {
    required String fallbackSlug,
  }) async {
    Future<SavedOrganization?> fromDb(Database db) async {
      final identity = await BackupOrgIdentityReader.readFromDatabase(
        db,
        fallbackSlug: fallbackSlug,
      );
      final storedSlug = identity.slug.trim();
      final slug = storedSlug.isNotEmpty &&
              await LocalDb.databaseExistsForOrg(storedSlug)
          ? storedSlug
          : fallbackSlug;
      final code = identity.code.trim().isNotEmpty
          ? identity.code.trim().toUpperCase()
          : slug;
      if (slug.isEmpty) return null;
      return SavedOrganization(
        slug: slug,
        code: code,
        name: identity.name.trim().isNotEmpty ? identity.name.trim() : slug,
        businessType: identity.businessType,
      );
    }

    final local = getIt<LocalDb>();
    if (local.isOpenAtPath(path)) {
      try {
        return await local.run(fromDb);
      } catch (_) {
        return null;
      }
    }

    Database? db;
    try {
      db = await openDatabase(path, readOnly: true);
      return await fromDb(db);
    } catch (_) {
      return null;
    } finally {
      await db?.close();
    }
  }

  /// Organizations shown on the connect screen, including freshly restored DBs
  /// that may not yet pass every health probe.
  static Future<List<SavedOrganization>> listOrganizationsForConnectPage() async {
    await ensureMigrated();
    await OrgRegistryStorage.registerFromCurrentOrgStorage();
    await _registerOrganizationsFromDeviceDatabases();
    final registered = await OrgRegistryStorage.getAll();

    final usable = await filterListableOrganizations(registered);
    final listed = <String, SavedOrganization>{};
    void add(SavedOrganization org) {
      listed['${org.slug}|${org.code.toUpperCase()}'] = org;
    }

    for (final org in usable) {
      add(org);
    }

    for (final org in registered) {
      if (!org.isValid) continue;
      final alreadyListed = listed.values.any(
        (saved) =>
            saved.slug == org.slug ||
            saved.code.toUpperCase() == org.code.toUpperCase(),
      );
      if (alreadyListed) continue;
      if (await hasDatabaseForOrganization(org)) add(org);
    }

    DriveRestoreDebug.log(
      'connect page: ${listed.length} org(s) from ${registered.length} registered '
      '(${usable.length} passed health)',
    );
    return listed.values.toList();
  }

  static Future<String?> _resolveDatabasePathForOrganization(
    SavedOrganization org,
  ) async {
    await ensureMigrated();
    final dbSlug = await resolveDatabaseSlug(org);
    if (await LocalDb.databaseExistsForOrg(dbSlug)) {
      return LocalDb.databasePathForOrg(dbSlug);
    }

    final legacy = File(await LocalDb.legacyDatabasePath());
    if (!legacy.existsSync()) return null;

    final legacySlug = await _readSlugFromDatabase(legacy.path);
    if (legacySlug == null ||
        legacySlug.isEmpty ||
        legacySlug != dbSlug) {
      return null;
    }
    return legacy.path;
  }

  /// Keeps [OrgStorage.activeDatabaseSlug] aligned with the signed-in organization.
  static Future<void> syncActiveDatabaseSlugWithCurrentOrg() async {
    await ensureMigrated();
    final dbSlug = await resolveActiveDatabaseSlug();
    if (dbSlug == null) return;

    final activeSlug = (await OrgStorage.getActiveDatabaseSlug())?.trim();
    if (activeSlug == dbSlug) return;

    await OrgStorage.saveActiveDatabaseSlug(dbSlug);
    await getIt<LocalDb>().resetConnection();
  }

  static Future<void> switchTo(SavedOrganization org) async {
    await ensureMigrated();

    if (await TestDataLoginService.isTestDataOrganization(org.code)) {
      await TestDataLoginService().ensureDemoOrganizationDatabase(org);
    }

    final dbSlug = await resolveDatabaseSlug(org);
    if (!await LocalDb.databaseExistsForOrg(dbSlug)) {
      final legacy = File(await LocalDb.legacyDatabasePath());
      if (!legacy.existsSync()) {
        final name = org.name.isNotEmpty ? org.name : org.slug;
        throw StateError(defaultL10n.noLocalDataCompleteSetup(name));
      }
      final legacySlug = await _readSlugFromDatabase(legacy.path);
      if (legacySlug != dbSlug) {
        final name = org.name.isNotEmpty ? org.name : org.slug;
        throw StateError(defaultL10n.noLocalDataCompleteSetup(name));
      }
    }

    await TestDataOrganizationSeeder.activateOrganization(org);
    await OrgStorage.saveActiveDatabaseSlug(dbSlug);
    // Ensure OrgStorage identity is updated even when switching is bypassing
    // the login flow (e.g. demo/test org direct sign-in).
    await OrgStorage.saveOrganization(
      slug: org.slug,
      code: org.code,
      name: org.name,
      businessType: org.businessType,
      allowedEmailDomain: null,
    );
    await getIt<LocalDb>().resetConnection();
    await OrganizationBusinessTypeReader.syncToOrgStorage(getIt<LocalDb>());

    if (await TestDataLoginService.isTestDataOrganization(org.code)) {
      await OrganizationMetadataService.applyActiveOrganization(org);
    }
  }

  static Future<void> deleteDatabaseForSlug(String slug) async {
    await getIt<LocalDb>().resetConnection();
    final path = await LocalDb.databasePathForOrg(slug);
    if (await File(path).exists()) {
      await deleteDatabase(path);
    }
  }

  /// Deletes every on-device books file that belongs to [org].
  ///
  /// The connect list rediscovers organizations from these files, so removing
  /// only the registry entry leaves the organization in the list.
  static Future<void> deleteStoredDatabase(SavedOrganization org) async {
    final slug = org.slug.trim();
    final code = org.code.trim().toUpperCase();
    final paths = await _databasePathsForOrganization(slug: slug, code: code);
    final local = getIt<LocalDb>();
    for (final path in paths) {
      if (local.isOpenAtPath(path)) {
        await local.resetConnection();
        break;
      }
    }
    for (final path in paths) {
      await _deleteDatabaseFile(path);
    }
  }

  static Future<Set<String>> _databasePathsForOrganization({
    required String slug,
    required String code,
  }) async {
    final paths = <String>{};
    if (slug.isNotEmpty) {
      paths.add(await LocalDb.databasePathForOrg(slug));
    }

    final docsDir = await getApplicationDocumentsDirectory();
    final dir = Directory(docsDir.path);
    if (!dir.existsSync()) return paths;

    await for (final entity in dir.list()) {
      if (entity is! File) continue;
      final name = entity.path.split(Platform.pathSeparator).last;
      final isOrgFile = name.startsWith('hotel_org_') && name.endsWith('.db');
      final isLegacy = name == LocalDb.legacyDbFileName;
      if (!isOrgFile && !isLegacy) continue;
      if (slug.isNotEmpty && name == LocalDb.dbFileNameForOrg(slug)) {
        paths.add(entity.path);
        continue;
      }
      final identity = await _readOrganizationIdentity(entity.path);
      if (identity == null) continue;
      final sameCode = code.isNotEmpty && identity.code == code;
      final sameSlug = slug.isNotEmpty && identity.slug == slug;
      if (sameCode || sameSlug) paths.add(entity.path);
    }
    return paths;
  }

  static Future<({String slug, String code})?> _readOrganizationIdentity(
    String path,
  ) async {
    Future<({String slug, String code})?> read(Database db) async {
      final rows = await db.query(
        'SingleValue',
        where:
            "parent = 'Organization' AND fieldname IN ('organizationCode', 'organizationSlug')",
      );
      var fileSlug = '';
      var fileCode = '';
      for (final row in rows) {
        final field = row['fieldname']?.toString();
        final value = row['value']?.toString().trim() ?? '';
        if (field == 'organizationSlug') fileSlug = value;
        if (field == 'organizationCode') fileCode = value.toUpperCase();
      }
      if (fileSlug.isEmpty && fileCode.isEmpty) return null;
      return (slug: fileSlug, code: fileCode);
    }

    final local = getIt<LocalDb>();
    if (local.isOpenAtPath(path)) {
      try {
        return await local.run(read);
      } catch (_) {
        return null;
      }
    }

    Database? db;
    try {
      db = await openDatabase(path, readOnly: true);
      return await read(db);
    } catch (_) {
      return null;
    } finally {
      await db?.close();
    }
  }

  static Future<void> _deleteDatabaseFile(String path) async {
    final file = File(path);
    if (await file.exists()) {
      try {
        await deleteDatabase(path);
      } catch (_) {
        try {
          await file.delete();
        } catch (_) {}
      }
    }
    for (final suffix in ['-wal', '-shm']) {
      final side = File('$path$suffix');
      if (!await side.exists()) continue;
      try {
        await side.delete();
      } catch (_) {}
    }
  }
}

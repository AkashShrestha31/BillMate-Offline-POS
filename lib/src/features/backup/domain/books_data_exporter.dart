import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:hotel/src/core/constants/app_constants.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/org/org_registry_storage.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/core/services/org/saved_organization.dart';
import 'package:hotel/src/features/backup/domain/backup_excluded_tables.dart';
import 'package:hotel/src/features/backup/domain/backup_org_identity.dart';
import 'package:hotel/src/features/backup/domain/drive_backup_state_storage.dart';
import 'package:hotel/src/features/backup/domain/models/backup_manifest.dart';
import 'package:hotel/src/features/backup/domain/models/organization_backup_meta.dart';
import 'package:hotel/src/features/setup/domain/local_setup_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sqflite/sqflite.dart';

typedef BackupProgressCallback = void Function(String message, double progress);

class OrganizationBackupBundle {
  const OrganizationBackupBundle({
    required this.meta,
    required this.manifest,
    required this.tableFiles,
    required this.registry,
  });

  final OrganizationBackupMeta meta;
  final BackupManifest manifest;
  final Map<String, String> tableFiles;
  final List<SavedOrganization> registry;
}

@lazySingleton
class BooksDataExporter {
  BooksDataExporter(this._db);

  final LocalDb _db;
  static String? _cachedAppVersion;

  Future<OrganizationBackupBundle> exportActiveOrganization({
    BackupProgressCallback? onProgress,
  }) async {
    if (!await LocalDb.databaseFileExists()) {
      throw StateError('Local database is not initialized.');
    }

    final slug = await LocalDb.resolveOpenSlug();
    if (slug == null || slug.isEmpty) {
      throw StateError('No active organization found.');
    }

    final db = await _db.database;
    final dbIdentity = await BackupOrgIdentityReader.readFromDatabase(
      db,
      fallbackSlug: slug,
    );
    final code = dbIdentity.code.isNotEmpty
        ? dbIdentity.code
        : ((await OrgStorage.getOrgCode())?.trim() ?? '');
    final name = BackupOrgIdentityReader.pickDisplayName([
      dbIdentity.name,
      (await OrgStorage.getOrgName())?.trim(),
    ]);
    final resolvedName = name.isNotEmpty ? name : slug;
    final businessType =
        dbIdentity.businessType ?? await OrgStorage.getBusinessType();
    final tables = await _listExportableTables(db);
    final nonEmptyTables = await _filterNonEmptyTables(db, tables);
    final tableFiles = <String, String>{};
    final recordCounts = <String, int>{};
    final checksumSink = _DigestSink();
    final checksumInput = sha256.startChunkedConversion(checksumSink);

    final metadataFuture = Future.wait([
      _readAppVersion(),
      DriveBackupStateStorage.getOrCreateDeviceId(),
      LocalSetupStorage.getSavedAdminEmail(),
      LocalSetupStorage.getSavedAdminPassword(),
      OrgRegistryStorage.getAll(),
    ]);

    for (var i = 0; i < nonEmptyTables.length; i++) {
      final table = nonEmptyTables[i];
      onProgress?.call(table, i / nonEmptyTables.length);

      final rows = await db.query(table);
      if (rows.isEmpty) continue;

      recordCounts[table] = rows.length;
      final payload = jsonEncode({
        'table': table,
        'rows': rows.map(_serializeRow).toList(growable: false),
      });
      tableFiles[table] = payload;
      checksumInput.add(utf8.encode('$table:$payload\n'));
    }

    checksumInput.close();
    final checksum = checksumSink.value?.toString() ?? '';
    final exportedAt = DateTime.now().toUtc().toIso8601String();
    final metadata = await metadataFuture;
    final appVersion = metadata[0] as String;
    final deviceId = metadata[1] as String;
    final adminEmail = metadata[2] as String?;
    final adminPassword = metadata[3] as String?;
    final registry = metadata[4] as List<SavedOrganization>;

    final manifest = BackupManifest(
      formatVersion: BackupManifest.currentFormatVersion,
      tables: tableFiles.keys.toList(),
      recordCounts: recordCounts,
      checksum: checksum,
      exportedAt: exportedAt,
    );

    final meta = OrganizationBackupMeta(
      formatVersion: BackupManifest.currentFormatVersion,
      appVersion: appVersion,
      slug: slug,
      code: code,
      name: resolvedName,
      businessType: businessType,
      exportedAt: exportedAt,
      deviceId: deviceId,
      recordCounts: recordCounts,
      checksum: checksum,
      adminEmail: adminEmail,
      adminPassword: adminPassword,
    );

    onProgress?.call('registry', 1);

    return OrganizationBackupBundle(
      meta: meta,
      manifest: manifest,
      tableFiles: tableFiles,
      registry: registry,
    );
  }

  Future<List<String>> _filterNonEmptyTables(
    Database db,
    List<String> tables,
  ) async {
    if (tables.isEmpty) return tables;

    final nonEmpty = <String>[];
    await db.transaction((txn) async {
      for (final table in tables) {
        final result = await txn.rawQuery('SELECT COUNT(*) AS c FROM "$table"');
        final count = (result.first['c'] as num?)?.toInt() ?? 0;
        if (count > 0) nonEmpty.add(table);
      }
    });
    return nonEmpty;
  }

  Future<String> readAppVersionForBackup() => _readAppVersion();

  Future<List<String>> _listExportableTables(Database db) async {
    final rows = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type = 'table' AND name NOT LIKE 'sqlite_%' ORDER BY name",
    );
    return rows
        .map((row) => row['name']?.toString() ?? '')
        .where((name) => name.isNotEmpty && !BackupExcludedTables.shouldSkip(name))
        .toList();
  }

  Future<String> _readAppVersion() async {
    final cached = _cachedAppVersion;
    if (cached != null) return cached;

    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final version = packageInfo.version.trim();
      final build = packageInfo.buildNumber.trim();
      if (version.isNotEmpty) {
        _cachedAppVersion =
            build.isNotEmpty ? '$version+$build' : version;
        return _cachedAppVersion!;
      }
    } on MissingPluginException {
      // Hot reload / stale native build — use pubspec fallback.
    } catch (_) {}
    _cachedAppVersion = AppConstants.appVersionWithBuild;
    return _cachedAppVersion!;
  }

  Map<String, dynamic> _serializeRow(Map<String, dynamic> row) {
    return row.map((key, value) {
      if (value is List<int>) {
        return MapEntry(key, base64Encode(value));
      }
      return MapEntry(key, value);
    });
  }
}

class _DigestSink implements Sink<Digest> {
  Digest? value;

  @override
  void add(Digest data) => value = data;

  @override
  void close() {}
}

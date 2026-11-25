import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/features/backup/domain/backup_change_log_service.dart';
import 'package:hotel/src/features/backup/domain/backup_change_log_storage.dart';
import 'package:hotel/src/features/backup/domain/backup_org_identity.dart';
import 'package:hotel/src/features/backup/domain/books_data_exporter.dart';
import 'package:hotel/src/features/backup/domain/drive_backup_state_storage.dart';
import 'package:hotel/src/features/backup/domain/models/backup_manifest.dart';
import 'package:hotel/src/features/backup/domain/models/organization_backup_meta.dart';
import 'package:hotel/src/features/setup/domain/local_setup_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

class DeltaExportResult {
  const DeltaExportResult({
    required this.meta,
    required this.manifest,
    required this.tableFiles,
    required this.upsertsByTable,
    required this.deletesByTable,
    required this.maxChangeLogId,
    required this.changeCount,
    required this.orgSlug,
  });

  final OrganizationBackupMeta meta;
  final BackupManifest manifest;
  final Map<String, String> tableFiles;
  final Map<String, List<Map<String, dynamic>>> upsertsByTable;
  final Map<String, List<String>> deletesByTable;
  final int maxChangeLogId;
  final int changeCount;
  final String orgSlug;
}

@lazySingleton
class BooksDeltaExporter {
  BooksDeltaExporter(this._db, this._fullExporter);

  final LocalDb _db;
  final BooksDataExporter _fullExporter;

  static const int maxIncrementalChanges = 8000;

  static Future<int> pendingChangesForActiveOrg(LocalDb db) async {
    final slug = await LocalDb.resolveOpenSlug();
    if (slug == null || slug.isEmpty) return 0;
    final checkpoint = await BackupChangeLogStorage.getCheckpoint(slug);
    final database = await db.database;
    final count = await BackupChangeLogService.pendingUniqueRowCount(
      database,
      sinceLogId: checkpoint,
    );
    return count;
  }

  Future<DeltaExportResult?> tryExportActiveOrganizationDelta({
    BackupProgressCallback? onProgress,
  }) async {
    if (!await LocalDb.databaseFileExists()) return null;

    final slug = await LocalDb.resolveOpenSlug();
    if (slug == null || slug.isEmpty) return null;

    final db = await _db.database;
    final checkpoint = await BackupChangeLogStorage.getCheckpoint(slug);
    final pending = await BackupChangeLogService.pendingUniqueRowCount(
      db,
      sinceLogId: checkpoint,
    );
    if (pending <= 0 || pending > maxIncrementalChanges) return null;

    final changes = await BackupChangeLogService.readCollapsedDelta(
      db,
      sinceLogId: checkpoint,
    );
    if (changes.isEmpty) return null;

    final upsertsByTable = <String, List<Map<String, dynamic>>>{};
    final deletesByTable = <String, List<String>>{};

    for (final change in changes) {
      if (BackupChangeLogService.shouldSkipTable(change.tableName)) continue;
      if (change.isDelete) {
        deletesByTable.putIfAbsent(change.tableName, () => []).add(change.rowKey);
        continue;
      }
      final row = await BackupChangeLogService.fetchRow(
        db,
        change.tableName,
        change.rowKey,
      );
      if (row == null) {
        deletesByTable.putIfAbsent(change.tableName, () => []).add(change.rowKey);
        continue;
      }
      upsertsByTable.putIfAbsent(change.tableName, () => []).add(row);
    }

    final tables = <String>{
      ...upsertsByTable.keys,
      ...deletesByTable.keys,
    }.toList()
      ..sort();

    if (tables.isEmpty) return null;

    final tableFiles = <String, String>{};
    final recordCounts = <String, int>{};
    final checksumSink = _DigestSink();
    final checksumInput = sha256.startChunkedConversion(checksumSink);

    for (var i = 0; i < tables.length; i++) {
      final table = tables[i];
      onProgress?.call(table, i / tables.length);

      final upserts = upsertsByTable[table] ?? const [];
      final deletes = deletesByTable[table] ?? const [];
      if (upserts.isEmpty && deletes.isEmpty) continue;

      if (upserts.isEmpty && deletes.isNotEmpty) {
        final payload = jsonEncode({'table': table, 'rows': <dynamic>[]});
        tableFiles[table] = payload;
        checksumInput.add(utf8.encode('$table:$payload\n'));
        checksumInput.add(utf8.encode('$table:delete:${deletes.join(',')}\n'));
        recordCounts[table] = 0;
        continue;
      }

      final serializedUpserts = upserts.map(_serializeRow).toList(growable: false);
      final payload = jsonEncode({
        'table': table,
        'rows': serializedUpserts,
      });
      tableFiles[table] = payload;
      checksumInput.add(utf8.encode('$table:$payload\n'));
      recordCounts[table] = serializedUpserts.length;
      if (deletes.isNotEmpty) {
        checksumInput.add(utf8.encode('$table:delete:${deletes.join(',')}\n'));
      }
    }

    if (tableFiles.isEmpty && deletesByTable.isEmpty) return null;

    checksumInput.close();
    final maxLogId = changes.map((e) => e.logId).reduce((a, b) => a > b ? a : b);
    final exportedAt = DateTime.now().toUtc().toIso8601String();

    final manifest = BackupManifest(
      formatVersion: BackupManifest.deltaFormatVersion,
      tables: tableFiles.keys.toList(),
      recordCounts: recordCounts,
      checksum: checksumSink.value?.toString() ?? '',
      exportedAt: exportedAt,
      delta: true,
      sinceChangeLogId: checkpoint,
      maxChangeLogId: maxLogId,
      deletes: deletesByTable.map(
        (key, value) => MapEntry(key, List<String>.from(value)),
      ),
    );

    final baseMeta = await _buildMeta(db, slug: slug, exportedAt: exportedAt);

    return DeltaExportResult(
      meta: OrganizationBackupMeta(
        formatVersion: BackupManifest.deltaFormatVersion,
        appVersion: baseMeta.appVersion,
        slug: baseMeta.slug,
        code: baseMeta.code,
        name: baseMeta.name,
        businessType: baseMeta.businessType,
        exportedAt: exportedAt,
        deviceId: baseMeta.deviceId,
        recordCounts: recordCounts,
        checksum: manifest.checksum,
        adminEmail: baseMeta.adminEmail,
        adminPassword: baseMeta.adminPassword,
      ),
      manifest: manifest,
      tableFiles: tableFiles,
      upsertsByTable: upsertsByTable,
      deletesByTable: deletesByTable,
      maxChangeLogId: maxLogId,
      changeCount: pending,
      orgSlug: slug,
    );
  }

  Future<OrganizationBackupMeta> _buildMeta(
    Database db, {
    required String slug,
    required String exportedAt,
  }) async {
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

    return OrganizationBackupMeta(
      formatVersion: BackupManifest.deltaFormatVersion,
      appVersion: await _fullExporter.readAppVersionForBackup(),
      slug: slug,
      code: code,
      name: resolvedName,
      businessType: dbIdentity.businessType ?? await OrgStorage.getBusinessType(),
      exportedAt: exportedAt,
      deviceId: await DriveBackupStateStorage.getOrCreateDeviceId(),
      recordCounts: const {},
      checksum: '',
      adminEmail: await LocalSetupStorage.getSavedAdminEmail(),
      adminPassword: await LocalSetupStorage.getSavedAdminPassword(),
    );
  }

  Future<void> advanceCheckpoint(String orgSlug, int maxChangeLogId) async {
    final db = await _db.database;
    final resolvedSlug = (await LocalDb.resolveOpenSlug())?.trim();
    final slug = resolvedSlug?.isNotEmpty == true ? resolvedSlug! : orgSlug.trim();
    if (slug.isEmpty) return;

    final throughLogId = await BackupChangeLogService.maxLogId(db);
    if (throughLogId <= 0) return;

    await BackupChangeLogStorage.setCheckpoint(slug, throughLogId);
    await BackupChangeLogService.pruneThrough(db, throughLogId);
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

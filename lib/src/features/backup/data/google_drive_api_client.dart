import 'dart:convert';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:hotel/src/features/backup/data/google_drive_auth_service.dart';
import 'package:hotel/src/features/backup/domain/backup_org_identity.dart';
import 'package:hotel/src/features/backup/domain/backup_table_merge.dart';
import 'package:hotel/src/features/backup/domain/books_delta_exporter.dart';
import 'package:hotel/src/features/backup/domain/drive_backup_state_storage.dart';
import 'package:hotel/src/features/backup/domain/backup_compression.dart';
import 'package:hotel/src/features/backup/domain/backup_parallel.dart';
import 'package:hotel/src/features/backup/domain/models/backup_manifest.dart';
import 'package:hotel/src/features/backup/domain/models/downloaded_org_backup.dart';
import 'package:hotel/src/features/backup/domain/models/drive_org_backup_summary.dart';
import 'package:hotel/src/features/backup/domain/drive_restore_debug.dart';
import 'package:hotel/src/features/backup/domain/models/organization_backup_meta.dart';
import 'package:hotel/src/features/setup/domain/local_books_database_health.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GoogleDriveApiClient {
  GoogleDriveApiClient(this._authService);

  final GoogleDriveAuthService _authService;

  static const rootFolderName = 'HotelBooks';
  static const _uploadConcurrency = 5;
  static const _downloadConcurrency = 6;

  Future<drive.DriveApi> _api() async {
    final client = await _authService.googleSignIn.authenticatedClient();
    if (client == null) {
      throw StateError('Google Drive is not authenticated.');
    }
    return drive.DriveApi(client);
  }

  Future<String?> findFolder({
    required drive.DriveApi api,
    required String name,
    String? parentId,
  }) async {
    final parentClause = parentId == null
        ? "'root' in parents"
        : "'$parentId' in parents";
    final query =
        "name = '$name' and mimeType = 'application/vnd.google-apps.folder' and trashed = false and $parentClause";

    final existing = await api.files.list(
      q: query,
      spaces: 'drive',
      $fields: 'files(id,name)',
    );

    if (existing.files != null &&
        existing.files!.isNotEmpty &&
        existing.files!.first.id != null) {
      return existing.files!.first.id!;
    }
    return null;
  }

  Future<String> findOrCreateFolder({
    required drive.DriveApi api,
    required String name,
    String? parentId,
  }) async {
    final existing = await findFolder(api: api, name: name, parentId: parentId);
    if (existing != null) return existing;

    final folder = drive.File()
      ..name = name
      ..mimeType = 'application/vnd.google-apps.folder'
      ..parents = parentId == null ? ['root'] : [parentId];

    final created = await api.files.create(
      folder,
      $fields: 'id',
    );
    if (created.id == null) {
      throw StateError('Could not create Google Drive folder: $name');
    }
    return created.id!;
  }

  Future<String> _cachedFindOrCreateFolder({
    required drive.DriveApi api,
    required String cacheKey,
    required String name,
    String? parentId,
  }) async {
    final cached = await DriveBackupStateStorage.getFolderCache(cacheKey);
    if (cached != null) return cached;

    final id = await findOrCreateFolder(
      api: api,
      name: name,
      parentId: parentId,
    );
    await DriveBackupStateStorage.setFolderCache(cacheKey, id);
    return id;
  }

  Future<({String orgFolderId, String dataFolderId, String rootId})>
      _ensureOrgBackupPaths({
    required drive.DriveApi api,
    required String orgSlug,
  }) async {
    final rootId = await _cachedFindOrCreateFolder(
      api: api,
      cacheKey: 'root',
      name: rootFolderName,
    );
    final orgsId = await _cachedFindOrCreateFolder(
      api: api,
      cacheKey: 'orgs',
      name: 'orgs',
      parentId: rootId,
    );
    final orgFolderId = await _cachedFindOrCreateFolder(
      api: api,
      cacheKey: 'org_$orgSlug',
      name: orgSlug,
      parentId: orgsId,
    );
    final dataFolderId = await _cachedFindOrCreateFolder(
      api: api,
      cacheKey: 'data_$orgSlug',
      name: 'data',
      parentId: orgFolderId,
    );
    return (orgFolderId: orgFolderId, dataFolderId: dataFolderId, rootId: rootId);
  }

  Future<Map<String, String>> _existingFileIds({
    required drive.DriveApi api,
    required String parentId,
  }) async {
    final result = await api.files.list(
      q: "'$parentId' in parents and trashed = false",
      spaces: 'drive',
      $fields: 'files(id,name)',
      pageSize: 1000,
    );

    final ids = <String, String>{};
    for (final file in result.files ?? <drive.File>[]) {
      final name = file.name;
      final id = file.id;
      if (name != null && id != null) {
        ids[name] = id;
      }
    }
    return ids;
  }

  Future<void> uploadJsonFile({
    required drive.DriveApi api,
    required String parentId,
    required String fileName,
    required Map<String, dynamic> json,
    Map<String, String>? existingFileIds,
  }) async {
    await uploadBytes(
      api: api,
      parentId: parentId,
      fileName: fileName,
      bytes: utf8.encode(jsonEncode(json)),
      mimeType: 'application/json',
      existingFileId: existingFileIds?[fileName],
    );
  }

  Future<void> uploadBytes({
    required drive.DriveApi api,
    required String parentId,
    required String fileName,
    required List<int> bytes,
    String mimeType = 'application/json',
    String? existingFileId,
  }) async {
    final media = drive.Media(
      Stream.value(bytes),
      bytes.length,
      contentType: mimeType,
    );

    if (existingFileId != null) {
      await api.files.update(
        drive.File(),
        existingFileId,
        uploadMedia: media,
      );
      return;
    }

    final file = drive.File()
      ..name = fileName
      ..parents = [parentId];

    await api.files.create(
      file,
      uploadMedia: media,
      $fields: 'id',
    );
  }

  Future<void> uploadOrganizationBackup({
    required String orgSlug,
    required Map<String, dynamic> meta,
    required Map<String, dynamic> manifest,
    required Map<String, dynamic> registry,
    required Map<String, String> tableFiles,
    void Function(String step, double progress)? onProgress,
  }) async {
    final api = await _api();
    final paths = await _ensureOrgBackupPaths(api: api, orgSlug: orgSlug);

    final existingResults = await Future.wait([
      _existingFileIds(api: api, parentId: paths.orgFolderId),
      if (tableFiles.isNotEmpty)
        _existingFileIds(api: api, parentId: paths.dataFolderId)
      else
        Future<Map<String, String>>.value({}),
    ]);
    final orgExisting = existingResults[0];
    final dataExisting = existingResults[1];

    onProgress?.call('meta.json', 0.05);
    await Future.wait([
      uploadJsonFile(
        api: api,
        parentId: paths.orgFolderId,
        fileName: 'meta.json',
        json: meta,
        existingFileIds: orgExisting,
      ),
      uploadJsonFile(
        api: api,
        parentId: paths.orgFolderId,
        fileName: 'manifest.json',
        json: manifest,
        existingFileIds: orgExisting,
      ),
      uploadJsonFile(
        api: api,
        parentId: paths.rootId,
        fileName: 'registry.json',
        json: registry,
      ),
    ]);

    onProgress?.call('upload', 0.15);

    final entries = tableFiles.entries.toList();
    var completed = 0;

    if (entries.isEmpty) {
      onProgress?.call('upload', 1.0);
      return;
    }

    await runWithConcurrency<MapEntry<String, String>>(
      items: entries,
      concurrency: _uploadConcurrency,
      worker: (entry, _) async {
        final fileName = '${entry.key}${BackupCompression.tableFileSuffix}';
        final legacyFileName = '${entry.key}.json';
        await uploadBytes(
          api: api,
          parentId: paths.dataFolderId,
          fileName: fileName,
          bytes: BackupCompression.encodeJson(entry.value),
          mimeType: 'application/gzip',
          existingFileId: dataExisting[fileName],
        );
        final legacyId = dataExisting[legacyFileName];
        if (legacyId != null) {
          try {
            await api.files.delete(legacyId);
          } catch (_) {
            // Best-effort cleanup of pre-compression backups.
          }
        }
        completed++;
        onProgress?.call(
          entry.key,
          0.15 + (completed / entries.length) * 0.85,
        );
      },
    );
  }

  /// Merges [delta] rows into existing Drive table files and uploads only changed tables.
  Future<void> uploadIncrementalTableUpdates({
    required String orgSlug,
    required DeltaExportResult delta,
    void Function(String step, double progress)? onProgress,
  }) async {
    final api = await _api();
    final paths = await _ensureOrgBackupPaths(api: api, orgSlug: orgSlug);
    final dataExisting = await _existingFileIds(
      api: api,
      parentId: paths.dataFolderId,
    );
    final orgExisting = await _existingFileIds(
      api: api,
      parentId: paths.orgFolderId,
    );

    final tables = delta.tableFiles.keys.toList();
    if (tables.isEmpty) return;

    onProgress?.call('download', 0.05);
    final existingByTable = <String, String>{};
    for (final table in tables) {
      final fileName = '$table${BackupCompression.tableFileSuffix}';
      final legacyFileName = '$table.json';
      final fileId = dataExisting[fileName] ?? dataExisting[legacyFileName];
      if (fileId == null) continue;
      final content = await downloadTextFile(api, fileId);
      if (content != null && content.isNotEmpty) {
        existingByTable[table] = content;
      }
    }

    onProgress?.call('merge', 0.2);
    final mergedFiles = <String, String>{};
    for (final table in tables) {
      final upserts = delta.upsertsByTable[table] ?? const [];
      final serializedUpserts = upserts
          .map(
            (row) => row.map((key, value) {
              if (value is List<int>) {
                return MapEntry(key, base64Encode(value));
              }
              return MapEntry(key, value);
            }),
          )
          .toList(growable: false);
      mergedFiles[table] = BackupTableMerge.mergeTableJson(
        tableName: table,
        existingJson: existingByTable[table],
        upsertRows: serializedUpserts,
        deleteKeys: delta.deletesByTable[table] ?? const [],
      );
    }

    onProgress?.call('upload', 0.35);
    var completed = 0;
    await runWithConcurrency<String>(
      items: mergedFiles.keys.toList(),
      concurrency: _uploadConcurrency,
      worker: (table, _) async {
        final fileName = '$table${BackupCompression.tableFileSuffix}';
        await uploadBytes(
          api: api,
          parentId: paths.dataFolderId,
          fileName: fileName,
          bytes: BackupCompression.encodeJson(mergedFiles[table]!),
          mimeType: 'application/gzip',
          existingFileId: dataExisting[fileName],
        );
        completed++;
        onProgress?.call(
          table,
          0.35 + (completed / mergedFiles.length) * 0.55,
        );
      },
    );

    onProgress?.call('meta', 0.95);
    final mergedManifest = await _buildMergedManifestForUpload(
      api: api,
      orgFolderId: paths.orgFolderId,
      delta: delta,
      mergedFiles: mergedFiles,
    );
    await Future.wait([
      uploadJsonFile(
        api: api,
        parentId: paths.orgFolderId,
        fileName: 'meta.json',
        json: delta.meta.toJson(),
        existingFileIds: orgExisting,
      ),
      uploadJsonFile(
        api: api,
        parentId: paths.orgFolderId,
        fileName: 'manifest.json',
        json: mergedManifest.toJson(),
        existingFileIds: orgExisting,
      ),
      uploadJsonFile(
        api: api,
        parentId: paths.orgFolderId,
        fileName: 'delta_manifest.json',
        json: delta.manifest.toJson(),
        existingFileIds: orgExisting,
      ),
    ]);
    onProgress?.call('done', 1);
  }

  Future<List<DriveOrgBackupSummary>> listOrgBackups() async {
    final api = await _api();
    final rootId = await findFolder(api: api, name: rootFolderName);
    if (rootId == null) return [];

    final orgsId = await findFolder(api: api, name: 'orgs', parentId: rootId);
    if (orgsId == null) return [];

    final folders = await api.files.list(
      q: "'$orgsId' in parents and mimeType = 'application/vnd.google-apps.folder' and trashed = false",
      spaces: 'drive',
      $fields: 'files(id,name)',
    );

    final folderList = folders.files ?? <drive.File>[];
    final summaries = await Future.wait(
      folderList.map((folder) async {
        final folderId = folder.id;
        final slug = folder.name?.trim();
        if (folderId == null || slug == null || slug.isEmpty) return null;

        final metaJson = await downloadJsonFile(
          api: api,
          parentId: folderId,
          fileName: 'meta.json',
        );
        if (metaJson == null) return null;

        final meta = OrganizationBackupMeta.fromJson(metaJson);
        final displayName = BackupOrgIdentityReader.pickDisplayName([
          meta.name,
        ]);
        return DriveOrgBackupSummary(
          slug: meta.slug.isNotEmpty ? meta.slug : slug,
          name: displayName.isNotEmpty ? displayName : slug,
          code: meta.code,
          businessType: meta.businessType,
          exportedAt: DateTime.tryParse(meta.exportedAt),
        );
      }),
    );

    final result = summaries.whereType<DriveOrgBackupSummary>().toList();
    result.sort((a, b) {
      final aTime = a.exportedAt?.millisecondsSinceEpoch ?? 0;
      final bTime = b.exportedAt?.millisecondsSinceEpoch ?? 0;
      return bTime.compareTo(aTime);
    });
    return result;
  }

  /// Reads [meta.json] exported time for [orgSlug] without downloading tables.
  Future<DateTime?> fetchOrgBackupExportedAt(String orgSlug) async {
    final meta = await fetchOrgBackupMeta(orgSlug);
    if (meta == null) return null;
    return DateTime.tryParse(meta.exportedAt);
  }

  Future<OrganizationBackupMeta?> fetchOrgBackupMeta(String orgSlug) async {
    final trimmed = orgSlug.trim();
    if (trimmed.isEmpty) return null;

    final api = await _api();
    final rootId = await findFolder(api: api, name: rootFolderName);
    if (rootId == null) return null;

    final orgsId = await findFolder(api: api, name: 'orgs', parentId: rootId);
    if (orgsId == null) return null;

    final orgFolderId = await findFolder(
      api: api,
      name: trimmed,
      parentId: orgsId,
    );
    if (orgFolderId == null) return null;

    final metaJson = await downloadJsonFile(
      api: api,
      parentId: orgFolderId,
      fileName: 'meta.json',
    );
    if (metaJson == null) return null;

    return OrganizationBackupMeta.fromJson(metaJson);
  }

  /// Table names present in Drive `data/` for [orgSlug] (no file download).
  Future<Set<String>> listBackedUpTableNamesOnDrive(String orgSlug) async {
    final api = await _api();
    final orgFolderId = await _findOrgFolderId(api: api, orgSlug: orgSlug);
    if (orgFolderId == null) return {};

    final dataFolderId = await findFolder(
      api: api,
      name: 'data',
      parentId: orgFolderId,
    );
    if (dataFolderId == null) return {};

    final files = await api.files.list(
      q: "'$dataFolderId' in parents and trashed = false and mimeType != 'application/vnd.google-apps.folder'",
      spaces: 'drive',
      $fields: 'files(name)',
      pageSize: 1000,
    );

    final names = <String>{};
    for (final file in files.files ?? <drive.File>[]) {
      final name = file.name;
      if (name == null) continue;
      if (name.endsWith(BackupCompression.tableFileSuffix)) {
        names.add(
          name.substring(0, name.length - BackupCompression.tableFileSuffix.length),
        );
        continue;
      }
      if (name.endsWith('.json')) {
        names.add(name.substring(0, name.length - 5));
      }
    }
    return names;
  }

  /// True when Drive has every core table file needed for a fresh-device restore.
  Future<bool> hasRestorableBaselineOnDrive(String orgSlug) async {
    final names = await listBackedUpTableNamesOnDrive(orgSlug);
    final missing = LocalBooksDatabaseHealth.coreTables
        .where((table) => !names.contains(table))
        .toList();
    if (missing.isEmpty) return true;

    DriveRestoreDebug.log(
      'Drive baseline incomplete for $orgSlug — missing: ${missing.join(', ')} '
      '(on Drive: ${names.length} table file(s))',
    );
    return false;
  }

  Future<String?> _findOrgFolderId({
    required drive.DriveApi api,
    required String orgSlug,
  }) async {
    final rootId = await findFolder(api: api, name: rootFolderName);
    if (rootId == null) return null;

    final orgsId = await findFolder(api: api, name: 'orgs', parentId: rootId);
    if (orgsId == null) return null;

    return findFolder(api: api, name: orgSlug.trim(), parentId: orgsId);
  }

  Future<DownloadedOrgBackup> downloadOrganizationBackup(String orgSlug) async {
    final api = await _api();
    final rootId = await findFolder(api: api, name: rootFolderName);
    if (rootId == null) {
      throw StateError('No backups found in Google Drive.');
    }

    final orgsId = await findFolder(api: api, name: 'orgs', parentId: rootId);
    if (orgsId == null) {
      throw StateError('No organization backups found.');
    }

    final orgFolderId = await findFolder(api: api, name: orgSlug, parentId: orgsId);
    if (orgFolderId == null) {
      throw StateError('Backup not found for organization $orgSlug.');
    }

    final metaJson = await downloadJsonFile(
      api: api,
      parentId: orgFolderId,
      fileName: 'meta.json',
    );
    if (metaJson == null) {
      throw StateError('Backup files are incomplete (missing meta.json).');
    }

    final meta = OrganizationBackupMeta.fromJson(metaJson);
    final tableFiles = await _downloadAllTableFiles(
      api: api,
      orgFolderId: orgFolderId,
    );
    if (tableFiles.isEmpty) {
      throw StateError(
        'Backup files are incomplete (no table data found in Drive).',
      );
    }

    final onDrive = tableFiles.keys.toSet();
    final missingCore = LocalBooksDatabaseHealth.coreTables
        .where((table) => !onDrive.contains(table))
        .toList();
    if (missingCore.isNotEmpty) {
      DriveRestoreDebug.log(
        'partial backup on Drive for $orgSlug — '
        'missing core tables: ${missingCore.join(', ')}; '
        'will attempt core bootstrap after import',
      );
    }

    final manifest = await _resolveManifestForRestore(
      api: api,
      orgFolderId: orgFolderId,
      meta: meta,
      tableFiles: tableFiles,
    );

    return DownloadedOrgBackup(
      meta: meta,
      manifest: manifest,
      tableFiles: tableFiles,
    );
  }

  Future<Map<String, String>> _downloadAllTableFiles({
    required drive.DriveApi api,
    required String orgFolderId,
  }) async {
    final dataFolderId = await findFolder(
      api: api,
      name: 'data',
      parentId: orgFolderId,
    );
    if (dataFolderId == null) return {};

    final files = await api.files.list(
      q: "'$dataFolderId' in parents and trashed = false and mimeType != 'application/vnd.google-apps.folder'",
      spaces: 'drive',
      $fields: 'files(id,name)',
      pageSize: 1000,
    );

    final downloadables = <({String table, String id})>[];
    final legacyJsonIds = <String, String>{};
    for (final file in files.files ?? <drive.File>[]) {
      final name = file.name;
      final id = file.id;
      if (name == null || id == null) continue;

      if (name.endsWith(BackupCompression.tableFileSuffix)) {
        downloadables.add((
          table: name.substring(0, name.length - BackupCompression.tableFileSuffix.length),
          id: id,
        ));
        continue;
      }

      if (name.endsWith('.json')) {
        final table = name.substring(0, name.length - 5);
        legacyJsonIds[table] = id;
      }
    }

    for (final entry in legacyJsonIds.entries) {
      if (downloadables.any((item) => item.table == entry.key)) continue;
      downloadables.add((table: entry.key, id: entry.value));
    }

    final tableFiles = <String, String>{};
    await runWithConcurrency(
      items: downloadables,
      concurrency: _downloadConcurrency,
      worker: (item, _) async {
        final content = await downloadTextFile(api, item.id);
        if (content != null && content.isNotEmpty) {
          tableFiles[item.table] = content;
        }
      },
    );
    return tableFiles;
  }

  Future<BackupManifest> _resolveManifestForRestore({
    required drive.DriveApi api,
    required String orgFolderId,
    required OrganizationBackupMeta meta,
    required Map<String, String> tableFiles,
  }) async {
    final manifestJson = await downloadJsonFile(
      api: api,
      parentId: orgFolderId,
      fileName: 'manifest.json',
    );
    if (manifestJson != null) {
      return _manifestCoveringTables(
        BackupManifest.fromJson(manifestJson),
        tableFiles: tableFiles,
        exportedAt: meta.exportedAt,
      );
    }

    final deltaJson = await downloadJsonFile(
      api: api,
      parentId: orgFolderId,
      fileName: 'delta_manifest.json',
    );
    if (deltaJson != null) {
      return _manifestCoveringTables(
        BackupManifest.fromJson(deltaJson),
        tableFiles: tableFiles,
        exportedAt: meta.exportedAt,
      );
    }

    return _synthesizeManifest(
      tableFiles: tableFiles,
      exportedAt: meta.exportedAt,
    );
  }

  BackupManifest _manifestCoveringTables(
    BackupManifest base, {
    required Map<String, String> tableFiles,
    required String exportedAt,
  }) {
    final tables = {...base.tables, ...tableFiles.keys}.toList()..sort();
    final counts = Map<String, int>.from(base.recordCounts);
    for (final table in tableFiles.keys) {
      counts[table] = _countRowsInTableJson(tableFiles[table]!);
    }

    return BackupManifest(
      formatVersion: BackupManifest.currentFormatVersion,
      tables: tables,
      recordCounts: counts,
      checksum: base.checksum,
      exportedAt: exportedAt.isNotEmpty ? exportedAt : base.exportedAt,
    );
  }

  BackupManifest _synthesizeManifest({
    required Map<String, String> tableFiles,
    required String exportedAt,
  }) {
    final tables = tableFiles.keys.toList()..sort();
    final counts = <String, int>{
      for (final table in tables) table: _countRowsInTableJson(tableFiles[table]!),
    };
    return BackupManifest(
      formatVersion: BackupManifest.currentFormatVersion,
      tables: tables,
      recordCounts: counts,
      checksum: '',
      exportedAt: exportedAt,
    );
  }

  static int _countRowsInTableJson(String json) {
    try {
      final decoded = jsonDecode(json);
      if (decoded is! Map) return 0;
      final rows = decoded['rows'];
      if (rows is List) return rows.length;
    } catch (_) {}
    return 0;
  }

  Future<BackupManifest> _buildMergedManifestForUpload({
    required drive.DriveApi api,
    required String orgFolderId,
    required DeltaExportResult delta,
    required Map<String, String> mergedFiles,
  }) async {
    final existingJson = await downloadJsonFile(
      api: api,
      parentId: orgFolderId,
      fileName: 'manifest.json',
    );
    final base = existingJson != null
        ? BackupManifest.fromJson(existingJson)
        : null;

    final tables = {
      ...?base?.tables,
      ...mergedFiles.keys,
    }.toList()
      ..sort();

    final counts = Map<String, int>.from(base?.recordCounts ?? const {});
    for (final table in mergedFiles.keys) {
      counts[table] = _countRowsInTableJson(mergedFiles[table]!);
    }

    return BackupManifest(
      formatVersion: BackupManifest.currentFormatVersion,
      tables: tables,
      recordCounts: counts,
      checksum: delta.manifest.checksum,
      exportedAt: delta.meta.exportedAt,
    );
  }

  Future<Map<String, dynamic>?> downloadJsonFile({
    required drive.DriveApi api,
    required String parentId,
    required String fileName,
  }) async {
    final raw = await _downloadFileContentInFolder(
      api: api,
      parentId: parentId,
      fileName: fileName,
    );
    if (raw == null || raw.isEmpty) return null;
    final decoded = jsonDecode(raw);
    if (decoded is Map<String, dynamic>) return decoded;
    if (decoded is Map) return Map<String, dynamic>.from(decoded);
    return null;
  }

  Future<String?> downloadTextFile(drive.DriveApi api, String fileId) =>
      _downloadFileContentById(api, fileId);

  Future<String?> _downloadFileContentInFolder({
    required drive.DriveApi api,
    required String parentId,
    required String fileName,
  }) async {
    final query =
        "name = '$fileName' and '$parentId' in parents and trashed = false";
    final existing = await api.files.list(
      q: query,
      spaces: 'drive',
      $fields: 'files(id,name)',
    );
    final id = existing.files?.isNotEmpty == true ? existing.files!.first.id : null;
    if (id == null) return null;
    return _downloadFileContentById(api, id);
  }

  Future<String?> _downloadFileContentById(
    drive.DriveApi api,
    String fileId,
  ) async {
    final media = await api.files.get(
      fileId,
      downloadOptions: drive.DownloadOptions.fullMedia,
    ) as drive.Media;

    final bytes = <int>[];
    await for (final chunk in media.stream) {
      bytes.addAll(chunk);
    }
    if (bytes.isEmpty) return null;
    return BackupCompression.decodeBytes(bytes);
  }
}

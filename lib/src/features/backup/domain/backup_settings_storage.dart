import 'package:hotel/src/features/backup/domain/models/backup_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists user backup preferences (auto backup, Wi‑Fi only, schedule).
class BackupSettingsStorage {
  BackupSettingsStorage._();

  static const _autoEnabledKey = 'backup_auto_enabled_v1';
  static const _wifiOnlyKey = 'backup_wifi_only_v1';
  static const _frequencyKey = 'backup_frequency_v1';
  static const _syncDirectionKey = 'backup_sync_direction_v1';
  static const _lastAutoRunAtKey = 'backup_last_auto_run_at_v1';
  static const _lastAutoRunOutcomeKey = 'backup_last_auto_run_outcome_v1';
  static const _lastAutoRunMessageKey = 'backup_last_auto_run_message_v1';

  static Future<BackupSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    return BackupSettings(
      autoBackupEnabled: prefs.getBool(_autoEnabledKey) ?? false,
      wifiOnly: prefs.getBool(_wifiOnlyKey) ?? true,
      frequency: BackupFrequency.fromStorage(prefs.getString(_frequencyKey)),
      syncDirection: BackupSyncDirection.fromStorage(
        prefs.getString(_syncDirectionKey),
      ),
    );
  }

  static Future<void> save(BackupSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_autoEnabledKey, settings.autoBackupEnabled);
    await prefs.setBool(_wifiOnlyKey, settings.wifiOnly);
    await prefs.setString(_frequencyKey, settings.frequency.name);
    await prefs.setString(_syncDirectionKey, settings.syncDirection.name);
  }

  static Future<DateTime?> getLastAutoRunAt() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_lastAutoRunAtKey);
    if (raw == null || raw.isEmpty) return null;
    return DateTime.tryParse(raw);
  }

  static Future<void> saveLastAutoRun(AutoBackupRunResult result) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _lastAutoRunAtKey,
      DateTime.now().toUtc().toIso8601String(),
    );
    await prefs.setString(_lastAutoRunOutcomeKey, result.outcome.name);
    final message = result.message?.trim();
    if (message == null || message.isEmpty) {
      await prefs.remove(_lastAutoRunMessageKey);
    } else {
      await prefs.setString(_lastAutoRunMessageKey, message);
    }
  }

  static Future<AutoBackupRunResult?> getLastAutoRun() async {
    final prefs = await SharedPreferences.getInstance();
    final outcomeRaw = prefs.getString(_lastAutoRunOutcomeKey);
    if (outcomeRaw == null) return null;
    final outcome = AutoBackupOutcome.values.firstWhere(
      (v) => v.name == outcomeRaw,
      orElse: () => AutoBackupOutcome.skipped,
    );
    return AutoBackupRunResult(
      outcome: outcome,
      message: prefs.getString(_lastAutoRunMessageKey),
    );
  }
}

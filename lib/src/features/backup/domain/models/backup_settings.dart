/// How often automatic backup/sync should run.
enum BackupFrequency {
  off,
  daily,
  weekly,
  monthly;

  static BackupFrequency fromStorage(String? raw) {
    return BackupFrequency.values.firstWhere(
      (v) => v.name == raw,
      orElse: () => BackupFrequency.daily,
    );
  }
}

/// Whether auto sync uploads, downloads, or both.
enum BackupSyncDirection {
  uploadOnly,
  downloadOnly,
  both;

  static BackupSyncDirection fromStorage(String? raw) {
    return BackupSyncDirection.values.firstWhere(
      (v) => v.name == raw,
      orElse: () => BackupSyncDirection.uploadOnly,
    );
  }

  bool get includesUpload =>
      this == BackupSyncDirection.uploadOnly || this == BackupSyncDirection.both;

  bool get includesDownload =>
      this == BackupSyncDirection.downloadOnly || this == BackupSyncDirection.both;
}

/// User preferences for Google Drive auto backup (WhatsApp-style).
class BackupSettings {
  const BackupSettings({
    required this.autoBackupEnabled,
    required this.wifiOnly,
    required this.frequency,
    required this.syncDirection,
  });

  final bool autoBackupEnabled;
  final bool wifiOnly;
  final BackupFrequency frequency;
  final BackupSyncDirection syncDirection;

  static const defaults = BackupSettings(
    autoBackupEnabled: false,
    wifiOnly: true,
    frequency: BackupFrequency.daily,
    syncDirection: BackupSyncDirection.uploadOnly,
  );

  BackupSettings copyWith({
    bool? autoBackupEnabled,
    bool? wifiOnly,
    BackupFrequency? frequency,
    BackupSyncDirection? syncDirection,
  }) {
    return BackupSettings(
      autoBackupEnabled: autoBackupEnabled ?? this.autoBackupEnabled,
      wifiOnly: wifiOnly ?? this.wifiOnly,
      frequency: frequency ?? this.frequency,
      syncDirection: syncDirection ?? this.syncDirection,
    );
  }
}

enum AutoBackupOutcome {
  skipped,
  uploaded,
  downloaded,
  failed,
}

class AutoBackupRunResult {
  const AutoBackupRunResult({
    required this.outcome,
    this.message,
  });

  final AutoBackupOutcome outcome;
  final String? message;

  bool get didWork =>
      outcome == AutoBackupOutcome.uploaded ||
      outcome == AutoBackupOutcome.downloaded;
}

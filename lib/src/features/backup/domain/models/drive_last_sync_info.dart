class DriveLastSyncInfo {
  const DriveLastSyncInfo({
    this.accountEmail,
    this.syncedAt,
    this.orgSlug,
    this.orgName,
    this.tableCount,
    this.recordCount,
    this.lastError,
    this.pendingChanges,
  });

  final String? accountEmail;
  final DateTime? syncedAt;
  final String? orgSlug;
  final String? orgName;
  final int? tableCount;
  final int? recordCount;
  final String? lastError;

  /// Row changes logged since the last backup checkpoint.
  final int? pendingChanges;

  bool get hasSynced => syncedAt != null;
  bool get isSignedIn =>
      accountEmail != null && accountEmail!.trim().isNotEmpty;
}

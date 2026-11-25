/// Shared markers for offline demo / test-data rows.
abstract final class TestDataConstants {
  static const createdByMarker = 'biztrack_test_data';

  static bool isDemoCreatedBy(String? createdBy) =>
      createdBy?.trim() == createdByMarker;

  /// Seeded demo invoices use `SINV-TEST-*` / `PINV-TEST-*`.
  static bool isDemoInvoiceName(String? name) {
    final normalized = name?.trim().toUpperCase() ?? '';
    return normalized.contains('-TEST-');
  }

  /// Demo rows do not count toward free-tier create limits or record locks.
  static bool isExcludedFromFreemiumLimits({
    String? createdBy,
    String? recordName,
  }) {
    return isDemoCreatedBy(createdBy) || isDemoInvoiceName(recordName);
  }
}

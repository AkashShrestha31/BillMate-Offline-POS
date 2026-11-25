import 'package:hotel/src/core/config/app_freemium_config.dart';
import 'package:hotel/src/core/constants/test_data_constants.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/billing/freemium_check_result.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_record_spec.dart';
import 'package:hotel/src/core/services/billing/subscription_service.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/org/org_registry_storage.dart';

/// Central freemium checks — premium users and non-billing platforms are unlimited.
class FreemiumGateService {
  FreemiumGateService(this._db, this._billing);

  /// Prefix for blocked messages so UI can detect freemium limits without English heuristics.
  static const blockedMessagePrefix = '@freemium@';

  final LocalDb _db;
  final SubscriptionService _billing;

  static const _excludeDemoCreatedByWhere =
      "createdBy IS NULL OR TRIM(createdBy) = '' OR createdBy != ?";

  static final _excludeDemoCreatedByArgs = [
    TestDataConstants.createdByMarker,
  ];

  bool get limitsApply {
    if (!AppFreemiumConfig.enabled) return false;
    if (_billing.hasPremiumAccess) return false;
    if (_billing.isSyncingEntitlements &&
        _billing.hadPremiumBeforeEntitlementSync) {
      return false;
    }
    return true;
  }

  int limitFor(FreemiumFeature feature, {String? partyRole}) {
    return switch (feature) {
      FreemiumFeature.salesInvoice => AppFreemiumConfig.salesInvoiceLimit,
      FreemiumFeature.purchaseInvoice => AppFreemiumConfig.purchaseInvoiceLimit,
      FreemiumFeature.employee => AppFreemiumConfig.employeeLimit,
      FreemiumFeature.item => AppFreemiumConfig.itemLimit,
      FreemiumFeature.category => AppFreemiumConfig.categoryLimit,
      FreemiumFeature.paymentMethod => AppFreemiumConfig.paymentMethodLimit,
      FreemiumFeature.partyRole => AppFreemiumConfig.partyRoleLimit,
      FreemiumFeature.party =>
        AppFreemiumConfig.partyLimitForRole(partyRole),
      FreemiumFeature.organization => AppFreemiumConfig.organizationLimit,
      _ => 0,
    };
  }

  /// Oldest records within the free allowance remain accessible after premium ends.
  /// Returns `null` when every record is accessible (premium or billing disabled).
  Future<Set<String>?> accessibleRecordKeys(
    FreemiumFeature feature, {
    String? partyRole,
  }) async {
    if (!limitsApply) return null;

    final spec = FreemiumRecordSpec.forFeature(feature, partyRole: partyRole);
    if (spec == null) return null;

    final limit = limitFor(feature, partyRole: partyRole);
    if (limit <= 0) return const {};

    final rows = await _db.query(
      spec.table,
      where: spec.where,
      whereArgs: spec.whereArgs,
      orderBy: spec.orderBy,
    );

    Iterable<Map<String, Object?>> filtered = rows;
    if (spec.postFilter != null) {
      filtered = rows.where(spec.postFilter!);
    }

    final keys = <String>{};
    for (final row in filtered) {
      if (keys.length >= limit) break;
      final raw = row[spec.idColumn];
      if (raw == null) continue;
      keys.add(raw.toString());
    }
    return keys;
  }

  bool isRecordLocked(String recordKey, Set<String>? accessibleKeys) {
    if (accessibleKeys == null) return false;
    if (TestDataConstants.isDemoInvoiceName(recordKey)) return false;
    if (AppFreemiumConfig.isFreePaymentMethod(recordKey)) return false;
    final normalized = recordKey.trim();
    if (normalized.isEmpty) return false;
    return !accessibleKeys.contains(normalized);
  }

  Future<FreemiumCheckResult> check(
    FreemiumFeature feature, {
    String? partyRole,
    int additionalCount = 1,
  }) async {
    if (!limitsApply) return const FreemiumCheckResult.allowed();

    return switch (feature) {
      FreemiumFeature.salesInvoice => _checkCount(
          await _countUserInvoices('SalesInvoice'),
          AppFreemiumConfig.salesInvoiceLimit,
          'sales invoices',
          additionalCount: additionalCount,
        ),
      FreemiumFeature.purchaseInvoice => _checkCount(
          await _countUserInvoices('PurchaseInvoice'),
          AppFreemiumConfig.purchaseInvoiceLimit,
          'purchase invoices',
          additionalCount: additionalCount,
        ),
      FreemiumFeature.employee => _checkCount(
          await _db.count('Employee'),
          AppFreemiumConfig.employeeLimit,
          'employees',
          additionalCount: additionalCount,
        ),
      FreemiumFeature.item => _checkCount(
          await _db.count('Item'),
          AppFreemiumConfig.itemLimit,
          'items',
          additionalCount: additionalCount,
        ),
      FreemiumFeature.category => _checkCount(
          await _db.count('Category'),
          AppFreemiumConfig.categoryLimit,
          'categories',
          additionalCount: additionalCount,
        ),
      FreemiumFeature.paymentMethod => _checkCount(
          await _countUserPaymentMethods(),
          AppFreemiumConfig.paymentMethodLimit,
          'payment methods',
          additionalCount: additionalCount,
        ),
      FreemiumFeature.partyRole => _checkCount(
          await _countUserPartyRoles(),
          AppFreemiumConfig.partyRoleLimit,
          'custom party roles',
          additionalCount: additionalCount,
        ),
      FreemiumFeature.party => _checkPartyRole(partyRole, additionalCount),
      FreemiumFeature.organization => _checkOrganization(),
      FreemiumFeature.reportProfitLoss ||
      FreemiumFeature.reportStatement ||
      FreemiumFeature.reportAnalytics =>
        _checkPremiumOnly(
          AppFreemiumConfig.reportsRequirePremium,
          'Reports are available with Premium.',
        ),
      FreemiumFeature.backupSync => _checkPremiumOnly(
          AppFreemiumConfig.backupRequirePremium,
          'Backup & sync requires Premium.',
        ),
      FreemiumFeature.payroll => _checkPremiumOnly(
          AppFreemiumConfig.payrollRequirePremium,
          'Payroll requires Premium.',
        ),
      FreemiumFeature.attendance => _checkPremiumOnly(
          AppFreemiumConfig.attendanceRequirePremium,
          'Attendance requires Premium.',
        ),
      FreemiumFeature.stock => _checkPremiumOnly(
          AppFreemiumConfig.stockRequirePremium,
          'Stock management requires Premium.',
        ),
      FreemiumFeature.inventory =>
        const FreemiumCheckResult.allowed(),
      FreemiumFeature.invoiceExport => _checkPremiumOnly(
          AppFreemiumConfig.invoiceExportRequirePremium,
          'Download and print requires Premium.',
        ),
    };
  }

  Future<void> assertCan(
    FreemiumFeature feature, {
    String? partyRole,
    int additionalCount = 1,
  }) async {
    final result = await check(
      feature,
      partyRole: partyRole,
      additionalCount: additionalCount,
    );
    if (!result.allowed) {
      throw AppException(
        message: FreemiumGateService.blockedMessagePrefix +
            (result.message ?? 'Upgrade to Premium to continue.'),
      );
    }
  }

  Future<int> _countUserInvoices(String table) {
    return _db.count(
      table,
      where: _excludeDemoCreatedByWhere,
      whereArgs: _excludeDemoCreatedByArgs,
    );
  }

  Future<int> _countUserPaymentMethods() {
    return _db.count(
      'PaymentMethod',
      where: "LOWER(TRIM(name)) NOT IN ('cash', 'qr')",
    );
  }

  Future<int> _countUserPartyRoles() async {
    final rows = await _db.query('Role', where: 'is_system = ?', whereArgs: [0]);
    return rows.where((row) {
      final name = (row['name'] as String?)?.trim().toLowerCase() ?? '';
      return !AppFreemiumConfig.seededCustomRoleNames.contains(name);
    }).length;
  }

  Future<FreemiumCheckResult> _checkPartyRole(
    String? partyRole,
    int additionalCount,
  ) async {
    final role = partyRole?.trim();
    if (role == null || role.isEmpty) {
      return const FreemiumCheckResult.blocked(
        message: 'Party role is required.',
      );
    }
    final current = await _db.count(
      'Party',
      where: 'LOWER(role) = ?',
      whereArgs: [role.toLowerCase()],
    );
    return _checkCount(
      current,
      AppFreemiumConfig.partyLimitForRole(role),
      'parties for $role',
      additionalCount: additionalCount,
    );
  }

  Future<FreemiumCheckResult> _checkOrganization() async {
    final current = (await OrgRegistryStorage.getAll()).length;
    return _checkCount(
      current,
      AppFreemiumConfig.organizationLimit,
      'organizations',
    );
  }

  FreemiumCheckResult _checkPremiumOnly(bool requirePremium, String message) {
    if (!requirePremium) return const FreemiumCheckResult.allowed();
    return FreemiumCheckResult.blocked(message: message);
  }

  FreemiumCheckResult _checkCount(
    int current,
    int limit,
    String label, {
    int additionalCount = 1,
  }) {
    if (current + additionalCount <= limit) {
      return const FreemiumCheckResult.allowed();
    }
    return FreemiumCheckResult.blocked(
      message:
          'Free plan allows up to $limit $label. Upgrade to Premium for unlimited access.',
      limit: limit,
      current: current,
    );
  }
}

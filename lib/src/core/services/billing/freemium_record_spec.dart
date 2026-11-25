import 'package:hotel/src/core/config/app_freemium_config.dart';
import 'package:hotel/src/core/constants/test_data_constants.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';

/// SQLite location for freemium countable records (oldest records stay accessible).
class FreemiumRecordSpec {
  const FreemiumRecordSpec({
    required this.table,
    required this.idColumn,
    required this.orderBy,
    this.where,
    this.whereArgs,
    this.postFilter,
  });

  final String table;
  final String idColumn;
  final String orderBy;
  final String? where;
  final List<Object?>? whereArgs;
  final bool Function(Map<String, Object?> row)? postFilter;

  static FreemiumRecordSpec? forFeature(
    FreemiumFeature feature, {
    String? partyRole,
  }) {
    return switch (feature) {
      FreemiumFeature.salesInvoice => FreemiumRecordSpec(
          table: 'SalesInvoice',
          idColumn: 'name',
          orderBy: 'created ASC',
          where: _excludeDemoCreatedByWhere,
          whereArgs: _excludeDemoCreatedByArgs,
        ),
      FreemiumFeature.purchaseInvoice => FreemiumRecordSpec(
          table: 'PurchaseInvoice',
          idColumn: 'name',
          orderBy: 'created ASC',
          where: _excludeDemoCreatedByWhere,
          whereArgs: _excludeDemoCreatedByArgs,
        ),
      FreemiumFeature.employee => const FreemiumRecordSpec(
          table: 'Employee',
          idColumn: 'id',
          orderBy: 'created ASC',
        ),
      FreemiumFeature.item => const FreemiumRecordSpec(
          table: 'Item',
          idColumn: 'name',
          orderBy: 'created ASC',
        ),
      FreemiumFeature.category => const FreemiumRecordSpec(
          table: 'Category',
          idColumn: 'id',
          orderBy: 'id ASC',
        ),
      FreemiumFeature.paymentMethod => FreemiumRecordSpec(
          table: 'PaymentMethod',
          idColumn: 'name',
          orderBy: 'created ASC',
          postFilter: _isCountablePaymentMethod,
        ),
      FreemiumFeature.partyRole => FreemiumRecordSpec(
          table: 'Role',
          idColumn: 'name',
          orderBy: 'created ASC',
          where: 'is_system = ?',
          whereArgs: const [0],
          postFilter: _isCountableCustomRole,
        ),
      FreemiumFeature.party => FreemiumRecordSpec(
          table: 'Party',
          idColumn: 'name',
          orderBy: 'created ASC',
          where: 'LOWER(role) = ?',
          whereArgs: [partyRole?.trim().toLowerCase()],
        ),
      _ => null,
    };
  }

  static const _excludeDemoCreatedByWhere =
      "createdBy IS NULL OR TRIM(createdBy) = '' OR createdBy != ?";

  static final _excludeDemoCreatedByArgs = [
    TestDataConstants.createdByMarker,
  ];

  static bool _isCountableCustomRole(Map<String, Object?> row) {
    final name = (row['name'] as String?)?.trim().toLowerCase() ?? '';
    return !AppFreemiumConfig.seededCustomRoleNames.contains(name);
  }

  static bool _isCountablePaymentMethod(Map<String, Object?> row) {
    return !AppFreemiumConfig.isFreePaymentMethod(row['name'] as String?);
  }
}

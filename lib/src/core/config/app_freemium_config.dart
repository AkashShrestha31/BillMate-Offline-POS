import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotel/src/core/config/app_billing_config.dart';

/// Env-driven free-tier rules for iOS billing (Android unlimited when billing off).
///
/// **Count limits (free):** sales 10, purchase 10, employees 4, items 30,
/// categories 10, payment methods 2 (Cash and QR always free), custom party roles 4, customers 10,
/// other party roles 5 (supplier, room, cabin, custom), organizations 1.
///
/// **Premium only:** P&L / statement / analytics reports, backup & sync, payroll,
/// attendance, stock, invoice download/print/share, 2nd+ organization.
///
/// **Always free:** opening, closing, calculator, browsing lists, editing within limits.
abstract final class AppFreemiumConfig {
  static bool get enabled => AppBillingConfig.requiresPremium;

  /// Bootstrap roles that do not count toward the custom party-role limit.
  static const seededCustomRoleNames = {'room', 'cabin'};

  /// Seeded methods that stay free and do not count toward the payment-method limit.
  static const freePaymentMethodNames = {'cash', 'qr'};

  static bool isFreePaymentMethod(String? name) {
    return freePaymentMethodNames.contains(name?.trim().toLowerCase());
  }

  static int _int(String key, int defaultValue) {
    final raw = dotenv.env[key]?.trim();
    if (raw == null || raw.isEmpty) return defaultValue;
    return int.tryParse(raw) ?? defaultValue;
  }

  static bool _paidFlag(String key, {bool defaultValue = true}) {
    final raw = dotenv.env[key]?.trim().toLowerCase();
    if (raw == null || raw.isEmpty) return defaultValue;
    return raw == 'true' || raw == '1' || raw == 'yes';
  }

  static int get salesInvoiceLimit => _int('FREEMIUM_SALES_LIMIT', 10);
  static int get purchaseInvoiceLimit => _int('FREEMIUM_PURCHASE_LIMIT', 10);
  static int get employeeLimit => _int('FREEMIUM_EMPLOYEE_LIMIT', 4);
  static int get itemLimit => _int('FREEMIUM_ITEM_LIMIT', 30);
  static int get categoryLimit => _int('FREEMIUM_CATEGORY_LIMIT', 15);
  static int get paymentMethodLimit => _int('FREEMIUM_PAYMENT_METHOD_LIMIT', 2);
  static int get partyRoleLimit => _int('FREEMIUM_PARTY_ROLE_LIMIT', 4);
  static int get partyPerRoleLimit => _int('FREEMIUM_PARTY_PER_ROLE_LIMIT', 10);
  static int get partyOtherRoleLimit {
    final other = dotenv.env['FREEMIUM_PARTY_OTHER_ROLE_LIMIT']?.trim();
    if (other != null && other.isNotEmpty) {
      return int.tryParse(other) ?? 5;
    }
    return _int('FREEMIUM_PARTY_SUPPLIER_LIMIT', 5);
  }
  static int get organizationLimit => _int('FREEMIUM_ORGANIZATION_LIMIT', 1);

  /// Customers: [partyPerRoleLimit]. All other party roles: [partyOtherRoleLimit].
  static int partyLimitForRole(String? partyRole) {
    final role = partyRole?.trim().toLowerCase() ?? '';
    if (role == 'customer') return partyPerRoleLimit;
    return partyOtherRoleLimit;
  }

  static bool get reportsRequirePremium =>
      _paidFlag('FREEMIUM_REPORTS_REQUIRE_PREMIUM');
  static bool get backupRequirePremium =>
      _paidFlag('FREEMIUM_BACKUP_REQUIRE_PREMIUM');
  static bool get payrollRequirePremium =>
      _paidFlag('FREEMIUM_PAYROLL_REQUIRE_PREMIUM');
  static bool get attendanceRequirePremium =>
      _paidFlag('FREEMIUM_ATTENDANCE_REQUIRE_PREMIUM');
  static bool get stockRequirePremium =>
      _paidFlag('FREEMIUM_STOCK_REQUIRE_PREMIUM');
  static bool get invoiceExportRequirePremium =>
      _paidFlag('FREEMIUM_INVOICE_EXPORT_REQUIRE_PREMIUM');
}

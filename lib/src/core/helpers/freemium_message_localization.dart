import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/services/billing/freemium_check_result.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';

String localizedFreemiumMessage(
  AppLocalizations l10n,
  FreemiumFeature feature,
  FreemiumCheckResult result, {
  String? partyRole,
}) {
  if (result.limit != null) {
    final label = freemiumLimitLabel(
      l10n,
      feature,
      partyRole: partyRole,
    );
    return l10n.freemiumFreePlanLimit(result.limit!, label);
  }

  return switch (feature) {
    FreemiumFeature.party when partyRole == null || partyRole.trim().isEmpty =>
      l10n.freemiumPartyRoleRequired,
    FreemiumFeature.reportProfitLoss ||
    FreemiumFeature.reportStatement ||
    FreemiumFeature.reportAnalytics =>
      l10n.freemiumPremiumReports,
    FreemiumFeature.backupSync => l10n.freemiumPremiumBackupSync,
    FreemiumFeature.payroll => l10n.freemiumPremiumPayroll,
    FreemiumFeature.attendance => l10n.freemiumPremiumAttendance,
    FreemiumFeature.stock => l10n.freemiumPremiumStock,
    FreemiumFeature.invoiceExport => l10n.freemiumPremiumInvoiceExport,
    _ => l10n.upgradeToPremiumContinue,
  };
}

String freemiumLimitLabel(
  AppLocalizations l10n,
  FreemiumFeature feature, {
  String? partyRole,
}) {
  return switch (feature) {
    FreemiumFeature.salesInvoice => l10n.freemiumLabelSalesInvoices,
    FreemiumFeature.purchaseInvoice => l10n.freemiumLabelPurchaseInvoices,
    FreemiumFeature.employee => l10n.freemiumLabelEmployees,
    FreemiumFeature.item => l10n.freemiumLabelItems,
    FreemiumFeature.category => l10n.freemiumLabelCategories,
    FreemiumFeature.paymentMethod => l10n.freemiumLabelPaymentMethods,
    FreemiumFeature.partyRole => l10n.freemiumLabelCustomPartyRoles,
    FreemiumFeature.party => l10n.freemiumLabelPartiesForRole(
        partyRole?.trim().isNotEmpty == true ? partyRole!.trim() : l10n.partyRoleLabel,
      ),
    FreemiumFeature.organization => l10n.freemiumLabelOrganizations,
    _ => l10n.upgradeToPremiumContinue,
  };
}

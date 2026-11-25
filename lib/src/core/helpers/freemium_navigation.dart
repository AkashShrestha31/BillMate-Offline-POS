import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/freemium_message_localization.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:hotel/src/core/widget/above_sheet_snack.dart';

/// Returns true when navigation / action may proceed.
Future<bool> gateFreemiumFeature(
  BuildContext context,
  FreemiumFeature feature, {
  String? partyRole,
}) async {
  final gate = getIt<FreemiumGateService>();
  final result = await gate.check(feature, partyRole: partyRole);
  if (result.allowed) return true;
  if (!context.mounted) return false;

  final message = localizedFreemiumMessage(
    context.l10n,
    feature,
    result,
    partyRole: partyRole,
  );
  context.showKiiSnackBarWarning(message);
  await context.router.push(PremiumPaywallRoute(fromSettings: true));
  return false;
}

Future<bool> gateInvoiceExport(BuildContext context) =>
    gateFreemiumFeature(context, FreemiumFeature.invoiceExport);

/// Returns true when the action may proceed. On block, shows an error only.
Future<bool> showFreemiumLimitMessage(
  BuildContext context,
  FreemiumFeature feature, {
  String? partyRole,
}) async {
  final result = await getIt<FreemiumGateService>().check(
    feature,
    partyRole: partyRole,
  );
  if (result.allowed) return true;
  if (!context.mounted) return false;
  AboveSheetSnack.showError(
    context,
    localizedFreemiumMessage(
      context.l10n,
      feature,
      result,
      partyRole: partyRole,
    ),
  );
  return false;
}

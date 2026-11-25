import 'package:flutter/material.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/widget/above_sheet_snack.dart';
import 'package:hotel/src/features/settings/domain/live_stock_tracking_service.dart';

LiveStockTrackingService? liveStockOrNull() {
  if (!getIt.isRegistered<LiveStockTrackingService>()) return null;
  return getIt<LiveStockTrackingService>();
}

bool liveStockAllowsSale({
  required String itemName,
  required double requestedQty,
  String? itemType,
}) {
  final tracking = liveStockOrNull();
  if (tracking == null) return true;
  return tracking.canIssue(
    itemName: itemName,
    requestedQty: requestedQty,
    itemType: itemType,
  );
}

void showLiveStockShortage(BuildContext context, String itemName) {
  if (!context.mounted) return;
  final available = liveStockOrNull()?.onHand(itemName) ?? 0;
  final message = available <= 0
      ? context.l10n.liveStockOutOfStock(itemName)
      : context.l10n.liveStockInsufficient(
          itemName,
          LiveStockTrackingService.formatQty(available),
        );
  AboveSheetSnack.showWarning(context, message);
}

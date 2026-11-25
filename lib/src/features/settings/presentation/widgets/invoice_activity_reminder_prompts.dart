import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/widget/pdf_export_option_tile.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/settings/domain/invoice_activity_reminder_copy.dart';
import 'package:hotel/src/features/settings/domain/invoice_activity_reminder_dismiss_storage.dart';
import 'package:hotel/src/features/settings/presentation/widgets/shift_reminder_dialog.dart';

/// In-app prompt when no sales or purchase was recorded today.
abstract final class InvoiceActivityReminderPrompts {
  static Future<void> show(BuildContext context) async {
    final action = await showShiftReminderDialog(
      context,
      title: InvoiceActivityReminderCopy.dialogTitle,
      message: InvoiceActivityReminderCopy.dialogMessage,
      proceedLabel: InvoiceActivityReminderCopy.proceedLabel,
      icon: Icons.receipt_long_rounded,
      iconTint: Theme.of(context).colorScheme.primary,
    );

    if (!context.mounted) return;

    switch (action) {
      case ShiftReminderDialogAction.dismissToday:
        await InvoiceActivityReminderDismissStorage.dismissForToday();
      case ShiftReminderDialogAction.proceed:
        // Don't re-prompt while the user is adding a record this session.
        InvoiceActivityReminderDismissStorage.dismissForSession();
        await _chooseAndOpenCreateInvoice(context);
      case ShiftReminderDialogAction.cancel:
      case null:
        // Suppress for this app run only; can show again on next cold start.
        InvoiceActivityReminderDismissStorage.dismissForSession();
    }
  }

  static Future<void> _chooseAndOpenCreateInvoice(BuildContext context) async {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    final choice = await showModalBottomSheet<InvoiceType>(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    InvoiceActivityReminderCopy.proceedLabel,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  verticalMarginSmall,
                  const Divider(),
                  verticalMarginMedium,
                  PdfExportOptionTile(
                    icon: Icons.trending_up_rounded,
                    title: InvoiceActivityReminderCopy.addSalesLabel,
                    color: primary,
                    onTap: () =>
                        Navigator.pop(sheetContext, InvoiceType.sales),
                  ),
                  verticalMarginLarge,
                  PdfExportOptionTile(
                    icon: Icons.shopping_cart_outlined,
                    title: InvoiceActivityReminderCopy.addPurchaseLabel,
                    color: primary,
                    onTap: () =>
                        Navigator.pop(sheetContext, InvoiceType.purchase),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (choice == null || !context.mounted) return;

    await context.router.push(
      QuickAddItemsRoute(
        invoiceType: choice,
        fromQuickSales: true,
      ),
    );
  }
}

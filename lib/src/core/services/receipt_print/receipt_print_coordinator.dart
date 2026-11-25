import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/services/receipt_print/bluetooth_printer_picker_sheet.dart';
import 'package:hotel/src/core/services/receipt_print/bluetooth_printer_settings.dart';
import 'package:hotel/src/core/services/receipt_print/bluetooth_receipt_printer.dart';
import 'package:hotel/src/core/widget/action_bottom_sheet.dart';
import 'package:hotel/src/core/widget/estimate_invoice_sheet.dart';

class ReceiptPrintCoordinator {
  ReceiptPrintCoordinator._();

  static Future<void> printReceipt(
    BuildContext context, {
    required EstimateInvoiceViewData data,
    String heading = 'RECEIPT',
    bool showEstimateDisclaimer = false,
    bool closeCurrentRouteFirst = false,
  }) async {
    if (!await gateInvoiceExport(context)) return;
    if (!context.mounted) return;

    final saved = await BluetoothPrinterSettings.load();
    if (!context.mounted) return;
    final l10n = context.l10n;

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    Future<void> runBluetooth(SavedBluetoothPrinter printer) async {
      if (!context.mounted) return;
      AppLoadingOverlay.of(context).show();
      try {
        final ready = await BluetoothReceiptPrinter.connect(printer.mac);
        if (!ready) {
          throw StateError(l10n.btPrinterConnectFailed);
        }
        await BluetoothReceiptPrinter.printReceipt(
          data: data,
          printer: printer,
          heading: heading,
          showEstimateDisclaimer: showEstimateDisclaimer,
        );
        if (context.mounted) {
          context.showKiiSnackBarSuccess(l10n.btPrinterPrintSent);
        }
      } catch (e) {
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.btPrinterPrintFailed)),
        );
      } finally {
        if (context.mounted) AppLoadingOverlay.of(context).hide();
      }
    }

    Future<void> runSystem() async {
      try {
        await EstimateInvoicePdf.print(
          data,
          heading: heading,
          showEstimateDisclaimer: showEstimateDisclaimer,
        );
      } catch (e) {
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.btPrinterSystemFailed)),
        );
      }
    }

    ActionBottomSheet.show(
      context,
      title: context.l10n.btPrinterPrintTitle,
      items: [
        if (BluetoothReceiptPrinter.isSupported) ...[
          ActionSheetItem(
            icon: Icons.bluetooth_searching,
            title: saved == null
                ? context.l10n.btPrinterBluetooth
                : context.l10n.btPrinterPrintOn(saved.name),
            onTap: () async {
              var printer = saved;
              printer ??= await BluetoothPrinterPickerSheet.show(context);
              if (printer == null || !context.mounted) return;
              await runBluetooth(printer);
            },
          ),
          if (saved != null)
            ActionSheetItem(
              icon: Icons.print_outlined,
              title: context.l10n.btPrinterChooseAnother,
              onTap: () async {
                final printer = await BluetoothPrinterPickerSheet.show(context);
                if (printer == null || !context.mounted) return;
                await runBluetooth(printer);
              },
            ),
        ],
        ActionSheetItem(
          icon: Icons.picture_as_pdf_outlined,
          title: Platform.isIOS
              ? context.l10n.btPrinterAirPrint
              : context.l10n.btPrinterSystem,
          onTap: () async {
            if (closeCurrentRouteFirst && navigator.canPop()) {
              navigator.pop();
            }
            await runSystem();
          },
        ),
      ],
    );
  }
}

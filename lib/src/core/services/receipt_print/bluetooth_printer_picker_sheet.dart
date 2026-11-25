import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/services/receipt_print/bluetooth_printer_settings.dart';
import 'package:hotel/src/core/services/receipt_print/bluetooth_receipt_printer.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothPrinterPickerSheet extends StatefulWidget {
  const BluetoothPrinterPickerSheet({
    super.key,
    this.allowTestPrint = true,
  });

  final bool allowTestPrint;

  static Future<SavedBluetoothPrinter?> show(
    BuildContext context, {
    bool allowTestPrint = true,
  }) async {
    // Ask before this sheet opens. A second sheet on top of Transaction
    // Details swallows the system permission dialog.
    await BluetoothReceiptPrinter.requestPermissions();
    if (!context.mounted) return null;
    return showModalBottomSheet<SavedBluetoothPrinter>(
      context: context,
      useRootNavigator: true,
      useSafeArea: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
          child: DecoratedBox(
            decoration: AppBottomSheetTheme.topSheetDecoration(ctx),
            child: BluetoothPrinterPickerSheet(
              allowTestPrint: allowTestPrint,
            ),
          ),
        );
      },
    );
  }

  @override
  State<BluetoothPrinterPickerSheet> createState() =>
      _BluetoothPrinterPickerSheetState();
}

class _BluetoothPrinterPickerSheetState
    extends State<BluetoothPrinterPickerSheet> {
  bool _loading = true;
  bool _busy = false;
  bool _permissionBlocked = false;
  String? _error;
  int _paperMm = 80;
  String? _selectedMac;
  List<BluetoothPrinterDevice> _devices = const [];
  SavedBluetoothPrinter? _saved;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final saved = await BluetoothPrinterSettings.load();
    if (!mounted) return;
    setState(() {
      _saved = saved;
      _paperMm = saved?.paperMm ?? 80;
      _selectedMac = saved?.mac;
    });
    await _refresh();
  }

  Future<void> _refresh() async {
    setState(() {
      _loading = true;
      _error = null;
      _permissionBlocked = false;
    });
    final allowed = await BluetoothReceiptPrinter.requestPermissions();
    if (!mounted) return;
    if (!allowed) {
      setState(() {
        _loading = false;
        _permissionBlocked = true;
        _error = context.l10n.btPrinterPermissionDenied;
      });
      return;
    }
    final on = await BluetoothReceiptPrinter.isBluetoothOn();
    if (!mounted) return;
    if (!on) {
      setState(() {
        _loading = false;
        _error = context.l10n.btPrinterBluetoothOff;
      });
      return;
    }
    final devices = await BluetoothReceiptPrinter.pairedPrinters();
    if (!mounted) return;
    setState(() {
      _devices = devices;
      _loading = false;
      if (_selectedMac == null && devices.isNotEmpty) {
        _selectedMac = devices.first.mac;
      }
    });
  }

  BluetoothPrinterDevice? get _selected {
    for (final d in _devices) {
      if (d.mac == _selectedMac) return d;
    }
    return null;
  }

  bool get _canUsePrinter =>
      !_busy && !_loading && _error == null && _selected != null;

  Future<void> _useSelected({bool test = false}) async {
    final device = _selected;
    if (device == null) {
      context.showKiiSnackBarWarning(context.l10n.btPrinterSelectOne);
      return;
    }
    setState(() => _busy = true);
    final printer = SavedBluetoothPrinter(
      name: device.name,
      mac: device.mac,
      paperMm: _paperMm,
    );
    final connected = await BluetoothReceiptPrinter.connect(printer.mac);
    if (!mounted) return;
    if (!connected) {
      setState(() => _busy = false);
      context.showKiiSnackBarError(context.l10n.btPrinterConnectFailed);
      return;
    }
    await BluetoothPrinterSettings.save(printer);
    if (test) {
      try {
        await BluetoothReceiptPrinter.printTestPage(printer);
        if (mounted) {
          context.showKiiSnackBarSuccess(context.l10n.btPrinterTestSent);
        }
      } catch (_) {
        if (mounted) {
          context.showKiiSnackBarError(context.l10n.btPrinterPrintFailed);
        }
      }
      if (mounted) setState(() => _busy = false);
      return;
    }
    if (mounted) Navigator.of(context).pop(printer);
  }

  Future<void> _requestAccess() async {
    if (await BluetoothReceiptPrinter.permissionNeedsSettings()) {
      await openAppSettings();
      return;
    }
    await _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final listMaxHeight = MediaQuery.sizeOf(context).height * 0.28;
    final showPrinterActions =
        !_loading && _error == null && _devices.isNotEmpty;

    final maxHeight = MediaQuery.sizeOf(context).height * 0.92;

    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 12, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: AppBottomSheetTheme.dragHandle(context)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.btPrinterTitle,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                    ),
                    const AppBottomSheetCloseButton(),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          Flexible(
            fit: FlexFit.loose,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 16 + bottomInset),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    Platform.isIOS
                        ? l10n.btPrinterIosHint
                        : l10n.btPrinterPairHint,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _PaperWidthToggle(
                    selected: _paperMm,
                    label58: l10n.btPrinterPaper58,
                    label80: l10n.btPrinterPaper80,
                    onChanged: (mm) => setState(() => _paperMm = mm),
                  ),
                  const SizedBox(height: 20),
                  if (_loading)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 28),
                      child: Center(
                        child: SizedBox(
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(strokeWidth: 2.5),
                        ),
                      ),
                    )
                  else if (_permissionBlocked)
                    _StatusBlock(
                      icon: Icons.bluetooth_rounded,
                      message: _error!,
                      primaryLabel: l10n.retry,
                      onPrimary: _requestAccess,
                      onOpenSettings: openAppSettings,
                    )
                  else if (_error != null || _devices.isEmpty)
                    _StatusBlock(
                      icon: _error != null
                          ? Icons.bluetooth_disabled_rounded
                          : Icons.print_disabled_outlined,
                      message: _error ?? l10n.btPrinterNonePaired,
                      primaryLabel: l10n.retry,
                      onPrimary: _refresh,
                      onOpenSettings: openAppSettings,
                    )
                  else
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: listMaxHeight),
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: _devices.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, i) {
                          final d = _devices[i];
                          final selected = d.mac == _selectedMac;
                          return ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              selected ? Icons.print : Icons.print_outlined,
                              color: selected
                                  ? scheme.primary
                                  : scheme.onSurfaceVariant,
                            ),
                            title: Text(
                              d.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              d.mac,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: selected
                                ? Icon(Icons.check_circle,
                                    color: scheme.primary)
                                : null,
                            onTap: () => setState(() => _selectedMac = d.mac),
                          );
                        },
                      ),
                    ),
                  if (showPrinterActions) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        if (widget.allowTestPrint) ...[
                          Expanded(
                            child: CustomButtonWidget.outlined(
                              title: l10n.btPrinterTest,
                              width: double.infinity,
                              height: 44,
                              borderRadius: 8,
                              elevation: 0,
                              useFixedSizes: true,
                              onPressed: _canUsePrinter
                                  ? () => _useSelected(test: true)
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                        Expanded(
                          child: CustomButtonWidget(
                            title: l10n.btPrinterUse,
                            width: double.infinity,
                            height: 44,
                            borderRadius: 8,
                            elevation: 0,
                            useFixedSizes: true,
                            onPressed:
                                _canUsePrinter ? () => _useSelected() : null,
                          ),
                        ),
                      ],
                    ),
                    if (_saved != null)
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: _busy
                              ? null
                              : () async {
                                  await BluetoothPrinterSettings.clear();
                                  await BluetoothReceiptPrinter.disconnect();
                                  if (!context.mounted) return;
                                  Navigator.pop(context);
                                },
                          child: Text(l10n.btPrinterForget),
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBlock extends StatelessWidget {
  const _StatusBlock({
    required this.icon,
    required this.message,
    required this.primaryLabel,
    required this.onPrimary,
    required this.onOpenSettings,
  });

  final IconData icon;
  final String message;
  final String primaryLabel;
  final VoidCallback onPrimary;
  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        Center(child: Icon(icon, size: 28, color: scheme.primary)),
        const SizedBox(height: 8),
        Text(
          message,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: scheme.onSurface,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomButtonWidget(
                title: primaryLabel,
                width: double.infinity,
                height: 44,
                borderRadius: 8,
                elevation: 0,
                useFixedSizes: true,
                onPressed: onPrimary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButtonWidget.outlined(
                title: context.l10n.btPrinterOpenSettings,
                width: double.infinity,
                height: 44,
                borderRadius: 8,
                useFixedSizes: true,
                onPressed: onOpenSettings,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PaperWidthToggle extends StatelessWidget {
  const _PaperWidthToggle({
    required this.selected,
    required this.label58,
    required this.label80,
    required this.onChanged,
  });

  final int selected;
  final String label58;
  final String label80;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    const radius = 8.0;
    final borderColor = scheme.outlineVariant.withValues(alpha: 0.75);

    Widget half(int value, String label) {
      final on = selected == value;
      return Expanded(
        child: Material(
          color: on
              ? scheme.primaryContainer.withValues(alpha: 0.7)
              : scheme.surface,
          child: InkWell(
            onTap: () => onChanged(value),
            child: SizedBox(
              height: 44,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (on) ...[
                    Icon(Icons.check_rounded, size: 16, color: scheme.primary),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    label,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: on ? scheme.onPrimaryContainer : scheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Row(
          children: [
            half(58, label58),
            Container(width: 1, height: 44, color: borderColor),
            half(80, label80),
          ],
        ),
      ),
    );
  }
}

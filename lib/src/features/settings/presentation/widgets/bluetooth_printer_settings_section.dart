import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/services/receipt_print/bluetooth_printer_picker_sheet.dart';
import 'package:hotel/src/core/services/receipt_print/bluetooth_printer_settings.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/more_settings_widgets.dart';

class BluetoothPrinterSettingsSection extends StatefulWidget {
  const BluetoothPrinterSettingsSection({super.key, this.embedded = false});

  final bool embedded;

  @override
  State<BluetoothPrinterSettingsSection> createState() =>
      _BluetoothPrinterSettingsSectionState();
}

class _BluetoothPrinterSettingsSectionState
    extends State<BluetoothPrinterSettingsSection> {
  SavedBluetoothPrinter? _printer;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final printer = await BluetoothPrinterSettings.load();
    if (!mounted) return;
    setState(() {
      _printer = printer;
      _loading = false;
    });
  }

  Future<void> _openPicker() async {
    await BluetoothPrinterPickerSheet.show(context);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10n = context.l10n;
    final subtitle = _loading
        ? l10n.loading
        : _printer == null
            ? l10n.btPrinterNotConfigured
            : '${_printer!.name} · ${_printer!.paperMm}mm';

    final tile = ListTile(
      contentPadding: MoreSettingsLayout.tilePadding(context),
      leading: const MoreIconBox(icon: Icons.print_outlined),
      title: Text(
        l10n.btPrinterSettingsTitle,
        style: MoreSettingsLayout.tileTitle(theme),
      ),
      subtitle: Text(
        subtitle,
        style: MoreSettingsLayout.tileSubtitle(theme),
      ),
      trailing: Icon(
        Icons.chevron_right,
        size: MoreSettingsLayout.chevronSize(context),
        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
      ),
      onTap: _openPicker,
    );

    if (widget.embedded) return tile;
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: tile,
    );
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class SavedBluetoothPrinter {
  const SavedBluetoothPrinter({
    required this.name,
    required this.mac,
    required this.paperMm,
  });

  final String name;
  final String mac;
  final int paperMm;

  bool get is80mm => paperMm != 58;
}

class BluetoothPrinterSettings {
  BluetoothPrinterSettings._();

  static const _nameKey = 'bt_receipt_printer_name';
  static const _macKey = 'bt_receipt_printer_mac';
  static const _paperKey = 'bt_receipt_printer_paper_mm';

  static Future<SavedBluetoothPrinter?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final mac = prefs.getString(_macKey)?.trim() ?? '';
    if (mac.isEmpty) return null;
    final paper = prefs.getInt(_paperKey) ?? 80;
    return SavedBluetoothPrinter(
      name: prefs.getString(_nameKey)?.trim().isNotEmpty == true
          ? prefs.getString(_nameKey)!.trim()
          : mac,
      mac: mac,
      paperMm: paper == 58 ? 58 : 80,
    );
  }

  static Future<void> save(SavedBluetoothPrinter printer) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, printer.name);
    await prefs.setString(_macKey, printer.mac);
    await prefs.setInt(_paperKey, printer.paperMm == 58 ? 58 : 80);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_nameKey);
    await prefs.remove(_macKey);
    await prefs.remove(_paperKey);
  }
}

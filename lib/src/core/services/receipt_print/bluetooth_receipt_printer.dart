import 'dart:io';
import 'dart:math' as math;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:hotel/src/core/services/receipt_print/bluetooth_printer_settings.dart';
import 'package:hotel/src/core/widget/estimate_invoice_sheet.dart';
import 'package:image/image.dart' as img;
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:printing/printing.dart';

class BluetoothPrinterDevice {
  const BluetoothPrinterDevice({required this.name, required this.mac});

  final String name;
  final String mac;
}

class BluetoothReceiptPrinter {
  BluetoothReceiptPrinter._();

  static const int _chunk = 900;

  static bool get isSupported => Platform.isAndroid || Platform.isIOS;

  static Future<bool> requestPermissions() async {
    if (Platform.isIOS) return _requestIosBluetooth();
    if (!Platform.isAndroid) return false;
    final sdk = (await DeviceInfoPlugin().androidInfo).version.sdkInt;
    final permissions = sdk >= 31
        ? <Permission>[Permission.bluetoothScan, Permission.bluetoothConnect]
        : <Permission>[Permission.bluetooth, Permission.locationWhenInUse];
    var statuses = <Permission, PermissionStatus>{
      for (final permission in permissions) permission: await permission.status,
    };
    final pending = permissions.where((permission) {
      final status = statuses[permission]!;
      return !status.isGranted &&
          !status.isLimited &&
          !status.isPermanentlyDenied &&
          !status.isRestricted;
    }).toList();
    if (pending.isNotEmpty) {
      statuses = {...statuses, ...await pending.request()};
    }
    return statuses.values
        .every((status) => status.isGranted || status.isLimited);
  }

  /// iOS reports "not determined" as denied. [Permission.bluetooth.request]
  /// creates a CBCentralManager, which presents the system Bluetooth alert.
  /// That callback can return before the user taps, so this waits until the
  /// choice is granted or permanently denied. The printer sheet stays closed
  /// until then, or it covers the alert.
  static Future<bool> _requestIosBluetooth() async {
    var status = await Permission.bluetooth.status;
    if (status.isGranted || status.isLimited) return true;
    if (status.isPermanentlyDenied || status.isRestricted) return false;

    final started = DateTime.now();
    status = await Permission.bluetooth.request();
    if (status.isGranted || status.isLimited) return true;
    if (status.isPermanentlyDenied || status.isRestricted) return false;

    if (DateTime.now().difference(started) <
        const Duration(milliseconds: 400)) {
      try {
        await PrintBluetoothThermal.bluetoothEnabled;
      } catch (_) {}
    }

    final deadline = DateTime.now().add(const Duration(seconds: 45));
    while (DateTime.now().isBefore(deadline)) {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      status = await Permission.bluetooth.status;
      if (status.isGranted || status.isLimited) return true;
      if (status.isPermanentlyDenied || status.isRestricted) return false;
    }
    return false;
  }

  /// True when the system will not show the permission dialog again.
  static Future<bool> permissionNeedsSettings() async {
    final permissions = Platform.isIOS
        ? <Permission>[Permission.bluetooth]
        : (Platform.isAndroid &&
                (await DeviceInfoPlugin().androidInfo).version.sdkInt >= 31)
            ? <Permission>[
                Permission.bluetoothScan,
                Permission.bluetoothConnect
              ]
            : <Permission>[Permission.bluetooth, Permission.locationWhenInUse];
    for (final permission in permissions) {
      final status = await permission.status;
      if (status.isPermanentlyDenied || status.isRestricted) return true;
    }
    return false;
  }

  static Future<bool> isBluetoothOn() async {
    try {
      return await PrintBluetoothThermal.bluetoothEnabled;
    } catch (_) {
      return false;
    }
  }

  static Future<List<BluetoothPrinterDevice>> pairedPrinters() async {
    try {
      final raw = await PrintBluetoothThermal.pairedBluetooths;
      final out = <BluetoothPrinterDevice>[];
      for (final p in raw) {
        final mac = p.macAdress.trim();
        if (mac.isEmpty) continue;
        final name = p.name.trim().isEmpty ? mac : p.name.trim();
        out.add(BluetoothPrinterDevice(name: name, mac: mac));
      }
      return out;
    } catch (_) {
      return const [];
    }
  }

  static Future<bool> isConnected() async {
    try {
      return await PrintBluetoothThermal.connectionStatus;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> connect(String mac) async {
    final address = mac.trim();
    if (address.isEmpty) return false;
    try {
      if (await isConnected()) {
        await PrintBluetoothThermal.disconnect;
        await Future<void>.delayed(const Duration(milliseconds: 250));
      }
      return await PrintBluetoothThermal.connect(macPrinterAddress: address);
    } catch (_) {
      return false;
    }
  }

  static Future<void> disconnect() async {
    try {
      await PrintBluetoothThermal.disconnect;
    } catch (_) {}
  }

  static PdfPageFormat thermalPageFormat(int paperMm, {int extraLines = 0}) {
    final mm = paperMm == 58 ? 58.0 : 80.0;
    final heightPt = (280 + extraLines * 22).clamp(320, 2800).toDouble();
    return PdfPageFormat(
      mm * PdfPageFormat.mm,
      heightPt,
      marginAll: 3 * PdfPageFormat.mm,
    );
  }

  static int _dotsWidth(int paperMm) => paperMm == 58 ? 384 : 576;

  static Future<void> printReceipt({
    required EstimateInvoiceViewData data,
    required SavedBluetoothPrinter printer,
    String heading = 'RECEIPT',
    bool showEstimateDisclaimer = false,
  }) async {
    final extraLines = data.lines.length + data.returnedLines.length;
    final pdfBytes = await EstimateInvoicePdf.buildPdfBytes(
      data,
      pageFormat: thermalPageFormat(printer.paperMm, extraLines: extraLines),
      heading: heading,
      showEstimateDisclaimer: showEstimateDisclaimer,
    );
    await printPdfBytes(pdfBytes, paperMm: printer.paperMm);
  }

  static Future<void> printPdfBytes(
    Uint8List pdfBytes, {
    required int paperMm,
  }) async {
    final pngPages = <Uint8List>[];
    await for (final page in Printing.raster(pdfBytes, dpi: 203)) {
      pngPages.add(await page.toPng());
    }
    if (pngPages.isEmpty) {
      throw StateError('Could not render receipt for the printer');
    }

    final payload = <int>[
      0x1B, 0x40, // init
      0x1B, 0x61, 0x01, // center
    ];
    for (final png in pngPages) {
      payload.addAll(_rasterPng(png, maxWidth: _dotsWidth(paperMm)));
    }
    payload.addAll(const [
      0x1B, 0x64, 0x04, // feed 4 lines
      0x1D, 0x56, 0x00, // full cut (common)
      0x1D, 0x56, 0x41, 0x10, // partial cut (Epson-style)
    ]);

    final ok = await _writeChunks(payload);
    if (!ok) {
      throw StateError('Printer did not accept the receipt data');
    }
  }

  static Future<void> printTestPage(SavedBluetoothPrinter printer) async {
    final ticket =
        'BillMate\n${printer.name}\n${printer.paperMm}mm\nBluetooth printer OK\n----------------\nThank you\n\n\n';
    final bytes = <int>[
      0x1B,
      0x40,
      0x1B,
      0x61,
      0x01,
      ...ticket.codeUnits,
      0x1B,
      0x64,
      0x03,
      0x1D,
      0x56,
      0x00,
    ];
    final ok = await _writeChunks(bytes);
    if (!ok) {
      throw StateError('Test print failed');
    }
  }

  static Future<bool> _writeChunks(List<int> bytes) async {
    for (var i = 0; i < bytes.length; i += _chunk) {
      final end = math.min(i + _chunk, bytes.length);
      final slice = Uint8List.fromList(bytes.sublist(i, end));
      bool sent = false;
      try {
        sent = await PrintBluetoothThermal.writeBytes(List<int>.from(slice));
      } catch (e) {
        debugPrint('bluetooth write failed: $e');
        return false;
      }
      if (!sent) return false;
      await Future<void>.delayed(const Duration(milliseconds: 20));
    }
    return true;
  }

  static List<int> _rasterPng(Uint8List png, {required int maxWidth}) {
    final decoded = img.decodeImage(png);
    if (decoded == null) {
      throw StateError('Could not decode receipt image');
    }
    var work = decoded;
    if (work.width > maxWidth) {
      work = img.copyResize(
        work,
        width: maxWidth,
        interpolation: img.Interpolation.linear,
      );
    } else if (work.width < maxWidth) {
      work = img.copyResize(
        work,
        width: maxWidth,
        interpolation: img.Interpolation.linear,
      );
    }

    work = _trimTrailingWhitespace(work);

    final w = work.width;
    final h = work.height;
    final widthBytes = (w + 7) >> 3;
    final out = <int>[];
    const slice = 255;
    for (var y0 = 0; y0 < h; y0 += slice) {
      final sliceH = math.min(slice, h - y0);
      out.addAll([
        0x1D,
        0x76,
        0x30,
        0x00,
        widthBytes & 0xFF,
        (widthBytes >> 8) & 0xFF,
        sliceH & 0xFF,
        (sliceH >> 8) & 0xFF,
      ]);
      for (var y = 0; y < sliceH; y++) {
        for (var xb = 0; xb < widthBytes; xb++) {
          var b = 0;
          for (var bit = 0; bit < 8; bit++) {
            final x = xb * 8 + bit;
            if (x >= w) continue;
            final p = work.getPixel(x, y0 + y);
            final lum = p.r * 0.299 + p.g * 0.587 + p.b * 0.114;
            if (lum < 168) b |= 0x80 >> bit;
          }
          out.add(b);
        }
      }
    }
    return out;
  }

  static img.Image _trimTrailingWhitespace(img.Image work) {
    var lastInk = 0;
    for (var y = work.height - 1; y >= 0; y--) {
      var ink = false;
      for (var x = 0; x < work.width; x++) {
        final p = work.getPixel(x, y);
        final lum = p.r * 0.299 + p.g * 0.587 + p.b * 0.114;
        if (lum < 245) {
          ink = true;
          break;
        }
      }
      if (ink) {
        lastInk = y;
        break;
      }
    }
    final croppedH = math.min(work.height, lastInk + 12);
    if (croppedH >= work.height - 1) return work;
    return img.copyCrop(
      work,
      x: 0,
      y: 0,
      width: work.width,
      height: croppedH,
    );
  }
}

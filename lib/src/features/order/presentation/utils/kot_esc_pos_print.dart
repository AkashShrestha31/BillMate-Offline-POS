import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotel/src/features/order/data/models/response/order_model.dart';

/// Default LAN loopback (desktop / iOS simulator).
const String kotThermalPrinterHost = '127.0.0.1';
const int kotThermalPrinterPort = 9100;

/// Dotenv keys (optional): `KOT_THERMAL_HOST`, `KOT_THERMAL_PORT`.

/// escpresso uses ~48 cpl on 80mm; keep rows shorter than that.
const int _paperChars = 32;

String? _envTrim(String key) {
  try {
    final v = dotenv.env[key]?.trim();
    if (v == null || v.isEmpty) return null;
    return v;
  } catch (_) {
    return null;
  }
}

List<String> _effectiveHosts() {
  final fromEnv = _envTrim('KOT_THERMAL_HOST');
  if (fromEnv != null) return [fromEnv];
  if (Platform.isAndroid) {
    return [kotThermalPrinterHost, '10.0.2.2'];
  }
  return [kotThermalPrinterHost];
}

int _effectivePort() {
  final raw = _envTrim('KOT_THERMAL_PORT');
  final p = int.tryParse(raw ?? '');
  if (p != null && p > 0 && p < 65536) return p;
  return kotThermalPrinterPort;
}

String _qtyEsc(double? q) {
  if (q == null) return '0';
  if (q == q.roundToDouble()) return '${q.round()}';
  return q.toStringAsFixed(1);
}

/// escpresso filters “binary garbage”; UTF‑8 multi‑byte + long punctuation can confuse it — keep CP437‑safe ASCII for thermal.
String _thermalSafe(String s) {
  final buf = StringBuffer();
  for (final r in s.runes) {
    if (r >= 0x20 && r <= 0x7E) {
      buf.writeCharCode(r);
    } else if (r == 0x0A || r == 0x0D) {
      // skip — we add LF ourselves (avoid accidental FF-style controls)
    } else {
      buf.write('?');
    }
  }
  return buf.toString();
}

String _threeCol(String left, String mid, String right, {int leftW = 3, int rightW = 5}) {
  final midMax = _paperChars - leftW - 1 - rightW - 1;
  final l = left.length > leftW ? left.substring(0, leftW) : left.padRight(leftW);
  final r = right.padLeft(rightW);
  final m = mid.length > midMax ? mid.substring(0, midMax) : mid.padRight(midMax);
  return '$l $m $r';
}

/// Minimal ESC/POS tuned for **escpresso** + real Epson‑like printers.
/// Avoids GS ! size (problematic on some emulators); uses ESC E bold; uses ESC i cut like escpresso README tests.
class _EscPosBuffer {
  final List<int> _b = [];

  void _raw(List<int> bytes) => _b.addAll(bytes);

  void init() => _raw([0x1B, 0x40]);

  void alignLeft() => _raw([0x1B, 0x61, 0]);

  void alignCenter() => _raw([0x1B, 0x61, 1]);

  void bold(bool on) => _raw([0x1B, 0x45, on ? 1 : 0]);

  /// LF only — escpresso documents FF (0x0C) clears buffer; never emit raw 0x0C from UTF‑8.
  void textLine(String asciiLine) {
    _b.addAll(latin1.encode(asciiLine));
    _b.add(0x0A);
  }

  void feed([int n = 1]) {
    for (var i = 0; i < n; i++) {
      _b.add(0x0A);
    }
  }

  /// Short separator — long runs of `-` can trip escpresso “binary garbage” heuristics.
  void separator() => textLine(List.filled(24, '-').join());

  /// README / Epson examples use ESC i for partial cut (escpresso implements it).
  void cutPartial() => _raw([0x1B, 0x69]);

  List<int> build() => List<int>.from(_b);
}

/// Builds ESC/POS bytes for one KOT ticket.
List<int> buildKotEscPosBytes({
  required int kotNumber,
  required String orderTypeLabel,
  required String tableLabel,
  required String orderBy,
  required String orderAt,
  required String status,
  required List<OrderItemModel> mergedLines,
  required String printedBy,
  required String printedAt,
}) {
  final out = _EscPosBuffer();
  out.init();

  out.alignCenter();
  out.bold(true);
  out.textLine(_thermalSafe('KOT $kotNumber'));
  out.bold(false);
  out.alignLeft();
  out.feed(1);

  out.textLine(_thermalSafe('Type: ${orderTypeLabel.trim()}'));
  out.textLine(_thermalSafe('Table: ${tableLabel.trim()}'));
  out.textLine(_thermalSafe('Order By: ${orderBy.trim()}'));
  out.textLine(_thermalSafe('Order At: ${orderAt.trim()}'));
  out.textLine(_thermalSafe('Status: ${status.trim()}'));
  out.separator();

  out.bold(true);
  out.textLine(_thermalSafe(_threeCol('SN', 'Dishes', 'QTY')));
  out.bold(false);
  out.separator();

  for (var i = 0; i < mergedLines.length; i++) {
    final line = mergedLines[i];
    out.textLine(
      _thermalSafe(_threeCol('${i + 1}', line.item ?? '-', _qtyEsc(line.quantity))),
    );
  }

  out.separator();
  final totalQty = mergedLines.fold<double>(0, (a, b) => a + (b.quantity ?? 0));
  out.bold(true);
  out.textLine(
    _thermalSafe('Total (Dishes/QTY): ${mergedLines.length}/${_qtyEsc(totalQty)}'),
  );
  out.bold(false);
  out.feed(1);
  out.textLine(_thermalSafe('Printed By: ${printedBy.trim()}'));
  out.textLine(_thermalSafe('Printed At: ${printedAt.trim()}'));
  out.feed(1);

  out.alignCenter();
  out.bold(true);
  out.textLine(_thermalSafe('Thank You!'));
  out.bold(false);
  out.alignLeft();
  out.feed(2);
  out.cutPartial();

  return out.build();
}

Future<void> _sendOnce(
  List<int> bytes, {
  required String host,
  required int port,
  required Duration timeout,
}) async {
  if (bytes.isEmpty) {
    throw StateError('KOT ESC/POS payload is empty — nothing to print.');
  }

  final socket = await Socket.connect(host, port, timeout: timeout);
  try {
    try {
      socket.setOption(SocketOption.tcpNoDelay, true);
    } catch (_) {}
    final payload = Uint8List.fromList(bytes);
    if (kDebugMode) {
      debugPrint('[kot_print] $host:$port ← ${payload.length} bytes');
      final head = payload.length > 48 ? payload.sublist(0, 48) : payload;
      debugPrint('[kot_print] head hex: ${head.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ')}');
    }
    socket.add(payload);
    await socket.flush();
    await Future<void>.delayed(const Duration(milliseconds: 350));
  } finally {
    await socket.close();
  }
}

/// Sends ESC/POS [bytes] over TCP. Tries each host from [_effectiveHosts] until one succeeds.
Future<void> sendEscPosToSocket(
  List<int> bytes, {
  Duration timeout = const Duration(seconds: 12),
}) async {
  final port = _effectivePort();
  final hosts = _effectiveHosts();
  Object? lastError;

  for (final host in hosts) {
    try {
      await _sendOnce(bytes, host: host, port: port, timeout: timeout);
      return;
    } catch (e) {
      lastError = e;
    }
  }

  final tried = hosts.join(', ');
  throw Exception(
    'Could not connect to thermal printer (tried $tried port $port).\n'
    '${lastError ?? ''}\n'
    '• Android emulator + listener on your PC: add to .env → KOT_THERMAL_HOST=10.0.2.2\n'
    '• Physical phone + Wi‑Fi printer: KOT_THERMAL_HOST=<printer IP> (e.g. 192.168.1.x)\n'
    '• Same machine only (desktop): ensure something listens on port $port (e.g. nc -lk $port)',
  );
}

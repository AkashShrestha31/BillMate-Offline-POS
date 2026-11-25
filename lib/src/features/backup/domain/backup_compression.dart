import 'dart:convert';
import 'dart:io';

/// Gzip helpers for backup payloads (JSON text ↔ compressed bytes).
abstract final class BackupCompression {
  static const tableFileSuffix = '.json.gz';

  static List<int> encodeJson(String json) => gzip.encode(utf8.encode(json));

  static String decodeBytes(List<int> bytes) {
    if (_isGzip(bytes)) {
      return utf8.decode(gzip.decode(bytes));
    }
    return utf8.decode(bytes);
  }

  static bool _isGzip(List<int> bytes) =>
      bytes.length >= 2 && bytes[0] == 0x1f && bytes[1] == 0x8b;
}

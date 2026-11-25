import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

/// Encodes / decodes item photos for local SQLite ([Item.image]).
class ItemImageHelper {
  ItemImageHelper._();

  static const int maxStoredBytes = 5 * 1024 * 1024;

  /// Reads [path] and returns `data:<mime>;base64,...` for DB storage.
  static Future<String?> encodeFileForStorage(String? path) async {
    if (path == null || path.trim().isEmpty) return null;
    final trimmed = path.trim();
    if (isStoredImageValue(trimmed)) return trimmed;

    try {
      final file = File(trimmed);
      if (!await file.exists()) return null;
      final len = await file.length();
      if (len > maxStoredBytes) return null;
      final bytes = await file.readAsBytes();
      final mime = _mimeFromPath(trimmed);
      return 'data:$mime;base64,${base64Encode(bytes)}';
    } catch (_) {
      return null;
    }
  }

  static bool isStoredImageValue(String value) {
    final t = value.trim();
    return t.startsWith('data:image/') && t.contains(';base64,');
  }

  static bool isLocalFilePath(String value) {
    final t = value.trim();
    return t.startsWith('/') ||
        t.startsWith('file://') ||
        (t.contains('/data/user/') && !t.startsWith('http'));
  }

  static bool isNetworkUrl(String value) {
    final lower = value.trim().toLowerCase();
    return lower.startsWith('http://') || lower.startsWith('https://');
  }

  static String? _mimeFromPath(String path) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.gif')) return 'image/gif';
    if (lower.endsWith('.webp')) return 'image/webp';
    return 'image/jpeg';
  }

  static Uint8List? decodeToBytes(String? raw) {
    final t = raw?.trim();
    if (t == null || t.isEmpty) return null;

    if (isStoredImageValue(t)) {
      final marker = ';base64,';
      final i = t.indexOf(marker);
      if (i < 0) return null;
      try {
        return base64Decode(t.substring(i + marker.length));
      } catch (_) {
        return null;
      }
    }

    if (isLocalFilePath(t)) {
      try {
        final path = t.startsWith('file://') ? t.substring(7) : t;
        final file = File(path);
        if (file.existsSync()) return file.readAsBytesSync();
      } catch (_) {}
      return null;
    }

    return null;
  }

  static String? filePathIfLocal(String? raw) {
    final t = raw?.trim();
    if (t == null || t.isEmpty || isStoredImageValue(t) || isNetworkUrl(t)) {
      return null;
    }
    if (!isLocalFilePath(t)) return null;
    return t.startsWith('file://') ? t.substring(7) : t;
  }

  /// Builds an image widget from DB value: data-URI base64, local path, or http(s).
  static Widget buildImage(
    String? raw, {
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
  }) {
    final t = raw?.trim();
    if (t == null || t.isEmpty) {
      return const SizedBox.shrink();
    }

    final bytes = decodeToBytes(t);
    if (bytes != null && bytes.isNotEmpty) {
      return Image.memory(
        bytes,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: errorBuilder ?? (_, __, ___) => const SizedBox.shrink(),
      );
    }

    final localPath = filePathIfLocal(t);
    if (localPath != null) {
      return Image.file(
        File(localPath),
        fit: fit,
        width: width,
        height: height,
        errorBuilder: errorBuilder ?? (_, __, ___) => const SizedBox.shrink(),
      );
    }

    if (isNetworkUrl(t)) {
      return Image.network(
        t,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: errorBuilder ?? (_, __, ___) => const SizedBox.shrink(),
      );
    }

    return const SizedBox.shrink();
  }

  static bool hasDisplayableImage(String? raw) {
    final t = raw?.trim();
    if (t == null || t.isEmpty) return false;
    if (isStoredImageValue(t) || isNetworkUrl(t)) return true;
    final path = filePathIfLocal(t);
    if (path != null) return File(path).existsSync();
    return false;
  }

  /// Resolves a stored image value to an [ImageProvider] for [CircleAvatar].
  static ImageProvider? imageProvider(String? raw) {
    final t = raw?.trim();
    if (t == null || t.isEmpty) return null;

    final bytes = decodeToBytes(t);
    if (bytes != null && bytes.isNotEmpty) {
      return MemoryImage(bytes);
    }

    final localPath = filePathIfLocal(t);
    if (localPath != null && File(localPath).existsSync()) {
      return FileImage(File(localPath));
    }

    if (isNetworkUrl(t)) {
      return NetworkImage(t);
    }

    return null;
  }
}

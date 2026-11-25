import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Resolves a barcode to a display name using Open Food / Beauty / Product Facts APIs.
class OpenFactsBarcodeLookup {
  OpenFactsBarcodeLookup({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  static const _userAgent = 'HotelApp/1.0 (Flutter)';

  static const _bases = <String>[
    'https://world.openfoodfacts.org',
    'https://world.openbeautyfacts.org',
    'https://world.openproductsfacts.org',
  ];

  Future<String?> lookupDisplayName(
    String barcode, {
    Duration timeout = const Duration(seconds: 10),
    int maxSources = 3,
  }) async {
    final code = barcode.trim();
    if (code.isEmpty) return null;

    final limit = maxSources.clamp(1, _bases.length);
    for (final base in _bases.take(limit)) {
      final name = await _fetchFromBase(base, code, timeout);
      if (name != null && name.isNotEmpty) return name;
    }
    return null;
  }

  Future<String?> _fetchFromBase(
    String baseUrl,
    String barcode,
    Duration timeout,
  ) async {
    final uri = '$baseUrl/api/v0/product/$barcode.json';
    try {
      final response = await _dio.get<dynamic>(
        uri,
        options: Options(
          headers: const {'User-Agent': _userAgent},
          receiveTimeout: timeout,
          sendTimeout: timeout,
        ),
      );
      if (response.statusCode != 200 || response.data == null) return null;

      final raw = response.data;
      final data = raw is Map<String, dynamic> ? raw : null;
      if (data == null) return null;
      if (data['status'] != 1) return null;

      final product = data['product'];
      if (product is! Map<String, dynamic>) return null;

      return _displayNameFromProduct(product);
    } catch (e, st) {
      debugPrint('OpenFacts lookup failed ($baseUrl): $e\n$st');
      return null;
    }
  }

  String? _displayNameFromProduct(Map<String, dynamic> product) {
    for (final key in ['product_name', 'product_name_en', 'generic_name']) {
      final v = product[key];
      if (v is String) {
        final t = v.trim();
        if (t.isNotEmpty) return t;
      }
    }
    final brands = product['brands'];
    if (brands is String) {
      for (final part in brands.split(',')) {
        final t = part.trim();
        if (t.isNotEmpty) return t;
      }
    }
    return null;
  }
}

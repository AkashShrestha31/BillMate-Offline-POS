import 'package:hotel/src/features/payment_methods/data/models/payment_method_item.dart';

/// Body of `GET /api/analytics/payment-methods/`.
class PaymentMethodsResponse {
  const PaymentMethodsResponse({
    required this.success,
    required this.count,
    required this.data,
  });

  final bool success;
  final int count;
  final List<PaymentMethodItem> data;

  factory PaymentMethodsResponse.fromJson(Map<String, dynamic> json) {
    final rawList = json['data'];
    return PaymentMethodsResponse(
      success: json['success'] as bool? ?? false,
      count: (json['count'] as num?)?.toInt() ?? 0,
      data: rawList is List
          ? rawList
              .map((e) => PaymentMethodItem.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList()
          : const [],
    );
  }
}

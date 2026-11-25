import 'package:json_annotation/json_annotation.dart';

part 'payment_analytics_request_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class PaymentAnalyticsRequestModel {
  final String? startDate;
  final String? endDate;
  final String? paymentType;
  final String reportType;
  final String referenceType;

  const PaymentAnalyticsRequestModel({
    this.startDate,
    this.endDate,
    this.paymentType,
    required this.reportType,
    required this.referenceType,
  });

  /// Factory method to create an instance from a JSON map
  factory PaymentAnalyticsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentAnalyticsRequestModelFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$PaymentAnalyticsRequestModelToJson(this);

  /// Copy with method for creating modified instances
  PaymentAnalyticsRequestModel copyWith({
    String? startDate,
    String? endDate,
    String? paymentType,
    String? reportType,
    String? referenceType,
  }) {
    return PaymentAnalyticsRequestModel(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      paymentType: paymentType ?? this.paymentType,
      reportType: reportType ?? this.reportType,
      referenceType: referenceType ?? this.referenceType,
    );
  }
}

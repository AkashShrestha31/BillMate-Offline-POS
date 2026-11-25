import 'package:json_annotation/json_annotation.dart';

part 'payment_analytics_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentAnalyticsResponseModel {
  final String reportType;
  final List<PaymentDayData> data;
  final PaymentFilters filters;
  final PaymentSummary summary;
  final String note;

  const PaymentAnalyticsResponseModel({
    required this.reportType,
    required this.data,
    required this.filters,
    required this.summary,
    required this.note,
  });

  /// Factory method to create an instance from a JSON map
  factory PaymentAnalyticsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentAnalyticsResponseModelFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$PaymentAnalyticsResponseModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentDayData {
  final String reportDate;
  final int paymentCount;
  @JsonKey(fromJson: _doubleFromJson)
  final double totalPayments;
  @JsonKey(fromJson: _doubleFromJson)
  final double averageAmount;
  final PaymentBreakdown paymentBreakdown;

  const PaymentDayData({
    required this.reportDate,
    required this.paymentCount,
    required this.totalPayments,
    required this.averageAmount,
    required this.paymentBreakdown,
  });

  factory PaymentDayData.fromJson(Map<String, dynamic> json) => _$PaymentDayDataFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDayDataToJson(this);

  static double _doubleFromJson(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentBreakdown {
  @JsonKey(fromJson: _doubleFromJson)
  final double cashPayment;
  @JsonKey(fromJson: _doubleFromJson)
  final double transferPayment;
  @JsonKey(fromJson: _doubleFromJson)
  final double bankPayment;
  final List<PaymentDetail> paymentDetails;

  const PaymentBreakdown({
    required this.cashPayment,
    required this.transferPayment,
    required this.bankPayment,
    required this.paymentDetails,
  });

  factory PaymentBreakdown.fromJson(Map<String, dynamic> json) => _$PaymentBreakdownFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentBreakdownToJson(this);

  static double _doubleFromJson(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class PaymentDetail {
  final String? paymentName;
  final String method;
  @JsonKey(fromJson: _doubleFromJson)
  final double amount;
  final String date;
  final String? party;
  final String? paymentType;
  final String? referenceId;
  final String? paymentAccount;
  final List<PaymentReference> paymentForReferences;

  const PaymentDetail({
    this.paymentName,
    required this.method,
    required this.amount,
    required this.date,
    this.party,
     this.paymentType,
    this.referenceId,
    this.paymentAccount,
    required this.paymentForReferences,
  });

  factory PaymentDetail.fromJson(Map<String, dynamic> json) => _$PaymentDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDetailToJson(this);

  static double _doubleFromJson(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentReference {
  final String referenceName;
  final String referenceType;
  final double amount;

  const PaymentReference({
    required this.referenceName,
    required this.referenceType,
    required this.amount,
  });

  factory PaymentReference.fromJson(Map<String, dynamic> json) =>
      _$PaymentReferenceFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentReferenceToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentFilters {
  final String? startDate;
  final String? endDate;
  final String? paymentType;

  const PaymentFilters({
    this.startDate,
    this.endDate,
    this.paymentType,
  });

  factory PaymentFilters.fromJson(Map<String, dynamic> json) => _$PaymentFiltersFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentFiltersToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentSummary {
  final int totalPayments;
  @JsonKey(fromJson: _doubleFromJson)
  final double totalAmount;
  @JsonKey(fromJson: _doubleFromJson)
  final double averageAmount;
  final PaymentMethodBreakdown paymentMethodBreakdown;

  const PaymentSummary({
    required this.totalPayments,
    required this.totalAmount,
    required this.averageAmount,
    required this.paymentMethodBreakdown,
  });

  factory PaymentSummary.fromJson(Map<String, dynamic> json) => _$PaymentSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentSummaryToJson(this);

  static double _doubleFromJson(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentMethodBreakdown {
  @JsonKey(fromJson: _doubleFromJson)
  final double cashPayment;
  @JsonKey(fromJson: _doubleFromJson)
  final double transferPayment;
  @JsonKey(fromJson: _doubleFromJson)
  final double bankPayment;
  final List<PaymentMethod> methods;

  const PaymentMethodBreakdown({
    required this.cashPayment,
    required this.transferPayment,
    required this.bankPayment,
    required this.methods,
  });

  factory PaymentMethodBreakdown.fromJson(Map<String, dynamic> json) => _$PaymentMethodBreakdownFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodBreakdownToJson(this);

  static double _doubleFromJson(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentMethod {
  final String method;
  @JsonKey(fromJson: _doubleFromJson)
  final double amount;
  final int count;

  const PaymentMethod({
    required this.method,
    required this.amount,
    required this.count,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => _$PaymentMethodFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);

  static double _doubleFromJson(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}

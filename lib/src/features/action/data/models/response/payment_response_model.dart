import 'package:json_annotation/json_annotation.dart';

part 'payment_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentResponseModel {
  final String message;
  final UpdatedPayment updatedPayment;

  const PaymentResponseModel({
    required this.message,
    required this.updatedPayment,
  });

  /// Factory method to create an instance from a JSON map
  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseModelFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$PaymentResponseModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdatedPayment {
  final String name;
  final String date;
  final String paymentType;
  final String paymentMethod;

  const UpdatedPayment({
    required this.name,
    required this.date,
    required this.paymentType,
    required this.paymentMethod,
  });

  factory UpdatedPayment.fromJson(Map<String, dynamic> json) =>
      _$UpdatedPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatedPaymentToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentListResponseModel {
  final List<UpdatedPayment> payments;
  final int? totalCount;
  final int? currentPage;
  final int? totalPages;

  const PaymentListResponseModel({
    required this.payments,
    this.totalCount,
    this.currentPage,
    this.totalPages,
  });

  factory PaymentListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentListResponseModelToJson(this);
}
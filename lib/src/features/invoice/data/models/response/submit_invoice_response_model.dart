import 'package:json_annotation/json_annotation.dart';

part 'submit_invoice_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SubmitInvoiceResponseModel {
  final String message;
  final String invoiceName;
  final String action;

  SubmitInvoiceResponseModel({
    required this.message,
    required this.invoiceName,
    required this.action,
  });

  factory SubmitInvoiceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitInvoiceResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitInvoiceResponseModelToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'submit_invoice_request_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SubmitInvoiceRequestParams {
  final String invoiceName;
  final String action;
  final String modifiedBy;

  SubmitInvoiceRequestParams({
    required this.invoiceName,
    this.action = "submit",
    required this.modifiedBy,
  });

  factory SubmitInvoiceRequestParams.fromJson(Map<String, dynamic> json) =>
      _$SubmitInvoiceRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitInvoiceRequestParamsToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'create_invoice_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreateInvoiceResponseModel {
  final String message;
  final String invoiceName;
  final int itemsCreated;
  final double netTotal;
  final double grandTotal;
  final String status;

  CreateInvoiceResponseModel({
    required this.message,
    required this.invoiceName,
    required this.itemsCreated,
    required this.netTotal,
    required this.grandTotal,
    required this.status,
  });

  factory CreateInvoiceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CreateInvoiceResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateInvoiceResponseModelToJson(this);
}

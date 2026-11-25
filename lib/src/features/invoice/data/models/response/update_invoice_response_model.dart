import 'package:json_annotation/json_annotation.dart';

part 'update_invoice_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateInvoiceResponseModel {
  final String message;

  UpdateInvoiceResponseModel({
    required this.message,
  });

  factory UpdateInvoiceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateInvoiceResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateInvoiceResponseModelToJson(this);
}

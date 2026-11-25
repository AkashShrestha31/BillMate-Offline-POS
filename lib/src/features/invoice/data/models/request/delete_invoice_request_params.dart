import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_invoice_request_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DeleteInvoiceRequestParams {
  final List<String> invoiceNames; // Changed from String to List<String>

  @JsonKey(includeToJson: false)
  final InvoiceType? invoiceType;

  final bool? confirmDelete;
  final bool? forceDelete;
  final String? deletedBy;

  DeleteInvoiceRequestParams({
    required this.invoiceNames,
    this.invoiceType,
    this.confirmDelete,
    this.forceDelete,
    this.deletedBy,
  });

  factory DeleteInvoiceRequestParams.fromJson(Map<String, dynamic> json) =>
      _$DeleteInvoiceRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteInvoiceRequestParamsToJson(this);
}
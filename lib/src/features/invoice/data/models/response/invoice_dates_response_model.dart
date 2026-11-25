import 'package:json_annotation/json_annotation.dart';

part 'invoice_dates_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class InvoiceDatesResponseModel {
  final bool success;
  @JsonKey(name: 'data')
  final List<String> dates;

  InvoiceDatesResponseModel({
    required this.success,
    required this.dates,
  });

  factory InvoiceDatesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDatesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceDatesResponseModelToJson(this);
}

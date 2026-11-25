import 'package:json_annotation/json_annotation.dart';

part 'settlement_request_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SettlementRequestParams {
  final List<String> parties;
  final String paymentMethod;
  final String paymentDate;
  final bool settleSalesInvoices;
  final bool settlePurchaseInvoices;
  final bool skipPartiesWithErrors;
  final String createdBy;

  SettlementRequestParams({
    required this.parties,
    required this.paymentMethod,
    required this.paymentDate,
    this.settleSalesInvoices = true,
    this.settlePurchaseInvoices = true,
    this.skipPartiesWithErrors = true,
    required this.createdBy,
  });

  /// Factory method to create an instance from a JSON map
  factory SettlementRequestParams.fromJson(Map<String, dynamic> json) =>
      _$SettlementRequestParamsFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$SettlementRequestParamsToJson(this);

  /// Copy with method for immutability
  SettlementRequestParams copyWith({
    List<String>? parties,
    String? paymentMethod,
    String? paymentDate,
    bool? settleSalesInvoices,
    bool? settlePurchaseInvoices,
    bool? skipPartiesWithErrors,
    String? createdBy,
  }) {
    return SettlementRequestParams(
      parties: parties ?? this.parties,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentDate: paymentDate ?? this.paymentDate,
      settleSalesInvoices: settleSalesInvoices ?? this.settleSalesInvoices,
      settlePurchaseInvoices:
          settlePurchaseInvoices ?? this.settlePurchaseInvoices,
      skipPartiesWithErrors:
          skipPartiesWithErrors ?? this.skipPartiesWithErrors,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}

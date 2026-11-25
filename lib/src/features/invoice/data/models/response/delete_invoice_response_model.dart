import 'package:json_annotation/json_annotation.dart';

part 'delete_invoice_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DeleteInvoiceResponseModel {
  final bool success;
  final String message;
  final DeleteInvoiceSummary summary;
  final List<DeletedInvoiceDetail> deletedInvoices;
  final List<PartyUpdate> partyUpdates;

  DeleteInvoiceResponseModel({
    required this.success,
    required this.message,
    required this.summary,
    required this.deletedInvoices,
    required this.partyUpdates,
  });

  factory DeleteInvoiceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DeleteInvoiceResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteInvoiceResponseModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DeleteInvoiceSummary {
  final int totalInvoicesRequested;
  final int totalInvoicesDeleted;
  final int totalInvoicesNotFound;
  final int totalItemsDeleted;
  final int totalPaymentForDeleted;
  final int totalPaymentsDeleted;
  final int partiesUpdated;

  DeleteInvoiceSummary({
    required this.totalInvoicesRequested,
    required this.totalInvoicesDeleted,
    required this.totalInvoicesNotFound,
    required this.totalItemsDeleted,
    required this.totalPaymentForDeleted,
    required this.totalPaymentsDeleted,
    required this.partiesUpdated,
  });

  factory DeleteInvoiceSummary.fromJson(Map<String, dynamic> json) =>
      _$DeleteInvoiceSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteInvoiceSummaryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DeletedInvoiceDetail {
  final String invoiceName;
  final String party;
  final double outstandingAmount;
  final int itemsDeleted;
  final int paymentForDeleted;
  final int paymentsDeleted;

  DeletedInvoiceDetail({
    required this.invoiceName,
    required this.party,
    required this.outstandingAmount,
    required this.itemsDeleted,
    required this.paymentForDeleted,
    required this.paymentsDeleted,
  });

  factory DeletedInvoiceDetail.fromJson(Map<String, dynamic> json) =>
      _$DeletedInvoiceDetailFromJson(json);

  Map<String, dynamic> toJson() => _$DeletedInvoiceDetailToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PartyUpdate {
  final String party;
  final double outstandingReduction;

  PartyUpdate({
    required this.party,
    required this.outstandingReduction,
  });

  factory PartyUpdate.fromJson(Map<String, dynamic> json) =>
      _$PartyUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$PartyUpdateToJson(this);
}
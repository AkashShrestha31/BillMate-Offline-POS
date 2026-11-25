// Response Model
import 'package:freezed_annotation/freezed_annotation.dart';

part 'party_update_response_model.freezed.dart';
part 'party_update_response_model.g.dart';

@freezed
class PartyUpdateResponseModel with _$PartyUpdateResponseModel {
  const factory PartyUpdateResponseModel({
    required bool success,
    required String message,
    @JsonKey(name: 'total_records_updated') required int totalRecordsUpdated,
    @JsonKey(name: 'updates_by_table') required UpdatesByTable updatesByTable,
    @JsonKey(name: 'updated_party') required UpdatedParty updatedParty,
  }) = _PartyUpdateResponseModel;

  factory PartyUpdateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PartyUpdateResponseModelFromJson(json);
}

@freezed
class UpdatesByTable with _$UpdatesByTable {
  const factory UpdatesByTable({
    @JsonKey(name: 'Party') required int party,
    @JsonKey(name: 'SalesInvoice') required int salesInvoice,
    @JsonKey(name: 'SalesQuote') required int salesQuote,
    @JsonKey(name: 'PurchaseInvoice') required int purchaseInvoice,
    @JsonKey(name: 'PurchaseReceipt') required int purchaseReceipt,
    @JsonKey(name: 'Payment') required int payment,
    @JsonKey(name: 'Shipment') required int shipment,
    @JsonKey(name: 'AccountingLedgerEntry') required int accountingLedgerEntry,
    @JsonKey(name: 'LoyaltyPointEntry') required int loyaltyPointEntry,
  }) = _UpdatesByTable;

  factory UpdatesByTable.fromJson(Map<String, dynamic> json) =>
      _$UpdatesByTableFromJson(json);
}

@freezed
class UpdatedParty with _$UpdatedParty {
  const factory UpdatedParty({
    required String name,
    required String role,
    required String? email,
    required String? phone,
    required String? address,
    required String? loyaltyProgram,
    required int loyaltyPoints,
    @JsonKey(name: 'outstandingAmount', fromJson: _stringToDouble)
    required double outstandingAmount,
    required String created,
    required String modified,
    required String modifiedBy,
  }) = _UpdatedParty;

  factory UpdatedParty.fromJson(Map<String, dynamic> json) =>
      _$UpdatedPartyFromJson(json);
}

// Helper function for type conversion
double _stringToDouble(dynamic value) {
  if (value == null) return 0.0;
  return double.tryParse(value.toString()) ?? 0.0;
}

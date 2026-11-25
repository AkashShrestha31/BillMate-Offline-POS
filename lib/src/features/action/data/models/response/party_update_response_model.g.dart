// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_update_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartyUpdateResponseModelImpl _$$PartyUpdateResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PartyUpdateResponseModelImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      totalRecordsUpdated: (json['total_records_updated'] as num).toInt(),
      updatesByTable: UpdatesByTable.fromJson(
          json['updates_by_table'] as Map<String, dynamic>),
      updatedParty:
          UpdatedParty.fromJson(json['updated_party'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PartyUpdateResponseModelImplToJson(
        _$PartyUpdateResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'total_records_updated': instance.totalRecordsUpdated,
      'updates_by_table': instance.updatesByTable,
      'updated_party': instance.updatedParty,
    };

_$UpdatesByTableImpl _$$UpdatesByTableImplFromJson(Map<String, dynamic> json) =>
    _$UpdatesByTableImpl(
      party: (json['Party'] as num).toInt(),
      salesInvoice: (json['SalesInvoice'] as num).toInt(),
      salesQuote: (json['SalesQuote'] as num).toInt(),
      purchaseInvoice: (json['PurchaseInvoice'] as num).toInt(),
      purchaseReceipt: (json['PurchaseReceipt'] as num).toInt(),
      payment: (json['Payment'] as num).toInt(),
      shipment: (json['Shipment'] as num).toInt(),
      accountingLedgerEntry: (json['AccountingLedgerEntry'] as num).toInt(),
      loyaltyPointEntry: (json['LoyaltyPointEntry'] as num).toInt(),
    );

Map<String, dynamic> _$$UpdatesByTableImplToJson(
        _$UpdatesByTableImpl instance) =>
    <String, dynamic>{
      'Party': instance.party,
      'SalesInvoice': instance.salesInvoice,
      'SalesQuote': instance.salesQuote,
      'PurchaseInvoice': instance.purchaseInvoice,
      'PurchaseReceipt': instance.purchaseReceipt,
      'Payment': instance.payment,
      'Shipment': instance.shipment,
      'AccountingLedgerEntry': instance.accountingLedgerEntry,
      'LoyaltyPointEntry': instance.loyaltyPointEntry,
    };

_$UpdatedPartyImpl _$$UpdatedPartyImplFromJson(Map<String, dynamic> json) =>
    _$UpdatedPartyImpl(
      name: json['name'] as String,
      role: json['role'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      loyaltyProgram: json['loyaltyProgram'] as String?,
      loyaltyPoints: (json['loyaltyPoints'] as num).toInt(),
      outstandingAmount: _stringToDouble(json['outstandingAmount']),
      created: json['created'] as String,
      modified: json['modified'] as String,
      modifiedBy: json['modifiedBy'] as String,
    );

Map<String, dynamic> _$$UpdatedPartyImplToJson(_$UpdatedPartyImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'role': instance.role,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'loyaltyProgram': instance.loyaltyProgram,
      'loyaltyPoints': instance.loyaltyPoints,
      'outstandingAmount': instance.outstandingAmount,
      'created': instance.created,
      'modified': instance.modified,
      'modifiedBy': instance.modifiedBy,
    };

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'party_update_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartyUpdateResponseModel _$PartyUpdateResponseModelFromJson(
    Map<String, dynamic> json) {
  return _PartyUpdateResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PartyUpdateResponseModel {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_records_updated')
  int get totalRecordsUpdated => throw _privateConstructorUsedError;
  @JsonKey(name: 'updates_by_table')
  UpdatesByTable get updatesByTable => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_party')
  UpdatedParty get updatedParty => throw _privateConstructorUsedError;

  /// Serializes this PartyUpdateResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartyUpdateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartyUpdateResponseModelCopyWith<PartyUpdateResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartyUpdateResponseModelCopyWith<$Res> {
  factory $PartyUpdateResponseModelCopyWith(PartyUpdateResponseModel value,
          $Res Function(PartyUpdateResponseModel) then) =
      _$PartyUpdateResponseModelCopyWithImpl<$Res, PartyUpdateResponseModel>;
  @useResult
  $Res call(
      {bool success,
      String message,
      @JsonKey(name: 'total_records_updated') int totalRecordsUpdated,
      @JsonKey(name: 'updates_by_table') UpdatesByTable updatesByTable,
      @JsonKey(name: 'updated_party') UpdatedParty updatedParty});

  $UpdatesByTableCopyWith<$Res> get updatesByTable;
  $UpdatedPartyCopyWith<$Res> get updatedParty;
}

/// @nodoc
class _$PartyUpdateResponseModelCopyWithImpl<$Res,
        $Val extends PartyUpdateResponseModel>
    implements $PartyUpdateResponseModelCopyWith<$Res> {
  _$PartyUpdateResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartyUpdateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? totalRecordsUpdated = null,
    Object? updatesByTable = null,
    Object? updatedParty = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      totalRecordsUpdated: null == totalRecordsUpdated
          ? _value.totalRecordsUpdated
          : totalRecordsUpdated // ignore: cast_nullable_to_non_nullable
              as int,
      updatesByTable: null == updatesByTable
          ? _value.updatesByTable
          : updatesByTable // ignore: cast_nullable_to_non_nullable
              as UpdatesByTable,
      updatedParty: null == updatedParty
          ? _value.updatedParty
          : updatedParty // ignore: cast_nullable_to_non_nullable
              as UpdatedParty,
    ) as $Val);
  }

  /// Create a copy of PartyUpdateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UpdatesByTableCopyWith<$Res> get updatesByTable {
    return $UpdatesByTableCopyWith<$Res>(_value.updatesByTable, (value) {
      return _then(_value.copyWith(updatesByTable: value) as $Val);
    });
  }

  /// Create a copy of PartyUpdateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UpdatedPartyCopyWith<$Res> get updatedParty {
    return $UpdatedPartyCopyWith<$Res>(_value.updatedParty, (value) {
      return _then(_value.copyWith(updatedParty: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PartyUpdateResponseModelImplCopyWith<$Res>
    implements $PartyUpdateResponseModelCopyWith<$Res> {
  factory _$$PartyUpdateResponseModelImplCopyWith(
          _$PartyUpdateResponseModelImpl value,
          $Res Function(_$PartyUpdateResponseModelImpl) then) =
      __$$PartyUpdateResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String message,
      @JsonKey(name: 'total_records_updated') int totalRecordsUpdated,
      @JsonKey(name: 'updates_by_table') UpdatesByTable updatesByTable,
      @JsonKey(name: 'updated_party') UpdatedParty updatedParty});

  @override
  $UpdatesByTableCopyWith<$Res> get updatesByTable;
  @override
  $UpdatedPartyCopyWith<$Res> get updatedParty;
}

/// @nodoc
class __$$PartyUpdateResponseModelImplCopyWithImpl<$Res>
    extends _$PartyUpdateResponseModelCopyWithImpl<$Res,
        _$PartyUpdateResponseModelImpl>
    implements _$$PartyUpdateResponseModelImplCopyWith<$Res> {
  __$$PartyUpdateResponseModelImplCopyWithImpl(
      _$PartyUpdateResponseModelImpl _value,
      $Res Function(_$PartyUpdateResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartyUpdateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? totalRecordsUpdated = null,
    Object? updatesByTable = null,
    Object? updatedParty = null,
  }) {
    return _then(_$PartyUpdateResponseModelImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      totalRecordsUpdated: null == totalRecordsUpdated
          ? _value.totalRecordsUpdated
          : totalRecordsUpdated // ignore: cast_nullable_to_non_nullable
              as int,
      updatesByTable: null == updatesByTable
          ? _value.updatesByTable
          : updatesByTable // ignore: cast_nullable_to_non_nullable
              as UpdatesByTable,
      updatedParty: null == updatedParty
          ? _value.updatedParty
          : updatedParty // ignore: cast_nullable_to_non_nullable
              as UpdatedParty,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartyUpdateResponseModelImpl implements _PartyUpdateResponseModel {
  const _$PartyUpdateResponseModelImpl(
      {required this.success,
      required this.message,
      @JsonKey(name: 'total_records_updated') required this.totalRecordsUpdated,
      @JsonKey(name: 'updates_by_table') required this.updatesByTable,
      @JsonKey(name: 'updated_party') required this.updatedParty});

  factory _$PartyUpdateResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartyUpdateResponseModelImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  @JsonKey(name: 'total_records_updated')
  final int totalRecordsUpdated;
  @override
  @JsonKey(name: 'updates_by_table')
  final UpdatesByTable updatesByTable;
  @override
  @JsonKey(name: 'updated_party')
  final UpdatedParty updatedParty;

  @override
  String toString() {
    return 'PartyUpdateResponseModel(success: $success, message: $message, totalRecordsUpdated: $totalRecordsUpdated, updatesByTable: $updatesByTable, updatedParty: $updatedParty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartyUpdateResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.totalRecordsUpdated, totalRecordsUpdated) ||
                other.totalRecordsUpdated == totalRecordsUpdated) &&
            (identical(other.updatesByTable, updatesByTable) ||
                other.updatesByTable == updatesByTable) &&
            (identical(other.updatedParty, updatedParty) ||
                other.updatedParty == updatedParty));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message,
      totalRecordsUpdated, updatesByTable, updatedParty);

  /// Create a copy of PartyUpdateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartyUpdateResponseModelImplCopyWith<_$PartyUpdateResponseModelImpl>
      get copyWith => __$$PartyUpdateResponseModelImplCopyWithImpl<
          _$PartyUpdateResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartyUpdateResponseModelImplToJson(
      this,
    );
  }
}

abstract class _PartyUpdateResponseModel implements PartyUpdateResponseModel {
  const factory _PartyUpdateResponseModel(
          {required final bool success,
          required final String message,
          @JsonKey(name: 'total_records_updated')
          required final int totalRecordsUpdated,
          @JsonKey(name: 'updates_by_table')
          required final UpdatesByTable updatesByTable,
          @JsonKey(name: 'updated_party')
          required final UpdatedParty updatedParty}) =
      _$PartyUpdateResponseModelImpl;

  factory _PartyUpdateResponseModel.fromJson(Map<String, dynamic> json) =
      _$PartyUpdateResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  @JsonKey(name: 'total_records_updated')
  int get totalRecordsUpdated;
  @override
  @JsonKey(name: 'updates_by_table')
  UpdatesByTable get updatesByTable;
  @override
  @JsonKey(name: 'updated_party')
  UpdatedParty get updatedParty;

  /// Create a copy of PartyUpdateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartyUpdateResponseModelImplCopyWith<_$PartyUpdateResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UpdatesByTable _$UpdatesByTableFromJson(Map<String, dynamic> json) {
  return _UpdatesByTable.fromJson(json);
}

/// @nodoc
mixin _$UpdatesByTable {
  @JsonKey(name: 'Party')
  int get party => throw _privateConstructorUsedError;
  @JsonKey(name: 'SalesInvoice')
  int get salesInvoice => throw _privateConstructorUsedError;
  @JsonKey(name: 'SalesQuote')
  int get salesQuote => throw _privateConstructorUsedError;
  @JsonKey(name: 'PurchaseInvoice')
  int get purchaseInvoice => throw _privateConstructorUsedError;
  @JsonKey(name: 'PurchaseReceipt')
  int get purchaseReceipt => throw _privateConstructorUsedError;
  @JsonKey(name: 'Payment')
  int get payment => throw _privateConstructorUsedError;
  @JsonKey(name: 'Shipment')
  int get shipment => throw _privateConstructorUsedError;
  @JsonKey(name: 'AccountingLedgerEntry')
  int get accountingLedgerEntry => throw _privateConstructorUsedError;
  @JsonKey(name: 'LoyaltyPointEntry')
  int get loyaltyPointEntry => throw _privateConstructorUsedError;

  /// Serializes this UpdatesByTable to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdatesByTable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdatesByTableCopyWith<UpdatesByTable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatesByTableCopyWith<$Res> {
  factory $UpdatesByTableCopyWith(
          UpdatesByTable value, $Res Function(UpdatesByTable) then) =
      _$UpdatesByTableCopyWithImpl<$Res, UpdatesByTable>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Party') int party,
      @JsonKey(name: 'SalesInvoice') int salesInvoice,
      @JsonKey(name: 'SalesQuote') int salesQuote,
      @JsonKey(name: 'PurchaseInvoice') int purchaseInvoice,
      @JsonKey(name: 'PurchaseReceipt') int purchaseReceipt,
      @JsonKey(name: 'Payment') int payment,
      @JsonKey(name: 'Shipment') int shipment,
      @JsonKey(name: 'AccountingLedgerEntry') int accountingLedgerEntry,
      @JsonKey(name: 'LoyaltyPointEntry') int loyaltyPointEntry});
}

/// @nodoc
class _$UpdatesByTableCopyWithImpl<$Res, $Val extends UpdatesByTable>
    implements $UpdatesByTableCopyWith<$Res> {
  _$UpdatesByTableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdatesByTable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? party = null,
    Object? salesInvoice = null,
    Object? salesQuote = null,
    Object? purchaseInvoice = null,
    Object? purchaseReceipt = null,
    Object? payment = null,
    Object? shipment = null,
    Object? accountingLedgerEntry = null,
    Object? loyaltyPointEntry = null,
  }) {
    return _then(_value.copyWith(
      party: null == party
          ? _value.party
          : party // ignore: cast_nullable_to_non_nullable
              as int,
      salesInvoice: null == salesInvoice
          ? _value.salesInvoice
          : salesInvoice // ignore: cast_nullable_to_non_nullable
              as int,
      salesQuote: null == salesQuote
          ? _value.salesQuote
          : salesQuote // ignore: cast_nullable_to_non_nullable
              as int,
      purchaseInvoice: null == purchaseInvoice
          ? _value.purchaseInvoice
          : purchaseInvoice // ignore: cast_nullable_to_non_nullable
              as int,
      purchaseReceipt: null == purchaseReceipt
          ? _value.purchaseReceipt
          : purchaseReceipt // ignore: cast_nullable_to_non_nullable
              as int,
      payment: null == payment
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as int,
      shipment: null == shipment
          ? _value.shipment
          : shipment // ignore: cast_nullable_to_non_nullable
              as int,
      accountingLedgerEntry: null == accountingLedgerEntry
          ? _value.accountingLedgerEntry
          : accountingLedgerEntry // ignore: cast_nullable_to_non_nullable
              as int,
      loyaltyPointEntry: null == loyaltyPointEntry
          ? _value.loyaltyPointEntry
          : loyaltyPointEntry // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdatesByTableImplCopyWith<$Res>
    implements $UpdatesByTableCopyWith<$Res> {
  factory _$$UpdatesByTableImplCopyWith(_$UpdatesByTableImpl value,
          $Res Function(_$UpdatesByTableImpl) then) =
      __$$UpdatesByTableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Party') int party,
      @JsonKey(name: 'SalesInvoice') int salesInvoice,
      @JsonKey(name: 'SalesQuote') int salesQuote,
      @JsonKey(name: 'PurchaseInvoice') int purchaseInvoice,
      @JsonKey(name: 'PurchaseReceipt') int purchaseReceipt,
      @JsonKey(name: 'Payment') int payment,
      @JsonKey(name: 'Shipment') int shipment,
      @JsonKey(name: 'AccountingLedgerEntry') int accountingLedgerEntry,
      @JsonKey(name: 'LoyaltyPointEntry') int loyaltyPointEntry});
}

/// @nodoc
class __$$UpdatesByTableImplCopyWithImpl<$Res>
    extends _$UpdatesByTableCopyWithImpl<$Res, _$UpdatesByTableImpl>
    implements _$$UpdatesByTableImplCopyWith<$Res> {
  __$$UpdatesByTableImplCopyWithImpl(
      _$UpdatesByTableImpl _value, $Res Function(_$UpdatesByTableImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdatesByTable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? party = null,
    Object? salesInvoice = null,
    Object? salesQuote = null,
    Object? purchaseInvoice = null,
    Object? purchaseReceipt = null,
    Object? payment = null,
    Object? shipment = null,
    Object? accountingLedgerEntry = null,
    Object? loyaltyPointEntry = null,
  }) {
    return _then(_$UpdatesByTableImpl(
      party: null == party
          ? _value.party
          : party // ignore: cast_nullable_to_non_nullable
              as int,
      salesInvoice: null == salesInvoice
          ? _value.salesInvoice
          : salesInvoice // ignore: cast_nullable_to_non_nullable
              as int,
      salesQuote: null == salesQuote
          ? _value.salesQuote
          : salesQuote // ignore: cast_nullable_to_non_nullable
              as int,
      purchaseInvoice: null == purchaseInvoice
          ? _value.purchaseInvoice
          : purchaseInvoice // ignore: cast_nullable_to_non_nullable
              as int,
      purchaseReceipt: null == purchaseReceipt
          ? _value.purchaseReceipt
          : purchaseReceipt // ignore: cast_nullable_to_non_nullable
              as int,
      payment: null == payment
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as int,
      shipment: null == shipment
          ? _value.shipment
          : shipment // ignore: cast_nullable_to_non_nullable
              as int,
      accountingLedgerEntry: null == accountingLedgerEntry
          ? _value.accountingLedgerEntry
          : accountingLedgerEntry // ignore: cast_nullable_to_non_nullable
              as int,
      loyaltyPointEntry: null == loyaltyPointEntry
          ? _value.loyaltyPointEntry
          : loyaltyPointEntry // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatesByTableImpl implements _UpdatesByTable {
  const _$UpdatesByTableImpl(
      {@JsonKey(name: 'Party') required this.party,
      @JsonKey(name: 'SalesInvoice') required this.salesInvoice,
      @JsonKey(name: 'SalesQuote') required this.salesQuote,
      @JsonKey(name: 'PurchaseInvoice') required this.purchaseInvoice,
      @JsonKey(name: 'PurchaseReceipt') required this.purchaseReceipt,
      @JsonKey(name: 'Payment') required this.payment,
      @JsonKey(name: 'Shipment') required this.shipment,
      @JsonKey(name: 'AccountingLedgerEntry')
      required this.accountingLedgerEntry,
      @JsonKey(name: 'LoyaltyPointEntry') required this.loyaltyPointEntry});

  factory _$UpdatesByTableImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdatesByTableImplFromJson(json);

  @override
  @JsonKey(name: 'Party')
  final int party;
  @override
  @JsonKey(name: 'SalesInvoice')
  final int salesInvoice;
  @override
  @JsonKey(name: 'SalesQuote')
  final int salesQuote;
  @override
  @JsonKey(name: 'PurchaseInvoice')
  final int purchaseInvoice;
  @override
  @JsonKey(name: 'PurchaseReceipt')
  final int purchaseReceipt;
  @override
  @JsonKey(name: 'Payment')
  final int payment;
  @override
  @JsonKey(name: 'Shipment')
  final int shipment;
  @override
  @JsonKey(name: 'AccountingLedgerEntry')
  final int accountingLedgerEntry;
  @override
  @JsonKey(name: 'LoyaltyPointEntry')
  final int loyaltyPointEntry;

  @override
  String toString() {
    return 'UpdatesByTable(party: $party, salesInvoice: $salesInvoice, salesQuote: $salesQuote, purchaseInvoice: $purchaseInvoice, purchaseReceipt: $purchaseReceipt, payment: $payment, shipment: $shipment, accountingLedgerEntry: $accountingLedgerEntry, loyaltyPointEntry: $loyaltyPointEntry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatesByTableImpl &&
            (identical(other.party, party) || other.party == party) &&
            (identical(other.salesInvoice, salesInvoice) ||
                other.salesInvoice == salesInvoice) &&
            (identical(other.salesQuote, salesQuote) ||
                other.salesQuote == salesQuote) &&
            (identical(other.purchaseInvoice, purchaseInvoice) ||
                other.purchaseInvoice == purchaseInvoice) &&
            (identical(other.purchaseReceipt, purchaseReceipt) ||
                other.purchaseReceipt == purchaseReceipt) &&
            (identical(other.payment, payment) || other.payment == payment) &&
            (identical(other.shipment, shipment) ||
                other.shipment == shipment) &&
            (identical(other.accountingLedgerEntry, accountingLedgerEntry) ||
                other.accountingLedgerEntry == accountingLedgerEntry) &&
            (identical(other.loyaltyPointEntry, loyaltyPointEntry) ||
                other.loyaltyPointEntry == loyaltyPointEntry));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      party,
      salesInvoice,
      salesQuote,
      purchaseInvoice,
      purchaseReceipt,
      payment,
      shipment,
      accountingLedgerEntry,
      loyaltyPointEntry);

  /// Create a copy of UpdatesByTable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatesByTableImplCopyWith<_$UpdatesByTableImpl> get copyWith =>
      __$$UpdatesByTableImplCopyWithImpl<_$UpdatesByTableImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatesByTableImplToJson(
      this,
    );
  }
}

abstract class _UpdatesByTable implements UpdatesByTable {
  const factory _UpdatesByTable(
      {@JsonKey(name: 'Party') required final int party,
      @JsonKey(name: 'SalesInvoice') required final int salesInvoice,
      @JsonKey(name: 'SalesQuote') required final int salesQuote,
      @JsonKey(name: 'PurchaseInvoice') required final int purchaseInvoice,
      @JsonKey(name: 'PurchaseReceipt') required final int purchaseReceipt,
      @JsonKey(name: 'Payment') required final int payment,
      @JsonKey(name: 'Shipment') required final int shipment,
      @JsonKey(name: 'AccountingLedgerEntry')
      required final int accountingLedgerEntry,
      @JsonKey(name: 'LoyaltyPointEntry')
      required final int loyaltyPointEntry}) = _$UpdatesByTableImpl;

  factory _UpdatesByTable.fromJson(Map<String, dynamic> json) =
      _$UpdatesByTableImpl.fromJson;

  @override
  @JsonKey(name: 'Party')
  int get party;
  @override
  @JsonKey(name: 'SalesInvoice')
  int get salesInvoice;
  @override
  @JsonKey(name: 'SalesQuote')
  int get salesQuote;
  @override
  @JsonKey(name: 'PurchaseInvoice')
  int get purchaseInvoice;
  @override
  @JsonKey(name: 'PurchaseReceipt')
  int get purchaseReceipt;
  @override
  @JsonKey(name: 'Payment')
  int get payment;
  @override
  @JsonKey(name: 'Shipment')
  int get shipment;
  @override
  @JsonKey(name: 'AccountingLedgerEntry')
  int get accountingLedgerEntry;
  @override
  @JsonKey(name: 'LoyaltyPointEntry')
  int get loyaltyPointEntry;

  /// Create a copy of UpdatesByTable
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatesByTableImplCopyWith<_$UpdatesByTableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdatedParty _$UpdatedPartyFromJson(Map<String, dynamic> json) {
  return _UpdatedParty.fromJson(json);
}

/// @nodoc
mixin _$UpdatedParty {
  String get name => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get loyaltyProgram => throw _privateConstructorUsedError;
  int get loyaltyPoints => throw _privateConstructorUsedError;
  @JsonKey(name: 'outstandingAmount', fromJson: _stringToDouble)
  double get outstandingAmount => throw _privateConstructorUsedError;
  String get created => throw _privateConstructorUsedError;
  String get modified => throw _privateConstructorUsedError;
  String get modifiedBy => throw _privateConstructorUsedError;

  /// Serializes this UpdatedParty to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdatedParty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdatedPartyCopyWith<UpdatedParty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatedPartyCopyWith<$Res> {
  factory $UpdatedPartyCopyWith(
          UpdatedParty value, $Res Function(UpdatedParty) then) =
      _$UpdatedPartyCopyWithImpl<$Res, UpdatedParty>;
  @useResult
  $Res call(
      {String name,
      String role,
      String? email,
      String? phone,
      String? address,
      String? loyaltyProgram,
      int loyaltyPoints,
      @JsonKey(name: 'outstandingAmount', fromJson: _stringToDouble)
      double outstandingAmount,
      String created,
      String modified,
      String modifiedBy});
}

/// @nodoc
class _$UpdatedPartyCopyWithImpl<$Res, $Val extends UpdatedParty>
    implements $UpdatedPartyCopyWith<$Res> {
  _$UpdatedPartyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdatedParty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? role = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? loyaltyProgram = freezed,
    Object? loyaltyPoints = null,
    Object? outstandingAmount = null,
    Object? created = null,
    Object? modified = null,
    Object? modifiedBy = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      loyaltyProgram: freezed == loyaltyProgram
          ? _value.loyaltyProgram
          : loyaltyProgram // ignore: cast_nullable_to_non_nullable
              as String?,
      loyaltyPoints: null == loyaltyPoints
          ? _value.loyaltyPoints
          : loyaltyPoints // ignore: cast_nullable_to_non_nullable
              as int,
      outstandingAmount: null == outstandingAmount
          ? _value.outstandingAmount
          : outstandingAmount // ignore: cast_nullable_to_non_nullable
              as double,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String,
      modified: null == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as String,
      modifiedBy: null == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdatedPartyImplCopyWith<$Res>
    implements $UpdatedPartyCopyWith<$Res> {
  factory _$$UpdatedPartyImplCopyWith(
          _$UpdatedPartyImpl value, $Res Function(_$UpdatedPartyImpl) then) =
      __$$UpdatedPartyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String role,
      String? email,
      String? phone,
      String? address,
      String? loyaltyProgram,
      int loyaltyPoints,
      @JsonKey(name: 'outstandingAmount', fromJson: _stringToDouble)
      double outstandingAmount,
      String created,
      String modified,
      String modifiedBy});
}

/// @nodoc
class __$$UpdatedPartyImplCopyWithImpl<$Res>
    extends _$UpdatedPartyCopyWithImpl<$Res, _$UpdatedPartyImpl>
    implements _$$UpdatedPartyImplCopyWith<$Res> {
  __$$UpdatedPartyImplCopyWithImpl(
      _$UpdatedPartyImpl _value, $Res Function(_$UpdatedPartyImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdatedParty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? role = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? loyaltyProgram = freezed,
    Object? loyaltyPoints = null,
    Object? outstandingAmount = null,
    Object? created = null,
    Object? modified = null,
    Object? modifiedBy = null,
  }) {
    return _then(_$UpdatedPartyImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      loyaltyProgram: freezed == loyaltyProgram
          ? _value.loyaltyProgram
          : loyaltyProgram // ignore: cast_nullable_to_non_nullable
              as String?,
      loyaltyPoints: null == loyaltyPoints
          ? _value.loyaltyPoints
          : loyaltyPoints // ignore: cast_nullable_to_non_nullable
              as int,
      outstandingAmount: null == outstandingAmount
          ? _value.outstandingAmount
          : outstandingAmount // ignore: cast_nullable_to_non_nullable
              as double,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String,
      modified: null == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as String,
      modifiedBy: null == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatedPartyImpl implements _UpdatedParty {
  const _$UpdatedPartyImpl(
      {required this.name,
      required this.role,
      required this.email,
      required this.phone,
      required this.address,
      required this.loyaltyProgram,
      required this.loyaltyPoints,
      @JsonKey(name: 'outstandingAmount', fromJson: _stringToDouble)
      required this.outstandingAmount,
      required this.created,
      required this.modified,
      required this.modifiedBy});

  factory _$UpdatedPartyImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdatedPartyImplFromJson(json);

  @override
  final String name;
  @override
  final String role;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? address;
  @override
  final String? loyaltyProgram;
  @override
  final int loyaltyPoints;
  @override
  @JsonKey(name: 'outstandingAmount', fromJson: _stringToDouble)
  final double outstandingAmount;
  @override
  final String created;
  @override
  final String modified;
  @override
  final String modifiedBy;

  @override
  String toString() {
    return 'UpdatedParty(name: $name, role: $role, email: $email, phone: $phone, address: $address, loyaltyProgram: $loyaltyProgram, loyaltyPoints: $loyaltyPoints, outstandingAmount: $outstandingAmount, created: $created, modified: $modified, modifiedBy: $modifiedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatedPartyImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.loyaltyProgram, loyaltyProgram) ||
                other.loyaltyProgram == loyaltyProgram) &&
            (identical(other.loyaltyPoints, loyaltyPoints) ||
                other.loyaltyPoints == loyaltyPoints) &&
            (identical(other.outstandingAmount, outstandingAmount) ||
                other.outstandingAmount == outstandingAmount) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.modified, modified) ||
                other.modified == modified) &&
            (identical(other.modifiedBy, modifiedBy) ||
                other.modifiedBy == modifiedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      role,
      email,
      phone,
      address,
      loyaltyProgram,
      loyaltyPoints,
      outstandingAmount,
      created,
      modified,
      modifiedBy);

  /// Create a copy of UpdatedParty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatedPartyImplCopyWith<_$UpdatedPartyImpl> get copyWith =>
      __$$UpdatedPartyImplCopyWithImpl<_$UpdatedPartyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatedPartyImplToJson(
      this,
    );
  }
}

abstract class _UpdatedParty implements UpdatedParty {
  const factory _UpdatedParty(
      {required final String name,
      required final String role,
      required final String? email,
      required final String? phone,
      required final String? address,
      required final String? loyaltyProgram,
      required final int loyaltyPoints,
      @JsonKey(name: 'outstandingAmount', fromJson: _stringToDouble)
      required final double outstandingAmount,
      required final String created,
      required final String modified,
      required final String modifiedBy}) = _$UpdatedPartyImpl;

  factory _UpdatedParty.fromJson(Map<String, dynamic> json) =
      _$UpdatedPartyImpl.fromJson;

  @override
  String get name;
  @override
  String get role;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get address;
  @override
  String? get loyaltyProgram;
  @override
  int get loyaltyPoints;
  @override
  @JsonKey(name: 'outstandingAmount', fromJson: _stringToDouble)
  double get outstandingAmount;
  @override
  String get created;
  @override
  String get modified;
  @override
  String get modifiedBy;

  /// Create a copy of UpdatedParty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatedPartyImplCopyWith<_$UpdatedPartyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

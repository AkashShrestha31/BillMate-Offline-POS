// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'party_transaction_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartyTransactionSummaryModel _$PartyTransactionSummaryModelFromJson(
    Map<String, dynamic> json) {
  return _PartyTransactionSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$PartyTransactionSummaryModel {
  @JsonKey(name: 'total_sales_invoices')
  int? get totalSalesInvoices => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sales_amount')
  double? get totalSalesAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_purchase_invoices')
  int? get totalPurchaseInvoices => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_purchase_amount')
  double? get totalPurchaseAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_payments')
  int? get totalPayments => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_payment_amount')
  double? get totalPaymentAmount => throw _privateConstructorUsedError;

  /// Serializes this PartyTransactionSummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartyTransactionSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartyTransactionSummaryModelCopyWith<PartyTransactionSummaryModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartyTransactionSummaryModelCopyWith<$Res> {
  factory $PartyTransactionSummaryModelCopyWith(
          PartyTransactionSummaryModel value,
          $Res Function(PartyTransactionSummaryModel) then) =
      _$PartyTransactionSummaryModelCopyWithImpl<$Res,
          PartyTransactionSummaryModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_sales_invoices') int? totalSalesInvoices,
      @JsonKey(name: 'total_sales_amount') double? totalSalesAmount,
      @JsonKey(name: 'total_purchase_invoices') int? totalPurchaseInvoices,
      @JsonKey(name: 'total_purchase_amount') double? totalPurchaseAmount,
      @JsonKey(name: 'total_payments') int? totalPayments,
      @JsonKey(name: 'total_payment_amount') double? totalPaymentAmount});
}

/// @nodoc
class _$PartyTransactionSummaryModelCopyWithImpl<$Res,
        $Val extends PartyTransactionSummaryModel>
    implements $PartyTransactionSummaryModelCopyWith<$Res> {
  _$PartyTransactionSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartyTransactionSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSalesInvoices = freezed,
    Object? totalSalesAmount = freezed,
    Object? totalPurchaseInvoices = freezed,
    Object? totalPurchaseAmount = freezed,
    Object? totalPayments = freezed,
    Object? totalPaymentAmount = freezed,
  }) {
    return _then(_value.copyWith(
      totalSalesInvoices: freezed == totalSalesInvoices
          ? _value.totalSalesInvoices
          : totalSalesInvoices // ignore: cast_nullable_to_non_nullable
              as int?,
      totalSalesAmount: freezed == totalSalesAmount
          ? _value.totalSalesAmount
          : totalSalesAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      totalPurchaseInvoices: freezed == totalPurchaseInvoices
          ? _value.totalPurchaseInvoices
          : totalPurchaseInvoices // ignore: cast_nullable_to_non_nullable
              as int?,
      totalPurchaseAmount: freezed == totalPurchaseAmount
          ? _value.totalPurchaseAmount
          : totalPurchaseAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      totalPayments: freezed == totalPayments
          ? _value.totalPayments
          : totalPayments // ignore: cast_nullable_to_non_nullable
              as int?,
      totalPaymentAmount: freezed == totalPaymentAmount
          ? _value.totalPaymentAmount
          : totalPaymentAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartyTransactionSummaryModelImplCopyWith<$Res>
    implements $PartyTransactionSummaryModelCopyWith<$Res> {
  factory _$$PartyTransactionSummaryModelImplCopyWith(
          _$PartyTransactionSummaryModelImpl value,
          $Res Function(_$PartyTransactionSummaryModelImpl) then) =
      __$$PartyTransactionSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_sales_invoices') int? totalSalesInvoices,
      @JsonKey(name: 'total_sales_amount') double? totalSalesAmount,
      @JsonKey(name: 'total_purchase_invoices') int? totalPurchaseInvoices,
      @JsonKey(name: 'total_purchase_amount') double? totalPurchaseAmount,
      @JsonKey(name: 'total_payments') int? totalPayments,
      @JsonKey(name: 'total_payment_amount') double? totalPaymentAmount});
}

/// @nodoc
class __$$PartyTransactionSummaryModelImplCopyWithImpl<$Res>
    extends _$PartyTransactionSummaryModelCopyWithImpl<$Res,
        _$PartyTransactionSummaryModelImpl>
    implements _$$PartyTransactionSummaryModelImplCopyWith<$Res> {
  __$$PartyTransactionSummaryModelImplCopyWithImpl(
      _$PartyTransactionSummaryModelImpl _value,
      $Res Function(_$PartyTransactionSummaryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartyTransactionSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSalesInvoices = freezed,
    Object? totalSalesAmount = freezed,
    Object? totalPurchaseInvoices = freezed,
    Object? totalPurchaseAmount = freezed,
    Object? totalPayments = freezed,
    Object? totalPaymentAmount = freezed,
  }) {
    return _then(_$PartyTransactionSummaryModelImpl(
      totalSalesInvoices: freezed == totalSalesInvoices
          ? _value.totalSalesInvoices
          : totalSalesInvoices // ignore: cast_nullable_to_non_nullable
              as int?,
      totalSalesAmount: freezed == totalSalesAmount
          ? _value.totalSalesAmount
          : totalSalesAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      totalPurchaseInvoices: freezed == totalPurchaseInvoices
          ? _value.totalPurchaseInvoices
          : totalPurchaseInvoices // ignore: cast_nullable_to_non_nullable
              as int?,
      totalPurchaseAmount: freezed == totalPurchaseAmount
          ? _value.totalPurchaseAmount
          : totalPurchaseAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      totalPayments: freezed == totalPayments
          ? _value.totalPayments
          : totalPayments // ignore: cast_nullable_to_non_nullable
              as int?,
      totalPaymentAmount: freezed == totalPaymentAmount
          ? _value.totalPaymentAmount
          : totalPaymentAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartyTransactionSummaryModelImpl
    implements _PartyTransactionSummaryModel {
  const _$PartyTransactionSummaryModelImpl(
      {@JsonKey(name: 'total_sales_invoices') this.totalSalesInvoices,
      @JsonKey(name: 'total_sales_amount') this.totalSalesAmount,
      @JsonKey(name: 'total_purchase_invoices') this.totalPurchaseInvoices,
      @JsonKey(name: 'total_purchase_amount') this.totalPurchaseAmount,
      @JsonKey(name: 'total_payments') this.totalPayments,
      @JsonKey(name: 'total_payment_amount') this.totalPaymentAmount});

  factory _$PartyTransactionSummaryModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PartyTransactionSummaryModelImplFromJson(json);

  @override
  @JsonKey(name: 'total_sales_invoices')
  final int? totalSalesInvoices;
  @override
  @JsonKey(name: 'total_sales_amount')
  final double? totalSalesAmount;
  @override
  @JsonKey(name: 'total_purchase_invoices')
  final int? totalPurchaseInvoices;
  @override
  @JsonKey(name: 'total_purchase_amount')
  final double? totalPurchaseAmount;
  @override
  @JsonKey(name: 'total_payments')
  final int? totalPayments;
  @override
  @JsonKey(name: 'total_payment_amount')
  final double? totalPaymentAmount;

  @override
  String toString() {
    return 'PartyTransactionSummaryModel(totalSalesInvoices: $totalSalesInvoices, totalSalesAmount: $totalSalesAmount, totalPurchaseInvoices: $totalPurchaseInvoices, totalPurchaseAmount: $totalPurchaseAmount, totalPayments: $totalPayments, totalPaymentAmount: $totalPaymentAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartyTransactionSummaryModelImpl &&
            (identical(other.totalSalesInvoices, totalSalesInvoices) ||
                other.totalSalesInvoices == totalSalesInvoices) &&
            (identical(other.totalSalesAmount, totalSalesAmount) ||
                other.totalSalesAmount == totalSalesAmount) &&
            (identical(other.totalPurchaseInvoices, totalPurchaseInvoices) ||
                other.totalPurchaseInvoices == totalPurchaseInvoices) &&
            (identical(other.totalPurchaseAmount, totalPurchaseAmount) ||
                other.totalPurchaseAmount == totalPurchaseAmount) &&
            (identical(other.totalPayments, totalPayments) ||
                other.totalPayments == totalPayments) &&
            (identical(other.totalPaymentAmount, totalPaymentAmount) ||
                other.totalPaymentAmount == totalPaymentAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalSalesInvoices,
      totalSalesAmount,
      totalPurchaseInvoices,
      totalPurchaseAmount,
      totalPayments,
      totalPaymentAmount);

  /// Create a copy of PartyTransactionSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartyTransactionSummaryModelImplCopyWith<
          _$PartyTransactionSummaryModelImpl>
      get copyWith => __$$PartyTransactionSummaryModelImplCopyWithImpl<
          _$PartyTransactionSummaryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartyTransactionSummaryModelImplToJson(
      this,
    );
  }
}

abstract class _PartyTransactionSummaryModel
    implements PartyTransactionSummaryModel {
  const factory _PartyTransactionSummaryModel(
      {@JsonKey(name: 'total_sales_invoices') final int? totalSalesInvoices,
      @JsonKey(name: 'total_sales_amount') final double? totalSalesAmount,
      @JsonKey(name: 'total_purchase_invoices')
      final int? totalPurchaseInvoices,
      @JsonKey(name: 'total_purchase_amount') final double? totalPurchaseAmount,
      @JsonKey(name: 'total_payments') final int? totalPayments,
      @JsonKey(name: 'total_payment_amount')
      final double? totalPaymentAmount}) = _$PartyTransactionSummaryModelImpl;

  factory _PartyTransactionSummaryModel.fromJson(Map<String, dynamic> json) =
      _$PartyTransactionSummaryModelImpl.fromJson;

  @override
  @JsonKey(name: 'total_sales_invoices')
  int? get totalSalesInvoices;
  @override
  @JsonKey(name: 'total_sales_amount')
  double? get totalSalesAmount;
  @override
  @JsonKey(name: 'total_purchase_invoices')
  int? get totalPurchaseInvoices;
  @override
  @JsonKey(name: 'total_purchase_amount')
  double? get totalPurchaseAmount;
  @override
  @JsonKey(name: 'total_payments')
  int? get totalPayments;
  @override
  @JsonKey(name: 'total_payment_amount')
  double? get totalPaymentAmount;

  /// Create a copy of PartyTransactionSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartyTransactionSummaryModelImplCopyWith<
          _$PartyTransactionSummaryModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

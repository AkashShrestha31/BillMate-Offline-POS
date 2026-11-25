// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hotel_sales_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HotelSalesResponseModel _$HotelSalesResponseModelFromJson(
    Map<String, dynamic> json) {
  return _HotelSalesResponseModel.fromJson(json);
}

/// @nodoc
mixin _$HotelSalesResponseModel {
  int get count => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<SalesReport> get results => throw _privateConstructorUsedError;

  /// Serializes this HotelSalesResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HotelSalesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HotelSalesResponseModelCopyWith<HotelSalesResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HotelSalesResponseModelCopyWith<$Res> {
  factory $HotelSalesResponseModelCopyWith(HotelSalesResponseModel value,
          $Res Function(HotelSalesResponseModel) then) =
      _$HotelSalesResponseModelCopyWithImpl<$Res, HotelSalesResponseModel>;
  @useResult
  $Res call(
      {int count, String? next, String? previous, List<SalesReport> results});
}

/// @nodoc
class _$HotelSalesResponseModelCopyWithImpl<$Res,
        $Val extends HotelSalesResponseModel>
    implements $HotelSalesResponseModelCopyWith<$Res> {
  _$HotelSalesResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HotelSalesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = null,
  }) {
    return _then(_value.copyWith(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<SalesReport>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HotelSalesResponseModelImplCopyWith<$Res>
    implements $HotelSalesResponseModelCopyWith<$Res> {
  factory _$$HotelSalesResponseModelImplCopyWith(
          _$HotelSalesResponseModelImpl value,
          $Res Function(_$HotelSalesResponseModelImpl) then) =
      __$$HotelSalesResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int count, String? next, String? previous, List<SalesReport> results});
}

/// @nodoc
class __$$HotelSalesResponseModelImplCopyWithImpl<$Res>
    extends _$HotelSalesResponseModelCopyWithImpl<$Res,
        _$HotelSalesResponseModelImpl>
    implements _$$HotelSalesResponseModelImplCopyWith<$Res> {
  __$$HotelSalesResponseModelImplCopyWithImpl(
      _$HotelSalesResponseModelImpl _value,
      $Res Function(_$HotelSalesResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of HotelSalesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = null,
  }) {
    return _then(_$HotelSalesResponseModelImpl(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<SalesReport>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HotelSalesResponseModelImpl implements _HotelSalesResponseModel {
  const _$HotelSalesResponseModelImpl(
      {required this.count,
      required this.next,
      required this.previous,
      required final List<SalesReport> results})
      : _results = results;

  factory _$HotelSalesResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HotelSalesResponseModelImplFromJson(json);

  @override
  final int count;
  @override
  final String? next;
  @override
  final String? previous;
  final List<SalesReport> _results;
  @override
  List<SalesReport> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'HotelSalesResponseModel(count: $count, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotelSalesResponseModelImpl &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.previous, previous) ||
                other.previous == previous) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, count, next, previous,
      const DeepCollectionEquality().hash(_results));

  /// Create a copy of HotelSalesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HotelSalesResponseModelImplCopyWith<_$HotelSalesResponseModelImpl>
      get copyWith => __$$HotelSalesResponseModelImplCopyWithImpl<
          _$HotelSalesResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HotelSalesResponseModelImplToJson(
      this,
    );
  }
}

abstract class _HotelSalesResponseModel implements HotelSalesResponseModel {
  const factory _HotelSalesResponseModel(
          {required final int count,
          required final String? next,
          required final String? previous,
          required final List<SalesReport> results}) =
      _$HotelSalesResponseModelImpl;

  factory _HotelSalesResponseModel.fromJson(Map<String, dynamic> json) =
      _$HotelSalesResponseModelImpl.fromJson;

  @override
  int get count;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<SalesReport> get results;

  /// Create a copy of HotelSalesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HotelSalesResponseModelImplCopyWith<_$HotelSalesResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SalesReport _$SalesReportFromJson(Map<String, dynamic> json) {
  return _SalesReport.fromJson(json);
}

/// @nodoc
mixin _$SalesReport {
  int get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _stringToDouble)
  double get openingBalance => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _stringToDouble)
  double get salesAmount => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _stringToDouble)
  double get qrAmount => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _stringToDouble)
  double get cashAmount => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _stringToDouble)
  double get discount => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _stringToDouble)
  double get expenses => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _stringToDouble)
  double get unPaid => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _stringToDouble)
  double get unPaidDiscount => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _stringToDouble)
  double get creditPaidCash => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _stringToDouble)
  double get creditQr => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _stringToDouble)
  double get closingBalance => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _stringToDouble)
  double get lostMoney => throw _privateConstructorUsedError;

  /// Serializes this SalesReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SalesReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalesReportCopyWith<SalesReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesReportCopyWith<$Res> {
  factory $SalesReportCopyWith(
          SalesReport value, $Res Function(SalesReport) then) =
      _$SalesReportCopyWithImpl<$Res, SalesReport>;
  @useResult
  $Res call(
      {int id,
      DateTime date,
      @JsonKey(fromJson: _stringToDouble) double openingBalance,
      @JsonKey(fromJson: _stringToDouble) double salesAmount,
      @JsonKey(fromJson: _stringToDouble) double qrAmount,
      @JsonKey(fromJson: _stringToDouble) double cashAmount,
      @JsonKey(fromJson: _stringToDouble) double discount,
      @JsonKey(fromJson: _stringToDouble) double expenses,
      @JsonKey(fromJson: _stringToDouble) double unPaid,
      @JsonKey(fromJson: _stringToDouble) double unPaidDiscount,
      @JsonKey(fromJson: _stringToDouble) double creditPaidCash,
      @JsonKey(fromJson: _stringToDouble) double creditQr,
      @JsonKey(fromJson: _stringToDouble) double closingBalance,
      @JsonKey(fromJson: _stringToDouble) double lostMoney});
}

/// @nodoc
class _$SalesReportCopyWithImpl<$Res, $Val extends SalesReport>
    implements $SalesReportCopyWith<$Res> {
  _$SalesReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? openingBalance = null,
    Object? salesAmount = null,
    Object? qrAmount = null,
    Object? cashAmount = null,
    Object? discount = null,
    Object? expenses = null,
    Object? unPaid = null,
    Object? unPaidDiscount = null,
    Object? creditPaidCash = null,
    Object? creditQr = null,
    Object? closingBalance = null,
    Object? lostMoney = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      openingBalance: null == openingBalance
          ? _value.openingBalance
          : openingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      salesAmount: null == salesAmount
          ? _value.salesAmount
          : salesAmount // ignore: cast_nullable_to_non_nullable
              as double,
      qrAmount: null == qrAmount
          ? _value.qrAmount
          : qrAmount // ignore: cast_nullable_to_non_nullable
              as double,
      cashAmount: null == cashAmount
          ? _value.cashAmount
          : cashAmount // ignore: cast_nullable_to_non_nullable
              as double,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
      expenses: null == expenses
          ? _value.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as double,
      unPaid: null == unPaid
          ? _value.unPaid
          : unPaid // ignore: cast_nullable_to_non_nullable
              as double,
      unPaidDiscount: null == unPaidDiscount
          ? _value.unPaidDiscount
          : unPaidDiscount // ignore: cast_nullable_to_non_nullable
              as double,
      creditPaidCash: null == creditPaidCash
          ? _value.creditPaidCash
          : creditPaidCash // ignore: cast_nullable_to_non_nullable
              as double,
      creditQr: null == creditQr
          ? _value.creditQr
          : creditQr // ignore: cast_nullable_to_non_nullable
              as double,
      closingBalance: null == closingBalance
          ? _value.closingBalance
          : closingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      lostMoney: null == lostMoney
          ? _value.lostMoney
          : lostMoney // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SalesReportImplCopyWith<$Res>
    implements $SalesReportCopyWith<$Res> {
  factory _$$SalesReportImplCopyWith(
          _$SalesReportImpl value, $Res Function(_$SalesReportImpl) then) =
      __$$SalesReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime date,
      @JsonKey(fromJson: _stringToDouble) double openingBalance,
      @JsonKey(fromJson: _stringToDouble) double salesAmount,
      @JsonKey(fromJson: _stringToDouble) double qrAmount,
      @JsonKey(fromJson: _stringToDouble) double cashAmount,
      @JsonKey(fromJson: _stringToDouble) double discount,
      @JsonKey(fromJson: _stringToDouble) double expenses,
      @JsonKey(fromJson: _stringToDouble) double unPaid,
      @JsonKey(fromJson: _stringToDouble) double unPaidDiscount,
      @JsonKey(fromJson: _stringToDouble) double creditPaidCash,
      @JsonKey(fromJson: _stringToDouble) double creditQr,
      @JsonKey(fromJson: _stringToDouble) double closingBalance,
      @JsonKey(fromJson: _stringToDouble) double lostMoney});
}

/// @nodoc
class __$$SalesReportImplCopyWithImpl<$Res>
    extends _$SalesReportCopyWithImpl<$Res, _$SalesReportImpl>
    implements _$$SalesReportImplCopyWith<$Res> {
  __$$SalesReportImplCopyWithImpl(
      _$SalesReportImpl _value, $Res Function(_$SalesReportImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? openingBalance = null,
    Object? salesAmount = null,
    Object? qrAmount = null,
    Object? cashAmount = null,
    Object? discount = null,
    Object? expenses = null,
    Object? unPaid = null,
    Object? unPaidDiscount = null,
    Object? creditPaidCash = null,
    Object? creditQr = null,
    Object? closingBalance = null,
    Object? lostMoney = null,
  }) {
    return _then(_$SalesReportImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      openingBalance: null == openingBalance
          ? _value.openingBalance
          : openingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      salesAmount: null == salesAmount
          ? _value.salesAmount
          : salesAmount // ignore: cast_nullable_to_non_nullable
              as double,
      qrAmount: null == qrAmount
          ? _value.qrAmount
          : qrAmount // ignore: cast_nullable_to_non_nullable
              as double,
      cashAmount: null == cashAmount
          ? _value.cashAmount
          : cashAmount // ignore: cast_nullable_to_non_nullable
              as double,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
      expenses: null == expenses
          ? _value.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as double,
      unPaid: null == unPaid
          ? _value.unPaid
          : unPaid // ignore: cast_nullable_to_non_nullable
              as double,
      unPaidDiscount: null == unPaidDiscount
          ? _value.unPaidDiscount
          : unPaidDiscount // ignore: cast_nullable_to_non_nullable
              as double,
      creditPaidCash: null == creditPaidCash
          ? _value.creditPaidCash
          : creditPaidCash // ignore: cast_nullable_to_non_nullable
              as double,
      creditQr: null == creditQr
          ? _value.creditQr
          : creditQr // ignore: cast_nullable_to_non_nullable
              as double,
      closingBalance: null == closingBalance
          ? _value.closingBalance
          : closingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      lostMoney: null == lostMoney
          ? _value.lostMoney
          : lostMoney // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$SalesReportImpl extends _SalesReport {
  const _$SalesReportImpl(
      {required this.id,
      required this.date,
      @JsonKey(fromJson: _stringToDouble) required this.openingBalance,
      @JsonKey(fromJson: _stringToDouble) required this.salesAmount,
      @JsonKey(fromJson: _stringToDouble) required this.qrAmount,
      @JsonKey(fromJson: _stringToDouble) required this.cashAmount,
      @JsonKey(fromJson: _stringToDouble) required this.discount,
      @JsonKey(fromJson: _stringToDouble) required this.expenses,
      @JsonKey(fromJson: _stringToDouble) required this.unPaid,
      @JsonKey(fromJson: _stringToDouble) required this.unPaidDiscount,
      @JsonKey(fromJson: _stringToDouble) required this.creditPaidCash,
      @JsonKey(fromJson: _stringToDouble) required this.creditQr,
      @JsonKey(fromJson: _stringToDouble) required this.closingBalance,
      @JsonKey(fromJson: _stringToDouble) required this.lostMoney})
      : super._();

  factory _$SalesReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesReportImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime date;
  @override
  @JsonKey(fromJson: _stringToDouble)
  final double openingBalance;
  @override
  @JsonKey(fromJson: _stringToDouble)
  final double salesAmount;
  @override
  @JsonKey(fromJson: _stringToDouble)
  final double qrAmount;
  @override
  @JsonKey(fromJson: _stringToDouble)
  final double cashAmount;
  @override
  @JsonKey(fromJson: _stringToDouble)
  final double discount;
  @override
  @JsonKey(fromJson: _stringToDouble)
  final double expenses;
  @override
  @JsonKey(fromJson: _stringToDouble)
  final double unPaid;
  @override
  @JsonKey(fromJson: _stringToDouble)
  final double unPaidDiscount;
  @override
  @JsonKey(fromJson: _stringToDouble)
  final double creditPaidCash;
  @override
  @JsonKey(fromJson: _stringToDouble)
  final double creditQr;
  @override
  @JsonKey(fromJson: _stringToDouble)
  final double closingBalance;
  @override
  @JsonKey(fromJson: _stringToDouble)
  final double lostMoney;

  @override
  String toString() {
    return 'SalesReport(id: $id, date: $date, openingBalance: $openingBalance, salesAmount: $salesAmount, qrAmount: $qrAmount, cashAmount: $cashAmount, discount: $discount, expenses: $expenses, unPaid: $unPaid, unPaidDiscount: $unPaidDiscount, creditPaidCash: $creditPaidCash, creditQr: $creditQr, closingBalance: $closingBalance, lostMoney: $lostMoney)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesReportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.openingBalance, openingBalance) ||
                other.openingBalance == openingBalance) &&
            (identical(other.salesAmount, salesAmount) ||
                other.salesAmount == salesAmount) &&
            (identical(other.qrAmount, qrAmount) ||
                other.qrAmount == qrAmount) &&
            (identical(other.cashAmount, cashAmount) ||
                other.cashAmount == cashAmount) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.expenses, expenses) ||
                other.expenses == expenses) &&
            (identical(other.unPaid, unPaid) || other.unPaid == unPaid) &&
            (identical(other.unPaidDiscount, unPaidDiscount) ||
                other.unPaidDiscount == unPaidDiscount) &&
            (identical(other.creditPaidCash, creditPaidCash) ||
                other.creditPaidCash == creditPaidCash) &&
            (identical(other.creditQr, creditQr) ||
                other.creditQr == creditQr) &&
            (identical(other.closingBalance, closingBalance) ||
                other.closingBalance == closingBalance) &&
            (identical(other.lostMoney, lostMoney) ||
                other.lostMoney == lostMoney));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      date,
      openingBalance,
      salesAmount,
      qrAmount,
      cashAmount,
      discount,
      expenses,
      unPaid,
      unPaidDiscount,
      creditPaidCash,
      creditQr,
      closingBalance,
      lostMoney);

  /// Create a copy of SalesReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesReportImplCopyWith<_$SalesReportImpl> get copyWith =>
      __$$SalesReportImplCopyWithImpl<_$SalesReportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesReportImplToJson(
      this,
    );
  }
}

abstract class _SalesReport extends SalesReport {
  const factory _SalesReport(
      {required final int id,
      required final DateTime date,
      @JsonKey(fromJson: _stringToDouble) required final double openingBalance,
      @JsonKey(fromJson: _stringToDouble) required final double salesAmount,
      @JsonKey(fromJson: _stringToDouble) required final double qrAmount,
      @JsonKey(fromJson: _stringToDouble) required final double cashAmount,
      @JsonKey(fromJson: _stringToDouble) required final double discount,
      @JsonKey(fromJson: _stringToDouble) required final double expenses,
      @JsonKey(fromJson: _stringToDouble) required final double unPaid,
      @JsonKey(fromJson: _stringToDouble) required final double unPaidDiscount,
      @JsonKey(fromJson: _stringToDouble) required final double creditPaidCash,
      @JsonKey(fromJson: _stringToDouble) required final double creditQr,
      @JsonKey(fromJson: _stringToDouble) required final double closingBalance,
      @JsonKey(fromJson: _stringToDouble)
      required final double lostMoney}) = _$SalesReportImpl;
  const _SalesReport._() : super._();

  factory _SalesReport.fromJson(Map<String, dynamic> json) =
      _$SalesReportImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get date;
  @override
  @JsonKey(fromJson: _stringToDouble)
  double get openingBalance;
  @override
  @JsonKey(fromJson: _stringToDouble)
  double get salesAmount;
  @override
  @JsonKey(fromJson: _stringToDouble)
  double get qrAmount;
  @override
  @JsonKey(fromJson: _stringToDouble)
  double get cashAmount;
  @override
  @JsonKey(fromJson: _stringToDouble)
  double get discount;
  @override
  @JsonKey(fromJson: _stringToDouble)
  double get expenses;
  @override
  @JsonKey(fromJson: _stringToDouble)
  double get unPaid;
  @override
  @JsonKey(fromJson: _stringToDouble)
  double get unPaidDiscount;
  @override
  @JsonKey(fromJson: _stringToDouble)
  double get creditPaidCash;
  @override
  @JsonKey(fromJson: _stringToDouble)
  double get creditQr;
  @override
  @JsonKey(fromJson: _stringToDouble)
  double get closingBalance;
  @override
  @JsonKey(fromJson: _stringToDouble)
  double get lostMoney;

  /// Create a copy of SalesReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesReportImplCopyWith<_$SalesReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cash_register_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CashRegisterModel _$CashRegisterModelFromJson(Map<String, dynamic> json) {
  return _CashRegisterModel.fromJson(json);
}

/// @nodoc
mixin _$CashRegisterModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'shift_date')
  String? get shiftDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'opening_time')
  String? get openingTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'closing_time')
  String? get closingTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'opening_amount')
  double? get openingAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'closing_amount')
  double? get closingAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'expected_amount')
  double? get expectedAmount => throw _privateConstructorUsedError;
  double? get difference => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sales')
  double? get totalSales => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_cash_in')
  double? get totalCashIn => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_cash_out')
  double? get totalCashOut => throw _privateConstructorUsedError;
  @JsonKey(name: 'opening_note')
  String? get openingNote => throw _privateConstructorUsedError;
  @JsonKey(name: 'closing_note')
  String? get closingNote => throw _privateConstructorUsedError;
  @JsonKey(name: 'opened_by')
  String? get openedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'closed_by')
  String? get closedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'opening_denominations')
  List<DenominationModel>? get openingDenominations =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'closing_denominations')
  List<DenominationModel>? get closingDenominations =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'total_denominations')
  double? get totalDenominations => throw _privateConstructorUsedError;
  @JsonKey(name: 'variance_note')
  String? get varianceNote => throw _privateConstructorUsedError;
  @JsonKey(name: 'cash_movements')
  List<CashMovementModel>? get cashMovements =>
      throw _privateConstructorUsedError;

  /// Serializes this CashRegisterModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CashRegisterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CashRegisterModelCopyWith<CashRegisterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashRegisterModelCopyWith<$Res> {
  factory $CashRegisterModelCopyWith(
          CashRegisterModel value, $Res Function(CashRegisterModel) then) =
      _$CashRegisterModelCopyWithImpl<$Res, CashRegisterModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      String status,
      @JsonKey(name: 'shift_date') String? shiftDate,
      @JsonKey(name: 'opening_time') String? openingTime,
      @JsonKey(name: 'closing_time') String? closingTime,
      @JsonKey(name: 'opening_amount') double? openingAmount,
      @JsonKey(name: 'closing_amount') double? closingAmount,
      @JsonKey(name: 'expected_amount') double? expectedAmount,
      double? difference,
      @JsonKey(name: 'total_sales') double? totalSales,
      @JsonKey(name: 'total_cash_in') double? totalCashIn,
      @JsonKey(name: 'total_cash_out') double? totalCashOut,
      @JsonKey(name: 'opening_note') String? openingNote,
      @JsonKey(name: 'closing_note') String? closingNote,
      @JsonKey(name: 'opened_by') String? openedBy,
      @JsonKey(name: 'closed_by') String? closedBy,
      @JsonKey(name: 'opening_denominations')
      List<DenominationModel>? openingDenominations,
      @JsonKey(name: 'closing_denominations')
      List<DenominationModel>? closingDenominations,
      @JsonKey(name: 'total_denominations') double? totalDenominations,
      @JsonKey(name: 'variance_note') String? varianceNote,
      @JsonKey(name: 'cash_movements') List<CashMovementModel>? cashMovements});
}

/// @nodoc
class _$CashRegisterModelCopyWithImpl<$Res, $Val extends CashRegisterModel>
    implements $CashRegisterModelCopyWith<$Res> {
  _$CashRegisterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CashRegisterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? shiftDate = freezed,
    Object? openingTime = freezed,
    Object? closingTime = freezed,
    Object? openingAmount = freezed,
    Object? closingAmount = freezed,
    Object? expectedAmount = freezed,
    Object? difference = freezed,
    Object? totalSales = freezed,
    Object? totalCashIn = freezed,
    Object? totalCashOut = freezed,
    Object? openingNote = freezed,
    Object? closingNote = freezed,
    Object? openedBy = freezed,
    Object? closedBy = freezed,
    Object? openingDenominations = freezed,
    Object? closingDenominations = freezed,
    Object? totalDenominations = freezed,
    Object? varianceNote = freezed,
    Object? cashMovements = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      shiftDate: freezed == shiftDate
          ? _value.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as String?,
      openingTime: freezed == openingTime
          ? _value.openingTime
          : openingTime // ignore: cast_nullable_to_non_nullable
              as String?,
      closingTime: freezed == closingTime
          ? _value.closingTime
          : closingTime // ignore: cast_nullable_to_non_nullable
              as String?,
      openingAmount: freezed == openingAmount
          ? _value.openingAmount
          : openingAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      closingAmount: freezed == closingAmount
          ? _value.closingAmount
          : closingAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      expectedAmount: freezed == expectedAmount
          ? _value.expectedAmount
          : expectedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      difference: freezed == difference
          ? _value.difference
          : difference // ignore: cast_nullable_to_non_nullable
              as double?,
      totalSales: freezed == totalSales
          ? _value.totalSales
          : totalSales // ignore: cast_nullable_to_non_nullable
              as double?,
      totalCashIn: freezed == totalCashIn
          ? _value.totalCashIn
          : totalCashIn // ignore: cast_nullable_to_non_nullable
              as double?,
      totalCashOut: freezed == totalCashOut
          ? _value.totalCashOut
          : totalCashOut // ignore: cast_nullable_to_non_nullable
              as double?,
      openingNote: freezed == openingNote
          ? _value.openingNote
          : openingNote // ignore: cast_nullable_to_non_nullable
              as String?,
      closingNote: freezed == closingNote
          ? _value.closingNote
          : closingNote // ignore: cast_nullable_to_non_nullable
              as String?,
      openedBy: freezed == openedBy
          ? _value.openedBy
          : openedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      closedBy: freezed == closedBy
          ? _value.closedBy
          : closedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      openingDenominations: freezed == openingDenominations
          ? _value.openingDenominations
          : openingDenominations // ignore: cast_nullable_to_non_nullable
              as List<DenominationModel>?,
      closingDenominations: freezed == closingDenominations
          ? _value.closingDenominations
          : closingDenominations // ignore: cast_nullable_to_non_nullable
              as List<DenominationModel>?,
      totalDenominations: freezed == totalDenominations
          ? _value.totalDenominations
          : totalDenominations // ignore: cast_nullable_to_non_nullable
              as double?,
      varianceNote: freezed == varianceNote
          ? _value.varianceNote
          : varianceNote // ignore: cast_nullable_to_non_nullable
              as String?,
      cashMovements: freezed == cashMovements
          ? _value.cashMovements
          : cashMovements // ignore: cast_nullable_to_non_nullable
              as List<CashMovementModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CashRegisterModelImplCopyWith<$Res>
    implements $CashRegisterModelCopyWith<$Res> {
  factory _$$CashRegisterModelImplCopyWith(_$CashRegisterModelImpl value,
          $Res Function(_$CashRegisterModelImpl) then) =
      __$$CashRegisterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String status,
      @JsonKey(name: 'shift_date') String? shiftDate,
      @JsonKey(name: 'opening_time') String? openingTime,
      @JsonKey(name: 'closing_time') String? closingTime,
      @JsonKey(name: 'opening_amount') double? openingAmount,
      @JsonKey(name: 'closing_amount') double? closingAmount,
      @JsonKey(name: 'expected_amount') double? expectedAmount,
      double? difference,
      @JsonKey(name: 'total_sales') double? totalSales,
      @JsonKey(name: 'total_cash_in') double? totalCashIn,
      @JsonKey(name: 'total_cash_out') double? totalCashOut,
      @JsonKey(name: 'opening_note') String? openingNote,
      @JsonKey(name: 'closing_note') String? closingNote,
      @JsonKey(name: 'opened_by') String? openedBy,
      @JsonKey(name: 'closed_by') String? closedBy,
      @JsonKey(name: 'opening_denominations')
      List<DenominationModel>? openingDenominations,
      @JsonKey(name: 'closing_denominations')
      List<DenominationModel>? closingDenominations,
      @JsonKey(name: 'total_denominations') double? totalDenominations,
      @JsonKey(name: 'variance_note') String? varianceNote,
      @JsonKey(name: 'cash_movements') List<CashMovementModel>? cashMovements});
}

/// @nodoc
class __$$CashRegisterModelImplCopyWithImpl<$Res>
    extends _$CashRegisterModelCopyWithImpl<$Res, _$CashRegisterModelImpl>
    implements _$$CashRegisterModelImplCopyWith<$Res> {
  __$$CashRegisterModelImplCopyWithImpl(_$CashRegisterModelImpl _value,
      $Res Function(_$CashRegisterModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CashRegisterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? shiftDate = freezed,
    Object? openingTime = freezed,
    Object? closingTime = freezed,
    Object? openingAmount = freezed,
    Object? closingAmount = freezed,
    Object? expectedAmount = freezed,
    Object? difference = freezed,
    Object? totalSales = freezed,
    Object? totalCashIn = freezed,
    Object? totalCashOut = freezed,
    Object? openingNote = freezed,
    Object? closingNote = freezed,
    Object? openedBy = freezed,
    Object? closedBy = freezed,
    Object? openingDenominations = freezed,
    Object? closingDenominations = freezed,
    Object? totalDenominations = freezed,
    Object? varianceNote = freezed,
    Object? cashMovements = freezed,
  }) {
    return _then(_$CashRegisterModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      shiftDate: freezed == shiftDate
          ? _value.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as String?,
      openingTime: freezed == openingTime
          ? _value.openingTime
          : openingTime // ignore: cast_nullable_to_non_nullable
              as String?,
      closingTime: freezed == closingTime
          ? _value.closingTime
          : closingTime // ignore: cast_nullable_to_non_nullable
              as String?,
      openingAmount: freezed == openingAmount
          ? _value.openingAmount
          : openingAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      closingAmount: freezed == closingAmount
          ? _value.closingAmount
          : closingAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      expectedAmount: freezed == expectedAmount
          ? _value.expectedAmount
          : expectedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      difference: freezed == difference
          ? _value.difference
          : difference // ignore: cast_nullable_to_non_nullable
              as double?,
      totalSales: freezed == totalSales
          ? _value.totalSales
          : totalSales // ignore: cast_nullable_to_non_nullable
              as double?,
      totalCashIn: freezed == totalCashIn
          ? _value.totalCashIn
          : totalCashIn // ignore: cast_nullable_to_non_nullable
              as double?,
      totalCashOut: freezed == totalCashOut
          ? _value.totalCashOut
          : totalCashOut // ignore: cast_nullable_to_non_nullable
              as double?,
      openingNote: freezed == openingNote
          ? _value.openingNote
          : openingNote // ignore: cast_nullable_to_non_nullable
              as String?,
      closingNote: freezed == closingNote
          ? _value.closingNote
          : closingNote // ignore: cast_nullable_to_non_nullable
              as String?,
      openedBy: freezed == openedBy
          ? _value.openedBy
          : openedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      closedBy: freezed == closedBy
          ? _value.closedBy
          : closedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      openingDenominations: freezed == openingDenominations
          ? _value._openingDenominations
          : openingDenominations // ignore: cast_nullable_to_non_nullable
              as List<DenominationModel>?,
      closingDenominations: freezed == closingDenominations
          ? _value._closingDenominations
          : closingDenominations // ignore: cast_nullable_to_non_nullable
              as List<DenominationModel>?,
      totalDenominations: freezed == totalDenominations
          ? _value.totalDenominations
          : totalDenominations // ignore: cast_nullable_to_non_nullable
              as double?,
      varianceNote: freezed == varianceNote
          ? _value.varianceNote
          : varianceNote // ignore: cast_nullable_to_non_nullable
              as String?,
      cashMovements: freezed == cashMovements
          ? _value._cashMovements
          : cashMovements // ignore: cast_nullable_to_non_nullable
              as List<CashMovementModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CashRegisterModelImpl implements _CashRegisterModel {
  const _$CashRegisterModelImpl(
      {required this.id,
      required this.name,
      required this.status,
      @JsonKey(name: 'shift_date') this.shiftDate,
      @JsonKey(name: 'opening_time') this.openingTime,
      @JsonKey(name: 'closing_time') this.closingTime,
      @JsonKey(name: 'opening_amount') this.openingAmount,
      @JsonKey(name: 'closing_amount') this.closingAmount,
      @JsonKey(name: 'expected_amount') this.expectedAmount,
      this.difference,
      @JsonKey(name: 'total_sales') this.totalSales,
      @JsonKey(name: 'total_cash_in') this.totalCashIn,
      @JsonKey(name: 'total_cash_out') this.totalCashOut,
      @JsonKey(name: 'opening_note') this.openingNote,
      @JsonKey(name: 'closing_note') this.closingNote,
      @JsonKey(name: 'opened_by') this.openedBy,
      @JsonKey(name: 'closed_by') this.closedBy,
      @JsonKey(name: 'opening_denominations')
      final List<DenominationModel>? openingDenominations,
      @JsonKey(name: 'closing_denominations')
      final List<DenominationModel>? closingDenominations,
      @JsonKey(name: 'total_denominations') this.totalDenominations,
      @JsonKey(name: 'variance_note') this.varianceNote,
      @JsonKey(name: 'cash_movements')
      final List<CashMovementModel>? cashMovements})
      : _openingDenominations = openingDenominations,
        _closingDenominations = closingDenominations,
        _cashMovements = cashMovements;

  factory _$CashRegisterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashRegisterModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String status;
  @override
  @JsonKey(name: 'shift_date')
  final String? shiftDate;
  @override
  @JsonKey(name: 'opening_time')
  final String? openingTime;
  @override
  @JsonKey(name: 'closing_time')
  final String? closingTime;
  @override
  @JsonKey(name: 'opening_amount')
  final double? openingAmount;
  @override
  @JsonKey(name: 'closing_amount')
  final double? closingAmount;
  @override
  @JsonKey(name: 'expected_amount')
  final double? expectedAmount;
  @override
  final double? difference;
  @override
  @JsonKey(name: 'total_sales')
  final double? totalSales;
  @override
  @JsonKey(name: 'total_cash_in')
  final double? totalCashIn;
  @override
  @JsonKey(name: 'total_cash_out')
  final double? totalCashOut;
  @override
  @JsonKey(name: 'opening_note')
  final String? openingNote;
  @override
  @JsonKey(name: 'closing_note')
  final String? closingNote;
  @override
  @JsonKey(name: 'opened_by')
  final String? openedBy;
  @override
  @JsonKey(name: 'closed_by')
  final String? closedBy;
  final List<DenominationModel>? _openingDenominations;
  @override
  @JsonKey(name: 'opening_denominations')
  List<DenominationModel>? get openingDenominations {
    final value = _openingDenominations;
    if (value == null) return null;
    if (_openingDenominations is EqualUnmodifiableListView)
      return _openingDenominations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<DenominationModel>? _closingDenominations;
  @override
  @JsonKey(name: 'closing_denominations')
  List<DenominationModel>? get closingDenominations {
    final value = _closingDenominations;
    if (value == null) return null;
    if (_closingDenominations is EqualUnmodifiableListView)
      return _closingDenominations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'total_denominations')
  final double? totalDenominations;
  @override
  @JsonKey(name: 'variance_note')
  final String? varianceNote;
  final List<CashMovementModel>? _cashMovements;
  @override
  @JsonKey(name: 'cash_movements')
  List<CashMovementModel>? get cashMovements {
    final value = _cashMovements;
    if (value == null) return null;
    if (_cashMovements is EqualUnmodifiableListView) return _cashMovements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CashRegisterModel(id: $id, name: $name, status: $status, shiftDate: $shiftDate, openingTime: $openingTime, closingTime: $closingTime, openingAmount: $openingAmount, closingAmount: $closingAmount, expectedAmount: $expectedAmount, difference: $difference, totalSales: $totalSales, totalCashIn: $totalCashIn, totalCashOut: $totalCashOut, openingNote: $openingNote, closingNote: $closingNote, openedBy: $openedBy, closedBy: $closedBy, openingDenominations: $openingDenominations, closingDenominations: $closingDenominations, totalDenominations: $totalDenominations, varianceNote: $varianceNote, cashMovements: $cashMovements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashRegisterModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.shiftDate, shiftDate) ||
                other.shiftDate == shiftDate) &&
            (identical(other.openingTime, openingTime) ||
                other.openingTime == openingTime) &&
            (identical(other.closingTime, closingTime) ||
                other.closingTime == closingTime) &&
            (identical(other.openingAmount, openingAmount) ||
                other.openingAmount == openingAmount) &&
            (identical(other.closingAmount, closingAmount) ||
                other.closingAmount == closingAmount) &&
            (identical(other.expectedAmount, expectedAmount) ||
                other.expectedAmount == expectedAmount) &&
            (identical(other.difference, difference) ||
                other.difference == difference) &&
            (identical(other.totalSales, totalSales) ||
                other.totalSales == totalSales) &&
            (identical(other.totalCashIn, totalCashIn) ||
                other.totalCashIn == totalCashIn) &&
            (identical(other.totalCashOut, totalCashOut) ||
                other.totalCashOut == totalCashOut) &&
            (identical(other.openingNote, openingNote) ||
                other.openingNote == openingNote) &&
            (identical(other.closingNote, closingNote) ||
                other.closingNote == closingNote) &&
            (identical(other.openedBy, openedBy) ||
                other.openedBy == openedBy) &&
            (identical(other.closedBy, closedBy) ||
                other.closedBy == closedBy) &&
            const DeepCollectionEquality()
                .equals(other._openingDenominations, _openingDenominations) &&
            const DeepCollectionEquality()
                .equals(other._closingDenominations, _closingDenominations) &&
            (identical(other.totalDenominations, totalDenominations) ||
                other.totalDenominations == totalDenominations) &&
            (identical(other.varianceNote, varianceNote) ||
                other.varianceNote == varianceNote) &&
            const DeepCollectionEquality()
                .equals(other._cashMovements, _cashMovements));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        status,
        shiftDate,
        openingTime,
        closingTime,
        openingAmount,
        closingAmount,
        expectedAmount,
        difference,
        totalSales,
        totalCashIn,
        totalCashOut,
        openingNote,
        closingNote,
        openedBy,
        closedBy,
        const DeepCollectionEquality().hash(_openingDenominations),
        const DeepCollectionEquality().hash(_closingDenominations),
        totalDenominations,
        varianceNote,
        const DeepCollectionEquality().hash(_cashMovements)
      ]);

  /// Create a copy of CashRegisterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CashRegisterModelImplCopyWith<_$CashRegisterModelImpl> get copyWith =>
      __$$CashRegisterModelImplCopyWithImpl<_$CashRegisterModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CashRegisterModelImplToJson(
      this,
    );
  }
}

abstract class _CashRegisterModel implements CashRegisterModel {
  const factory _CashRegisterModel(
      {required final int id,
      required final String name,
      required final String status,
      @JsonKey(name: 'shift_date') final String? shiftDate,
      @JsonKey(name: 'opening_time') final String? openingTime,
      @JsonKey(name: 'closing_time') final String? closingTime,
      @JsonKey(name: 'opening_amount') final double? openingAmount,
      @JsonKey(name: 'closing_amount') final double? closingAmount,
      @JsonKey(name: 'expected_amount') final double? expectedAmount,
      final double? difference,
      @JsonKey(name: 'total_sales') final double? totalSales,
      @JsonKey(name: 'total_cash_in') final double? totalCashIn,
      @JsonKey(name: 'total_cash_out') final double? totalCashOut,
      @JsonKey(name: 'opening_note') final String? openingNote,
      @JsonKey(name: 'closing_note') final String? closingNote,
      @JsonKey(name: 'opened_by') final String? openedBy,
      @JsonKey(name: 'closed_by') final String? closedBy,
      @JsonKey(name: 'opening_denominations')
      final List<DenominationModel>? openingDenominations,
      @JsonKey(name: 'closing_denominations')
      final List<DenominationModel>? closingDenominations,
      @JsonKey(name: 'total_denominations') final double? totalDenominations,
      @JsonKey(name: 'variance_note') final String? varianceNote,
      @JsonKey(name: 'cash_movements')
      final List<CashMovementModel>? cashMovements}) = _$CashRegisterModelImpl;

  factory _CashRegisterModel.fromJson(Map<String, dynamic> json) =
      _$CashRegisterModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get status;
  @override
  @JsonKey(name: 'shift_date')
  String? get shiftDate;
  @override
  @JsonKey(name: 'opening_time')
  String? get openingTime;
  @override
  @JsonKey(name: 'closing_time')
  String? get closingTime;
  @override
  @JsonKey(name: 'opening_amount')
  double? get openingAmount;
  @override
  @JsonKey(name: 'closing_amount')
  double? get closingAmount;
  @override
  @JsonKey(name: 'expected_amount')
  double? get expectedAmount;
  @override
  double? get difference;
  @override
  @JsonKey(name: 'total_sales')
  double? get totalSales;
  @override
  @JsonKey(name: 'total_cash_in')
  double? get totalCashIn;
  @override
  @JsonKey(name: 'total_cash_out')
  double? get totalCashOut;
  @override
  @JsonKey(name: 'opening_note')
  String? get openingNote;
  @override
  @JsonKey(name: 'closing_note')
  String? get closingNote;
  @override
  @JsonKey(name: 'opened_by')
  String? get openedBy;
  @override
  @JsonKey(name: 'closed_by')
  String? get closedBy;
  @override
  @JsonKey(name: 'opening_denominations')
  List<DenominationModel>? get openingDenominations;
  @override
  @JsonKey(name: 'closing_denominations')
  List<DenominationModel>? get closingDenominations;
  @override
  @JsonKey(name: 'total_denominations')
  double? get totalDenominations;
  @override
  @JsonKey(name: 'variance_note')
  String? get varianceNote;
  @override
  @JsonKey(name: 'cash_movements')
  List<CashMovementModel>? get cashMovements;

  /// Create a copy of CashRegisterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CashRegisterModelImplCopyWith<_$CashRegisterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

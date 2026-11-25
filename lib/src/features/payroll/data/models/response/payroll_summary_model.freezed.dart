// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payroll_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PayrollSummaryModel _$PayrollSummaryModelFromJson(Map<String, dynamic> json) {
  return _PayrollSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$PayrollSummaryModel {
  @JsonKey(name: 'total_gross_pay')
  double get totalGrossPay => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_net_pay')
  double get totalNetPay => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_deductions')
  double get totalDeductions => throw _privateConstructorUsedError;

  /// Serializes this PayrollSummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayrollSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayrollSummaryModelCopyWith<PayrollSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayrollSummaryModelCopyWith<$Res> {
  factory $PayrollSummaryModelCopyWith(
          PayrollSummaryModel value, $Res Function(PayrollSummaryModel) then) =
      _$PayrollSummaryModelCopyWithImpl<$Res, PayrollSummaryModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_gross_pay') double totalGrossPay,
      @JsonKey(name: 'total_net_pay') double totalNetPay,
      @JsonKey(name: 'total_deductions') double totalDeductions});
}

/// @nodoc
class _$PayrollSummaryModelCopyWithImpl<$Res, $Val extends PayrollSummaryModel>
    implements $PayrollSummaryModelCopyWith<$Res> {
  _$PayrollSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayrollSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalGrossPay = null,
    Object? totalNetPay = null,
    Object? totalDeductions = null,
  }) {
    return _then(_value.copyWith(
      totalGrossPay: null == totalGrossPay
          ? _value.totalGrossPay
          : totalGrossPay // ignore: cast_nullable_to_non_nullable
              as double,
      totalNetPay: null == totalNetPay
          ? _value.totalNetPay
          : totalNetPay // ignore: cast_nullable_to_non_nullable
              as double,
      totalDeductions: null == totalDeductions
          ? _value.totalDeductions
          : totalDeductions // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayrollSummaryModelImplCopyWith<$Res>
    implements $PayrollSummaryModelCopyWith<$Res> {
  factory _$$PayrollSummaryModelImplCopyWith(_$PayrollSummaryModelImpl value,
          $Res Function(_$PayrollSummaryModelImpl) then) =
      __$$PayrollSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_gross_pay') double totalGrossPay,
      @JsonKey(name: 'total_net_pay') double totalNetPay,
      @JsonKey(name: 'total_deductions') double totalDeductions});
}

/// @nodoc
class __$$PayrollSummaryModelImplCopyWithImpl<$Res>
    extends _$PayrollSummaryModelCopyWithImpl<$Res, _$PayrollSummaryModelImpl>
    implements _$$PayrollSummaryModelImplCopyWith<$Res> {
  __$$PayrollSummaryModelImplCopyWithImpl(_$PayrollSummaryModelImpl _value,
      $Res Function(_$PayrollSummaryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayrollSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalGrossPay = null,
    Object? totalNetPay = null,
    Object? totalDeductions = null,
  }) {
    return _then(_$PayrollSummaryModelImpl(
      totalGrossPay: null == totalGrossPay
          ? _value.totalGrossPay
          : totalGrossPay // ignore: cast_nullable_to_non_nullable
              as double,
      totalNetPay: null == totalNetPay
          ? _value.totalNetPay
          : totalNetPay // ignore: cast_nullable_to_non_nullable
              as double,
      totalDeductions: null == totalDeductions
          ? _value.totalDeductions
          : totalDeductions // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayrollSummaryModelImpl implements _PayrollSummaryModel {
  const _$PayrollSummaryModelImpl(
      {@JsonKey(name: 'total_gross_pay') required this.totalGrossPay,
      @JsonKey(name: 'total_net_pay') required this.totalNetPay,
      @JsonKey(name: 'total_deductions') this.totalDeductions = 0.0});

  factory _$PayrollSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayrollSummaryModelImplFromJson(json);

  @override
  @JsonKey(name: 'total_gross_pay')
  final double totalGrossPay;
  @override
  @JsonKey(name: 'total_net_pay')
  final double totalNetPay;
  @override
  @JsonKey(name: 'total_deductions')
  final double totalDeductions;

  @override
  String toString() {
    return 'PayrollSummaryModel(totalGrossPay: $totalGrossPay, totalNetPay: $totalNetPay, totalDeductions: $totalDeductions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayrollSummaryModelImpl &&
            (identical(other.totalGrossPay, totalGrossPay) ||
                other.totalGrossPay == totalGrossPay) &&
            (identical(other.totalNetPay, totalNetPay) ||
                other.totalNetPay == totalNetPay) &&
            (identical(other.totalDeductions, totalDeductions) ||
                other.totalDeductions == totalDeductions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, totalGrossPay, totalNetPay, totalDeductions);

  /// Create a copy of PayrollSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayrollSummaryModelImplCopyWith<_$PayrollSummaryModelImpl> get copyWith =>
      __$$PayrollSummaryModelImplCopyWithImpl<_$PayrollSummaryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayrollSummaryModelImplToJson(
      this,
    );
  }
}

abstract class _PayrollSummaryModel implements PayrollSummaryModel {
  const factory _PayrollSummaryModel(
      {@JsonKey(name: 'total_gross_pay') required final double totalGrossPay,
      @JsonKey(name: 'total_net_pay') required final double totalNetPay,
      @JsonKey(name: 'total_deductions')
      final double totalDeductions}) = _$PayrollSummaryModelImpl;

  factory _PayrollSummaryModel.fromJson(Map<String, dynamic> json) =
      _$PayrollSummaryModelImpl.fromJson;

  @override
  @JsonKey(name: 'total_gross_pay')
  double get totalGrossPay;
  @override
  @JsonKey(name: 'total_net_pay')
  double get totalNetPay;
  @override
  @JsonKey(name: 'total_deductions')
  double get totalDeductions;

  /// Create a copy of PayrollSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayrollSummaryModelImplCopyWith<_$PayrollSummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

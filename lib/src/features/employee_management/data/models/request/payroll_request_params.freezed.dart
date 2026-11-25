// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payroll_request_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PayrollRequestParams _$PayrollRequestParamsFromJson(Map<String, dynamic> json) {
  return _PayrollRequestParams.fromJson(json);
}

/// @nodoc
mixin _$PayrollRequestParams {
  @JsonKey(name: 'employee_id')
  int get employeeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'payroll_month')
  String get payrollMonth => throw _privateConstructorUsedError;
  double? get bonus => throw _privateConstructorUsedError;
  @JsonKey(name: 'additional_allowances')
  double? get additionalAllowances => throw _privateConstructorUsedError;
  @JsonKey(name: 'additional_deductions')
  double? get additionalDeductions => throw _privateConstructorUsedError;

  /// Serializes this PayrollRequestParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayrollRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayrollRequestParamsCopyWith<PayrollRequestParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayrollRequestParamsCopyWith<$Res> {
  factory $PayrollRequestParamsCopyWith(PayrollRequestParams value,
          $Res Function(PayrollRequestParams) then) =
      _$PayrollRequestParamsCopyWithImpl<$Res, PayrollRequestParams>;
  @useResult
  $Res call(
      {@JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'payroll_month') String payrollMonth,
      double? bonus,
      @JsonKey(name: 'additional_allowances') double? additionalAllowances,
      @JsonKey(name: 'additional_deductions') double? additionalDeductions});
}

/// @nodoc
class _$PayrollRequestParamsCopyWithImpl<$Res,
        $Val extends PayrollRequestParams>
    implements $PayrollRequestParamsCopyWith<$Res> {
  _$PayrollRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayrollRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? payrollMonth = null,
    Object? bonus = freezed,
    Object? additionalAllowances = freezed,
    Object? additionalDeductions = freezed,
  }) {
    return _then(_value.copyWith(
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
      payrollMonth: null == payrollMonth
          ? _value.payrollMonth
          : payrollMonth // ignore: cast_nullable_to_non_nullable
              as String,
      bonus: freezed == bonus
          ? _value.bonus
          : bonus // ignore: cast_nullable_to_non_nullable
              as double?,
      additionalAllowances: freezed == additionalAllowances
          ? _value.additionalAllowances
          : additionalAllowances // ignore: cast_nullable_to_non_nullable
              as double?,
      additionalDeductions: freezed == additionalDeductions
          ? _value.additionalDeductions
          : additionalDeductions // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayrollRequestParamsImplCopyWith<$Res>
    implements $PayrollRequestParamsCopyWith<$Res> {
  factory _$$PayrollRequestParamsImplCopyWith(_$PayrollRequestParamsImpl value,
          $Res Function(_$PayrollRequestParamsImpl) then) =
      __$$PayrollRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'payroll_month') String payrollMonth,
      double? bonus,
      @JsonKey(name: 'additional_allowances') double? additionalAllowances,
      @JsonKey(name: 'additional_deductions') double? additionalDeductions});
}

/// @nodoc
class __$$PayrollRequestParamsImplCopyWithImpl<$Res>
    extends _$PayrollRequestParamsCopyWithImpl<$Res, _$PayrollRequestParamsImpl>
    implements _$$PayrollRequestParamsImplCopyWith<$Res> {
  __$$PayrollRequestParamsImplCopyWithImpl(_$PayrollRequestParamsImpl _value,
      $Res Function(_$PayrollRequestParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayrollRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? payrollMonth = null,
    Object? bonus = freezed,
    Object? additionalAllowances = freezed,
    Object? additionalDeductions = freezed,
  }) {
    return _then(_$PayrollRequestParamsImpl(
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
      payrollMonth: null == payrollMonth
          ? _value.payrollMonth
          : payrollMonth // ignore: cast_nullable_to_non_nullable
              as String,
      bonus: freezed == bonus
          ? _value.bonus
          : bonus // ignore: cast_nullable_to_non_nullable
              as double?,
      additionalAllowances: freezed == additionalAllowances
          ? _value.additionalAllowances
          : additionalAllowances // ignore: cast_nullable_to_non_nullable
              as double?,
      additionalDeductions: freezed == additionalDeductions
          ? _value.additionalDeductions
          : additionalDeductions // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayrollRequestParamsImpl implements _PayrollRequestParams {
  const _$PayrollRequestParamsImpl(
      {@JsonKey(name: 'employee_id') required this.employeeId,
      @JsonKey(name: 'payroll_month') required this.payrollMonth,
      this.bonus,
      @JsonKey(name: 'additional_allowances') this.additionalAllowances,
      @JsonKey(name: 'additional_deductions') this.additionalDeductions});

  factory _$PayrollRequestParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayrollRequestParamsImplFromJson(json);

  @override
  @JsonKey(name: 'employee_id')
  final int employeeId;
  @override
  @JsonKey(name: 'payroll_month')
  final String payrollMonth;
  @override
  final double? bonus;
  @override
  @JsonKey(name: 'additional_allowances')
  final double? additionalAllowances;
  @override
  @JsonKey(name: 'additional_deductions')
  final double? additionalDeductions;

  @override
  String toString() {
    return 'PayrollRequestParams(employeeId: $employeeId, payrollMonth: $payrollMonth, bonus: $bonus, additionalAllowances: $additionalAllowances, additionalDeductions: $additionalDeductions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayrollRequestParamsImpl &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.payrollMonth, payrollMonth) ||
                other.payrollMonth == payrollMonth) &&
            (identical(other.bonus, bonus) || other.bonus == bonus) &&
            (identical(other.additionalAllowances, additionalAllowances) ||
                other.additionalAllowances == additionalAllowances) &&
            (identical(other.additionalDeductions, additionalDeductions) ||
                other.additionalDeductions == additionalDeductions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, employeeId, payrollMonth, bonus,
      additionalAllowances, additionalDeductions);

  /// Create a copy of PayrollRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayrollRequestParamsImplCopyWith<_$PayrollRequestParamsImpl>
      get copyWith =>
          __$$PayrollRequestParamsImplCopyWithImpl<_$PayrollRequestParamsImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayrollRequestParamsImplToJson(
      this,
    );
  }
}

abstract class _PayrollRequestParams implements PayrollRequestParams {
  const factory _PayrollRequestParams(
      {@JsonKey(name: 'employee_id') required final int employeeId,
      @JsonKey(name: 'payroll_month') required final String payrollMonth,
      final double? bonus,
      @JsonKey(name: 'additional_allowances')
      final double? additionalAllowances,
      @JsonKey(name: 'additional_deductions')
      final double? additionalDeductions}) = _$PayrollRequestParamsImpl;

  factory _PayrollRequestParams.fromJson(Map<String, dynamic> json) =
      _$PayrollRequestParamsImpl.fromJson;

  @override
  @JsonKey(name: 'employee_id')
  int get employeeId;
  @override
  @JsonKey(name: 'payroll_month')
  String get payrollMonth;
  @override
  double? get bonus;
  @override
  @JsonKey(name: 'additional_allowances')
  double? get additionalAllowances;
  @override
  @JsonKey(name: 'additional_deductions')
  double? get additionalDeductions;

  /// Create a copy of PayrollRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayrollRequestParamsImplCopyWith<_$PayrollRequestParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generate_payroll_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GeneratePayrollRequest _$GeneratePayrollRequestFromJson(
    Map<String, dynamic> json) {
  return _GeneratePayrollRequest.fromJson(json);
}

/// @nodoc
mixin _$GeneratePayrollRequest {
  @JsonKey(name: 'employee_id')
  int get employeeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'add_bonus_day')
  bool get addBonusDay => throw _privateConstructorUsedError;
  @JsonKey(name: 'payroll_month')
  String get payrollMonth => throw _privateConstructorUsedError;
  double? get bonus => throw _privateConstructorUsedError;
  @JsonKey(name: 'additional_allowances')
  double? get additionalAllowances => throw _privateConstructorUsedError;
  @JsonKey(name: 'additional_deductions')
  double? get additionalDeductions => throw _privateConstructorUsedError;

  /// Serializes this GeneratePayrollRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GeneratePayrollRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeneratePayrollRequestCopyWith<GeneratePayrollRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneratePayrollRequestCopyWith<$Res> {
  factory $GeneratePayrollRequestCopyWith(GeneratePayrollRequest value,
          $Res Function(GeneratePayrollRequest) then) =
      _$GeneratePayrollRequestCopyWithImpl<$Res, GeneratePayrollRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'add_bonus_day') bool addBonusDay,
      @JsonKey(name: 'payroll_month') String payrollMonth,
      double? bonus,
      @JsonKey(name: 'additional_allowances') double? additionalAllowances,
      @JsonKey(name: 'additional_deductions') double? additionalDeductions});
}

/// @nodoc
class _$GeneratePayrollRequestCopyWithImpl<$Res,
        $Val extends GeneratePayrollRequest>
    implements $GeneratePayrollRequestCopyWith<$Res> {
  _$GeneratePayrollRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeneratePayrollRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? addBonusDay = null,
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
      addBonusDay: null == addBonusDay
          ? _value.addBonusDay
          : addBonusDay // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$GeneratePayrollRequestImplCopyWith<$Res>
    implements $GeneratePayrollRequestCopyWith<$Res> {
  factory _$$GeneratePayrollRequestImplCopyWith(
          _$GeneratePayrollRequestImpl value,
          $Res Function(_$GeneratePayrollRequestImpl) then) =
      __$$GeneratePayrollRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'add_bonus_day') bool addBonusDay,
      @JsonKey(name: 'payroll_month') String payrollMonth,
      double? bonus,
      @JsonKey(name: 'additional_allowances') double? additionalAllowances,
      @JsonKey(name: 'additional_deductions') double? additionalDeductions});
}

/// @nodoc
class __$$GeneratePayrollRequestImplCopyWithImpl<$Res>
    extends _$GeneratePayrollRequestCopyWithImpl<$Res,
        _$GeneratePayrollRequestImpl>
    implements _$$GeneratePayrollRequestImplCopyWith<$Res> {
  __$$GeneratePayrollRequestImplCopyWithImpl(
      _$GeneratePayrollRequestImpl _value,
      $Res Function(_$GeneratePayrollRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of GeneratePayrollRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? addBonusDay = null,
    Object? payrollMonth = null,
    Object? bonus = freezed,
    Object? additionalAllowances = freezed,
    Object? additionalDeductions = freezed,
  }) {
    return _then(_$GeneratePayrollRequestImpl(
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
      addBonusDay: null == addBonusDay
          ? _value.addBonusDay
          : addBonusDay // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$GeneratePayrollRequestImpl implements _GeneratePayrollRequest {
  const _$GeneratePayrollRequestImpl(
      {@JsonKey(name: 'employee_id') required this.employeeId,
      @JsonKey(name: 'add_bonus_day') required this.addBonusDay,
      @JsonKey(name: 'payroll_month') required this.payrollMonth,
      this.bonus,
      @JsonKey(name: 'additional_allowances') this.additionalAllowances,
      @JsonKey(name: 'additional_deductions') this.additionalDeductions});

  factory _$GeneratePayrollRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeneratePayrollRequestImplFromJson(json);

  @override
  @JsonKey(name: 'employee_id')
  final int employeeId;
  @override
  @JsonKey(name: 'add_bonus_day')
  final bool addBonusDay;
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
    return 'GeneratePayrollRequest(employeeId: $employeeId, addBonusDay: $addBonusDay, payrollMonth: $payrollMonth, bonus: $bonus, additionalAllowances: $additionalAllowances, additionalDeductions: $additionalDeductions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneratePayrollRequestImpl &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.addBonusDay, addBonusDay) ||
                other.addBonusDay == addBonusDay) &&
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
  int get hashCode => Object.hash(runtimeType, employeeId, addBonusDay,
      payrollMonth, bonus, additionalAllowances, additionalDeductions);

  /// Create a copy of GeneratePayrollRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneratePayrollRequestImplCopyWith<_$GeneratePayrollRequestImpl>
      get copyWith => __$$GeneratePayrollRequestImplCopyWithImpl<
          _$GeneratePayrollRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeneratePayrollRequestImplToJson(
      this,
    );
  }
}

abstract class _GeneratePayrollRequest implements GeneratePayrollRequest {
  const factory _GeneratePayrollRequest(
      {@JsonKey(name: 'employee_id') required final int employeeId,
      @JsonKey(name: 'add_bonus_day') required final bool addBonusDay,
      @JsonKey(name: 'payroll_month') required final String payrollMonth,
      final double? bonus,
      @JsonKey(name: 'additional_allowances')
      final double? additionalAllowances,
      @JsonKey(name: 'additional_deductions')
      final double? additionalDeductions}) = _$GeneratePayrollRequestImpl;

  factory _GeneratePayrollRequest.fromJson(Map<String, dynamic> json) =
      _$GeneratePayrollRequestImpl.fromJson;

  @override
  @JsonKey(name: 'employee_id')
  int get employeeId;
  @override
  @JsonKey(name: 'add_bonus_day')
  bool get addBonusDay;
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

  /// Create a copy of GeneratePayrollRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeneratePayrollRequestImplCopyWith<_$GeneratePayrollRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

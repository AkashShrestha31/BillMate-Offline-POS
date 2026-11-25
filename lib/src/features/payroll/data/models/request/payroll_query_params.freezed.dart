// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payroll_query_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PayrollQueryParams _$PayrollQueryParamsFromJson(Map<String, dynamic> json) {
  return _PayrollQueryParams.fromJson(json);
}

/// @nodoc
mixin _$PayrollQueryParams {
  @JsonKey(name: 'employee_id')
  int? get employeeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'payroll_month')
  String? get payrollMonth => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_status')
  String? get paymentStatus => throw _privateConstructorUsedError;
  int? get year => throw _privateConstructorUsedError;
  int? get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int? get perPage => throw _privateConstructorUsedError;

  /// Serializes this PayrollQueryParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayrollQueryParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayrollQueryParamsCopyWith<PayrollQueryParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayrollQueryParamsCopyWith<$Res> {
  factory $PayrollQueryParamsCopyWith(
          PayrollQueryParams value, $Res Function(PayrollQueryParams) then) =
      _$PayrollQueryParamsCopyWithImpl<$Res, PayrollQueryParams>;
  @useResult
  $Res call(
      {@JsonKey(name: 'employee_id') int? employeeId,
      @JsonKey(name: 'payroll_month') String? payrollMonth,
      @JsonKey(name: 'payment_status') String? paymentStatus,
      int? year,
      int? page,
      @JsonKey(name: 'per_page') int? perPage});
}

/// @nodoc
class _$PayrollQueryParamsCopyWithImpl<$Res, $Val extends PayrollQueryParams>
    implements $PayrollQueryParamsCopyWith<$Res> {
  _$PayrollQueryParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayrollQueryParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = freezed,
    Object? payrollMonth = freezed,
    Object? paymentStatus = freezed,
    Object? year = freezed,
    Object? page = freezed,
    Object? perPage = freezed,
  }) {
    return _then(_value.copyWith(
      employeeId: freezed == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int?,
      payrollMonth: freezed == payrollMonth
          ? _value.payrollMonth
          : payrollMonth // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentStatus: freezed == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      perPage: freezed == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayrollQueryParamsImplCopyWith<$Res>
    implements $PayrollQueryParamsCopyWith<$Res> {
  factory _$$PayrollQueryParamsImplCopyWith(_$PayrollQueryParamsImpl value,
          $Res Function(_$PayrollQueryParamsImpl) then) =
      __$$PayrollQueryParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'employee_id') int? employeeId,
      @JsonKey(name: 'payroll_month') String? payrollMonth,
      @JsonKey(name: 'payment_status') String? paymentStatus,
      int? year,
      int? page,
      @JsonKey(name: 'per_page') int? perPage});
}

/// @nodoc
class __$$PayrollQueryParamsImplCopyWithImpl<$Res>
    extends _$PayrollQueryParamsCopyWithImpl<$Res, _$PayrollQueryParamsImpl>
    implements _$$PayrollQueryParamsImplCopyWith<$Res> {
  __$$PayrollQueryParamsImplCopyWithImpl(_$PayrollQueryParamsImpl _value,
      $Res Function(_$PayrollQueryParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayrollQueryParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = freezed,
    Object? payrollMonth = freezed,
    Object? paymentStatus = freezed,
    Object? year = freezed,
    Object? page = freezed,
    Object? perPage = freezed,
  }) {
    return _then(_$PayrollQueryParamsImpl(
      employeeId: freezed == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int?,
      payrollMonth: freezed == payrollMonth
          ? _value.payrollMonth
          : payrollMonth // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentStatus: freezed == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      perPage: freezed == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayrollQueryParamsImpl implements _PayrollQueryParams {
  const _$PayrollQueryParamsImpl(
      {@JsonKey(name: 'employee_id') this.employeeId,
      @JsonKey(name: 'payroll_month') this.payrollMonth,
      @JsonKey(name: 'payment_status') this.paymentStatus,
      this.year,
      this.page,
      @JsonKey(name: 'per_page') this.perPage});

  factory _$PayrollQueryParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayrollQueryParamsImplFromJson(json);

  @override
  @JsonKey(name: 'employee_id')
  final int? employeeId;
  @override
  @JsonKey(name: 'payroll_month')
  final String? payrollMonth;
  @override
  @JsonKey(name: 'payment_status')
  final String? paymentStatus;
  @override
  final int? year;
  @override
  final int? page;
  @override
  @JsonKey(name: 'per_page')
  final int? perPage;

  @override
  String toString() {
    return 'PayrollQueryParams(employeeId: $employeeId, payrollMonth: $payrollMonth, paymentStatus: $paymentStatus, year: $year, page: $page, perPage: $perPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayrollQueryParamsImpl &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.payrollMonth, payrollMonth) ||
                other.payrollMonth == payrollMonth) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, employeeId, payrollMonth,
      paymentStatus, year, page, perPage);

  /// Create a copy of PayrollQueryParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayrollQueryParamsImplCopyWith<_$PayrollQueryParamsImpl> get copyWith =>
      __$$PayrollQueryParamsImplCopyWithImpl<_$PayrollQueryParamsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayrollQueryParamsImplToJson(
      this,
    );
  }
}

abstract class _PayrollQueryParams implements PayrollQueryParams {
  const factory _PayrollQueryParams(
          {@JsonKey(name: 'employee_id') final int? employeeId,
          @JsonKey(name: 'payroll_month') final String? payrollMonth,
          @JsonKey(name: 'payment_status') final String? paymentStatus,
          final int? year,
          final int? page,
          @JsonKey(name: 'per_page') final int? perPage}) =
      _$PayrollQueryParamsImpl;

  factory _PayrollQueryParams.fromJson(Map<String, dynamic> json) =
      _$PayrollQueryParamsImpl.fromJson;

  @override
  @JsonKey(name: 'employee_id')
  int? get employeeId;
  @override
  @JsonKey(name: 'payroll_month')
  String? get payrollMonth;
  @override
  @JsonKey(name: 'payment_status')
  String? get paymentStatus;
  @override
  int? get year;
  @override
  int? get page;
  @override
  @JsonKey(name: 'per_page')
  int? get perPage;

  /// Create a copy of PayrollQueryParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayrollQueryParamsImplCopyWith<_$PayrollQueryParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

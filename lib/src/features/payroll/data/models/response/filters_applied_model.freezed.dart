// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filters_applied_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FiltersAppliedModel _$FiltersAppliedModelFromJson(Map<String, dynamic> json) {
  return _FiltersAppliedModel.fromJson(json);
}

/// @nodoc
mixin _$FiltersAppliedModel {
  @JsonKey(name: 'employee_id')
  int? get employeeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'payroll_month')
  String? get payrollMonth => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_status')
  String? get paymentStatus => throw _privateConstructorUsedError;
  int? get year => throw _privateConstructorUsedError;

  /// Serializes this FiltersAppliedModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FiltersAppliedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FiltersAppliedModelCopyWith<FiltersAppliedModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FiltersAppliedModelCopyWith<$Res> {
  factory $FiltersAppliedModelCopyWith(
          FiltersAppliedModel value, $Res Function(FiltersAppliedModel) then) =
      _$FiltersAppliedModelCopyWithImpl<$Res, FiltersAppliedModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'employee_id') int? employeeId,
      @JsonKey(name: 'payroll_month') String? payrollMonth,
      @JsonKey(name: 'payment_status') String? paymentStatus,
      int? year});
}

/// @nodoc
class _$FiltersAppliedModelCopyWithImpl<$Res, $Val extends FiltersAppliedModel>
    implements $FiltersAppliedModelCopyWith<$Res> {
  _$FiltersAppliedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FiltersAppliedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = freezed,
    Object? payrollMonth = freezed,
    Object? paymentStatus = freezed,
    Object? year = freezed,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FiltersAppliedModelImplCopyWith<$Res>
    implements $FiltersAppliedModelCopyWith<$Res> {
  factory _$$FiltersAppliedModelImplCopyWith(_$FiltersAppliedModelImpl value,
          $Res Function(_$FiltersAppliedModelImpl) then) =
      __$$FiltersAppliedModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'employee_id') int? employeeId,
      @JsonKey(name: 'payroll_month') String? payrollMonth,
      @JsonKey(name: 'payment_status') String? paymentStatus,
      int? year});
}

/// @nodoc
class __$$FiltersAppliedModelImplCopyWithImpl<$Res>
    extends _$FiltersAppliedModelCopyWithImpl<$Res, _$FiltersAppliedModelImpl>
    implements _$$FiltersAppliedModelImplCopyWith<$Res> {
  __$$FiltersAppliedModelImplCopyWithImpl(_$FiltersAppliedModelImpl _value,
      $Res Function(_$FiltersAppliedModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FiltersAppliedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = freezed,
    Object? payrollMonth = freezed,
    Object? paymentStatus = freezed,
    Object? year = freezed,
  }) {
    return _then(_$FiltersAppliedModelImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FiltersAppliedModelImpl implements _FiltersAppliedModel {
  const _$FiltersAppliedModelImpl(
      {@JsonKey(name: 'employee_id') this.employeeId,
      @JsonKey(name: 'payroll_month') this.payrollMonth,
      @JsonKey(name: 'payment_status') this.paymentStatus,
      this.year});

  factory _$FiltersAppliedModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FiltersAppliedModelImplFromJson(json);

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
  String toString() {
    return 'FiltersAppliedModel(employeeId: $employeeId, payrollMonth: $payrollMonth, paymentStatus: $paymentStatus, year: $year)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FiltersAppliedModelImpl &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.payrollMonth, payrollMonth) ||
                other.payrollMonth == payrollMonth) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.year, year) || other.year == year));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, employeeId, payrollMonth, paymentStatus, year);

  /// Create a copy of FiltersAppliedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FiltersAppliedModelImplCopyWith<_$FiltersAppliedModelImpl> get copyWith =>
      __$$FiltersAppliedModelImplCopyWithImpl<_$FiltersAppliedModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FiltersAppliedModelImplToJson(
      this,
    );
  }
}

abstract class _FiltersAppliedModel implements FiltersAppliedModel {
  const factory _FiltersAppliedModel(
      {@JsonKey(name: 'employee_id') final int? employeeId,
      @JsonKey(name: 'payroll_month') final String? payrollMonth,
      @JsonKey(name: 'payment_status') final String? paymentStatus,
      final int? year}) = _$FiltersAppliedModelImpl;

  factory _FiltersAppliedModel.fromJson(Map<String, dynamic> json) =
      _$FiltersAppliedModelImpl.fromJson;

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

  /// Create a copy of FiltersAppliedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FiltersAppliedModelImplCopyWith<_$FiltersAppliedModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

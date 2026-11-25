// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_type_request_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaveTypeRequestParams _$LeaveTypeRequestParamsFromJson(
    Map<String, dynamic> json) {
  return _LeaveTypeRequestParams.fromJson(json);
}

/// @nodoc
mixin _$LeaveTypeRequestParams {
  @JsonKey(name: 'leave_type_name')
  String get leaveTypeName => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_days_per_year')
  int get maxDaysPerYear => throw _privateConstructorUsedError;
  @JsonKey(name: 'carry_forward_allowed')
  bool? get carryForwardAllowed => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_carry_forward_days')
  int? get maxCarryForwardDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'requires_approval')
  bool? get requiresApproval => throw _privateConstructorUsedError;
  @JsonKey(name: 'advance_notice_days')
  int? get advanceNoticeDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_paid')
  bool? get isPaid => throw _privateConstructorUsedError;
  @JsonKey(name: 'gender_specific')
  String? get genderSpecific => throw _privateConstructorUsedError;

  /// Serializes this LeaveTypeRequestParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveTypeRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveTypeRequestParamsCopyWith<LeaveTypeRequestParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveTypeRequestParamsCopyWith<$Res> {
  factory $LeaveTypeRequestParamsCopyWith(LeaveTypeRequestParams value,
          $Res Function(LeaveTypeRequestParams) then) =
      _$LeaveTypeRequestParamsCopyWithImpl<$Res, LeaveTypeRequestParams>;
  @useResult
  $Res call(
      {@JsonKey(name: 'leave_type_name') String leaveTypeName,
      String? description,
      @JsonKey(name: 'max_days_per_year') int maxDaysPerYear,
      @JsonKey(name: 'carry_forward_allowed') bool? carryForwardAllowed,
      @JsonKey(name: 'max_carry_forward_days') int? maxCarryForwardDays,
      @JsonKey(name: 'requires_approval') bool? requiresApproval,
      @JsonKey(name: 'advance_notice_days') int? advanceNoticeDays,
      @JsonKey(name: 'is_paid') bool? isPaid,
      @JsonKey(name: 'gender_specific') String? genderSpecific});
}

/// @nodoc
class _$LeaveTypeRequestParamsCopyWithImpl<$Res,
        $Val extends LeaveTypeRequestParams>
    implements $LeaveTypeRequestParamsCopyWith<$Res> {
  _$LeaveTypeRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveTypeRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? leaveTypeName = null,
    Object? description = freezed,
    Object? maxDaysPerYear = null,
    Object? carryForwardAllowed = freezed,
    Object? maxCarryForwardDays = freezed,
    Object? requiresApproval = freezed,
    Object? advanceNoticeDays = freezed,
    Object? isPaid = freezed,
    Object? genderSpecific = freezed,
  }) {
    return _then(_value.copyWith(
      leaveTypeName: null == leaveTypeName
          ? _value.leaveTypeName
          : leaveTypeName // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      maxDaysPerYear: null == maxDaysPerYear
          ? _value.maxDaysPerYear
          : maxDaysPerYear // ignore: cast_nullable_to_non_nullable
              as int,
      carryForwardAllowed: freezed == carryForwardAllowed
          ? _value.carryForwardAllowed
          : carryForwardAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      maxCarryForwardDays: freezed == maxCarryForwardDays
          ? _value.maxCarryForwardDays
          : maxCarryForwardDays // ignore: cast_nullable_to_non_nullable
              as int?,
      requiresApproval: freezed == requiresApproval
          ? _value.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool?,
      advanceNoticeDays: freezed == advanceNoticeDays
          ? _value.advanceNoticeDays
          : advanceNoticeDays // ignore: cast_nullable_to_non_nullable
              as int?,
      isPaid: freezed == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool?,
      genderSpecific: freezed == genderSpecific
          ? _value.genderSpecific
          : genderSpecific // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaveTypeRequestParamsImplCopyWith<$Res>
    implements $LeaveTypeRequestParamsCopyWith<$Res> {
  factory _$$LeaveTypeRequestParamsImplCopyWith(
          _$LeaveTypeRequestParamsImpl value,
          $Res Function(_$LeaveTypeRequestParamsImpl) then) =
      __$$LeaveTypeRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'leave_type_name') String leaveTypeName,
      String? description,
      @JsonKey(name: 'max_days_per_year') int maxDaysPerYear,
      @JsonKey(name: 'carry_forward_allowed') bool? carryForwardAllowed,
      @JsonKey(name: 'max_carry_forward_days') int? maxCarryForwardDays,
      @JsonKey(name: 'requires_approval') bool? requiresApproval,
      @JsonKey(name: 'advance_notice_days') int? advanceNoticeDays,
      @JsonKey(name: 'is_paid') bool? isPaid,
      @JsonKey(name: 'gender_specific') String? genderSpecific});
}

/// @nodoc
class __$$LeaveTypeRequestParamsImplCopyWithImpl<$Res>
    extends _$LeaveTypeRequestParamsCopyWithImpl<$Res,
        _$LeaveTypeRequestParamsImpl>
    implements _$$LeaveTypeRequestParamsImplCopyWith<$Res> {
  __$$LeaveTypeRequestParamsImplCopyWithImpl(
      _$LeaveTypeRequestParamsImpl _value,
      $Res Function(_$LeaveTypeRequestParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaveTypeRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? leaveTypeName = null,
    Object? description = freezed,
    Object? maxDaysPerYear = null,
    Object? carryForwardAllowed = freezed,
    Object? maxCarryForwardDays = freezed,
    Object? requiresApproval = freezed,
    Object? advanceNoticeDays = freezed,
    Object? isPaid = freezed,
    Object? genderSpecific = freezed,
  }) {
    return _then(_$LeaveTypeRequestParamsImpl(
      leaveTypeName: null == leaveTypeName
          ? _value.leaveTypeName
          : leaveTypeName // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      maxDaysPerYear: null == maxDaysPerYear
          ? _value.maxDaysPerYear
          : maxDaysPerYear // ignore: cast_nullable_to_non_nullable
              as int,
      carryForwardAllowed: freezed == carryForwardAllowed
          ? _value.carryForwardAllowed
          : carryForwardAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      maxCarryForwardDays: freezed == maxCarryForwardDays
          ? _value.maxCarryForwardDays
          : maxCarryForwardDays // ignore: cast_nullable_to_non_nullable
              as int?,
      requiresApproval: freezed == requiresApproval
          ? _value.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool?,
      advanceNoticeDays: freezed == advanceNoticeDays
          ? _value.advanceNoticeDays
          : advanceNoticeDays // ignore: cast_nullable_to_non_nullable
              as int?,
      isPaid: freezed == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool?,
      genderSpecific: freezed == genderSpecific
          ? _value.genderSpecific
          : genderSpecific // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveTypeRequestParamsImpl implements _LeaveTypeRequestParams {
  const _$LeaveTypeRequestParamsImpl(
      {@JsonKey(name: 'leave_type_name') required this.leaveTypeName,
      this.description,
      @JsonKey(name: 'max_days_per_year') required this.maxDaysPerYear,
      @JsonKey(name: 'carry_forward_allowed') this.carryForwardAllowed,
      @JsonKey(name: 'max_carry_forward_days') this.maxCarryForwardDays,
      @JsonKey(name: 'requires_approval') this.requiresApproval,
      @JsonKey(name: 'advance_notice_days') this.advanceNoticeDays,
      @JsonKey(name: 'is_paid') this.isPaid,
      @JsonKey(name: 'gender_specific') this.genderSpecific});

  factory _$LeaveTypeRequestParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveTypeRequestParamsImplFromJson(json);

  @override
  @JsonKey(name: 'leave_type_name')
  final String leaveTypeName;
  @override
  final String? description;
  @override
  @JsonKey(name: 'max_days_per_year')
  final int maxDaysPerYear;
  @override
  @JsonKey(name: 'carry_forward_allowed')
  final bool? carryForwardAllowed;
  @override
  @JsonKey(name: 'max_carry_forward_days')
  final int? maxCarryForwardDays;
  @override
  @JsonKey(name: 'requires_approval')
  final bool? requiresApproval;
  @override
  @JsonKey(name: 'advance_notice_days')
  final int? advanceNoticeDays;
  @override
  @JsonKey(name: 'is_paid')
  final bool? isPaid;
  @override
  @JsonKey(name: 'gender_specific')
  final String? genderSpecific;

  @override
  String toString() {
    return 'LeaveTypeRequestParams(leaveTypeName: $leaveTypeName, description: $description, maxDaysPerYear: $maxDaysPerYear, carryForwardAllowed: $carryForwardAllowed, maxCarryForwardDays: $maxCarryForwardDays, requiresApproval: $requiresApproval, advanceNoticeDays: $advanceNoticeDays, isPaid: $isPaid, genderSpecific: $genderSpecific)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveTypeRequestParamsImpl &&
            (identical(other.leaveTypeName, leaveTypeName) ||
                other.leaveTypeName == leaveTypeName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.maxDaysPerYear, maxDaysPerYear) ||
                other.maxDaysPerYear == maxDaysPerYear) &&
            (identical(other.carryForwardAllowed, carryForwardAllowed) ||
                other.carryForwardAllowed == carryForwardAllowed) &&
            (identical(other.maxCarryForwardDays, maxCarryForwardDays) ||
                other.maxCarryForwardDays == maxCarryForwardDays) &&
            (identical(other.requiresApproval, requiresApproval) ||
                other.requiresApproval == requiresApproval) &&
            (identical(other.advanceNoticeDays, advanceNoticeDays) ||
                other.advanceNoticeDays == advanceNoticeDays) &&
            (identical(other.isPaid, isPaid) || other.isPaid == isPaid) &&
            (identical(other.genderSpecific, genderSpecific) ||
                other.genderSpecific == genderSpecific));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      leaveTypeName,
      description,
      maxDaysPerYear,
      carryForwardAllowed,
      maxCarryForwardDays,
      requiresApproval,
      advanceNoticeDays,
      isPaid,
      genderSpecific);

  /// Create a copy of LeaveTypeRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveTypeRequestParamsImplCopyWith<_$LeaveTypeRequestParamsImpl>
      get copyWith => __$$LeaveTypeRequestParamsImplCopyWithImpl<
          _$LeaveTypeRequestParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveTypeRequestParamsImplToJson(
      this,
    );
  }
}

abstract class _LeaveTypeRequestParams implements LeaveTypeRequestParams {
  const factory _LeaveTypeRequestParams(
      {@JsonKey(name: 'leave_type_name') required final String leaveTypeName,
      final String? description,
      @JsonKey(name: 'max_days_per_year') required final int maxDaysPerYear,
      @JsonKey(name: 'carry_forward_allowed') final bool? carryForwardAllowed,
      @JsonKey(name: 'max_carry_forward_days') final int? maxCarryForwardDays,
      @JsonKey(name: 'requires_approval') final bool? requiresApproval,
      @JsonKey(name: 'advance_notice_days') final int? advanceNoticeDays,
      @JsonKey(name: 'is_paid') final bool? isPaid,
      @JsonKey(name: 'gender_specific')
      final String? genderSpecific}) = _$LeaveTypeRequestParamsImpl;

  factory _LeaveTypeRequestParams.fromJson(Map<String, dynamic> json) =
      _$LeaveTypeRequestParamsImpl.fromJson;

  @override
  @JsonKey(name: 'leave_type_name')
  String get leaveTypeName;
  @override
  String? get description;
  @override
  @JsonKey(name: 'max_days_per_year')
  int get maxDaysPerYear;
  @override
  @JsonKey(name: 'carry_forward_allowed')
  bool? get carryForwardAllowed;
  @override
  @JsonKey(name: 'max_carry_forward_days')
  int? get maxCarryForwardDays;
  @override
  @JsonKey(name: 'requires_approval')
  bool? get requiresApproval;
  @override
  @JsonKey(name: 'advance_notice_days')
  int? get advanceNoticeDays;
  @override
  @JsonKey(name: 'is_paid')
  bool? get isPaid;
  @override
  @JsonKey(name: 'gender_specific')
  String? get genderSpecific;

  /// Create a copy of LeaveTypeRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveTypeRequestParamsImplCopyWith<_$LeaveTypeRequestParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

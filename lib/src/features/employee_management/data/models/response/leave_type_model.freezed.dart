// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_type_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaveTypeModel _$LeaveTypeModelFromJson(Map<String, dynamic> json) {
  return _LeaveTypeModel.fromJson(json);
}

/// @nodoc
mixin _$LeaveTypeModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'leave_type_name')
  String get leaveTypeName => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_days_per_year')
  int get maxDaysPerYear => throw _privateConstructorUsedError;
  @JsonKey(name: 'carry_forward_allowed')
  bool get carryForwardAllowed => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_carry_forward_days')
  int? get maxCarryForwardDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'requires_approval')
  bool get requiresApproval => throw _privateConstructorUsedError;
  @JsonKey(name: 'advance_notice_days')
  int? get advanceNoticeDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_paid')
  bool get isPaid => throw _privateConstructorUsedError;
  @JsonKey(name: 'gender_specific')
  String? get genderSpecific => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  String? get created => throw _privateConstructorUsedError;
  String? get modified => throw _privateConstructorUsedError;

  /// Serializes this LeaveTypeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveTypeModelCopyWith<LeaveTypeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveTypeModelCopyWith<$Res> {
  factory $LeaveTypeModelCopyWith(
          LeaveTypeModel value, $Res Function(LeaveTypeModel) then) =
      _$LeaveTypeModelCopyWithImpl<$Res, LeaveTypeModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'leave_type_name') String leaveTypeName,
      String? description,
      @JsonKey(name: 'max_days_per_year') int maxDaysPerYear,
      @JsonKey(name: 'carry_forward_allowed') bool carryForwardAllowed,
      @JsonKey(name: 'max_carry_forward_days') int? maxCarryForwardDays,
      @JsonKey(name: 'requires_approval') bool requiresApproval,
      @JsonKey(name: 'advance_notice_days') int? advanceNoticeDays,
      @JsonKey(name: 'is_paid') bool isPaid,
      @JsonKey(name: 'gender_specific') String? genderSpecific,
      @JsonKey(name: 'is_active') bool isActive,
      String? created,
      String? modified});
}

/// @nodoc
class _$LeaveTypeModelCopyWithImpl<$Res, $Val extends LeaveTypeModel>
    implements $LeaveTypeModelCopyWith<$Res> {
  _$LeaveTypeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? leaveTypeName = null,
    Object? description = freezed,
    Object? maxDaysPerYear = null,
    Object? carryForwardAllowed = null,
    Object? maxCarryForwardDays = freezed,
    Object? requiresApproval = null,
    Object? advanceNoticeDays = freezed,
    Object? isPaid = null,
    Object? genderSpecific = freezed,
    Object? isActive = null,
    Object? created = freezed,
    Object? modified = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
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
      carryForwardAllowed: null == carryForwardAllowed
          ? _value.carryForwardAllowed
          : carryForwardAllowed // ignore: cast_nullable_to_non_nullable
              as bool,
      maxCarryForwardDays: freezed == maxCarryForwardDays
          ? _value.maxCarryForwardDays
          : maxCarryForwardDays // ignore: cast_nullable_to_non_nullable
              as int?,
      requiresApproval: null == requiresApproval
          ? _value.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool,
      advanceNoticeDays: freezed == advanceNoticeDays
          ? _value.advanceNoticeDays
          : advanceNoticeDays // ignore: cast_nullable_to_non_nullable
              as int?,
      isPaid: null == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
      genderSpecific: freezed == genderSpecific
          ? _value.genderSpecific
          : genderSpecific // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String?,
      modified: freezed == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaveTypeModelImplCopyWith<$Res>
    implements $LeaveTypeModelCopyWith<$Res> {
  factory _$$LeaveTypeModelImplCopyWith(_$LeaveTypeModelImpl value,
          $Res Function(_$LeaveTypeModelImpl) then) =
      __$$LeaveTypeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'leave_type_name') String leaveTypeName,
      String? description,
      @JsonKey(name: 'max_days_per_year') int maxDaysPerYear,
      @JsonKey(name: 'carry_forward_allowed') bool carryForwardAllowed,
      @JsonKey(name: 'max_carry_forward_days') int? maxCarryForwardDays,
      @JsonKey(name: 'requires_approval') bool requiresApproval,
      @JsonKey(name: 'advance_notice_days') int? advanceNoticeDays,
      @JsonKey(name: 'is_paid') bool isPaid,
      @JsonKey(name: 'gender_specific') String? genderSpecific,
      @JsonKey(name: 'is_active') bool isActive,
      String? created,
      String? modified});
}

/// @nodoc
class __$$LeaveTypeModelImplCopyWithImpl<$Res>
    extends _$LeaveTypeModelCopyWithImpl<$Res, _$LeaveTypeModelImpl>
    implements _$$LeaveTypeModelImplCopyWith<$Res> {
  __$$LeaveTypeModelImplCopyWithImpl(
      _$LeaveTypeModelImpl _value, $Res Function(_$LeaveTypeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaveTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? leaveTypeName = null,
    Object? description = freezed,
    Object? maxDaysPerYear = null,
    Object? carryForwardAllowed = null,
    Object? maxCarryForwardDays = freezed,
    Object? requiresApproval = null,
    Object? advanceNoticeDays = freezed,
    Object? isPaid = null,
    Object? genderSpecific = freezed,
    Object? isActive = null,
    Object? created = freezed,
    Object? modified = freezed,
  }) {
    return _then(_$LeaveTypeModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
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
      carryForwardAllowed: null == carryForwardAllowed
          ? _value.carryForwardAllowed
          : carryForwardAllowed // ignore: cast_nullable_to_non_nullable
              as bool,
      maxCarryForwardDays: freezed == maxCarryForwardDays
          ? _value.maxCarryForwardDays
          : maxCarryForwardDays // ignore: cast_nullable_to_non_nullable
              as int?,
      requiresApproval: null == requiresApproval
          ? _value.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool,
      advanceNoticeDays: freezed == advanceNoticeDays
          ? _value.advanceNoticeDays
          : advanceNoticeDays // ignore: cast_nullable_to_non_nullable
              as int?,
      isPaid: null == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
      genderSpecific: freezed == genderSpecific
          ? _value.genderSpecific
          : genderSpecific // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String?,
      modified: freezed == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveTypeModelImpl implements _LeaveTypeModel {
  const _$LeaveTypeModelImpl(
      {required this.id,
      @JsonKey(name: 'leave_type_name') required this.leaveTypeName,
      this.description,
      @JsonKey(name: 'max_days_per_year') required this.maxDaysPerYear,
      @JsonKey(name: 'carry_forward_allowed') required this.carryForwardAllowed,
      @JsonKey(name: 'max_carry_forward_days') this.maxCarryForwardDays,
      @JsonKey(name: 'requires_approval') required this.requiresApproval,
      @JsonKey(name: 'advance_notice_days') this.advanceNoticeDays,
      @JsonKey(name: 'is_paid') required this.isPaid,
      @JsonKey(name: 'gender_specific') this.genderSpecific,
      @JsonKey(name: 'is_active') required this.isActive,
      this.created,
      this.modified});

  factory _$LeaveTypeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveTypeModelImplFromJson(json);

  @override
  final int id;
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
  final bool carryForwardAllowed;
  @override
  @JsonKey(name: 'max_carry_forward_days')
  final int? maxCarryForwardDays;
  @override
  @JsonKey(name: 'requires_approval')
  final bool requiresApproval;
  @override
  @JsonKey(name: 'advance_notice_days')
  final int? advanceNoticeDays;
  @override
  @JsonKey(name: 'is_paid')
  final bool isPaid;
  @override
  @JsonKey(name: 'gender_specific')
  final String? genderSpecific;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  final String? created;
  @override
  final String? modified;

  @override
  String toString() {
    return 'LeaveTypeModel(id: $id, leaveTypeName: $leaveTypeName, description: $description, maxDaysPerYear: $maxDaysPerYear, carryForwardAllowed: $carryForwardAllowed, maxCarryForwardDays: $maxCarryForwardDays, requiresApproval: $requiresApproval, advanceNoticeDays: $advanceNoticeDays, isPaid: $isPaid, genderSpecific: $genderSpecific, isActive: $isActive, created: $created, modified: $modified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveTypeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
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
                other.genderSpecific == genderSpecific) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.modified, modified) ||
                other.modified == modified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      leaveTypeName,
      description,
      maxDaysPerYear,
      carryForwardAllowed,
      maxCarryForwardDays,
      requiresApproval,
      advanceNoticeDays,
      isPaid,
      genderSpecific,
      isActive,
      created,
      modified);

  /// Create a copy of LeaveTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveTypeModelImplCopyWith<_$LeaveTypeModelImpl> get copyWith =>
      __$$LeaveTypeModelImplCopyWithImpl<_$LeaveTypeModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveTypeModelImplToJson(
      this,
    );
  }
}

abstract class _LeaveTypeModel implements LeaveTypeModel {
  const factory _LeaveTypeModel(
      {required final int id,
      @JsonKey(name: 'leave_type_name') required final String leaveTypeName,
      final String? description,
      @JsonKey(name: 'max_days_per_year') required final int maxDaysPerYear,
      @JsonKey(name: 'carry_forward_allowed')
      required final bool carryForwardAllowed,
      @JsonKey(name: 'max_carry_forward_days') final int? maxCarryForwardDays,
      @JsonKey(name: 'requires_approval') required final bool requiresApproval,
      @JsonKey(name: 'advance_notice_days') final int? advanceNoticeDays,
      @JsonKey(name: 'is_paid') required final bool isPaid,
      @JsonKey(name: 'gender_specific') final String? genderSpecific,
      @JsonKey(name: 'is_active') required final bool isActive,
      final String? created,
      final String? modified}) = _$LeaveTypeModelImpl;

  factory _LeaveTypeModel.fromJson(Map<String, dynamic> json) =
      _$LeaveTypeModelImpl.fromJson;

  @override
  int get id;
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
  bool get carryForwardAllowed;
  @override
  @JsonKey(name: 'max_carry_forward_days')
  int? get maxCarryForwardDays;
  @override
  @JsonKey(name: 'requires_approval')
  bool get requiresApproval;
  @override
  @JsonKey(name: 'advance_notice_days')
  int? get advanceNoticeDays;
  @override
  @JsonKey(name: 'is_paid')
  bool get isPaid;
  @override
  @JsonKey(name: 'gender_specific')
  String? get genderSpecific;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  String? get created;
  @override
  String? get modified;

  /// Create a copy of LeaveTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveTypeModelImplCopyWith<_$LeaveTypeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

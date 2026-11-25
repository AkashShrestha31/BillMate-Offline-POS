// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_approval_request_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaveApprovalRequestParams _$LeaveApprovalRequestParamsFromJson(
    Map<String, dynamic> json) {
  return _LeaveApprovalRequestParams.fromJson(json);
}

/// @nodoc
mixin _$LeaveApprovalRequestParams {
  String get action => throw _privateConstructorUsedError; // APPROVE or REJECT
  @JsonKey(name: 'rejection_reason')
  String? get rejectionReason => throw _privateConstructorUsedError;
  @JsonKey(name: 'manager_comments')
  String? get managerComments => throw _privateConstructorUsedError;
  @JsonKey(name: 'hr_comments')
  String? get hrComments => throw _privateConstructorUsedError;

  /// Serializes this LeaveApprovalRequestParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveApprovalRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveApprovalRequestParamsCopyWith<LeaveApprovalRequestParams>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveApprovalRequestParamsCopyWith<$Res> {
  factory $LeaveApprovalRequestParamsCopyWith(LeaveApprovalRequestParams value,
          $Res Function(LeaveApprovalRequestParams) then) =
      _$LeaveApprovalRequestParamsCopyWithImpl<$Res,
          LeaveApprovalRequestParams>;
  @useResult
  $Res call(
      {String action,
      @JsonKey(name: 'rejection_reason') String? rejectionReason,
      @JsonKey(name: 'manager_comments') String? managerComments,
      @JsonKey(name: 'hr_comments') String? hrComments});
}

/// @nodoc
class _$LeaveApprovalRequestParamsCopyWithImpl<$Res,
        $Val extends LeaveApprovalRequestParams>
    implements $LeaveApprovalRequestParamsCopyWith<$Res> {
  _$LeaveApprovalRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveApprovalRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? rejectionReason = freezed,
    Object? managerComments = freezed,
    Object? hrComments = freezed,
  }) {
    return _then(_value.copyWith(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      managerComments: freezed == managerComments
          ? _value.managerComments
          : managerComments // ignore: cast_nullable_to_non_nullable
              as String?,
      hrComments: freezed == hrComments
          ? _value.hrComments
          : hrComments // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaveApprovalRequestParamsImplCopyWith<$Res>
    implements $LeaveApprovalRequestParamsCopyWith<$Res> {
  factory _$$LeaveApprovalRequestParamsImplCopyWith(
          _$LeaveApprovalRequestParamsImpl value,
          $Res Function(_$LeaveApprovalRequestParamsImpl) then) =
      __$$LeaveApprovalRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String action,
      @JsonKey(name: 'rejection_reason') String? rejectionReason,
      @JsonKey(name: 'manager_comments') String? managerComments,
      @JsonKey(name: 'hr_comments') String? hrComments});
}

/// @nodoc
class __$$LeaveApprovalRequestParamsImplCopyWithImpl<$Res>
    extends _$LeaveApprovalRequestParamsCopyWithImpl<$Res,
        _$LeaveApprovalRequestParamsImpl>
    implements _$$LeaveApprovalRequestParamsImplCopyWith<$Res> {
  __$$LeaveApprovalRequestParamsImplCopyWithImpl(
      _$LeaveApprovalRequestParamsImpl _value,
      $Res Function(_$LeaveApprovalRequestParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaveApprovalRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? rejectionReason = freezed,
    Object? managerComments = freezed,
    Object? hrComments = freezed,
  }) {
    return _then(_$LeaveApprovalRequestParamsImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      managerComments: freezed == managerComments
          ? _value.managerComments
          : managerComments // ignore: cast_nullable_to_non_nullable
              as String?,
      hrComments: freezed == hrComments
          ? _value.hrComments
          : hrComments // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveApprovalRequestParamsImpl implements _LeaveApprovalRequestParams {
  const _$LeaveApprovalRequestParamsImpl(
      {required this.action,
      @JsonKey(name: 'rejection_reason') this.rejectionReason,
      @JsonKey(name: 'manager_comments') this.managerComments,
      @JsonKey(name: 'hr_comments') this.hrComments});

  factory _$LeaveApprovalRequestParamsImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$LeaveApprovalRequestParamsImplFromJson(json);

  @override
  final String action;
// APPROVE or REJECT
  @override
  @JsonKey(name: 'rejection_reason')
  final String? rejectionReason;
  @override
  @JsonKey(name: 'manager_comments')
  final String? managerComments;
  @override
  @JsonKey(name: 'hr_comments')
  final String? hrComments;

  @override
  String toString() {
    return 'LeaveApprovalRequestParams(action: $action, rejectionReason: $rejectionReason, managerComments: $managerComments, hrComments: $hrComments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveApprovalRequestParamsImpl &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            (identical(other.managerComments, managerComments) ||
                other.managerComments == managerComments) &&
            (identical(other.hrComments, hrComments) ||
                other.hrComments == hrComments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, action, rejectionReason, managerComments, hrComments);

  /// Create a copy of LeaveApprovalRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveApprovalRequestParamsImplCopyWith<_$LeaveApprovalRequestParamsImpl>
      get copyWith => __$$LeaveApprovalRequestParamsImplCopyWithImpl<
          _$LeaveApprovalRequestParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveApprovalRequestParamsImplToJson(
      this,
    );
  }
}

abstract class _LeaveApprovalRequestParams
    implements LeaveApprovalRequestParams {
  const factory _LeaveApprovalRequestParams(
          {required final String action,
          @JsonKey(name: 'rejection_reason') final String? rejectionReason,
          @JsonKey(name: 'manager_comments') final String? managerComments,
          @JsonKey(name: 'hr_comments') final String? hrComments}) =
      _$LeaveApprovalRequestParamsImpl;

  factory _LeaveApprovalRequestParams.fromJson(Map<String, dynamic> json) =
      _$LeaveApprovalRequestParamsImpl.fromJson;

  @override
  String get action; // APPROVE or REJECT
  @override
  @JsonKey(name: 'rejection_reason')
  String? get rejectionReason;
  @override
  @JsonKey(name: 'manager_comments')
  String? get managerComments;
  @override
  @JsonKey(name: 'hr_comments')
  String? get hrComments;

  /// Create a copy of LeaveApprovalRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveApprovalRequestParamsImplCopyWith<_$LeaveApprovalRequestParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

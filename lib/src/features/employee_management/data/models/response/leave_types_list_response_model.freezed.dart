// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_types_list_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaveTypesListResponseModel _$LeaveTypesListResponseModelFromJson(
    Map<String, dynamic> json) {
  return _LeaveTypesListResponseModel.fromJson(json);
}

/// @nodoc
mixin _$LeaveTypesListResponseModel {
  bool get success => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  @JsonKey(name: 'leave_types')
  List<LeaveTypeModel> get leaveTypes => throw _privateConstructorUsedError;

  /// Serializes this LeaveTypesListResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveTypesListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveTypesListResponseModelCopyWith<LeaveTypesListResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveTypesListResponseModelCopyWith<$Res> {
  factory $LeaveTypesListResponseModelCopyWith(
          LeaveTypesListResponseModel value,
          $Res Function(LeaveTypesListResponseModel) then) =
      _$LeaveTypesListResponseModelCopyWithImpl<$Res,
          LeaveTypesListResponseModel>;
  @useResult
  $Res call(
      {bool success,
      int count,
      @JsonKey(name: 'leave_types') List<LeaveTypeModel> leaveTypes});
}

/// @nodoc
class _$LeaveTypesListResponseModelCopyWithImpl<$Res,
        $Val extends LeaveTypesListResponseModel>
    implements $LeaveTypesListResponseModelCopyWith<$Res> {
  _$LeaveTypesListResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveTypesListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
    Object? leaveTypes = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      leaveTypes: null == leaveTypes
          ? _value.leaveTypes
          : leaveTypes // ignore: cast_nullable_to_non_nullable
              as List<LeaveTypeModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaveTypesListResponseModelImplCopyWith<$Res>
    implements $LeaveTypesListResponseModelCopyWith<$Res> {
  factory _$$LeaveTypesListResponseModelImplCopyWith(
          _$LeaveTypesListResponseModelImpl value,
          $Res Function(_$LeaveTypesListResponseModelImpl) then) =
      __$$LeaveTypesListResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      int count,
      @JsonKey(name: 'leave_types') List<LeaveTypeModel> leaveTypes});
}

/// @nodoc
class __$$LeaveTypesListResponseModelImplCopyWithImpl<$Res>
    extends _$LeaveTypesListResponseModelCopyWithImpl<$Res,
        _$LeaveTypesListResponseModelImpl>
    implements _$$LeaveTypesListResponseModelImplCopyWith<$Res> {
  __$$LeaveTypesListResponseModelImplCopyWithImpl(
      _$LeaveTypesListResponseModelImpl _value,
      $Res Function(_$LeaveTypesListResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaveTypesListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
    Object? leaveTypes = null,
  }) {
    return _then(_$LeaveTypesListResponseModelImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      leaveTypes: null == leaveTypes
          ? _value._leaveTypes
          : leaveTypes // ignore: cast_nullable_to_non_nullable
              as List<LeaveTypeModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveTypesListResponseModelImpl
    implements _LeaveTypesListResponseModel {
  const _$LeaveTypesListResponseModelImpl(
      {required this.success,
      required this.count,
      @JsonKey(name: 'leave_types')
      required final List<LeaveTypeModel> leaveTypes})
      : _leaveTypes = leaveTypes;

  factory _$LeaveTypesListResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$LeaveTypesListResponseModelImplFromJson(json);

  @override
  final bool success;
  @override
  final int count;
  final List<LeaveTypeModel> _leaveTypes;
  @override
  @JsonKey(name: 'leave_types')
  List<LeaveTypeModel> get leaveTypes {
    if (_leaveTypes is EqualUnmodifiableListView) return _leaveTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_leaveTypes);
  }

  @override
  String toString() {
    return 'LeaveTypesListResponseModel(success: $success, count: $count, leaveTypes: $leaveTypes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveTypesListResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality()
                .equals(other._leaveTypes, _leaveTypes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, count,
      const DeepCollectionEquality().hash(_leaveTypes));

  /// Create a copy of LeaveTypesListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveTypesListResponseModelImplCopyWith<_$LeaveTypesListResponseModelImpl>
      get copyWith => __$$LeaveTypesListResponseModelImplCopyWithImpl<
          _$LeaveTypesListResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveTypesListResponseModelImplToJson(
      this,
    );
  }
}

abstract class _LeaveTypesListResponseModel
    implements LeaveTypesListResponseModel {
  const factory _LeaveTypesListResponseModel(
          {required final bool success,
          required final int count,
          @JsonKey(name: 'leave_types')
          required final List<LeaveTypeModel> leaveTypes}) =
      _$LeaveTypesListResponseModelImpl;

  factory _LeaveTypesListResponseModel.fromJson(Map<String, dynamic> json) =
      _$LeaveTypesListResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  int get count;
  @override
  @JsonKey(name: 'leave_types')
  List<LeaveTypeModel> get leaveTypes;

  /// Create a copy of LeaveTypesListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveTypesListResponseModelImplCopyWith<_$LeaveTypesListResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

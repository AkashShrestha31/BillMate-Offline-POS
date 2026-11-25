// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'party_update_request_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartyUpdateRequestParams _$PartyUpdateRequestParamsFromJson(
    Map<String, dynamic> json) {
  return _PartyUpdateRequestParams.fromJson(json);
}

/// @nodoc
mixin _$PartyUpdateRequestParams {
  @JsonKey(name: 'old_name')
  String get oldName => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_name')
  String get newName => throw _privateConstructorUsedError;
  @JsonKey(name: 'update_all_references')
  bool get updateAllReferences => throw _privateConstructorUsedError;
  String get modifiedBy => throw _privateConstructorUsedError;

  /// Serializes this PartyUpdateRequestParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartyUpdateRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartyUpdateRequestParamsCopyWith<PartyUpdateRequestParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartyUpdateRequestParamsCopyWith<$Res> {
  factory $PartyUpdateRequestParamsCopyWith(PartyUpdateRequestParams value,
          $Res Function(PartyUpdateRequestParams) then) =
      _$PartyUpdateRequestParamsCopyWithImpl<$Res, PartyUpdateRequestParams>;
  @useResult
  $Res call(
      {@JsonKey(name: 'old_name') String oldName,
      @JsonKey(name: 'new_name') String newName,
      @JsonKey(name: 'update_all_references') bool updateAllReferences,
      String modifiedBy});
}

/// @nodoc
class _$PartyUpdateRequestParamsCopyWithImpl<$Res,
        $Val extends PartyUpdateRequestParams>
    implements $PartyUpdateRequestParamsCopyWith<$Res> {
  _$PartyUpdateRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartyUpdateRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldName = null,
    Object? newName = null,
    Object? updateAllReferences = null,
    Object? modifiedBy = null,
  }) {
    return _then(_value.copyWith(
      oldName: null == oldName
          ? _value.oldName
          : oldName // ignore: cast_nullable_to_non_nullable
              as String,
      newName: null == newName
          ? _value.newName
          : newName // ignore: cast_nullable_to_non_nullable
              as String,
      updateAllReferences: null == updateAllReferences
          ? _value.updateAllReferences
          : updateAllReferences // ignore: cast_nullable_to_non_nullable
              as bool,
      modifiedBy: null == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartyUpdateRequestParamsImplCopyWith<$Res>
    implements $PartyUpdateRequestParamsCopyWith<$Res> {
  factory _$$PartyUpdateRequestParamsImplCopyWith(
          _$PartyUpdateRequestParamsImpl value,
          $Res Function(_$PartyUpdateRequestParamsImpl) then) =
      __$$PartyUpdateRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'old_name') String oldName,
      @JsonKey(name: 'new_name') String newName,
      @JsonKey(name: 'update_all_references') bool updateAllReferences,
      String modifiedBy});
}

/// @nodoc
class __$$PartyUpdateRequestParamsImplCopyWithImpl<$Res>
    extends _$PartyUpdateRequestParamsCopyWithImpl<$Res,
        _$PartyUpdateRequestParamsImpl>
    implements _$$PartyUpdateRequestParamsImplCopyWith<$Res> {
  __$$PartyUpdateRequestParamsImplCopyWithImpl(
      _$PartyUpdateRequestParamsImpl _value,
      $Res Function(_$PartyUpdateRequestParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartyUpdateRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldName = null,
    Object? newName = null,
    Object? updateAllReferences = null,
    Object? modifiedBy = null,
  }) {
    return _then(_$PartyUpdateRequestParamsImpl(
      oldName: null == oldName
          ? _value.oldName
          : oldName // ignore: cast_nullable_to_non_nullable
              as String,
      newName: null == newName
          ? _value.newName
          : newName // ignore: cast_nullable_to_non_nullable
              as String,
      updateAllReferences: null == updateAllReferences
          ? _value.updateAllReferences
          : updateAllReferences // ignore: cast_nullable_to_non_nullable
              as bool,
      modifiedBy: null == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartyUpdateRequestParamsImpl implements _PartyUpdateRequestParams {
  const _$PartyUpdateRequestParamsImpl(
      {@JsonKey(name: 'old_name') required this.oldName,
      @JsonKey(name: 'new_name') required this.newName,
      @JsonKey(name: 'update_all_references') required this.updateAllReferences,
      required this.modifiedBy});

  factory _$PartyUpdateRequestParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartyUpdateRequestParamsImplFromJson(json);

  @override
  @JsonKey(name: 'old_name')
  final String oldName;
  @override
  @JsonKey(name: 'new_name')
  final String newName;
  @override
  @JsonKey(name: 'update_all_references')
  final bool updateAllReferences;
  @override
  final String modifiedBy;

  @override
  String toString() {
    return 'PartyUpdateRequestParams(oldName: $oldName, newName: $newName, updateAllReferences: $updateAllReferences, modifiedBy: $modifiedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartyUpdateRequestParamsImpl &&
            (identical(other.oldName, oldName) || other.oldName == oldName) &&
            (identical(other.newName, newName) || other.newName == newName) &&
            (identical(other.updateAllReferences, updateAllReferences) ||
                other.updateAllReferences == updateAllReferences) &&
            (identical(other.modifiedBy, modifiedBy) ||
                other.modifiedBy == modifiedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, oldName, newName, updateAllReferences, modifiedBy);

  /// Create a copy of PartyUpdateRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartyUpdateRequestParamsImplCopyWith<_$PartyUpdateRequestParamsImpl>
      get copyWith => __$$PartyUpdateRequestParamsImplCopyWithImpl<
          _$PartyUpdateRequestParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartyUpdateRequestParamsImplToJson(
      this,
    );
  }
}

abstract class _PartyUpdateRequestParams implements PartyUpdateRequestParams {
  const factory _PartyUpdateRequestParams(
      {@JsonKey(name: 'old_name') required final String oldName,
      @JsonKey(name: 'new_name') required final String newName,
      @JsonKey(name: 'update_all_references')
      required final bool updateAllReferences,
      required final String modifiedBy}) = _$PartyUpdateRequestParamsImpl;

  factory _PartyUpdateRequestParams.fromJson(Map<String, dynamic> json) =
      _$PartyUpdateRequestParamsImpl.fromJson;

  @override
  @JsonKey(name: 'old_name')
  String get oldName;
  @override
  @JsonKey(name: 'new_name')
  String get newName;
  @override
  @JsonKey(name: 'update_all_references')
  bool get updateAllReferences;
  @override
  String get modifiedBy;

  /// Create a copy of PartyUpdateRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartyUpdateRequestParamsImplCopyWith<_$PartyUpdateRequestParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reconcile_party_request_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReconcilePartyRequestParams _$ReconcilePartyRequestParamsFromJson(
    Map<String, dynamic> json) {
  return _ReconcilePartyRequestParams.fromJson(json);
}

/// @nodoc
mixin _$ReconcilePartyRequestParams {
  @JsonKey(name: 'party_name')
  String get partyName => throw _privateConstructorUsedError;
  @JsonKey(name: 'party_type')
  String get partyType => throw _privateConstructorUsedError;
  @JsonKey(name: 'auto_fix')
  bool get autoFix => throw _privateConstructorUsedError;

  /// Serializes this ReconcilePartyRequestParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReconcilePartyRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReconcilePartyRequestParamsCopyWith<ReconcilePartyRequestParams>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReconcilePartyRequestParamsCopyWith<$Res> {
  factory $ReconcilePartyRequestParamsCopyWith(
          ReconcilePartyRequestParams value,
          $Res Function(ReconcilePartyRequestParams) then) =
      _$ReconcilePartyRequestParamsCopyWithImpl<$Res,
          ReconcilePartyRequestParams>;
  @useResult
  $Res call(
      {@JsonKey(name: 'party_name') String partyName,
      @JsonKey(name: 'party_type') String partyType,
      @JsonKey(name: 'auto_fix') bool autoFix});
}

/// @nodoc
class _$ReconcilePartyRequestParamsCopyWithImpl<$Res,
        $Val extends ReconcilePartyRequestParams>
    implements $ReconcilePartyRequestParamsCopyWith<$Res> {
  _$ReconcilePartyRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReconcilePartyRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? partyName = null,
    Object? partyType = null,
    Object? autoFix = null,
  }) {
    return _then(_value.copyWith(
      partyName: null == partyName
          ? _value.partyName
          : partyName // ignore: cast_nullable_to_non_nullable
              as String,
      partyType: null == partyType
          ? _value.partyType
          : partyType // ignore: cast_nullable_to_non_nullable
              as String,
      autoFix: null == autoFix
          ? _value.autoFix
          : autoFix // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReconcilePartyRequestParamsImplCopyWith<$Res>
    implements $ReconcilePartyRequestParamsCopyWith<$Res> {
  factory _$$ReconcilePartyRequestParamsImplCopyWith(
          _$ReconcilePartyRequestParamsImpl value,
          $Res Function(_$ReconcilePartyRequestParamsImpl) then) =
      __$$ReconcilePartyRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'party_name') String partyName,
      @JsonKey(name: 'party_type') String partyType,
      @JsonKey(name: 'auto_fix') bool autoFix});
}

/// @nodoc
class __$$ReconcilePartyRequestParamsImplCopyWithImpl<$Res>
    extends _$ReconcilePartyRequestParamsCopyWithImpl<$Res,
        _$ReconcilePartyRequestParamsImpl>
    implements _$$ReconcilePartyRequestParamsImplCopyWith<$Res> {
  __$$ReconcilePartyRequestParamsImplCopyWithImpl(
      _$ReconcilePartyRequestParamsImpl _value,
      $Res Function(_$ReconcilePartyRequestParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReconcilePartyRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? partyName = null,
    Object? partyType = null,
    Object? autoFix = null,
  }) {
    return _then(_$ReconcilePartyRequestParamsImpl(
      partyName: null == partyName
          ? _value.partyName
          : partyName // ignore: cast_nullable_to_non_nullable
              as String,
      partyType: null == partyType
          ? _value.partyType
          : partyType // ignore: cast_nullable_to_non_nullable
              as String,
      autoFix: null == autoFix
          ? _value.autoFix
          : autoFix // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReconcilePartyRequestParamsImpl
    implements _ReconcilePartyRequestParams {
  const _$ReconcilePartyRequestParamsImpl(
      {@JsonKey(name: 'party_name') required this.partyName,
      @JsonKey(name: 'party_type') required this.partyType,
      @JsonKey(name: 'auto_fix') required this.autoFix});

  factory _$ReconcilePartyRequestParamsImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ReconcilePartyRequestParamsImplFromJson(json);

  @override
  @JsonKey(name: 'party_name')
  final String partyName;
  @override
  @JsonKey(name: 'party_type')
  final String partyType;
  @override
  @JsonKey(name: 'auto_fix')
  final bool autoFix;

  @override
  String toString() {
    return 'ReconcilePartyRequestParams(partyName: $partyName, partyType: $partyType, autoFix: $autoFix)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReconcilePartyRequestParamsImpl &&
            (identical(other.partyName, partyName) ||
                other.partyName == partyName) &&
            (identical(other.partyType, partyType) ||
                other.partyType == partyType) &&
            (identical(other.autoFix, autoFix) || other.autoFix == autoFix));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, partyName, partyType, autoFix);

  /// Create a copy of ReconcilePartyRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReconcilePartyRequestParamsImplCopyWith<_$ReconcilePartyRequestParamsImpl>
      get copyWith => __$$ReconcilePartyRequestParamsImplCopyWithImpl<
          _$ReconcilePartyRequestParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReconcilePartyRequestParamsImplToJson(
      this,
    );
  }
}

abstract class _ReconcilePartyRequestParams
    implements ReconcilePartyRequestParams {
  const factory _ReconcilePartyRequestParams(
          {@JsonKey(name: 'party_name') required final String partyName,
          @JsonKey(name: 'party_type') required final String partyType,
          @JsonKey(name: 'auto_fix') required final bool autoFix}) =
      _$ReconcilePartyRequestParamsImpl;

  factory _ReconcilePartyRequestParams.fromJson(Map<String, dynamic> json) =
      _$ReconcilePartyRequestParamsImpl.fromJson;

  @override
  @JsonKey(name: 'party_name')
  String get partyName;
  @override
  @JsonKey(name: 'party_type')
  String get partyType;
  @override
  @JsonKey(name: 'auto_fix')
  bool get autoFix;

  /// Create a copy of ReconcilePartyRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReconcilePartyRequestParamsImplCopyWith<_$ReconcilePartyRequestParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

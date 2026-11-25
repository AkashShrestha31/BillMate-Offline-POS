// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'party_create_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartyCreateResponseModel _$PartyCreateResponseModelFromJson(
    Map<String, dynamic> json) {
  return _PartyCreateResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PartyCreateResponseModel {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  PartyModel get party => throw _privateConstructorUsedError;

  /// Serializes this PartyCreateResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartyCreateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartyCreateResponseModelCopyWith<PartyCreateResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartyCreateResponseModelCopyWith<$Res> {
  factory $PartyCreateResponseModelCopyWith(PartyCreateResponseModel value,
          $Res Function(PartyCreateResponseModel) then) =
      _$PartyCreateResponseModelCopyWithImpl<$Res, PartyCreateResponseModel>;
  @useResult
  $Res call({bool success, String message, PartyModel party});
}

/// @nodoc
class _$PartyCreateResponseModelCopyWithImpl<$Res,
        $Val extends PartyCreateResponseModel>
    implements $PartyCreateResponseModelCopyWith<$Res> {
  _$PartyCreateResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartyCreateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? party = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      party: null == party
          ? _value.party
          : party // ignore: cast_nullable_to_non_nullable
              as PartyModel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartyCreateResponseModelImplCopyWith<$Res>
    implements $PartyCreateResponseModelCopyWith<$Res> {
  factory _$$PartyCreateResponseModelImplCopyWith(
          _$PartyCreateResponseModelImpl value,
          $Res Function(_$PartyCreateResponseModelImpl) then) =
      __$$PartyCreateResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message, PartyModel party});
}

/// @nodoc
class __$$PartyCreateResponseModelImplCopyWithImpl<$Res>
    extends _$PartyCreateResponseModelCopyWithImpl<$Res,
        _$PartyCreateResponseModelImpl>
    implements _$$PartyCreateResponseModelImplCopyWith<$Res> {
  __$$PartyCreateResponseModelImplCopyWithImpl(
      _$PartyCreateResponseModelImpl _value,
      $Res Function(_$PartyCreateResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartyCreateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? party = null,
  }) {
    return _then(_$PartyCreateResponseModelImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      party: null == party
          ? _value.party
          : party // ignore: cast_nullable_to_non_nullable
              as PartyModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartyCreateResponseModelImpl implements _PartyCreateResponseModel {
  const _$PartyCreateResponseModelImpl(
      {required this.success, required this.message, required this.party});

  factory _$PartyCreateResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartyCreateResponseModelImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final PartyModel party;

  @override
  String toString() {
    return 'PartyCreateResponseModel(success: $success, message: $message, party: $party)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartyCreateResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.party, party) || other.party == party));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, party);

  /// Create a copy of PartyCreateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartyCreateResponseModelImplCopyWith<_$PartyCreateResponseModelImpl>
      get copyWith => __$$PartyCreateResponseModelImplCopyWithImpl<
          _$PartyCreateResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartyCreateResponseModelImplToJson(
      this,
    );
  }
}

abstract class _PartyCreateResponseModel implements PartyCreateResponseModel {
  const factory _PartyCreateResponseModel(
      {required final bool success,
      required final String message,
      required final PartyModel party}) = _$PartyCreateResponseModelImpl;

  factory _PartyCreateResponseModel.fromJson(Map<String, dynamic> json) =
      _$PartyCreateResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  PartyModel get party;

  /// Create a copy of PartyCreateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartyCreateResponseModelImplCopyWith<_$PartyCreateResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

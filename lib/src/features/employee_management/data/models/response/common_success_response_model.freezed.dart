// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common_success_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CommonSuccessResponseModel _$CommonSuccessResponseModelFromJson(
    Map<String, dynamic> json) {
  return _CommonSuccessResponseModel.fromJson(json);
}

/// @nodoc
mixin _$CommonSuccessResponseModel {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;

  /// Serializes this CommonSuccessResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommonSuccessResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommonSuccessResponseModelCopyWith<CommonSuccessResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommonSuccessResponseModelCopyWith<$Res> {
  factory $CommonSuccessResponseModelCopyWith(CommonSuccessResponseModel value,
          $Res Function(CommonSuccessResponseModel) then) =
      _$CommonSuccessResponseModelCopyWithImpl<$Res,
          CommonSuccessResponseModel>;
  @useResult
  $Res call({bool success, String message, Map<String, dynamic>? data});
}

/// @nodoc
class _$CommonSuccessResponseModelCopyWithImpl<$Res,
        $Val extends CommonSuccessResponseModel>
    implements $CommonSuccessResponseModelCopyWith<$Res> {
  _$CommonSuccessResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommonSuccessResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = freezed,
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
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommonSuccessResponseModelImplCopyWith<$Res>
    implements $CommonSuccessResponseModelCopyWith<$Res> {
  factory _$$CommonSuccessResponseModelImplCopyWith(
          _$CommonSuccessResponseModelImpl value,
          $Res Function(_$CommonSuccessResponseModelImpl) then) =
      __$$CommonSuccessResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message, Map<String, dynamic>? data});
}

/// @nodoc
class __$$CommonSuccessResponseModelImplCopyWithImpl<$Res>
    extends _$CommonSuccessResponseModelCopyWithImpl<$Res,
        _$CommonSuccessResponseModelImpl>
    implements _$$CommonSuccessResponseModelImplCopyWith<$Res> {
  __$$CommonSuccessResponseModelImplCopyWithImpl(
      _$CommonSuccessResponseModelImpl _value,
      $Res Function(_$CommonSuccessResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommonSuccessResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$CommonSuccessResponseModelImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommonSuccessResponseModelImpl implements _CommonSuccessResponseModel {
  const _$CommonSuccessResponseModelImpl(
      {required this.success,
      required this.message,
      final Map<String, dynamic>? data})
      : _data = data;

  factory _$CommonSuccessResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CommonSuccessResponseModelImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'CommonSuccessResponseModel(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommonSuccessResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message,
      const DeepCollectionEquality().hash(_data));

  /// Create a copy of CommonSuccessResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommonSuccessResponseModelImplCopyWith<_$CommonSuccessResponseModelImpl>
      get copyWith => __$$CommonSuccessResponseModelImplCopyWithImpl<
          _$CommonSuccessResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommonSuccessResponseModelImplToJson(
      this,
    );
  }
}

abstract class _CommonSuccessResponseModel
    implements CommonSuccessResponseModel {
  const factory _CommonSuccessResponseModel(
      {required final bool success,
      required final String message,
      final Map<String, dynamic>? data}) = _$CommonSuccessResponseModelImpl;

  factory _CommonSuccessResponseModel.fromJson(Map<String, dynamic> json) =
      _$CommonSuccessResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  Map<String, dynamic>? get data;

  /// Create a copy of CommonSuccessResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommonSuccessResponseModelImplCopyWith<_$CommonSuccessResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

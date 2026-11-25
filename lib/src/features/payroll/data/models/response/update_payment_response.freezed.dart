// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_payment_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdatePaymentResponse _$UpdatePaymentResponseFromJson(
    Map<String, dynamic> json) {
  return _UpdatePaymentResponse.fromJson(json);
}

/// @nodoc
mixin _$UpdatePaymentResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this UpdatePaymentResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdatePaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdatePaymentResponseCopyWith<UpdatePaymentResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePaymentResponseCopyWith<$Res> {
  factory $UpdatePaymentResponseCopyWith(UpdatePaymentResponse value,
          $Res Function(UpdatePaymentResponse) then) =
      _$UpdatePaymentResponseCopyWithImpl<$Res, UpdatePaymentResponse>;
  @useResult
  $Res call({bool success, String message});
}

/// @nodoc
class _$UpdatePaymentResponseCopyWithImpl<$Res,
        $Val extends UpdatePaymentResponse>
    implements $UpdatePaymentResponseCopyWith<$Res> {
  _$UpdatePaymentResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdatePaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdatePaymentResponseImplCopyWith<$Res>
    implements $UpdatePaymentResponseCopyWith<$Res> {
  factory _$$UpdatePaymentResponseImplCopyWith(
          _$UpdatePaymentResponseImpl value,
          $Res Function(_$UpdatePaymentResponseImpl) then) =
      __$$UpdatePaymentResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message});
}

/// @nodoc
class __$$UpdatePaymentResponseImplCopyWithImpl<$Res>
    extends _$UpdatePaymentResponseCopyWithImpl<$Res,
        _$UpdatePaymentResponseImpl>
    implements _$$UpdatePaymentResponseImplCopyWith<$Res> {
  __$$UpdatePaymentResponseImplCopyWithImpl(_$UpdatePaymentResponseImpl _value,
      $Res Function(_$UpdatePaymentResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdatePaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
  }) {
    return _then(_$UpdatePaymentResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatePaymentResponseImpl implements _UpdatePaymentResponse {
  const _$UpdatePaymentResponseImpl(
      {required this.success, required this.message});

  factory _$UpdatePaymentResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdatePaymentResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;

  @override
  String toString() {
    return 'UpdatePaymentResponse(success: $success, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePaymentResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message);

  /// Create a copy of UpdatePaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePaymentResponseImplCopyWith<_$UpdatePaymentResponseImpl>
      get copyWith => __$$UpdatePaymentResponseImplCopyWithImpl<
          _$UpdatePaymentResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatePaymentResponseImplToJson(
      this,
    );
  }
}

abstract class _UpdatePaymentResponse implements UpdatePaymentResponse {
  const factory _UpdatePaymentResponse(
      {required final bool success,
      required final String message}) = _$UpdatePaymentResponseImpl;

  factory _UpdatePaymentResponse.fromJson(Map<String, dynamic> json) =
      _$UpdatePaymentResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;

  /// Create a copy of UpdatePaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatePaymentResponseImplCopyWith<_$UpdatePaymentResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_payroll_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeletePayrollResponse _$DeletePayrollResponseFromJson(
    Map<String, dynamic> json) {
  return _DeletePayrollResponse.fromJson(json);
}

/// @nodoc
mixin _$DeletePayrollResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this DeletePayrollResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeletePayrollResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeletePayrollResponseCopyWith<DeletePayrollResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeletePayrollResponseCopyWith<$Res> {
  factory $DeletePayrollResponseCopyWith(DeletePayrollResponse value,
          $Res Function(DeletePayrollResponse) then) =
      _$DeletePayrollResponseCopyWithImpl<$Res, DeletePayrollResponse>;
  @useResult
  $Res call({bool success, String message});
}

/// @nodoc
class _$DeletePayrollResponseCopyWithImpl<$Res,
        $Val extends DeletePayrollResponse>
    implements $DeletePayrollResponseCopyWith<$Res> {
  _$DeletePayrollResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeletePayrollResponse
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
abstract class _$$DeletePayrollResponseImplCopyWith<$Res>
    implements $DeletePayrollResponseCopyWith<$Res> {
  factory _$$DeletePayrollResponseImplCopyWith(
          _$DeletePayrollResponseImpl value,
          $Res Function(_$DeletePayrollResponseImpl) then) =
      __$$DeletePayrollResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message});
}

/// @nodoc
class __$$DeletePayrollResponseImplCopyWithImpl<$Res>
    extends _$DeletePayrollResponseCopyWithImpl<$Res,
        _$DeletePayrollResponseImpl>
    implements _$$DeletePayrollResponseImplCopyWith<$Res> {
  __$$DeletePayrollResponseImplCopyWithImpl(_$DeletePayrollResponseImpl _value,
      $Res Function(_$DeletePayrollResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeletePayrollResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
  }) {
    return _then(_$DeletePayrollResponseImpl(
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
class _$DeletePayrollResponseImpl implements _DeletePayrollResponse {
  const _$DeletePayrollResponseImpl(
      {required this.success, required this.message});

  factory _$DeletePayrollResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeletePayrollResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;

  @override
  String toString() {
    return 'DeletePayrollResponse(success: $success, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletePayrollResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message);

  /// Create a copy of DeletePayrollResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletePayrollResponseImplCopyWith<_$DeletePayrollResponseImpl>
      get copyWith => __$$DeletePayrollResponseImplCopyWithImpl<
          _$DeletePayrollResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeletePayrollResponseImplToJson(
      this,
    );
  }
}

abstract class _DeletePayrollResponse implements DeletePayrollResponse {
  const factory _DeletePayrollResponse(
      {required final bool success,
      required final String message}) = _$DeletePayrollResponseImpl;

  factory _DeletePayrollResponse.fromJson(Map<String, dynamic> json) =
      _$DeletePayrollResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;

  /// Create a copy of DeletePayrollResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeletePayrollResponseImplCopyWith<_$DeletePayrollResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generate_payroll_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GeneratePayrollResponse _$GeneratePayrollResponseFromJson(
    Map<String, dynamic> json) {
  return _GeneratePayrollResponse.fromJson(json);
}

/// @nodoc
mixin _$GeneratePayrollResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  PayrollModel get payroll => throw _privateConstructorUsedError;

  /// Serializes this GeneratePayrollResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GeneratePayrollResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeneratePayrollResponseCopyWith<GeneratePayrollResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneratePayrollResponseCopyWith<$Res> {
  factory $GeneratePayrollResponseCopyWith(GeneratePayrollResponse value,
          $Res Function(GeneratePayrollResponse) then) =
      _$GeneratePayrollResponseCopyWithImpl<$Res, GeneratePayrollResponse>;
  @useResult
  $Res call({bool success, String message, PayrollModel payroll});

  $PayrollModelCopyWith<$Res> get payroll;
}

/// @nodoc
class _$GeneratePayrollResponseCopyWithImpl<$Res,
        $Val extends GeneratePayrollResponse>
    implements $GeneratePayrollResponseCopyWith<$Res> {
  _$GeneratePayrollResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeneratePayrollResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? payroll = null,
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
      payroll: null == payroll
          ? _value.payroll
          : payroll // ignore: cast_nullable_to_non_nullable
              as PayrollModel,
    ) as $Val);
  }

  /// Create a copy of GeneratePayrollResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PayrollModelCopyWith<$Res> get payroll {
    return $PayrollModelCopyWith<$Res>(_value.payroll, (value) {
      return _then(_value.copyWith(payroll: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GeneratePayrollResponseImplCopyWith<$Res>
    implements $GeneratePayrollResponseCopyWith<$Res> {
  factory _$$GeneratePayrollResponseImplCopyWith(
          _$GeneratePayrollResponseImpl value,
          $Res Function(_$GeneratePayrollResponseImpl) then) =
      __$$GeneratePayrollResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message, PayrollModel payroll});

  @override
  $PayrollModelCopyWith<$Res> get payroll;
}

/// @nodoc
class __$$GeneratePayrollResponseImplCopyWithImpl<$Res>
    extends _$GeneratePayrollResponseCopyWithImpl<$Res,
        _$GeneratePayrollResponseImpl>
    implements _$$GeneratePayrollResponseImplCopyWith<$Res> {
  __$$GeneratePayrollResponseImplCopyWithImpl(
      _$GeneratePayrollResponseImpl _value,
      $Res Function(_$GeneratePayrollResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GeneratePayrollResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? payroll = null,
  }) {
    return _then(_$GeneratePayrollResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      payroll: null == payroll
          ? _value.payroll
          : payroll // ignore: cast_nullable_to_non_nullable
              as PayrollModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeneratePayrollResponseImpl implements _GeneratePayrollResponse {
  const _$GeneratePayrollResponseImpl(
      {required this.success, required this.message, required this.payroll});

  factory _$GeneratePayrollResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeneratePayrollResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final PayrollModel payroll;

  @override
  String toString() {
    return 'GeneratePayrollResponse(success: $success, message: $message, payroll: $payroll)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneratePayrollResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.payroll, payroll) || other.payroll == payroll));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, payroll);

  /// Create a copy of GeneratePayrollResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneratePayrollResponseImplCopyWith<_$GeneratePayrollResponseImpl>
      get copyWith => __$$GeneratePayrollResponseImplCopyWithImpl<
          _$GeneratePayrollResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeneratePayrollResponseImplToJson(
      this,
    );
  }
}

abstract class _GeneratePayrollResponse implements GeneratePayrollResponse {
  const factory _GeneratePayrollResponse(
      {required final bool success,
      required final String message,
      required final PayrollModel payroll}) = _$GeneratePayrollResponseImpl;

  factory _GeneratePayrollResponse.fromJson(Map<String, dynamic> json) =
      _$GeneratePayrollResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  PayrollModel get payroll;

  /// Create a copy of GeneratePayrollResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeneratePayrollResponseImplCopyWith<_$GeneratePayrollResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

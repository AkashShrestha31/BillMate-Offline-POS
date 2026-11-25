// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_request_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoginRequestParams _$LoginRequestParamsFromJson(Map<String, dynamic> json) {
  return _LoginRequestParams.fromJson(json);
}

/// @nodoc
mixin _$LoginRequestParams {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Serializes this LoginRequestParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginRequestParamsCopyWith<LoginRequestParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginRequestParamsCopyWith<$Res> {
  factory $LoginRequestParamsCopyWith(
          LoginRequestParams value, $Res Function(LoginRequestParams) then) =
      _$LoginRequestParamsCopyWithImpl<$Res, LoginRequestParams>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class _$LoginRequestParamsCopyWithImpl<$Res, $Val extends LoginRequestParams>
    implements $LoginRequestParamsCopyWith<$Res> {
  _$LoginRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginRequestParamsImplCopyWith<$Res>
    implements $LoginRequestParamsCopyWith<$Res> {
  factory _$$LoginRequestParamsImplCopyWith(_$LoginRequestParamsImpl value,
          $Res Function(_$LoginRequestParamsImpl) then) =
      __$$LoginRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$LoginRequestParamsImplCopyWithImpl<$Res>
    extends _$LoginRequestParamsCopyWithImpl<$Res, _$LoginRequestParamsImpl>
    implements _$$LoginRequestParamsImplCopyWith<$Res> {
  __$$LoginRequestParamsImplCopyWithImpl(_$LoginRequestParamsImpl _value,
      $Res Function(_$LoginRequestParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$LoginRequestParamsImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginRequestParamsImpl implements _LoginRequestParams {
  const _$LoginRequestParamsImpl({required this.email, required this.password});

  factory _$LoginRequestParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginRequestParamsImplFromJson(json);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginRequestParams(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginRequestParamsImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  /// Create a copy of LoginRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginRequestParamsImplCopyWith<_$LoginRequestParamsImpl> get copyWith =>
      __$$LoginRequestParamsImplCopyWithImpl<_$LoginRequestParamsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginRequestParamsImplToJson(
      this,
    );
  }
}

abstract class _LoginRequestParams implements LoginRequestParams {
  const factory _LoginRequestParams(
      {required final String email,
      required final String password}) = _$LoginRequestParamsImpl;

  factory _LoginRequestParams.fromJson(Map<String, dynamic> json) =
      _$LoginRequestParamsImpl.fromJson;

  @override
  String get email;
  @override
  String get password;

  /// Create a copy of LoginRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginRequestParamsImplCopyWith<_$LoginRequestParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

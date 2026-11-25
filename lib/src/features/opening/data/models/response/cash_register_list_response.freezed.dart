// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cash_register_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CashRegisterListResponse _$CashRegisterListResponseFromJson(
    Map<String, dynamic> json) {
  return _CashRegisterListResponse.fromJson(json);
}

/// @nodoc
mixin _$CashRegisterListResponse {
  bool get success => throw _privateConstructorUsedError;
  int? get count => throw _privateConstructorUsedError;
  List<CashRegisterModel>? get registers => throw _privateConstructorUsedError;
  CashRegisterModel? get register => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this CashRegisterListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CashRegisterListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CashRegisterListResponseCopyWith<CashRegisterListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashRegisterListResponseCopyWith<$Res> {
  factory $CashRegisterListResponseCopyWith(CashRegisterListResponse value,
          $Res Function(CashRegisterListResponse) then) =
      _$CashRegisterListResponseCopyWithImpl<$Res, CashRegisterListResponse>;
  @useResult
  $Res call(
      {bool success,
      int? count,
      List<CashRegisterModel>? registers,
      CashRegisterModel? register,
      String? message});

  $CashRegisterModelCopyWith<$Res>? get register;
}

/// @nodoc
class _$CashRegisterListResponseCopyWithImpl<$Res,
        $Val extends CashRegisterListResponse>
    implements $CashRegisterListResponseCopyWith<$Res> {
  _$CashRegisterListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CashRegisterListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = freezed,
    Object? registers = freezed,
    Object? register = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      registers: freezed == registers
          ? _value.registers
          : registers // ignore: cast_nullable_to_non_nullable
              as List<CashRegisterModel>?,
      register: freezed == register
          ? _value.register
          : register // ignore: cast_nullable_to_non_nullable
              as CashRegisterModel?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of CashRegisterListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CashRegisterModelCopyWith<$Res>? get register {
    if (_value.register == null) {
      return null;
    }

    return $CashRegisterModelCopyWith<$Res>(_value.register!, (value) {
      return _then(_value.copyWith(register: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CashRegisterListResponseImplCopyWith<$Res>
    implements $CashRegisterListResponseCopyWith<$Res> {
  factory _$$CashRegisterListResponseImplCopyWith(
          _$CashRegisterListResponseImpl value,
          $Res Function(_$CashRegisterListResponseImpl) then) =
      __$$CashRegisterListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      int? count,
      List<CashRegisterModel>? registers,
      CashRegisterModel? register,
      String? message});

  @override
  $CashRegisterModelCopyWith<$Res>? get register;
}

/// @nodoc
class __$$CashRegisterListResponseImplCopyWithImpl<$Res>
    extends _$CashRegisterListResponseCopyWithImpl<$Res,
        _$CashRegisterListResponseImpl>
    implements _$$CashRegisterListResponseImplCopyWith<$Res> {
  __$$CashRegisterListResponseImplCopyWithImpl(
      _$CashRegisterListResponseImpl _value,
      $Res Function(_$CashRegisterListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CashRegisterListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = freezed,
    Object? registers = freezed,
    Object? register = freezed,
    Object? message = freezed,
  }) {
    return _then(_$CashRegisterListResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      registers: freezed == registers
          ? _value._registers
          : registers // ignore: cast_nullable_to_non_nullable
              as List<CashRegisterModel>?,
      register: freezed == register
          ? _value.register
          : register // ignore: cast_nullable_to_non_nullable
              as CashRegisterModel?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CashRegisterListResponseImpl implements _CashRegisterListResponse {
  const _$CashRegisterListResponseImpl(
      {required this.success,
      this.count,
      final List<CashRegisterModel>? registers,
      this.register,
      this.message})
      : _registers = registers;

  factory _$CashRegisterListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashRegisterListResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final int? count;
  final List<CashRegisterModel>? _registers;
  @override
  List<CashRegisterModel>? get registers {
    final value = _registers;
    if (value == null) return null;
    if (_registers is EqualUnmodifiableListView) return _registers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final CashRegisterModel? register;
  @override
  final String? message;

  @override
  String toString() {
    return 'CashRegisterListResponse(success: $success, count: $count, registers: $registers, register: $register, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashRegisterListResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality()
                .equals(other._registers, _registers) &&
            (identical(other.register, register) ||
                other.register == register) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, count,
      const DeepCollectionEquality().hash(_registers), register, message);

  /// Create a copy of CashRegisterListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CashRegisterListResponseImplCopyWith<_$CashRegisterListResponseImpl>
      get copyWith => __$$CashRegisterListResponseImplCopyWithImpl<
          _$CashRegisterListResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CashRegisterListResponseImplToJson(
      this,
    );
  }
}

abstract class _CashRegisterListResponse implements CashRegisterListResponse {
  const factory _CashRegisterListResponse(
      {required final bool success,
      final int? count,
      final List<CashRegisterModel>? registers,
      final CashRegisterModel? register,
      final String? message}) = _$CashRegisterListResponseImpl;

  factory _CashRegisterListResponse.fromJson(Map<String, dynamic> json) =
      _$CashRegisterListResponseImpl.fromJson;

  @override
  bool get success;
  @override
  int? get count;
  @override
  List<CashRegisterModel>? get registers;
  @override
  CashRegisterModel? get register;
  @override
  String? get message;

  /// Create a copy of CashRegisterListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CashRegisterListResponseImplCopyWith<_$CashRegisterListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

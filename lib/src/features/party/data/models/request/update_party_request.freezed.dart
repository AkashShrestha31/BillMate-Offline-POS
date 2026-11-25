// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_party_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdatePartyRequest _$UpdatePartyRequestFromJson(Map<String, dynamic> json) {
  return _UpdatePartyRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdatePartyRequest {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_name')
  String? get newName => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  String? get loyaltyProgram => throw _privateConstructorUsedError;
  int? get loyaltyPoints => throw _privateConstructorUsedError;
  String? get outstandingAmount => throw _privateConstructorUsedError;
  String? get defaultAccount => throw _privateConstructorUsedError;
  String? get fromLead => throw _privateConstructorUsedError;
  String? get modifiedBy => throw _privateConstructorUsedError;

  /// Serializes this UpdatePartyRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdatePartyRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdatePartyRequestCopyWith<UpdatePartyRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePartyRequestCopyWith<$Res> {
  factory $UpdatePartyRequestCopyWith(
          UpdatePartyRequest value, $Res Function(UpdatePartyRequest) then) =
      _$UpdatePartyRequestCopyWithImpl<$Res, UpdatePartyRequest>;
  @useResult
  $Res call(
      {String name,
      @JsonKey(name: 'new_name') String? newName,
      String? role,
      String? email,
      String? phone,
      String? address,
      String? currency,
      String? loyaltyProgram,
      int? loyaltyPoints,
      String? outstandingAmount,
      String? defaultAccount,
      String? fromLead,
      String? modifiedBy});
}

/// @nodoc
class _$UpdatePartyRequestCopyWithImpl<$Res, $Val extends UpdatePartyRequest>
    implements $UpdatePartyRequestCopyWith<$Res> {
  _$UpdatePartyRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdatePartyRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? newName = freezed,
    Object? role = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? currency = freezed,
    Object? loyaltyProgram = freezed,
    Object? loyaltyPoints = freezed,
    Object? outstandingAmount = freezed,
    Object? defaultAccount = freezed,
    Object? fromLead = freezed,
    Object? modifiedBy = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      newName: freezed == newName
          ? _value.newName
          : newName // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      loyaltyProgram: freezed == loyaltyProgram
          ? _value.loyaltyProgram
          : loyaltyProgram // ignore: cast_nullable_to_non_nullable
              as String?,
      loyaltyPoints: freezed == loyaltyPoints
          ? _value.loyaltyPoints
          : loyaltyPoints // ignore: cast_nullable_to_non_nullable
              as int?,
      outstandingAmount: freezed == outstandingAmount
          ? _value.outstandingAmount
          : outstandingAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultAccount: freezed == defaultAccount
          ? _value.defaultAccount
          : defaultAccount // ignore: cast_nullable_to_non_nullable
              as String?,
      fromLead: freezed == fromLead
          ? _value.fromLead
          : fromLead // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedBy: freezed == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdatePartyRequestImplCopyWith<$Res>
    implements $UpdatePartyRequestCopyWith<$Res> {
  factory _$$UpdatePartyRequestImplCopyWith(_$UpdatePartyRequestImpl value,
          $Res Function(_$UpdatePartyRequestImpl) then) =
      __$$UpdatePartyRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      @JsonKey(name: 'new_name') String? newName,
      String? role,
      String? email,
      String? phone,
      String? address,
      String? currency,
      String? loyaltyProgram,
      int? loyaltyPoints,
      String? outstandingAmount,
      String? defaultAccount,
      String? fromLead,
      String? modifiedBy});
}

/// @nodoc
class __$$UpdatePartyRequestImplCopyWithImpl<$Res>
    extends _$UpdatePartyRequestCopyWithImpl<$Res, _$UpdatePartyRequestImpl>
    implements _$$UpdatePartyRequestImplCopyWith<$Res> {
  __$$UpdatePartyRequestImplCopyWithImpl(_$UpdatePartyRequestImpl _value,
      $Res Function(_$UpdatePartyRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdatePartyRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? newName = freezed,
    Object? role = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? currency = freezed,
    Object? loyaltyProgram = freezed,
    Object? loyaltyPoints = freezed,
    Object? outstandingAmount = freezed,
    Object? defaultAccount = freezed,
    Object? fromLead = freezed,
    Object? modifiedBy = freezed,
  }) {
    return _then(_$UpdatePartyRequestImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      newName: freezed == newName
          ? _value.newName
          : newName // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      loyaltyProgram: freezed == loyaltyProgram
          ? _value.loyaltyProgram
          : loyaltyProgram // ignore: cast_nullable_to_non_nullable
              as String?,
      loyaltyPoints: freezed == loyaltyPoints
          ? _value.loyaltyPoints
          : loyaltyPoints // ignore: cast_nullable_to_non_nullable
              as int?,
      outstandingAmount: freezed == outstandingAmount
          ? _value.outstandingAmount
          : outstandingAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultAccount: freezed == defaultAccount
          ? _value.defaultAccount
          : defaultAccount // ignore: cast_nullable_to_non_nullable
              as String?,
      fromLead: freezed == fromLead
          ? _value.fromLead
          : fromLead // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedBy: freezed == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatePartyRequestImpl implements _UpdatePartyRequest {
  const _$UpdatePartyRequestImpl(
      {required this.name,
      @JsonKey(name: 'new_name') this.newName,
      this.role,
      this.email,
      this.phone,
      this.address,
      this.currency,
      this.loyaltyProgram,
      this.loyaltyPoints,
      this.outstandingAmount,
      this.defaultAccount,
      this.fromLead,
      this.modifiedBy});

  factory _$UpdatePartyRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdatePartyRequestImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: 'new_name')
  final String? newName;
  @override
  final String? role;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? address;
  @override
  final String? currency;
  @override
  final String? loyaltyProgram;
  @override
  final int? loyaltyPoints;
  @override
  final String? outstandingAmount;
  @override
  final String? defaultAccount;
  @override
  final String? fromLead;
  @override
  final String? modifiedBy;

  @override
  String toString() {
    return 'UpdatePartyRequest(name: $name, newName: $newName, role: $role, email: $email, phone: $phone, address: $address, currency: $currency, loyaltyProgram: $loyaltyProgram, loyaltyPoints: $loyaltyPoints, outstandingAmount: $outstandingAmount, defaultAccount: $defaultAccount, fromLead: $fromLead, modifiedBy: $modifiedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePartyRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.newName, newName) || other.newName == newName) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.loyaltyProgram, loyaltyProgram) ||
                other.loyaltyProgram == loyaltyProgram) &&
            (identical(other.loyaltyPoints, loyaltyPoints) ||
                other.loyaltyPoints == loyaltyPoints) &&
            (identical(other.outstandingAmount, outstandingAmount) ||
                other.outstandingAmount == outstandingAmount) &&
            (identical(other.defaultAccount, defaultAccount) ||
                other.defaultAccount == defaultAccount) &&
            (identical(other.fromLead, fromLead) ||
                other.fromLead == fromLead) &&
            (identical(other.modifiedBy, modifiedBy) ||
                other.modifiedBy == modifiedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      newName,
      role,
      email,
      phone,
      address,
      currency,
      loyaltyProgram,
      loyaltyPoints,
      outstandingAmount,
      defaultAccount,
      fromLead,
      modifiedBy);

  /// Create a copy of UpdatePartyRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePartyRequestImplCopyWith<_$UpdatePartyRequestImpl> get copyWith =>
      __$$UpdatePartyRequestImplCopyWithImpl<_$UpdatePartyRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatePartyRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdatePartyRequest implements UpdatePartyRequest {
  const factory _UpdatePartyRequest(
      {required final String name,
      @JsonKey(name: 'new_name') final String? newName,
      final String? role,
      final String? email,
      final String? phone,
      final String? address,
      final String? currency,
      final String? loyaltyProgram,
      final int? loyaltyPoints,
      final String? outstandingAmount,
      final String? defaultAccount,
      final String? fromLead,
      final String? modifiedBy}) = _$UpdatePartyRequestImpl;

  factory _UpdatePartyRequest.fromJson(Map<String, dynamic> json) =
      _$UpdatePartyRequestImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'new_name')
  String? get newName;
  @override
  String? get role;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get address;
  @override
  String? get currency;
  @override
  String? get loyaltyProgram;
  @override
  int? get loyaltyPoints;
  @override
  String? get outstandingAmount;
  @override
  String? get defaultAccount;
  @override
  String? get fromLead;
  @override
  String? get modifiedBy;

  /// Create a copy of UpdatePartyRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatePartyRequestImplCopyWith<_$UpdatePartyRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

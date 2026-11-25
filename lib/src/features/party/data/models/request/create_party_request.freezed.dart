// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_party_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreatePartyRequest _$CreatePartyRequestFromJson(Map<String, dynamic> json) {
  return _CreatePartyRequest.fromJson(json);
}

/// @nodoc
mixin _$CreatePartyRequest {
  String get name => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'loyaltyProgram')
  String? get loyaltyProgram => throw _privateConstructorUsedError;
  @JsonKey(name: 'loyaltyPoints')
  int? get loyaltyPoints => throw _privateConstructorUsedError;
  @JsonKey(name: 'outstandingAmount')
  String? get outstandingAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'defaultAccount')
  String? get defaultAccount => throw _privateConstructorUsedError;
  @JsonKey(name: 'fromLead')
  String? get fromLead => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdBy')
  String? get createdBy => throw _privateConstructorUsedError;

  /// Serializes this CreatePartyRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreatePartyRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatePartyRequestCopyWith<CreatePartyRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePartyRequestCopyWith<$Res> {
  factory $CreatePartyRequestCopyWith(
          CreatePartyRequest value, $Res Function(CreatePartyRequest) then) =
      _$CreatePartyRequestCopyWithImpl<$Res, CreatePartyRequest>;
  @useResult
  $Res call(
      {String name,
      String role,
      String? email,
      String? phone,
      String? address,
      String? currency,
      @JsonKey(name: 'loyaltyProgram') String? loyaltyProgram,
      @JsonKey(name: 'loyaltyPoints') int? loyaltyPoints,
      @JsonKey(name: 'outstandingAmount') String? outstandingAmount,
      @JsonKey(name: 'defaultAccount') String? defaultAccount,
      @JsonKey(name: 'fromLead') String? fromLead,
      @JsonKey(name: 'createdBy') String? createdBy});
}

/// @nodoc
class _$CreatePartyRequestCopyWithImpl<$Res, $Val extends CreatePartyRequest>
    implements $CreatePartyRequestCopyWith<$Res> {
  _$CreatePartyRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatePartyRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? role = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? currency = freezed,
    Object? loyaltyProgram = freezed,
    Object? loyaltyPoints = freezed,
    Object? outstandingAmount = freezed,
    Object? defaultAccount = freezed,
    Object? fromLead = freezed,
    Object? createdBy = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
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
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreatePartyRequestImplCopyWith<$Res>
    implements $CreatePartyRequestCopyWith<$Res> {
  factory _$$CreatePartyRequestImplCopyWith(_$CreatePartyRequestImpl value,
          $Res Function(_$CreatePartyRequestImpl) then) =
      __$$CreatePartyRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String role,
      String? email,
      String? phone,
      String? address,
      String? currency,
      @JsonKey(name: 'loyaltyProgram') String? loyaltyProgram,
      @JsonKey(name: 'loyaltyPoints') int? loyaltyPoints,
      @JsonKey(name: 'outstandingAmount') String? outstandingAmount,
      @JsonKey(name: 'defaultAccount') String? defaultAccount,
      @JsonKey(name: 'fromLead') String? fromLead,
      @JsonKey(name: 'createdBy') String? createdBy});
}

/// @nodoc
class __$$CreatePartyRequestImplCopyWithImpl<$Res>
    extends _$CreatePartyRequestCopyWithImpl<$Res, _$CreatePartyRequestImpl>
    implements _$$CreatePartyRequestImplCopyWith<$Res> {
  __$$CreatePartyRequestImplCopyWithImpl(_$CreatePartyRequestImpl _value,
      $Res Function(_$CreatePartyRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreatePartyRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? role = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? currency = freezed,
    Object? loyaltyProgram = freezed,
    Object? loyaltyPoints = freezed,
    Object? outstandingAmount = freezed,
    Object? defaultAccount = freezed,
    Object? fromLead = freezed,
    Object? createdBy = freezed,
  }) {
    return _then(_$CreatePartyRequestImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
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
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatePartyRequestImpl implements _CreatePartyRequest {
  const _$CreatePartyRequestImpl(
      {required this.name,
      required this.role,
      this.email,
      this.phone,
      this.address,
      this.currency,
      @JsonKey(name: 'loyaltyProgram') this.loyaltyProgram,
      @JsonKey(name: 'loyaltyPoints') this.loyaltyPoints,
      @JsonKey(name: 'outstandingAmount') this.outstandingAmount,
      @JsonKey(name: 'defaultAccount') this.defaultAccount,
      @JsonKey(name: 'fromLead') this.fromLead,
      @JsonKey(name: 'createdBy') this.createdBy});

  factory _$CreatePartyRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreatePartyRequestImplFromJson(json);

  @override
  final String name;
  @override
  final String role;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? address;
  @override
  final String? currency;
  @override
  @JsonKey(name: 'loyaltyProgram')
  final String? loyaltyProgram;
  @override
  @JsonKey(name: 'loyaltyPoints')
  final int? loyaltyPoints;
  @override
  @JsonKey(name: 'outstandingAmount')
  final String? outstandingAmount;
  @override
  @JsonKey(name: 'defaultAccount')
  final String? defaultAccount;
  @override
  @JsonKey(name: 'fromLead')
  final String? fromLead;
  @override
  @JsonKey(name: 'createdBy')
  final String? createdBy;

  @override
  String toString() {
    return 'CreatePartyRequest(name: $name, role: $role, email: $email, phone: $phone, address: $address, currency: $currency, loyaltyProgram: $loyaltyProgram, loyaltyPoints: $loyaltyPoints, outstandingAmount: $outstandingAmount, defaultAccount: $defaultAccount, fromLead: $fromLead, createdBy: $createdBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePartyRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
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
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
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
      createdBy);

  /// Create a copy of CreatePartyRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePartyRequestImplCopyWith<_$CreatePartyRequestImpl> get copyWith =>
      __$$CreatePartyRequestImplCopyWithImpl<_$CreatePartyRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatePartyRequestImplToJson(
      this,
    );
  }
}

abstract class _CreatePartyRequest implements CreatePartyRequest {
  const factory _CreatePartyRequest(
          {required final String name,
          required final String role,
          final String? email,
          final String? phone,
          final String? address,
          final String? currency,
          @JsonKey(name: 'loyaltyProgram') final String? loyaltyProgram,
          @JsonKey(name: 'loyaltyPoints') final int? loyaltyPoints,
          @JsonKey(name: 'outstandingAmount') final String? outstandingAmount,
          @JsonKey(name: 'defaultAccount') final String? defaultAccount,
          @JsonKey(name: 'fromLead') final String? fromLead,
          @JsonKey(name: 'createdBy') final String? createdBy}) =
      _$CreatePartyRequestImpl;

  factory _CreatePartyRequest.fromJson(Map<String, dynamic> json) =
      _$CreatePartyRequestImpl.fromJson;

  @override
  String get name;
  @override
  String get role;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get address;
  @override
  String? get currency;
  @override
  @JsonKey(name: 'loyaltyProgram')
  String? get loyaltyProgram;
  @override
  @JsonKey(name: 'loyaltyPoints')
  int? get loyaltyPoints;
  @override
  @JsonKey(name: 'outstandingAmount')
  String? get outstandingAmount;
  @override
  @JsonKey(name: 'defaultAccount')
  String? get defaultAccount;
  @override
  @JsonKey(name: 'fromLead')
  String? get fromLead;
  @override
  @JsonKey(name: 'createdBy')
  String? get createdBy;

  /// Create a copy of CreatePartyRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatePartyRequestImplCopyWith<_$CreatePartyRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

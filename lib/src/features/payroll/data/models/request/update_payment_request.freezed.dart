// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_payment_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdatePaymentRequest _$UpdatePaymentRequestFromJson(Map<String, dynamic> json) {
  return _UpdatePaymentRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdatePaymentRequest {
  @JsonKey(name: 'payroll_id')
  int get payrollId => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_date')
  String get paymentDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method')
  String? get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'bank_reference')
  String? get bankReference => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this UpdatePaymentRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdatePaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdatePaymentRequestCopyWith<UpdatePaymentRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePaymentRequestCopyWith<$Res> {
  factory $UpdatePaymentRequestCopyWith(UpdatePaymentRequest value,
          $Res Function(UpdatePaymentRequest) then) =
      _$UpdatePaymentRequestCopyWithImpl<$Res, UpdatePaymentRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'payroll_id') int payrollId,
      @JsonKey(name: 'payment_date') String paymentDate,
      @JsonKey(name: 'payment_method') String? paymentMethod,
      @JsonKey(name: 'bank_reference') String? bankReference,
      String? notes});
}

/// @nodoc
class _$UpdatePaymentRequestCopyWithImpl<$Res,
        $Val extends UpdatePaymentRequest>
    implements $UpdatePaymentRequestCopyWith<$Res> {
  _$UpdatePaymentRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdatePaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payrollId = null,
    Object? paymentDate = null,
    Object? paymentMethod = freezed,
    Object? bankReference = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      payrollId: null == payrollId
          ? _value.payrollId
          : payrollId // ignore: cast_nullable_to_non_nullable
              as int,
      paymentDate: null == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      bankReference: freezed == bankReference
          ? _value.bankReference
          : bankReference // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdatePaymentRequestImplCopyWith<$Res>
    implements $UpdatePaymentRequestCopyWith<$Res> {
  factory _$$UpdatePaymentRequestImplCopyWith(_$UpdatePaymentRequestImpl value,
          $Res Function(_$UpdatePaymentRequestImpl) then) =
      __$$UpdatePaymentRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'payroll_id') int payrollId,
      @JsonKey(name: 'payment_date') String paymentDate,
      @JsonKey(name: 'payment_method') String? paymentMethod,
      @JsonKey(name: 'bank_reference') String? bankReference,
      String? notes});
}

/// @nodoc
class __$$UpdatePaymentRequestImplCopyWithImpl<$Res>
    extends _$UpdatePaymentRequestCopyWithImpl<$Res, _$UpdatePaymentRequestImpl>
    implements _$$UpdatePaymentRequestImplCopyWith<$Res> {
  __$$UpdatePaymentRequestImplCopyWithImpl(_$UpdatePaymentRequestImpl _value,
      $Res Function(_$UpdatePaymentRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdatePaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payrollId = null,
    Object? paymentDate = null,
    Object? paymentMethod = freezed,
    Object? bankReference = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$UpdatePaymentRequestImpl(
      payrollId: null == payrollId
          ? _value.payrollId
          : payrollId // ignore: cast_nullable_to_non_nullable
              as int,
      paymentDate: null == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      bankReference: freezed == bankReference
          ? _value.bankReference
          : bankReference // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatePaymentRequestImpl implements _UpdatePaymentRequest {
  const _$UpdatePaymentRequestImpl(
      {@JsonKey(name: 'payroll_id') required this.payrollId,
      @JsonKey(name: 'payment_date') required this.paymentDate,
      @JsonKey(name: 'payment_method') this.paymentMethod,
      @JsonKey(name: 'bank_reference') this.bankReference,
      this.notes});

  factory _$UpdatePaymentRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdatePaymentRequestImplFromJson(json);

  @override
  @JsonKey(name: 'payroll_id')
  final int payrollId;
  @override
  @JsonKey(name: 'payment_date')
  final String paymentDate;
  @override
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @override
  @JsonKey(name: 'bank_reference')
  final String? bankReference;
  @override
  final String? notes;

  @override
  String toString() {
    return 'UpdatePaymentRequest(payrollId: $payrollId, paymentDate: $paymentDate, paymentMethod: $paymentMethod, bankReference: $bankReference, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePaymentRequestImpl &&
            (identical(other.payrollId, payrollId) ||
                other.payrollId == payrollId) &&
            (identical(other.paymentDate, paymentDate) ||
                other.paymentDate == paymentDate) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.bankReference, bankReference) ||
                other.bankReference == bankReference) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, payrollId, paymentDate, paymentMethod, bankReference, notes);

  /// Create a copy of UpdatePaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePaymentRequestImplCopyWith<_$UpdatePaymentRequestImpl>
      get copyWith =>
          __$$UpdatePaymentRequestImplCopyWithImpl<_$UpdatePaymentRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatePaymentRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdatePaymentRequest implements UpdatePaymentRequest {
  const factory _UpdatePaymentRequest(
      {@JsonKey(name: 'payroll_id') required final int payrollId,
      @JsonKey(name: 'payment_date') required final String paymentDate,
      @JsonKey(name: 'payment_method') final String? paymentMethod,
      @JsonKey(name: 'bank_reference') final String? bankReference,
      final String? notes}) = _$UpdatePaymentRequestImpl;

  factory _UpdatePaymentRequest.fromJson(Map<String, dynamic> json) =
      _$UpdatePaymentRequestImpl.fromJson;

  @override
  @JsonKey(name: 'payroll_id')
  int get payrollId;
  @override
  @JsonKey(name: 'payment_date')
  String get paymentDate;
  @override
  @JsonKey(name: 'payment_method')
  String? get paymentMethod;
  @override
  @JsonKey(name: 'bank_reference')
  String? get bankReference;
  @override
  String? get notes;

  /// Create a copy of UpdatePaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatePaymentRequestImplCopyWith<_$UpdatePaymentRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

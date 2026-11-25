// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_payroll_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeletePayrollRequest _$DeletePayrollRequestFromJson(Map<String, dynamic> json) {
  return _DeletePayrollRequest.fromJson(json);
}

/// @nodoc
mixin _$DeletePayrollRequest {
  @JsonKey(name: 'payroll_id')
  int get payrollId => throw _privateConstructorUsedError;

  /// Serializes this DeletePayrollRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeletePayrollRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeletePayrollRequestCopyWith<DeletePayrollRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeletePayrollRequestCopyWith<$Res> {
  factory $DeletePayrollRequestCopyWith(DeletePayrollRequest value,
          $Res Function(DeletePayrollRequest) then) =
      _$DeletePayrollRequestCopyWithImpl<$Res, DeletePayrollRequest>;
  @useResult
  $Res call({@JsonKey(name: 'payroll_id') int payrollId});
}

/// @nodoc
class _$DeletePayrollRequestCopyWithImpl<$Res,
        $Val extends DeletePayrollRequest>
    implements $DeletePayrollRequestCopyWith<$Res> {
  _$DeletePayrollRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeletePayrollRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payrollId = null,
  }) {
    return _then(_value.copyWith(
      payrollId: null == payrollId
          ? _value.payrollId
          : payrollId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeletePayrollRequestImplCopyWith<$Res>
    implements $DeletePayrollRequestCopyWith<$Res> {
  factory _$$DeletePayrollRequestImplCopyWith(_$DeletePayrollRequestImpl value,
          $Res Function(_$DeletePayrollRequestImpl) then) =
      __$$DeletePayrollRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'payroll_id') int payrollId});
}

/// @nodoc
class __$$DeletePayrollRequestImplCopyWithImpl<$Res>
    extends _$DeletePayrollRequestCopyWithImpl<$Res, _$DeletePayrollRequestImpl>
    implements _$$DeletePayrollRequestImplCopyWith<$Res> {
  __$$DeletePayrollRequestImplCopyWithImpl(_$DeletePayrollRequestImpl _value,
      $Res Function(_$DeletePayrollRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeletePayrollRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payrollId = null,
  }) {
    return _then(_$DeletePayrollRequestImpl(
      payrollId: null == payrollId
          ? _value.payrollId
          : payrollId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeletePayrollRequestImpl implements _DeletePayrollRequest {
  const _$DeletePayrollRequestImpl(
      {@JsonKey(name: 'payroll_id') required this.payrollId});

  factory _$DeletePayrollRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeletePayrollRequestImplFromJson(json);

  @override
  @JsonKey(name: 'payroll_id')
  final int payrollId;

  @override
  String toString() {
    return 'DeletePayrollRequest(payrollId: $payrollId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletePayrollRequestImpl &&
            (identical(other.payrollId, payrollId) ||
                other.payrollId == payrollId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, payrollId);

  /// Create a copy of DeletePayrollRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletePayrollRequestImplCopyWith<_$DeletePayrollRequestImpl>
      get copyWith =>
          __$$DeletePayrollRequestImplCopyWithImpl<_$DeletePayrollRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeletePayrollRequestImplToJson(
      this,
    );
  }
}

abstract class _DeletePayrollRequest implements DeletePayrollRequest {
  const factory _DeletePayrollRequest(
          {@JsonKey(name: 'payroll_id') required final int payrollId}) =
      _$DeletePayrollRequestImpl;

  factory _DeletePayrollRequest.fromJson(Map<String, dynamic> json) =
      _$DeletePayrollRequestImpl.fromJson;

  @override
  @JsonKey(name: 'payroll_id')
  int get payrollId;

  /// Create a copy of DeletePayrollRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeletePayrollRequestImplCopyWith<_$DeletePayrollRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

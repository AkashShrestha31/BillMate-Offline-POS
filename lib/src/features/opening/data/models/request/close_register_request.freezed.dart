// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'close_register_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CloseRegisterRequest _$CloseRegisterRequestFromJson(Map<String, dynamic> json) {
  return _CloseRegisterRequest.fromJson(json);
}

/// @nodoc
mixin _$CloseRegisterRequest {
  @JsonKey(name: 'register_id')
  int get registerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'shift_date')
  String get shiftDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'closing_amount')
  double get closingAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'closing_note')
  String? get closingNote => throw _privateConstructorUsedError;
  @JsonKey(name: 'closed_by')
  String get closedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'denominations', includeIfNull: false)
  List<DenominationRequestItem>? get denominations =>
      throw _privateConstructorUsedError;

  /// Serializes this CloseRegisterRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CloseRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CloseRegisterRequestCopyWith<CloseRegisterRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CloseRegisterRequestCopyWith<$Res> {
  factory $CloseRegisterRequestCopyWith(CloseRegisterRequest value,
          $Res Function(CloseRegisterRequest) then) =
      _$CloseRegisterRequestCopyWithImpl<$Res, CloseRegisterRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'register_id') int registerId,
      @JsonKey(name: 'shift_date') String shiftDate,
      @JsonKey(name: 'closing_amount') double closingAmount,
      @JsonKey(name: 'closing_note') String? closingNote,
      @JsonKey(name: 'closed_by') String closedBy,
      @JsonKey(name: 'denominations', includeIfNull: false)
      List<DenominationRequestItem>? denominations});
}

/// @nodoc
class _$CloseRegisterRequestCopyWithImpl<$Res,
        $Val extends CloseRegisterRequest>
    implements $CloseRegisterRequestCopyWith<$Res> {
  _$CloseRegisterRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CloseRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registerId = null,
    Object? shiftDate = null,
    Object? closingAmount = null,
    Object? closingNote = freezed,
    Object? closedBy = null,
    Object? denominations = freezed,
  }) {
    return _then(_value.copyWith(
      registerId: null == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as int,
      shiftDate: null == shiftDate
          ? _value.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as String,
      closingAmount: null == closingAmount
          ? _value.closingAmount
          : closingAmount // ignore: cast_nullable_to_non_nullable
              as double,
      closingNote: freezed == closingNote
          ? _value.closingNote
          : closingNote // ignore: cast_nullable_to_non_nullable
              as String?,
      closedBy: null == closedBy
          ? _value.closedBy
          : closedBy // ignore: cast_nullable_to_non_nullable
              as String,
      denominations: freezed == denominations
          ? _value.denominations
          : denominations // ignore: cast_nullable_to_non_nullable
              as List<DenominationRequestItem>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CloseRegisterRequestImplCopyWith<$Res>
    implements $CloseRegisterRequestCopyWith<$Res> {
  factory _$$CloseRegisterRequestImplCopyWith(_$CloseRegisterRequestImpl value,
          $Res Function(_$CloseRegisterRequestImpl) then) =
      __$$CloseRegisterRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'register_id') int registerId,
      @JsonKey(name: 'shift_date') String shiftDate,
      @JsonKey(name: 'closing_amount') double closingAmount,
      @JsonKey(name: 'closing_note') String? closingNote,
      @JsonKey(name: 'closed_by') String closedBy,
      @JsonKey(name: 'denominations', includeIfNull: false)
      List<DenominationRequestItem>? denominations});
}

/// @nodoc
class __$$CloseRegisterRequestImplCopyWithImpl<$Res>
    extends _$CloseRegisterRequestCopyWithImpl<$Res, _$CloseRegisterRequestImpl>
    implements _$$CloseRegisterRequestImplCopyWith<$Res> {
  __$$CloseRegisterRequestImplCopyWithImpl(_$CloseRegisterRequestImpl _value,
      $Res Function(_$CloseRegisterRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of CloseRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registerId = null,
    Object? shiftDate = null,
    Object? closingAmount = null,
    Object? closingNote = freezed,
    Object? closedBy = null,
    Object? denominations = freezed,
  }) {
    return _then(_$CloseRegisterRequestImpl(
      registerId: null == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as int,
      shiftDate: null == shiftDate
          ? _value.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as String,
      closingAmount: null == closingAmount
          ? _value.closingAmount
          : closingAmount // ignore: cast_nullable_to_non_nullable
              as double,
      closingNote: freezed == closingNote
          ? _value.closingNote
          : closingNote // ignore: cast_nullable_to_non_nullable
              as String?,
      closedBy: null == closedBy
          ? _value.closedBy
          : closedBy // ignore: cast_nullable_to_non_nullable
              as String,
      denominations: freezed == denominations
          ? _value._denominations
          : denominations // ignore: cast_nullable_to_non_nullable
              as List<DenominationRequestItem>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CloseRegisterRequestImpl implements _CloseRegisterRequest {
  const _$CloseRegisterRequestImpl(
      {@JsonKey(name: 'register_id') required this.registerId,
      @JsonKey(name: 'shift_date') required this.shiftDate,
      @JsonKey(name: 'closing_amount') required this.closingAmount,
      @JsonKey(name: 'closing_note') this.closingNote,
      @JsonKey(name: 'closed_by') required this.closedBy,
      @JsonKey(name: 'denominations', includeIfNull: false)
      final List<DenominationRequestItem>? denominations})
      : _denominations = denominations;

  factory _$CloseRegisterRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CloseRegisterRequestImplFromJson(json);

  @override
  @JsonKey(name: 'register_id')
  final int registerId;
  @override
  @JsonKey(name: 'shift_date')
  final String shiftDate;
  @override
  @JsonKey(name: 'closing_amount')
  final double closingAmount;
  @override
  @JsonKey(name: 'closing_note')
  final String? closingNote;
  @override
  @JsonKey(name: 'closed_by')
  final String closedBy;
  final List<DenominationRequestItem>? _denominations;
  @override
  @JsonKey(name: 'denominations', includeIfNull: false)
  List<DenominationRequestItem>? get denominations {
    final value = _denominations;
    if (value == null) return null;
    if (_denominations is EqualUnmodifiableListView) return _denominations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CloseRegisterRequest(registerId: $registerId, shiftDate: $shiftDate, closingAmount: $closingAmount, closingNote: $closingNote, closedBy: $closedBy, denominations: $denominations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CloseRegisterRequestImpl &&
            (identical(other.registerId, registerId) ||
                other.registerId == registerId) &&
            (identical(other.shiftDate, shiftDate) ||
                other.shiftDate == shiftDate) &&
            (identical(other.closingAmount, closingAmount) ||
                other.closingAmount == closingAmount) &&
            (identical(other.closingNote, closingNote) ||
                other.closingNote == closingNote) &&
            (identical(other.closedBy, closedBy) ||
                other.closedBy == closedBy) &&
            const DeepCollectionEquality()
                .equals(other._denominations, _denominations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      registerId,
      shiftDate,
      closingAmount,
      closingNote,
      closedBy,
      const DeepCollectionEquality().hash(_denominations));

  /// Create a copy of CloseRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CloseRegisterRequestImplCopyWith<_$CloseRegisterRequestImpl>
      get copyWith =>
          __$$CloseRegisterRequestImplCopyWithImpl<_$CloseRegisterRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CloseRegisterRequestImplToJson(
      this,
    );
  }
}

abstract class _CloseRegisterRequest implements CloseRegisterRequest {
  const factory _CloseRegisterRequest(
          {@JsonKey(name: 'register_id') required final int registerId,
          @JsonKey(name: 'shift_date') required final String shiftDate,
          @JsonKey(name: 'closing_amount') required final double closingAmount,
          @JsonKey(name: 'closing_note') final String? closingNote,
          @JsonKey(name: 'closed_by') required final String closedBy,
          @JsonKey(name: 'denominations', includeIfNull: false)
          final List<DenominationRequestItem>? denominations}) =
      _$CloseRegisterRequestImpl;

  factory _CloseRegisterRequest.fromJson(Map<String, dynamic> json) =
      _$CloseRegisterRequestImpl.fromJson;

  @override
  @JsonKey(name: 'register_id')
  int get registerId;
  @override
  @JsonKey(name: 'shift_date')
  String get shiftDate;
  @override
  @JsonKey(name: 'closing_amount')
  double get closingAmount;
  @override
  @JsonKey(name: 'closing_note')
  String? get closingNote;
  @override
  @JsonKey(name: 'closed_by')
  String get closedBy;
  @override
  @JsonKey(name: 'denominations', includeIfNull: false)
  List<DenominationRequestItem>? get denominations;

  /// Create a copy of CloseRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CloseRegisterRequestImplCopyWith<_$CloseRegisterRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

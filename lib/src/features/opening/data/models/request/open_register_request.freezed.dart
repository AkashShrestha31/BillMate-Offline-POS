// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'open_register_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OpenRegisterRequest _$OpenRegisterRequestFromJson(Map<String, dynamic> json) {
  return _OpenRegisterRequest.fromJson(json);
}

/// @nodoc
mixin _$OpenRegisterRequest {
  @JsonKey(name: 'register_name')
  String get registerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'shift_date')
  String get shiftDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'opening_amount')
  double get openingAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'opening_note')
  String? get openingNote => throw _privateConstructorUsedError;
  @JsonKey(name: 'opened_by')
  String get openedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'denominations', includeIfNull: false)
  List<DenominationRequestItem>? get denominations =>
      throw _privateConstructorUsedError;

  /// Serializes this OpenRegisterRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OpenRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OpenRegisterRequestCopyWith<OpenRegisterRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OpenRegisterRequestCopyWith<$Res> {
  factory $OpenRegisterRequestCopyWith(
          OpenRegisterRequest value, $Res Function(OpenRegisterRequest) then) =
      _$OpenRegisterRequestCopyWithImpl<$Res, OpenRegisterRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'register_name') String registerName,
      @JsonKey(name: 'shift_date') String shiftDate,
      @JsonKey(name: 'opening_amount') double openingAmount,
      @JsonKey(name: 'opening_note') String? openingNote,
      @JsonKey(name: 'opened_by') String openedBy,
      @JsonKey(name: 'denominations', includeIfNull: false)
      List<DenominationRequestItem>? denominations});
}

/// @nodoc
class _$OpenRegisterRequestCopyWithImpl<$Res, $Val extends OpenRegisterRequest>
    implements $OpenRegisterRequestCopyWith<$Res> {
  _$OpenRegisterRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OpenRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registerName = null,
    Object? shiftDate = null,
    Object? openingAmount = null,
    Object? openingNote = freezed,
    Object? openedBy = null,
    Object? denominations = freezed,
  }) {
    return _then(_value.copyWith(
      registerName: null == registerName
          ? _value.registerName
          : registerName // ignore: cast_nullable_to_non_nullable
              as String,
      shiftDate: null == shiftDate
          ? _value.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as String,
      openingAmount: null == openingAmount
          ? _value.openingAmount
          : openingAmount // ignore: cast_nullable_to_non_nullable
              as double,
      openingNote: freezed == openingNote
          ? _value.openingNote
          : openingNote // ignore: cast_nullable_to_non_nullable
              as String?,
      openedBy: null == openedBy
          ? _value.openedBy
          : openedBy // ignore: cast_nullable_to_non_nullable
              as String,
      denominations: freezed == denominations
          ? _value.denominations
          : denominations // ignore: cast_nullable_to_non_nullable
              as List<DenominationRequestItem>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OpenRegisterRequestImplCopyWith<$Res>
    implements $OpenRegisterRequestCopyWith<$Res> {
  factory _$$OpenRegisterRequestImplCopyWith(_$OpenRegisterRequestImpl value,
          $Res Function(_$OpenRegisterRequestImpl) then) =
      __$$OpenRegisterRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'register_name') String registerName,
      @JsonKey(name: 'shift_date') String shiftDate,
      @JsonKey(name: 'opening_amount') double openingAmount,
      @JsonKey(name: 'opening_note') String? openingNote,
      @JsonKey(name: 'opened_by') String openedBy,
      @JsonKey(name: 'denominations', includeIfNull: false)
      List<DenominationRequestItem>? denominations});
}

/// @nodoc
class __$$OpenRegisterRequestImplCopyWithImpl<$Res>
    extends _$OpenRegisterRequestCopyWithImpl<$Res, _$OpenRegisterRequestImpl>
    implements _$$OpenRegisterRequestImplCopyWith<$Res> {
  __$$OpenRegisterRequestImplCopyWithImpl(_$OpenRegisterRequestImpl _value,
      $Res Function(_$OpenRegisterRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of OpenRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registerName = null,
    Object? shiftDate = null,
    Object? openingAmount = null,
    Object? openingNote = freezed,
    Object? openedBy = null,
    Object? denominations = freezed,
  }) {
    return _then(_$OpenRegisterRequestImpl(
      registerName: null == registerName
          ? _value.registerName
          : registerName // ignore: cast_nullable_to_non_nullable
              as String,
      shiftDate: null == shiftDate
          ? _value.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as String,
      openingAmount: null == openingAmount
          ? _value.openingAmount
          : openingAmount // ignore: cast_nullable_to_non_nullable
              as double,
      openingNote: freezed == openingNote
          ? _value.openingNote
          : openingNote // ignore: cast_nullable_to_non_nullable
              as String?,
      openedBy: null == openedBy
          ? _value.openedBy
          : openedBy // ignore: cast_nullable_to_non_nullable
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
class _$OpenRegisterRequestImpl implements _OpenRegisterRequest {
  const _$OpenRegisterRequestImpl(
      {@JsonKey(name: 'register_name') required this.registerName,
      @JsonKey(name: 'shift_date') required this.shiftDate,
      @JsonKey(name: 'opening_amount') required this.openingAmount,
      @JsonKey(name: 'opening_note') this.openingNote,
      @JsonKey(name: 'opened_by') required this.openedBy,
      @JsonKey(name: 'denominations', includeIfNull: false)
      final List<DenominationRequestItem>? denominations})
      : _denominations = denominations;

  factory _$OpenRegisterRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OpenRegisterRequestImplFromJson(json);

  @override
  @JsonKey(name: 'register_name')
  final String registerName;
  @override
  @JsonKey(name: 'shift_date')
  final String shiftDate;
  @override
  @JsonKey(name: 'opening_amount')
  final double openingAmount;
  @override
  @JsonKey(name: 'opening_note')
  final String? openingNote;
  @override
  @JsonKey(name: 'opened_by')
  final String openedBy;
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
    return 'OpenRegisterRequest(registerName: $registerName, shiftDate: $shiftDate, openingAmount: $openingAmount, openingNote: $openingNote, openedBy: $openedBy, denominations: $denominations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpenRegisterRequestImpl &&
            (identical(other.registerName, registerName) ||
                other.registerName == registerName) &&
            (identical(other.shiftDate, shiftDate) ||
                other.shiftDate == shiftDate) &&
            (identical(other.openingAmount, openingAmount) ||
                other.openingAmount == openingAmount) &&
            (identical(other.openingNote, openingNote) ||
                other.openingNote == openingNote) &&
            (identical(other.openedBy, openedBy) ||
                other.openedBy == openedBy) &&
            const DeepCollectionEquality()
                .equals(other._denominations, _denominations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      registerName,
      shiftDate,
      openingAmount,
      openingNote,
      openedBy,
      const DeepCollectionEquality().hash(_denominations));

  /// Create a copy of OpenRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OpenRegisterRequestImplCopyWith<_$OpenRegisterRequestImpl> get copyWith =>
      __$$OpenRegisterRequestImplCopyWithImpl<_$OpenRegisterRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OpenRegisterRequestImplToJson(
      this,
    );
  }
}

abstract class _OpenRegisterRequest implements OpenRegisterRequest {
  const factory _OpenRegisterRequest(
          {@JsonKey(name: 'register_name') required final String registerName,
          @JsonKey(name: 'shift_date') required final String shiftDate,
          @JsonKey(name: 'opening_amount') required final double openingAmount,
          @JsonKey(name: 'opening_note') final String? openingNote,
          @JsonKey(name: 'opened_by') required final String openedBy,
          @JsonKey(name: 'denominations', includeIfNull: false)
          final List<DenominationRequestItem>? denominations}) =
      _$OpenRegisterRequestImpl;

  factory _OpenRegisterRequest.fromJson(Map<String, dynamic> json) =
      _$OpenRegisterRequestImpl.fromJson;

  @override
  @JsonKey(name: 'register_name')
  String get registerName;
  @override
  @JsonKey(name: 'shift_date')
  String get shiftDate;
  @override
  @JsonKey(name: 'opening_amount')
  double get openingAmount;
  @override
  @JsonKey(name: 'opening_note')
  String? get openingNote;
  @override
  @JsonKey(name: 'opened_by')
  String get openedBy;
  @override
  @JsonKey(name: 'denominations', includeIfNull: false)
  List<DenominationRequestItem>? get denominations;

  /// Create a copy of OpenRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OpenRegisterRequestImplCopyWith<_$OpenRegisterRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

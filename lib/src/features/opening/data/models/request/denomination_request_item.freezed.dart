// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'denomination_request_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DenominationRequestItem _$DenominationRequestItemFromJson(
    Map<String, dynamic> json) {
  return _DenominationRequestItem.fromJson(json);
}

/// @nodoc
mixin _$DenominationRequestItem {
  double get denomination => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this DenominationRequestItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DenominationRequestItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DenominationRequestItemCopyWith<DenominationRequestItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DenominationRequestItemCopyWith<$Res> {
  factory $DenominationRequestItemCopyWith(DenominationRequestItem value,
          $Res Function(DenominationRequestItem) then) =
      _$DenominationRequestItemCopyWithImpl<$Res, DenominationRequestItem>;
  @useResult
  $Res call({double denomination, int quantity, String type});
}

/// @nodoc
class _$DenominationRequestItemCopyWithImpl<$Res,
        $Val extends DenominationRequestItem>
    implements $DenominationRequestItemCopyWith<$Res> {
  _$DenominationRequestItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DenominationRequestItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? denomination = null,
    Object? quantity = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      denomination: null == denomination
          ? _value.denomination
          : denomination // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DenominationRequestItemImplCopyWith<$Res>
    implements $DenominationRequestItemCopyWith<$Res> {
  factory _$$DenominationRequestItemImplCopyWith(
          _$DenominationRequestItemImpl value,
          $Res Function(_$DenominationRequestItemImpl) then) =
      __$$DenominationRequestItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double denomination, int quantity, String type});
}

/// @nodoc
class __$$DenominationRequestItemImplCopyWithImpl<$Res>
    extends _$DenominationRequestItemCopyWithImpl<$Res,
        _$DenominationRequestItemImpl>
    implements _$$DenominationRequestItemImplCopyWith<$Res> {
  __$$DenominationRequestItemImplCopyWithImpl(
      _$DenominationRequestItemImpl _value,
      $Res Function(_$DenominationRequestItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of DenominationRequestItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? denomination = null,
    Object? quantity = null,
    Object? type = null,
  }) {
    return _then(_$DenominationRequestItemImpl(
      denomination: null == denomination
          ? _value.denomination
          : denomination // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DenominationRequestItemImpl implements _DenominationRequestItem {
  const _$DenominationRequestItemImpl(
      {required this.denomination, required this.quantity, required this.type});

  factory _$DenominationRequestItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DenominationRequestItemImplFromJson(json);

  @override
  final double denomination;
  @override
  final int quantity;
  @override
  final String type;

  @override
  String toString() {
    return 'DenominationRequestItem(denomination: $denomination, quantity: $quantity, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DenominationRequestItemImpl &&
            (identical(other.denomination, denomination) ||
                other.denomination == denomination) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, denomination, quantity, type);

  /// Create a copy of DenominationRequestItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DenominationRequestItemImplCopyWith<_$DenominationRequestItemImpl>
      get copyWith => __$$DenominationRequestItemImplCopyWithImpl<
          _$DenominationRequestItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DenominationRequestItemImplToJson(
      this,
    );
  }
}

abstract class _DenominationRequestItem implements DenominationRequestItem {
  const factory _DenominationRequestItem(
      {required final double denomination,
      required final int quantity,
      required final String type}) = _$DenominationRequestItemImpl;

  factory _DenominationRequestItem.fromJson(Map<String, dynamic> json) =
      _$DenominationRequestItemImpl.fromJson;

  @override
  double get denomination;
  @override
  int get quantity;
  @override
  String get type;

  /// Create a copy of DenominationRequestItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DenominationRequestItemImplCopyWith<_$DenominationRequestItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}

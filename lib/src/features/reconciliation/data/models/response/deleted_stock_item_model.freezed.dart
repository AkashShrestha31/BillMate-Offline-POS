// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deleted_stock_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeletedStockItemModel _$DeletedStockItemModelFromJson(
    Map<String, dynamic> json) {
  return _DeletedStockItemModel.fromJson(json);
}

/// @nodoc
mixin _$DeletedStockItemModel {
  String get name => throw _privateConstructorUsedError;
  String get item => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;

  /// Serializes this DeletedStockItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeletedStockItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeletedStockItemModelCopyWith<DeletedStockItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeletedStockItemModelCopyWith<$Res> {
  factory $DeletedStockItemModelCopyWith(DeletedStockItemModel value,
          $Res Function(DeletedStockItemModel) then) =
      _$DeletedStockItemModelCopyWithImpl<$Res, DeletedStockItemModel>;
  @useResult
  $Res call(
      {String name, String item, String location, int quantity, double value});
}

/// @nodoc
class _$DeletedStockItemModelCopyWithImpl<$Res,
        $Val extends DeletedStockItemModel>
    implements $DeletedStockItemModelCopyWith<$Res> {
  _$DeletedStockItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeletedStockItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? item = null,
    Object? location = null,
    Object? quantity = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeletedStockItemModelImplCopyWith<$Res>
    implements $DeletedStockItemModelCopyWith<$Res> {
  factory _$$DeletedStockItemModelImplCopyWith(
          _$DeletedStockItemModelImpl value,
          $Res Function(_$DeletedStockItemModelImpl) then) =
      __$$DeletedStockItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String item, String location, int quantity, double value});
}

/// @nodoc
class __$$DeletedStockItemModelImplCopyWithImpl<$Res>
    extends _$DeletedStockItemModelCopyWithImpl<$Res,
        _$DeletedStockItemModelImpl>
    implements _$$DeletedStockItemModelImplCopyWith<$Res> {
  __$$DeletedStockItemModelImplCopyWithImpl(_$DeletedStockItemModelImpl _value,
      $Res Function(_$DeletedStockItemModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeletedStockItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? item = null,
    Object? location = null,
    Object? quantity = null,
    Object? value = null,
  }) {
    return _then(_$DeletedStockItemModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeletedStockItemModelImpl implements _DeletedStockItemModel {
  const _$DeletedStockItemModelImpl(
      {required this.name,
      required this.item,
      required this.location,
      required this.quantity,
      required this.value});

  factory _$DeletedStockItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeletedStockItemModelImplFromJson(json);

  @override
  final String name;
  @override
  final String item;
  @override
  final String location;
  @override
  final int quantity;
  @override
  final double value;

  @override
  String toString() {
    return 'DeletedStockItemModel(name: $name, item: $item, location: $location, quantity: $quantity, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletedStockItemModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, item, location, quantity, value);

  /// Create a copy of DeletedStockItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletedStockItemModelImplCopyWith<_$DeletedStockItemModelImpl>
      get copyWith => __$$DeletedStockItemModelImplCopyWithImpl<
          _$DeletedStockItemModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeletedStockItemModelImplToJson(
      this,
    );
  }
}

abstract class _DeletedStockItemModel implements DeletedStockItemModel {
  const factory _DeletedStockItemModel(
      {required final String name,
      required final String item,
      required final String location,
      required final int quantity,
      required final double value}) = _$DeletedStockItemModelImpl;

  factory _DeletedStockItemModel.fromJson(Map<String, dynamic> json) =
      _$DeletedStockItemModelImpl.fromJson;

  @override
  String get name;
  @override
  String get item;
  @override
  String get location;
  @override
  int get quantity;
  @override
  double get value;

  /// Create a copy of DeletedStockItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeletedStockItemModelImplCopyWith<_$DeletedStockItemModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

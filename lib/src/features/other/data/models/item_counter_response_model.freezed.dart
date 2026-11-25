// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_counter_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ItemCounterResponseModel _$ItemCounterResponseModelFromJson(
    Map<String, dynamic> json) {
  return _ItemCounterResponseModel.fromJson(json);
}

/// @nodoc
mixin _$ItemCounterResponseModel {
  @JsonKey(name: 'item_counts')
  List<ItemCount> get itemCounts => throw _privateConstructorUsedError;

  /// Serializes this ItemCounterResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ItemCounterResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItemCounterResponseModelCopyWith<ItemCounterResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCounterResponseModelCopyWith<$Res> {
  factory $ItemCounterResponseModelCopyWith(ItemCounterResponseModel value,
          $Res Function(ItemCounterResponseModel) then) =
      _$ItemCounterResponseModelCopyWithImpl<$Res, ItemCounterResponseModel>;
  @useResult
  $Res call({@JsonKey(name: 'item_counts') List<ItemCount> itemCounts});
}

/// @nodoc
class _$ItemCounterResponseModelCopyWithImpl<$Res,
        $Val extends ItemCounterResponseModel>
    implements $ItemCounterResponseModelCopyWith<$Res> {
  _$ItemCounterResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ItemCounterResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemCounts = null,
  }) {
    return _then(_value.copyWith(
      itemCounts: null == itemCounts
          ? _value.itemCounts
          : itemCounts // ignore: cast_nullable_to_non_nullable
              as List<ItemCount>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemCounterResponseModelImplCopyWith<$Res>
    implements $ItemCounterResponseModelCopyWith<$Res> {
  factory _$$ItemCounterResponseModelImplCopyWith(
          _$ItemCounterResponseModelImpl value,
          $Res Function(_$ItemCounterResponseModelImpl) then) =
      __$$ItemCounterResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'item_counts') List<ItemCount> itemCounts});
}

/// @nodoc
class __$$ItemCounterResponseModelImplCopyWithImpl<$Res>
    extends _$ItemCounterResponseModelCopyWithImpl<$Res,
        _$ItemCounterResponseModelImpl>
    implements _$$ItemCounterResponseModelImplCopyWith<$Res> {
  __$$ItemCounterResponseModelImplCopyWithImpl(
      _$ItemCounterResponseModelImpl _value,
      $Res Function(_$ItemCounterResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemCounterResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemCounts = null,
  }) {
    return _then(_$ItemCounterResponseModelImpl(
      itemCounts: null == itemCounts
          ? _value._itemCounts
          : itemCounts // ignore: cast_nullable_to_non_nullable
              as List<ItemCount>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemCounterResponseModelImpl implements _ItemCounterResponseModel {
  const _$ItemCounterResponseModelImpl(
      {@JsonKey(name: 'item_counts') required final List<ItemCount> itemCounts})
      : _itemCounts = itemCounts;

  factory _$ItemCounterResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemCounterResponseModelImplFromJson(json);

  final List<ItemCount> _itemCounts;
  @override
  @JsonKey(name: 'item_counts')
  List<ItemCount> get itemCounts {
    if (_itemCounts is EqualUnmodifiableListView) return _itemCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemCounts);
  }

  @override
  String toString() {
    return 'ItemCounterResponseModel(itemCounts: $itemCounts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemCounterResponseModelImpl &&
            const DeepCollectionEquality()
                .equals(other._itemCounts, _itemCounts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_itemCounts));

  /// Create a copy of ItemCounterResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemCounterResponseModelImplCopyWith<_$ItemCounterResponseModelImpl>
      get copyWith => __$$ItemCounterResponseModelImplCopyWithImpl<
          _$ItemCounterResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemCounterResponseModelImplToJson(
      this,
    );
  }
}

abstract class _ItemCounterResponseModel implements ItemCounterResponseModel {
  const factory _ItemCounterResponseModel(
          {@JsonKey(name: 'item_counts')
          required final List<ItemCount> itemCounts}) =
      _$ItemCounterResponseModelImpl;

  factory _ItemCounterResponseModel.fromJson(Map<String, dynamic> json) =
      _$ItemCounterResponseModelImpl.fromJson;

  @override
  @JsonKey(name: 'item_counts')
  List<ItemCount> get itemCounts;

  /// Create a copy of ItemCounterResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItemCounterResponseModelImplCopyWith<_$ItemCounterResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ItemCount _$ItemCountFromJson(Map<String, dynamic> json) {
  return _ItemCount.fromJson(json);
}

/// @nodoc
mixin _$ItemCount {
  String get item => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sold')
  int get totalSold => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_purchased')
  int get totalPurchased => throw _privateConstructorUsedError;

  /// Serializes this ItemCount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ItemCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItemCountCopyWith<ItemCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCountCopyWith<$Res> {
  factory $ItemCountCopyWith(ItemCount value, $Res Function(ItemCount) then) =
      _$ItemCountCopyWithImpl<$Res, ItemCount>;
  @useResult
  $Res call(
      {String item,
      @JsonKey(name: 'total_sold') int totalSold,
      @JsonKey(name: 'total_purchased') int totalPurchased});
}

/// @nodoc
class _$ItemCountCopyWithImpl<$Res, $Val extends ItemCount>
    implements $ItemCountCopyWith<$Res> {
  _$ItemCountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ItemCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? totalSold = null,
    Object? totalPurchased = null,
  }) {
    return _then(_value.copyWith(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      totalSold: null == totalSold
          ? _value.totalSold
          : totalSold // ignore: cast_nullable_to_non_nullable
              as int,
      totalPurchased: null == totalPurchased
          ? _value.totalPurchased
          : totalPurchased // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemCountImplCopyWith<$Res>
    implements $ItemCountCopyWith<$Res> {
  factory _$$ItemCountImplCopyWith(
          _$ItemCountImpl value, $Res Function(_$ItemCountImpl) then) =
      __$$ItemCountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String item,
      @JsonKey(name: 'total_sold') int totalSold,
      @JsonKey(name: 'total_purchased') int totalPurchased});
}

/// @nodoc
class __$$ItemCountImplCopyWithImpl<$Res>
    extends _$ItemCountCopyWithImpl<$Res, _$ItemCountImpl>
    implements _$$ItemCountImplCopyWith<$Res> {
  __$$ItemCountImplCopyWithImpl(
      _$ItemCountImpl _value, $Res Function(_$ItemCountImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? totalSold = null,
    Object? totalPurchased = null,
  }) {
    return _then(_$ItemCountImpl(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      totalSold: null == totalSold
          ? _value.totalSold
          : totalSold // ignore: cast_nullable_to_non_nullable
              as int,
      totalPurchased: null == totalPurchased
          ? _value.totalPurchased
          : totalPurchased // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemCountImpl implements _ItemCount {
  const _$ItemCountImpl(
      {required this.item,
      @JsonKey(name: 'total_sold') required this.totalSold,
      @JsonKey(name: 'total_purchased') required this.totalPurchased});

  factory _$ItemCountImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemCountImplFromJson(json);

  @override
  final String item;
  @override
  @JsonKey(name: 'total_sold')
  final int totalSold;
  @override
  @JsonKey(name: 'total_purchased')
  final int totalPurchased;

  @override
  String toString() {
    return 'ItemCount(item: $item, totalSold: $totalSold, totalPurchased: $totalPurchased)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemCountImpl &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.totalSold, totalSold) ||
                other.totalSold == totalSold) &&
            (identical(other.totalPurchased, totalPurchased) ||
                other.totalPurchased == totalPurchased));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, item, totalSold, totalPurchased);

  /// Create a copy of ItemCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemCountImplCopyWith<_$ItemCountImpl> get copyWith =>
      __$$ItemCountImplCopyWithImpl<_$ItemCountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemCountImplToJson(
      this,
    );
  }
}

abstract class _ItemCount implements ItemCount {
  const factory _ItemCount(
      {required final String item,
      @JsonKey(name: 'total_sold') required final int totalSold,
      @JsonKey(name: 'total_purchased')
      required final int totalPurchased}) = _$ItemCountImpl;

  factory _ItemCount.fromJson(Map<String, dynamic> json) =
      _$ItemCountImpl.fromJson;

  @override
  String get item;
  @override
  @JsonKey(name: 'total_sold')
  int get totalSold;
  @override
  @JsonKey(name: 'total_purchased')
  int get totalPurchased;

  /// Create a copy of ItemCount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItemCountImplCopyWith<_$ItemCountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'previous_stock_details_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PreviousStockDetailsResponseModel _$PreviousStockDetailsResponseModelFromJson(
    Map<String, dynamic> json) {
  return _PreviousStockDetailsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PreviousStockDetailsResponseModel {
  bool get success => throw _privateConstructorUsedError;
  @JsonKey(name: 'stock_items')
  List<PreviousStockItemModel> get stockItems =>
      throw _privateConstructorUsedError;

  /// Serializes this PreviousStockDetailsResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PreviousStockDetailsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PreviousStockDetailsResponseModelCopyWith<PreviousStockDetailsResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreviousStockDetailsResponseModelCopyWith<$Res> {
  factory $PreviousStockDetailsResponseModelCopyWith(
          PreviousStockDetailsResponseModel value,
          $Res Function(PreviousStockDetailsResponseModel) then) =
      _$PreviousStockDetailsResponseModelCopyWithImpl<$Res,
          PreviousStockDetailsResponseModel>;
  @useResult
  $Res call(
      {bool success,
      @JsonKey(name: 'stock_items') List<PreviousStockItemModel> stockItems});
}

/// @nodoc
class _$PreviousStockDetailsResponseModelCopyWithImpl<$Res,
        $Val extends PreviousStockDetailsResponseModel>
    implements $PreviousStockDetailsResponseModelCopyWith<$Res> {
  _$PreviousStockDetailsResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PreviousStockDetailsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? stockItems = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      stockItems: null == stockItems
          ? _value.stockItems
          : stockItems // ignore: cast_nullable_to_non_nullable
              as List<PreviousStockItemModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PreviousStockDetailsResponseModelImplCopyWith<$Res>
    implements $PreviousStockDetailsResponseModelCopyWith<$Res> {
  factory _$$PreviousStockDetailsResponseModelImplCopyWith(
          _$PreviousStockDetailsResponseModelImpl value,
          $Res Function(_$PreviousStockDetailsResponseModelImpl) then) =
      __$$PreviousStockDetailsResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      @JsonKey(name: 'stock_items') List<PreviousStockItemModel> stockItems});
}

/// @nodoc
class __$$PreviousStockDetailsResponseModelImplCopyWithImpl<$Res>
    extends _$PreviousStockDetailsResponseModelCopyWithImpl<$Res,
        _$PreviousStockDetailsResponseModelImpl>
    implements _$$PreviousStockDetailsResponseModelImplCopyWith<$Res> {
  __$$PreviousStockDetailsResponseModelImplCopyWithImpl(
      _$PreviousStockDetailsResponseModelImpl _value,
      $Res Function(_$PreviousStockDetailsResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PreviousStockDetailsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? stockItems = null,
  }) {
    return _then(_$PreviousStockDetailsResponseModelImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      stockItems: null == stockItems
          ? _value._stockItems
          : stockItems // ignore: cast_nullable_to_non_nullable
              as List<PreviousStockItemModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreviousStockDetailsResponseModelImpl
    implements _PreviousStockDetailsResponseModel {
  const _$PreviousStockDetailsResponseModelImpl(
      {required this.success,
      @JsonKey(name: 'stock_items')
      required final List<PreviousStockItemModel> stockItems})
      : _stockItems = stockItems;

  factory _$PreviousStockDetailsResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PreviousStockDetailsResponseModelImplFromJson(json);

  @override
  final bool success;
  final List<PreviousStockItemModel> _stockItems;
  @override
  @JsonKey(name: 'stock_items')
  List<PreviousStockItemModel> get stockItems {
    if (_stockItems is EqualUnmodifiableListView) return _stockItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stockItems);
  }

  @override
  String toString() {
    return 'PreviousStockDetailsResponseModel(success: $success, stockItems: $stockItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreviousStockDetailsResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            const DeepCollectionEquality()
                .equals(other._stockItems, _stockItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, success, const DeepCollectionEquality().hash(_stockItems));

  /// Create a copy of PreviousStockDetailsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PreviousStockDetailsResponseModelImplCopyWith<
          _$PreviousStockDetailsResponseModelImpl>
      get copyWith => __$$PreviousStockDetailsResponseModelImplCopyWithImpl<
          _$PreviousStockDetailsResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreviousStockDetailsResponseModelImplToJson(
      this,
    );
  }
}

abstract class _PreviousStockDetailsResponseModel
    implements PreviousStockDetailsResponseModel {
  const factory _PreviousStockDetailsResponseModel(
          {required final bool success,
          @JsonKey(name: 'stock_items')
          required final List<PreviousStockItemModel> stockItems}) =
      _$PreviousStockDetailsResponseModelImpl;

  factory _PreviousStockDetailsResponseModel.fromJson(
          Map<String, dynamic> json) =
      _$PreviousStockDetailsResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  @JsonKey(name: 'stock_items')
  List<PreviousStockItemModel> get stockItems;

  /// Create a copy of PreviousStockDetailsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PreviousStockDetailsResponseModelImplCopyWith<
          _$PreviousStockDetailsResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'previous_stock_bulk_edit_request_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PreviousStockBulkEditRequestParams _$PreviousStockBulkEditRequestParamsFromJson(
    Map<String, dynamic> json) {
  return _PreviousStockBulkEditRequestParams.fromJson(json);
}

/// @nodoc
mixin _$PreviousStockBulkEditRequestParams {
  @JsonKey(name: 'stock_items')
  List<PreviousStockEditItemParams> get stockItems =>
      throw _privateConstructorUsedError;

  /// Serializes this PreviousStockBulkEditRequestParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PreviousStockBulkEditRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PreviousStockBulkEditRequestParamsCopyWith<
          PreviousStockBulkEditRequestParams>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreviousStockBulkEditRequestParamsCopyWith<$Res> {
  factory $PreviousStockBulkEditRequestParamsCopyWith(
          PreviousStockBulkEditRequestParams value,
          $Res Function(PreviousStockBulkEditRequestParams) then) =
      _$PreviousStockBulkEditRequestParamsCopyWithImpl<$Res,
          PreviousStockBulkEditRequestParams>;
  @useResult
  $Res call(
      {@JsonKey(name: 'stock_items')
      List<PreviousStockEditItemParams> stockItems});
}

/// @nodoc
class _$PreviousStockBulkEditRequestParamsCopyWithImpl<$Res,
        $Val extends PreviousStockBulkEditRequestParams>
    implements $PreviousStockBulkEditRequestParamsCopyWith<$Res> {
  _$PreviousStockBulkEditRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PreviousStockBulkEditRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockItems = null,
  }) {
    return _then(_value.copyWith(
      stockItems: null == stockItems
          ? _value.stockItems
          : stockItems // ignore: cast_nullable_to_non_nullable
              as List<PreviousStockEditItemParams>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PreviousStockBulkEditRequestParamsImplCopyWith<$Res>
    implements $PreviousStockBulkEditRequestParamsCopyWith<$Res> {
  factory _$$PreviousStockBulkEditRequestParamsImplCopyWith(
          _$PreviousStockBulkEditRequestParamsImpl value,
          $Res Function(_$PreviousStockBulkEditRequestParamsImpl) then) =
      __$$PreviousStockBulkEditRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'stock_items')
      List<PreviousStockEditItemParams> stockItems});
}

/// @nodoc
class __$$PreviousStockBulkEditRequestParamsImplCopyWithImpl<$Res>
    extends _$PreviousStockBulkEditRequestParamsCopyWithImpl<$Res,
        _$PreviousStockBulkEditRequestParamsImpl>
    implements _$$PreviousStockBulkEditRequestParamsImplCopyWith<$Res> {
  __$$PreviousStockBulkEditRequestParamsImplCopyWithImpl(
      _$PreviousStockBulkEditRequestParamsImpl _value,
      $Res Function(_$PreviousStockBulkEditRequestParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PreviousStockBulkEditRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockItems = null,
  }) {
    return _then(_$PreviousStockBulkEditRequestParamsImpl(
      stockItems: null == stockItems
          ? _value._stockItems
          : stockItems // ignore: cast_nullable_to_non_nullable
              as List<PreviousStockEditItemParams>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreviousStockBulkEditRequestParamsImpl
    implements _PreviousStockBulkEditRequestParams {
  const _$PreviousStockBulkEditRequestParamsImpl(
      {@JsonKey(name: 'stock_items')
      required final List<PreviousStockEditItemParams> stockItems})
      : _stockItems = stockItems;

  factory _$PreviousStockBulkEditRequestParamsImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PreviousStockBulkEditRequestParamsImplFromJson(json);

  final List<PreviousStockEditItemParams> _stockItems;
  @override
  @JsonKey(name: 'stock_items')
  List<PreviousStockEditItemParams> get stockItems {
    if (_stockItems is EqualUnmodifiableListView) return _stockItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stockItems);
  }

  @override
  String toString() {
    return 'PreviousStockBulkEditRequestParams(stockItems: $stockItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreviousStockBulkEditRequestParamsImpl &&
            const DeepCollectionEquality()
                .equals(other._stockItems, _stockItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_stockItems));

  /// Create a copy of PreviousStockBulkEditRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PreviousStockBulkEditRequestParamsImplCopyWith<
          _$PreviousStockBulkEditRequestParamsImpl>
      get copyWith => __$$PreviousStockBulkEditRequestParamsImplCopyWithImpl<
          _$PreviousStockBulkEditRequestParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreviousStockBulkEditRequestParamsImplToJson(
      this,
    );
  }
}

abstract class _PreviousStockBulkEditRequestParams
    implements PreviousStockBulkEditRequestParams {
  const factory _PreviousStockBulkEditRequestParams(
          {@JsonKey(name: 'stock_items')
          required final List<PreviousStockEditItemParams> stockItems}) =
      _$PreviousStockBulkEditRequestParamsImpl;

  factory _PreviousStockBulkEditRequestParams.fromJson(
          Map<String, dynamic> json) =
      _$PreviousStockBulkEditRequestParamsImpl.fromJson;

  @override
  @JsonKey(name: 'stock_items')
  List<PreviousStockEditItemParams> get stockItems;

  /// Create a copy of PreviousStockBulkEditRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PreviousStockBulkEditRequestParamsImplCopyWith<
          _$PreviousStockBulkEditRequestParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

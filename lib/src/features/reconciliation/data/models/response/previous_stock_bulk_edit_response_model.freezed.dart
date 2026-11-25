// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'previous_stock_bulk_edit_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PreviousStockBulkEditResponseModel _$PreviousStockBulkEditResponseModelFromJson(
    Map<String, dynamic> json) {
  return _PreviousStockBulkEditResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PreviousStockBulkEditResponseModel {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  EditSummaryModel get summary => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_items')
  List<UpdatedStockItemModel> get updatedItems =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'failed_items')
  List<FailedStockItemModel> get failedItems =>
      throw _privateConstructorUsedError;

  /// Serializes this PreviousStockBulkEditResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PreviousStockBulkEditResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PreviousStockBulkEditResponseModelCopyWith<
          PreviousStockBulkEditResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreviousStockBulkEditResponseModelCopyWith<$Res> {
  factory $PreviousStockBulkEditResponseModelCopyWith(
          PreviousStockBulkEditResponseModel value,
          $Res Function(PreviousStockBulkEditResponseModel) then) =
      _$PreviousStockBulkEditResponseModelCopyWithImpl<$Res,
          PreviousStockBulkEditResponseModel>;
  @useResult
  $Res call(
      {bool success,
      String message,
      EditSummaryModel summary,
      @JsonKey(name: 'updated_items') List<UpdatedStockItemModel> updatedItems,
      @JsonKey(name: 'failed_items') List<FailedStockItemModel> failedItems});

  $EditSummaryModelCopyWith<$Res> get summary;
}

/// @nodoc
class _$PreviousStockBulkEditResponseModelCopyWithImpl<$Res,
        $Val extends PreviousStockBulkEditResponseModel>
    implements $PreviousStockBulkEditResponseModelCopyWith<$Res> {
  _$PreviousStockBulkEditResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PreviousStockBulkEditResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? summary = null,
    Object? updatedItems = null,
    Object? failedItems = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as EditSummaryModel,
      updatedItems: null == updatedItems
          ? _value.updatedItems
          : updatedItems // ignore: cast_nullable_to_non_nullable
              as List<UpdatedStockItemModel>,
      failedItems: null == failedItems
          ? _value.failedItems
          : failedItems // ignore: cast_nullable_to_non_nullable
              as List<FailedStockItemModel>,
    ) as $Val);
  }

  /// Create a copy of PreviousStockBulkEditResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EditSummaryModelCopyWith<$Res> get summary {
    return $EditSummaryModelCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PreviousStockBulkEditResponseModelImplCopyWith<$Res>
    implements $PreviousStockBulkEditResponseModelCopyWith<$Res> {
  factory _$$PreviousStockBulkEditResponseModelImplCopyWith(
          _$PreviousStockBulkEditResponseModelImpl value,
          $Res Function(_$PreviousStockBulkEditResponseModelImpl) then) =
      __$$PreviousStockBulkEditResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String message,
      EditSummaryModel summary,
      @JsonKey(name: 'updated_items') List<UpdatedStockItemModel> updatedItems,
      @JsonKey(name: 'failed_items') List<FailedStockItemModel> failedItems});

  @override
  $EditSummaryModelCopyWith<$Res> get summary;
}

/// @nodoc
class __$$PreviousStockBulkEditResponseModelImplCopyWithImpl<$Res>
    extends _$PreviousStockBulkEditResponseModelCopyWithImpl<$Res,
        _$PreviousStockBulkEditResponseModelImpl>
    implements _$$PreviousStockBulkEditResponseModelImplCopyWith<$Res> {
  __$$PreviousStockBulkEditResponseModelImplCopyWithImpl(
      _$PreviousStockBulkEditResponseModelImpl _value,
      $Res Function(_$PreviousStockBulkEditResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PreviousStockBulkEditResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? summary = null,
    Object? updatedItems = null,
    Object? failedItems = null,
  }) {
    return _then(_$PreviousStockBulkEditResponseModelImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as EditSummaryModel,
      updatedItems: null == updatedItems
          ? _value._updatedItems
          : updatedItems // ignore: cast_nullable_to_non_nullable
              as List<UpdatedStockItemModel>,
      failedItems: null == failedItems
          ? _value._failedItems
          : failedItems // ignore: cast_nullable_to_non_nullable
              as List<FailedStockItemModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreviousStockBulkEditResponseModelImpl
    implements _PreviousStockBulkEditResponseModel {
  const _$PreviousStockBulkEditResponseModelImpl(
      {required this.success,
      required this.message,
      required this.summary,
      @JsonKey(name: 'updated_items')
      required final List<UpdatedStockItemModel> updatedItems,
      @JsonKey(name: 'failed_items')
      required final List<FailedStockItemModel> failedItems})
      : _updatedItems = updatedItems,
        _failedItems = failedItems;

  factory _$PreviousStockBulkEditResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PreviousStockBulkEditResponseModelImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final EditSummaryModel summary;
  final List<UpdatedStockItemModel> _updatedItems;
  @override
  @JsonKey(name: 'updated_items')
  List<UpdatedStockItemModel> get updatedItems {
    if (_updatedItems is EqualUnmodifiableListView) return _updatedItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_updatedItems);
  }

  final List<FailedStockItemModel> _failedItems;
  @override
  @JsonKey(name: 'failed_items')
  List<FailedStockItemModel> get failedItems {
    if (_failedItems is EqualUnmodifiableListView) return _failedItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_failedItems);
  }

  @override
  String toString() {
    return 'PreviousStockBulkEditResponseModel(success: $success, message: $message, summary: $summary, updatedItems: $updatedItems, failedItems: $failedItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreviousStockBulkEditResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality()
                .equals(other._updatedItems, _updatedItems) &&
            const DeepCollectionEquality()
                .equals(other._failedItems, _failedItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      message,
      summary,
      const DeepCollectionEquality().hash(_updatedItems),
      const DeepCollectionEquality().hash(_failedItems));

  /// Create a copy of PreviousStockBulkEditResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PreviousStockBulkEditResponseModelImplCopyWith<
          _$PreviousStockBulkEditResponseModelImpl>
      get copyWith => __$$PreviousStockBulkEditResponseModelImplCopyWithImpl<
          _$PreviousStockBulkEditResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreviousStockBulkEditResponseModelImplToJson(
      this,
    );
  }
}

abstract class _PreviousStockBulkEditResponseModel
    implements PreviousStockBulkEditResponseModel {
  const factory _PreviousStockBulkEditResponseModel(
          {required final bool success,
          required final String message,
          required final EditSummaryModel summary,
          @JsonKey(name: 'updated_items')
          required final List<UpdatedStockItemModel> updatedItems,
          @JsonKey(name: 'failed_items')
          required final List<FailedStockItemModel> failedItems}) =
      _$PreviousStockBulkEditResponseModelImpl;

  factory _PreviousStockBulkEditResponseModel.fromJson(
          Map<String, dynamic> json) =
      _$PreviousStockBulkEditResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  EditSummaryModel get summary;
  @override
  @JsonKey(name: 'updated_items')
  List<UpdatedStockItemModel> get updatedItems;
  @override
  @JsonKey(name: 'failed_items')
  List<FailedStockItemModel> get failedItems;

  /// Create a copy of PreviousStockBulkEditResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PreviousStockBulkEditResponseModelImplCopyWith<
          _$PreviousStockBulkEditResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

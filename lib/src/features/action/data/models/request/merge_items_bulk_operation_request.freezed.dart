// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'merge_items_bulk_operation_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MergeItemsBulkOperationRequest _$MergeItemsBulkOperationRequestFromJson(
    Map<String, dynamic> json) {
  return _MergeItemsBulkOperationRequest.fromJson(json);
}

/// @nodoc
mixin _$MergeItemsBulkOperationRequest {
  @JsonKey(name: 'operation')
  String get operation => throw _privateConstructorUsedError;
  @JsonKey(name: 'merge_data')
  MergeData get mergeData => throw _privateConstructorUsedError;
  @JsonKey(name: 'modifiedBy', includeIfNull: false)
  String? get modifiedBy => throw _privateConstructorUsedError;

  /// Serializes this MergeItemsBulkOperationRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MergeItemsBulkOperationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MergeItemsBulkOperationRequestCopyWith<MergeItemsBulkOperationRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MergeItemsBulkOperationRequestCopyWith<$Res> {
  factory $MergeItemsBulkOperationRequestCopyWith(
          MergeItemsBulkOperationRequest value,
          $Res Function(MergeItemsBulkOperationRequest) then) =
      _$MergeItemsBulkOperationRequestCopyWithImpl<$Res,
          MergeItemsBulkOperationRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'operation') String operation,
      @JsonKey(name: 'merge_data') MergeData mergeData,
      @JsonKey(name: 'modifiedBy', includeIfNull: false) String? modifiedBy});

  $MergeDataCopyWith<$Res> get mergeData;
}

/// @nodoc
class _$MergeItemsBulkOperationRequestCopyWithImpl<$Res,
        $Val extends MergeItemsBulkOperationRequest>
    implements $MergeItemsBulkOperationRequestCopyWith<$Res> {
  _$MergeItemsBulkOperationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MergeItemsBulkOperationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? operation = null,
    Object? mergeData = null,
    Object? modifiedBy = freezed,
  }) {
    return _then(_value.copyWith(
      operation: null == operation
          ? _value.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String,
      mergeData: null == mergeData
          ? _value.mergeData
          : mergeData // ignore: cast_nullable_to_non_nullable
              as MergeData,
      modifiedBy: freezed == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of MergeItemsBulkOperationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MergeDataCopyWith<$Res> get mergeData {
    return $MergeDataCopyWith<$Res>(_value.mergeData, (value) {
      return _then(_value.copyWith(mergeData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MergeItemsBulkOperationRequestImplCopyWith<$Res>
    implements $MergeItemsBulkOperationRequestCopyWith<$Res> {
  factory _$$MergeItemsBulkOperationRequestImplCopyWith(
          _$MergeItemsBulkOperationRequestImpl value,
          $Res Function(_$MergeItemsBulkOperationRequestImpl) then) =
      __$$MergeItemsBulkOperationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'operation') String operation,
      @JsonKey(name: 'merge_data') MergeData mergeData,
      @JsonKey(name: 'modifiedBy', includeIfNull: false) String? modifiedBy});

  @override
  $MergeDataCopyWith<$Res> get mergeData;
}

/// @nodoc
class __$$MergeItemsBulkOperationRequestImplCopyWithImpl<$Res>
    extends _$MergeItemsBulkOperationRequestCopyWithImpl<$Res,
        _$MergeItemsBulkOperationRequestImpl>
    implements _$$MergeItemsBulkOperationRequestImplCopyWith<$Res> {
  __$$MergeItemsBulkOperationRequestImplCopyWithImpl(
      _$MergeItemsBulkOperationRequestImpl _value,
      $Res Function(_$MergeItemsBulkOperationRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of MergeItemsBulkOperationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? operation = null,
    Object? mergeData = null,
    Object? modifiedBy = freezed,
  }) {
    return _then(_$MergeItemsBulkOperationRequestImpl(
      operation: null == operation
          ? _value.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String,
      mergeData: null == mergeData
          ? _value.mergeData
          : mergeData // ignore: cast_nullable_to_non_nullable
              as MergeData,
      modifiedBy: freezed == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MergeItemsBulkOperationRequestImpl
    implements _MergeItemsBulkOperationRequest {
  const _$MergeItemsBulkOperationRequestImpl(
      {@JsonKey(name: 'operation') required this.operation,
      @JsonKey(name: 'merge_data') required this.mergeData,
      @JsonKey(name: 'modifiedBy', includeIfNull: false) this.modifiedBy});

  factory _$MergeItemsBulkOperationRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$MergeItemsBulkOperationRequestImplFromJson(json);

  @override
  @JsonKey(name: 'operation')
  final String operation;
  @override
  @JsonKey(name: 'merge_data')
  final MergeData mergeData;
  @override
  @JsonKey(name: 'modifiedBy', includeIfNull: false)
  final String? modifiedBy;

  @override
  String toString() {
    return 'MergeItemsBulkOperationRequest(operation: $operation, mergeData: $mergeData, modifiedBy: $modifiedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MergeItemsBulkOperationRequestImpl &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.mergeData, mergeData) ||
                other.mergeData == mergeData) &&
            (identical(other.modifiedBy, modifiedBy) ||
                other.modifiedBy == modifiedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, operation, mergeData, modifiedBy);

  /// Create a copy of MergeItemsBulkOperationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MergeItemsBulkOperationRequestImplCopyWith<
          _$MergeItemsBulkOperationRequestImpl>
      get copyWith => __$$MergeItemsBulkOperationRequestImplCopyWithImpl<
          _$MergeItemsBulkOperationRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MergeItemsBulkOperationRequestImplToJson(
      this,
    );
  }
}

abstract class _MergeItemsBulkOperationRequest
    implements MergeItemsBulkOperationRequest {
  const factory _MergeItemsBulkOperationRequest(
      {@JsonKey(name: 'operation') required final String operation,
      @JsonKey(name: 'merge_data') required final MergeData mergeData,
      @JsonKey(name: 'modifiedBy', includeIfNull: false)
      final String? modifiedBy}) = _$MergeItemsBulkOperationRequestImpl;

  factory _MergeItemsBulkOperationRequest.fromJson(Map<String, dynamic> json) =
      _$MergeItemsBulkOperationRequestImpl.fromJson;

  @override
  @JsonKey(name: 'operation')
  String get operation;
  @override
  @JsonKey(name: 'merge_data')
  MergeData get mergeData;
  @override
  @JsonKey(name: 'modifiedBy', includeIfNull: false)
  String? get modifiedBy;

  /// Create a copy of MergeItemsBulkOperationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MergeItemsBulkOperationRequestImplCopyWith<
          _$MergeItemsBulkOperationRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MergeData _$MergeDataFromJson(Map<String, dynamic> json) {
  return _MergeData.fromJson(json);
}

/// @nodoc
mixin _$MergeData {
  @JsonKey(name: 'source_item')
  String get sourceItem => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_item')
  String get targetItem => throw _privateConstructorUsedError;

  /// Serializes this MergeData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MergeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MergeDataCopyWith<MergeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MergeDataCopyWith<$Res> {
  factory $MergeDataCopyWith(MergeData value, $Res Function(MergeData) then) =
      _$MergeDataCopyWithImpl<$Res, MergeData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'source_item') String sourceItem,
      @JsonKey(name: 'target_item') String targetItem});
}

/// @nodoc
class _$MergeDataCopyWithImpl<$Res, $Val extends MergeData>
    implements $MergeDataCopyWith<$Res> {
  _$MergeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MergeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceItem = null,
    Object? targetItem = null,
  }) {
    return _then(_value.copyWith(
      sourceItem: null == sourceItem
          ? _value.sourceItem
          : sourceItem // ignore: cast_nullable_to_non_nullable
              as String,
      targetItem: null == targetItem
          ? _value.targetItem
          : targetItem // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MergeDataImplCopyWith<$Res>
    implements $MergeDataCopyWith<$Res> {
  factory _$$MergeDataImplCopyWith(
          _$MergeDataImpl value, $Res Function(_$MergeDataImpl) then) =
      __$$MergeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'source_item') String sourceItem,
      @JsonKey(name: 'target_item') String targetItem});
}

/// @nodoc
class __$$MergeDataImplCopyWithImpl<$Res>
    extends _$MergeDataCopyWithImpl<$Res, _$MergeDataImpl>
    implements _$$MergeDataImplCopyWith<$Res> {
  __$$MergeDataImplCopyWithImpl(
      _$MergeDataImpl _value, $Res Function(_$MergeDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of MergeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceItem = null,
    Object? targetItem = null,
  }) {
    return _then(_$MergeDataImpl(
      sourceItem: null == sourceItem
          ? _value.sourceItem
          : sourceItem // ignore: cast_nullable_to_non_nullable
              as String,
      targetItem: null == targetItem
          ? _value.targetItem
          : targetItem // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MergeDataImpl implements _MergeData {
  const _$MergeDataImpl(
      {@JsonKey(name: 'source_item') required this.sourceItem,
      @JsonKey(name: 'target_item') required this.targetItem});

  factory _$MergeDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MergeDataImplFromJson(json);

  @override
  @JsonKey(name: 'source_item')
  final String sourceItem;
  @override
  @JsonKey(name: 'target_item')
  final String targetItem;

  @override
  String toString() {
    return 'MergeData(sourceItem: $sourceItem, targetItem: $targetItem)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MergeDataImpl &&
            (identical(other.sourceItem, sourceItem) ||
                other.sourceItem == sourceItem) &&
            (identical(other.targetItem, targetItem) ||
                other.targetItem == targetItem));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sourceItem, targetItem);

  /// Create a copy of MergeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MergeDataImplCopyWith<_$MergeDataImpl> get copyWith =>
      __$$MergeDataImplCopyWithImpl<_$MergeDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MergeDataImplToJson(
      this,
    );
  }
}

abstract class _MergeData implements MergeData {
  const factory _MergeData(
          {@JsonKey(name: 'source_item') required final String sourceItem,
          @JsonKey(name: 'target_item') required final String targetItem}) =
      _$MergeDataImpl;

  factory _MergeData.fromJson(Map<String, dynamic> json) =
      _$MergeDataImpl.fromJson;

  @override
  @JsonKey(name: 'source_item')
  String get sourceItem;
  @override
  @JsonKey(name: 'target_item')
  String get targetItem;

  /// Create a copy of MergeData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MergeDataImplCopyWith<_$MergeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

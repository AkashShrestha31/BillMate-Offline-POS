// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'merge_items_bulk_operation_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MergeItemsBulkOperationResponse _$MergeItemsBulkOperationResponseFromJson(
    Map<String, dynamic> json) {
  return _MergeItemsBulkOperationResponse.fromJson(json);
}

/// @nodoc
mixin _$MergeItemsBulkOperationResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_item')
  String? get sourceItem => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_item')
  String? get targetItem => throw _privateConstructorUsedError;
  @JsonKey(name: 'merged_data')
  Map<String, dynamic>? get mergedData => throw _privateConstructorUsedError;

  /// Serializes this MergeItemsBulkOperationResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MergeItemsBulkOperationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MergeItemsBulkOperationResponseCopyWith<MergeItemsBulkOperationResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MergeItemsBulkOperationResponseCopyWith<$Res> {
  factory $MergeItemsBulkOperationResponseCopyWith(
          MergeItemsBulkOperationResponse value,
          $Res Function(MergeItemsBulkOperationResponse) then) =
      _$MergeItemsBulkOperationResponseCopyWithImpl<$Res,
          MergeItemsBulkOperationResponse>;
  @useResult
  $Res call(
      {bool success,
      String message,
      @JsonKey(name: 'source_item') String? sourceItem,
      @JsonKey(name: 'target_item') String? targetItem,
      @JsonKey(name: 'merged_data') Map<String, dynamic>? mergedData});
}

/// @nodoc
class _$MergeItemsBulkOperationResponseCopyWithImpl<$Res,
        $Val extends MergeItemsBulkOperationResponse>
    implements $MergeItemsBulkOperationResponseCopyWith<$Res> {
  _$MergeItemsBulkOperationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MergeItemsBulkOperationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? sourceItem = freezed,
    Object? targetItem = freezed,
    Object? mergedData = freezed,
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
      sourceItem: freezed == sourceItem
          ? _value.sourceItem
          : sourceItem // ignore: cast_nullable_to_non_nullable
              as String?,
      targetItem: freezed == targetItem
          ? _value.targetItem
          : targetItem // ignore: cast_nullable_to_non_nullable
              as String?,
      mergedData: freezed == mergedData
          ? _value.mergedData
          : mergedData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MergeItemsBulkOperationResponseImplCopyWith<$Res>
    implements $MergeItemsBulkOperationResponseCopyWith<$Res> {
  factory _$$MergeItemsBulkOperationResponseImplCopyWith(
          _$MergeItemsBulkOperationResponseImpl value,
          $Res Function(_$MergeItemsBulkOperationResponseImpl) then) =
      __$$MergeItemsBulkOperationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String message,
      @JsonKey(name: 'source_item') String? sourceItem,
      @JsonKey(name: 'target_item') String? targetItem,
      @JsonKey(name: 'merged_data') Map<String, dynamic>? mergedData});
}

/// @nodoc
class __$$MergeItemsBulkOperationResponseImplCopyWithImpl<$Res>
    extends _$MergeItemsBulkOperationResponseCopyWithImpl<$Res,
        _$MergeItemsBulkOperationResponseImpl>
    implements _$$MergeItemsBulkOperationResponseImplCopyWith<$Res> {
  __$$MergeItemsBulkOperationResponseImplCopyWithImpl(
      _$MergeItemsBulkOperationResponseImpl _value,
      $Res Function(_$MergeItemsBulkOperationResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MergeItemsBulkOperationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? sourceItem = freezed,
    Object? targetItem = freezed,
    Object? mergedData = freezed,
  }) {
    return _then(_$MergeItemsBulkOperationResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      sourceItem: freezed == sourceItem
          ? _value.sourceItem
          : sourceItem // ignore: cast_nullable_to_non_nullable
              as String?,
      targetItem: freezed == targetItem
          ? _value.targetItem
          : targetItem // ignore: cast_nullable_to_non_nullable
              as String?,
      mergedData: freezed == mergedData
          ? _value._mergedData
          : mergedData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$MergeItemsBulkOperationResponseImpl
    implements _MergeItemsBulkOperationResponse {
  const _$MergeItemsBulkOperationResponseImpl(
      {required this.success,
      required this.message,
      @JsonKey(name: 'source_item') this.sourceItem,
      @JsonKey(name: 'target_item') this.targetItem,
      @JsonKey(name: 'merged_data') final Map<String, dynamic>? mergedData})
      : _mergedData = mergedData;

  factory _$MergeItemsBulkOperationResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$MergeItemsBulkOperationResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  @JsonKey(name: 'source_item')
  final String? sourceItem;
  @override
  @JsonKey(name: 'target_item')
  final String? targetItem;
  final Map<String, dynamic>? _mergedData;
  @override
  @JsonKey(name: 'merged_data')
  Map<String, dynamic>? get mergedData {
    final value = _mergedData;
    if (value == null) return null;
    if (_mergedData is EqualUnmodifiableMapView) return _mergedData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'MergeItemsBulkOperationResponse(success: $success, message: $message, sourceItem: $sourceItem, targetItem: $targetItem, mergedData: $mergedData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MergeItemsBulkOperationResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.sourceItem, sourceItem) ||
                other.sourceItem == sourceItem) &&
            (identical(other.targetItem, targetItem) ||
                other.targetItem == targetItem) &&
            const DeepCollectionEquality()
                .equals(other._mergedData, _mergedData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, sourceItem,
      targetItem, const DeepCollectionEquality().hash(_mergedData));

  /// Create a copy of MergeItemsBulkOperationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MergeItemsBulkOperationResponseImplCopyWith<
          _$MergeItemsBulkOperationResponseImpl>
      get copyWith => __$$MergeItemsBulkOperationResponseImplCopyWithImpl<
          _$MergeItemsBulkOperationResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MergeItemsBulkOperationResponseImplToJson(
      this,
    );
  }
}

abstract class _MergeItemsBulkOperationResponse
    implements MergeItemsBulkOperationResponse {
  const factory _MergeItemsBulkOperationResponse(
          {required final bool success,
          required final String message,
          @JsonKey(name: 'source_item') final String? sourceItem,
          @JsonKey(name: 'target_item') final String? targetItem,
          @JsonKey(name: 'merged_data')
          final Map<String, dynamic>? mergedData}) =
      _$MergeItemsBulkOperationResponseImpl;

  factory _MergeItemsBulkOperationResponse.fromJson(Map<String, dynamic> json) =
      _$MergeItemsBulkOperationResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  @JsonKey(name: 'source_item')
  String? get sourceItem;
  @override
  @JsonKey(name: 'target_item')
  String? get targetItem;
  @override
  @JsonKey(name: 'merged_data')
  Map<String, dynamic>? get mergedData;

  /// Create a copy of MergeItemsBulkOperationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MergeItemsBulkOperationResponseImplCopyWith<
          _$MergeItemsBulkOperationResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

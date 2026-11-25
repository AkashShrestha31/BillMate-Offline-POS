// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'previous_stock_delete_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PreviousStockDeleteResponseModel _$PreviousStockDeleteResponseModelFromJson(
    Map<String, dynamic> json) {
  return _PreviousStockDeleteResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PreviousStockDeleteResponseModel {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'deletion_summary')
  DeletionSummaryModel get deletionSummary =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'deleted_count')
  int get deletedCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'deleted_at')
  String get deletedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'deleted_by')
  String get deletedBy => throw _privateConstructorUsedError;

  /// Serializes this PreviousStockDeleteResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PreviousStockDeleteResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PreviousStockDeleteResponseModelCopyWith<PreviousStockDeleteResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreviousStockDeleteResponseModelCopyWith<$Res> {
  factory $PreviousStockDeleteResponseModelCopyWith(
          PreviousStockDeleteResponseModel value,
          $Res Function(PreviousStockDeleteResponseModel) then) =
      _$PreviousStockDeleteResponseModelCopyWithImpl<$Res,
          PreviousStockDeleteResponseModel>;
  @useResult
  $Res call(
      {bool success,
      String message,
      @JsonKey(name: 'deletion_summary') DeletionSummaryModel deletionSummary,
      @JsonKey(name: 'deleted_count') int deletedCount,
      @JsonKey(name: 'deleted_at') String deletedAt,
      @JsonKey(name: 'deleted_by') String deletedBy});

  $DeletionSummaryModelCopyWith<$Res> get deletionSummary;
}

/// @nodoc
class _$PreviousStockDeleteResponseModelCopyWithImpl<$Res,
        $Val extends PreviousStockDeleteResponseModel>
    implements $PreviousStockDeleteResponseModelCopyWith<$Res> {
  _$PreviousStockDeleteResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PreviousStockDeleteResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? deletionSummary = null,
    Object? deletedCount = null,
    Object? deletedAt = null,
    Object? deletedBy = null,
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
      deletionSummary: null == deletionSummary
          ? _value.deletionSummary
          : deletionSummary // ignore: cast_nullable_to_non_nullable
              as DeletionSummaryModel,
      deletedCount: null == deletedCount
          ? _value.deletedCount
          : deletedCount // ignore: cast_nullable_to_non_nullable
              as int,
      deletedAt: null == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as String,
      deletedBy: null == deletedBy
          ? _value.deletedBy
          : deletedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of PreviousStockDeleteResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeletionSummaryModelCopyWith<$Res> get deletionSummary {
    return $DeletionSummaryModelCopyWith<$Res>(_value.deletionSummary, (value) {
      return _then(_value.copyWith(deletionSummary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PreviousStockDeleteResponseModelImplCopyWith<$Res>
    implements $PreviousStockDeleteResponseModelCopyWith<$Res> {
  factory _$$PreviousStockDeleteResponseModelImplCopyWith(
          _$PreviousStockDeleteResponseModelImpl value,
          $Res Function(_$PreviousStockDeleteResponseModelImpl) then) =
      __$$PreviousStockDeleteResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String message,
      @JsonKey(name: 'deletion_summary') DeletionSummaryModel deletionSummary,
      @JsonKey(name: 'deleted_count') int deletedCount,
      @JsonKey(name: 'deleted_at') String deletedAt,
      @JsonKey(name: 'deleted_by') String deletedBy});

  @override
  $DeletionSummaryModelCopyWith<$Res> get deletionSummary;
}

/// @nodoc
class __$$PreviousStockDeleteResponseModelImplCopyWithImpl<$Res>
    extends _$PreviousStockDeleteResponseModelCopyWithImpl<$Res,
        _$PreviousStockDeleteResponseModelImpl>
    implements _$$PreviousStockDeleteResponseModelImplCopyWith<$Res> {
  __$$PreviousStockDeleteResponseModelImplCopyWithImpl(
      _$PreviousStockDeleteResponseModelImpl _value,
      $Res Function(_$PreviousStockDeleteResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PreviousStockDeleteResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? deletionSummary = null,
    Object? deletedCount = null,
    Object? deletedAt = null,
    Object? deletedBy = null,
  }) {
    return _then(_$PreviousStockDeleteResponseModelImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      deletionSummary: null == deletionSummary
          ? _value.deletionSummary
          : deletionSummary // ignore: cast_nullable_to_non_nullable
              as DeletionSummaryModel,
      deletedCount: null == deletedCount
          ? _value.deletedCount
          : deletedCount // ignore: cast_nullable_to_non_nullable
              as int,
      deletedAt: null == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as String,
      deletedBy: null == deletedBy
          ? _value.deletedBy
          : deletedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreviousStockDeleteResponseModelImpl
    implements _PreviousStockDeleteResponseModel {
  const _$PreviousStockDeleteResponseModelImpl(
      {required this.success,
      required this.message,
      @JsonKey(name: 'deletion_summary') required this.deletionSummary,
      @JsonKey(name: 'deleted_count') required this.deletedCount,
      @JsonKey(name: 'deleted_at') required this.deletedAt,
      @JsonKey(name: 'deleted_by') required this.deletedBy});

  factory _$PreviousStockDeleteResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PreviousStockDeleteResponseModelImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  @JsonKey(name: 'deletion_summary')
  final DeletionSummaryModel deletionSummary;
  @override
  @JsonKey(name: 'deleted_count')
  final int deletedCount;
  @override
  @JsonKey(name: 'deleted_at')
  final String deletedAt;
  @override
  @JsonKey(name: 'deleted_by')
  final String deletedBy;

  @override
  String toString() {
    return 'PreviousStockDeleteResponseModel(success: $success, message: $message, deletionSummary: $deletionSummary, deletedCount: $deletedCount, deletedAt: $deletedAt, deletedBy: $deletedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreviousStockDeleteResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.deletionSummary, deletionSummary) ||
                other.deletionSummary == deletionSummary) &&
            (identical(other.deletedCount, deletedCount) ||
                other.deletedCount == deletedCount) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.deletedBy, deletedBy) ||
                other.deletedBy == deletedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message,
      deletionSummary, deletedCount, deletedAt, deletedBy);

  /// Create a copy of PreviousStockDeleteResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PreviousStockDeleteResponseModelImplCopyWith<
          _$PreviousStockDeleteResponseModelImpl>
      get copyWith => __$$PreviousStockDeleteResponseModelImplCopyWithImpl<
          _$PreviousStockDeleteResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreviousStockDeleteResponseModelImplToJson(
      this,
    );
  }
}

abstract class _PreviousStockDeleteResponseModel
    implements PreviousStockDeleteResponseModel {
  const factory _PreviousStockDeleteResponseModel(
          {required final bool success,
          required final String message,
          @JsonKey(name: 'deletion_summary')
          required final DeletionSummaryModel deletionSummary,
          @JsonKey(name: 'deleted_count') required final int deletedCount,
          @JsonKey(name: 'deleted_at') required final String deletedAt,
          @JsonKey(name: 'deleted_by') required final String deletedBy}) =
      _$PreviousStockDeleteResponseModelImpl;

  factory _PreviousStockDeleteResponseModel.fromJson(
          Map<String, dynamic> json) =
      _$PreviousStockDeleteResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  @JsonKey(name: 'deletion_summary')
  DeletionSummaryModel get deletionSummary;
  @override
  @JsonKey(name: 'deleted_count')
  int get deletedCount;
  @override
  @JsonKey(name: 'deleted_at')
  String get deletedAt;
  @override
  @JsonKey(name: 'deleted_by')
  String get deletedBy;

  /// Create a copy of PreviousStockDeleteResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PreviousStockDeleteResponseModelImplCopyWith<
          _$PreviousStockDeleteResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deletion_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeletionSummaryModel _$DeletionSummaryModelFromJson(Map<String, dynamic> json) {
  return _DeletionSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$DeletionSummaryModel {
  @JsonKey(name: 'reporting_date')
  String get reportingDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_records_deleted')
  int get totalRecordsDeleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'unique_items')
  int get uniqueItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'unique_locations')
  int get uniqueLocations => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_quantity')
  int get totalQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_value')
  double get totalValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'uploaded_by')
  String get uploadedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'upload_time')
  String get uploadTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'sample_deleted_items')
  List<DeletedStockItemModel> get sampleDeletedItems =>
      throw _privateConstructorUsedError;

  /// Serializes this DeletionSummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeletionSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeletionSummaryModelCopyWith<DeletionSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeletionSummaryModelCopyWith<$Res> {
  factory $DeletionSummaryModelCopyWith(DeletionSummaryModel value,
          $Res Function(DeletionSummaryModel) then) =
      _$DeletionSummaryModelCopyWithImpl<$Res, DeletionSummaryModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'reporting_date') String reportingDate,
      @JsonKey(name: 'total_records_deleted') int totalRecordsDeleted,
      @JsonKey(name: 'unique_items') int uniqueItems,
      @JsonKey(name: 'unique_locations') int uniqueLocations,
      @JsonKey(name: 'total_quantity') int totalQuantity,
      @JsonKey(name: 'total_value') double totalValue,
      @JsonKey(name: 'uploaded_by') String uploadedBy,
      @JsonKey(name: 'upload_time') String uploadTime,
      @JsonKey(name: 'sample_deleted_items')
      List<DeletedStockItemModel> sampleDeletedItems});
}

/// @nodoc
class _$DeletionSummaryModelCopyWithImpl<$Res,
        $Val extends DeletionSummaryModel>
    implements $DeletionSummaryModelCopyWith<$Res> {
  _$DeletionSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeletionSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportingDate = null,
    Object? totalRecordsDeleted = null,
    Object? uniqueItems = null,
    Object? uniqueLocations = null,
    Object? totalQuantity = null,
    Object? totalValue = null,
    Object? uploadedBy = null,
    Object? uploadTime = null,
    Object? sampleDeletedItems = null,
  }) {
    return _then(_value.copyWith(
      reportingDate: null == reportingDate
          ? _value.reportingDate
          : reportingDate // ignore: cast_nullable_to_non_nullable
              as String,
      totalRecordsDeleted: null == totalRecordsDeleted
          ? _value.totalRecordsDeleted
          : totalRecordsDeleted // ignore: cast_nullable_to_non_nullable
              as int,
      uniqueItems: null == uniqueItems
          ? _value.uniqueItems
          : uniqueItems // ignore: cast_nullable_to_non_nullable
              as int,
      uniqueLocations: null == uniqueLocations
          ? _value.uniqueLocations
          : uniqueLocations // ignore: cast_nullable_to_non_nullable
              as int,
      totalQuantity: null == totalQuantity
          ? _value.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      totalValue: null == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double,
      uploadedBy: null == uploadedBy
          ? _value.uploadedBy
          : uploadedBy // ignore: cast_nullable_to_non_nullable
              as String,
      uploadTime: null == uploadTime
          ? _value.uploadTime
          : uploadTime // ignore: cast_nullable_to_non_nullable
              as String,
      sampleDeletedItems: null == sampleDeletedItems
          ? _value.sampleDeletedItems
          : sampleDeletedItems // ignore: cast_nullable_to_non_nullable
              as List<DeletedStockItemModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeletionSummaryModelImplCopyWith<$Res>
    implements $DeletionSummaryModelCopyWith<$Res> {
  factory _$$DeletionSummaryModelImplCopyWith(_$DeletionSummaryModelImpl value,
          $Res Function(_$DeletionSummaryModelImpl) then) =
      __$$DeletionSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'reporting_date') String reportingDate,
      @JsonKey(name: 'total_records_deleted') int totalRecordsDeleted,
      @JsonKey(name: 'unique_items') int uniqueItems,
      @JsonKey(name: 'unique_locations') int uniqueLocations,
      @JsonKey(name: 'total_quantity') int totalQuantity,
      @JsonKey(name: 'total_value') double totalValue,
      @JsonKey(name: 'uploaded_by') String uploadedBy,
      @JsonKey(name: 'upload_time') String uploadTime,
      @JsonKey(name: 'sample_deleted_items')
      List<DeletedStockItemModel> sampleDeletedItems});
}

/// @nodoc
class __$$DeletionSummaryModelImplCopyWithImpl<$Res>
    extends _$DeletionSummaryModelCopyWithImpl<$Res, _$DeletionSummaryModelImpl>
    implements _$$DeletionSummaryModelImplCopyWith<$Res> {
  __$$DeletionSummaryModelImplCopyWithImpl(_$DeletionSummaryModelImpl _value,
      $Res Function(_$DeletionSummaryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeletionSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportingDate = null,
    Object? totalRecordsDeleted = null,
    Object? uniqueItems = null,
    Object? uniqueLocations = null,
    Object? totalQuantity = null,
    Object? totalValue = null,
    Object? uploadedBy = null,
    Object? uploadTime = null,
    Object? sampleDeletedItems = null,
  }) {
    return _then(_$DeletionSummaryModelImpl(
      reportingDate: null == reportingDate
          ? _value.reportingDate
          : reportingDate // ignore: cast_nullable_to_non_nullable
              as String,
      totalRecordsDeleted: null == totalRecordsDeleted
          ? _value.totalRecordsDeleted
          : totalRecordsDeleted // ignore: cast_nullable_to_non_nullable
              as int,
      uniqueItems: null == uniqueItems
          ? _value.uniqueItems
          : uniqueItems // ignore: cast_nullable_to_non_nullable
              as int,
      uniqueLocations: null == uniqueLocations
          ? _value.uniqueLocations
          : uniqueLocations // ignore: cast_nullable_to_non_nullable
              as int,
      totalQuantity: null == totalQuantity
          ? _value.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      totalValue: null == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double,
      uploadedBy: null == uploadedBy
          ? _value.uploadedBy
          : uploadedBy // ignore: cast_nullable_to_non_nullable
              as String,
      uploadTime: null == uploadTime
          ? _value.uploadTime
          : uploadTime // ignore: cast_nullable_to_non_nullable
              as String,
      sampleDeletedItems: null == sampleDeletedItems
          ? _value._sampleDeletedItems
          : sampleDeletedItems // ignore: cast_nullable_to_non_nullable
              as List<DeletedStockItemModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeletionSummaryModelImpl implements _DeletionSummaryModel {
  const _$DeletionSummaryModelImpl(
      {@JsonKey(name: 'reporting_date') required this.reportingDate,
      @JsonKey(name: 'total_records_deleted') required this.totalRecordsDeleted,
      @JsonKey(name: 'unique_items') required this.uniqueItems,
      @JsonKey(name: 'unique_locations') required this.uniqueLocations,
      @JsonKey(name: 'total_quantity') required this.totalQuantity,
      @JsonKey(name: 'total_value') required this.totalValue,
      @JsonKey(name: 'uploaded_by') required this.uploadedBy,
      @JsonKey(name: 'upload_time') required this.uploadTime,
      @JsonKey(name: 'sample_deleted_items')
      required final List<DeletedStockItemModel> sampleDeletedItems})
      : _sampleDeletedItems = sampleDeletedItems;

  factory _$DeletionSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeletionSummaryModelImplFromJson(json);

  @override
  @JsonKey(name: 'reporting_date')
  final String reportingDate;
  @override
  @JsonKey(name: 'total_records_deleted')
  final int totalRecordsDeleted;
  @override
  @JsonKey(name: 'unique_items')
  final int uniqueItems;
  @override
  @JsonKey(name: 'unique_locations')
  final int uniqueLocations;
  @override
  @JsonKey(name: 'total_quantity')
  final int totalQuantity;
  @override
  @JsonKey(name: 'total_value')
  final double totalValue;
  @override
  @JsonKey(name: 'uploaded_by')
  final String uploadedBy;
  @override
  @JsonKey(name: 'upload_time')
  final String uploadTime;
  final List<DeletedStockItemModel> _sampleDeletedItems;
  @override
  @JsonKey(name: 'sample_deleted_items')
  List<DeletedStockItemModel> get sampleDeletedItems {
    if (_sampleDeletedItems is EqualUnmodifiableListView)
      return _sampleDeletedItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sampleDeletedItems);
  }

  @override
  String toString() {
    return 'DeletionSummaryModel(reportingDate: $reportingDate, totalRecordsDeleted: $totalRecordsDeleted, uniqueItems: $uniqueItems, uniqueLocations: $uniqueLocations, totalQuantity: $totalQuantity, totalValue: $totalValue, uploadedBy: $uploadedBy, uploadTime: $uploadTime, sampleDeletedItems: $sampleDeletedItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletionSummaryModelImpl &&
            (identical(other.reportingDate, reportingDate) ||
                other.reportingDate == reportingDate) &&
            (identical(other.totalRecordsDeleted, totalRecordsDeleted) ||
                other.totalRecordsDeleted == totalRecordsDeleted) &&
            (identical(other.uniqueItems, uniqueItems) ||
                other.uniqueItems == uniqueItems) &&
            (identical(other.uniqueLocations, uniqueLocations) ||
                other.uniqueLocations == uniqueLocations) &&
            (identical(other.totalQuantity, totalQuantity) ||
                other.totalQuantity == totalQuantity) &&
            (identical(other.totalValue, totalValue) ||
                other.totalValue == totalValue) &&
            (identical(other.uploadedBy, uploadedBy) ||
                other.uploadedBy == uploadedBy) &&
            (identical(other.uploadTime, uploadTime) ||
                other.uploadTime == uploadTime) &&
            const DeepCollectionEquality()
                .equals(other._sampleDeletedItems, _sampleDeletedItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      reportingDate,
      totalRecordsDeleted,
      uniqueItems,
      uniqueLocations,
      totalQuantity,
      totalValue,
      uploadedBy,
      uploadTime,
      const DeepCollectionEquality().hash(_sampleDeletedItems));

  /// Create a copy of DeletionSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletionSummaryModelImplCopyWith<_$DeletionSummaryModelImpl>
      get copyWith =>
          __$$DeletionSummaryModelImplCopyWithImpl<_$DeletionSummaryModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeletionSummaryModelImplToJson(
      this,
    );
  }
}

abstract class _DeletionSummaryModel implements DeletionSummaryModel {
  const factory _DeletionSummaryModel(
          {@JsonKey(name: 'reporting_date') required final String reportingDate,
          @JsonKey(name: 'total_records_deleted')
          required final int totalRecordsDeleted,
          @JsonKey(name: 'unique_items') required final int uniqueItems,
          @JsonKey(name: 'unique_locations') required final int uniqueLocations,
          @JsonKey(name: 'total_quantity') required final int totalQuantity,
          @JsonKey(name: 'total_value') required final double totalValue,
          @JsonKey(name: 'uploaded_by') required final String uploadedBy,
          @JsonKey(name: 'upload_time') required final String uploadTime,
          @JsonKey(name: 'sample_deleted_items')
          required final List<DeletedStockItemModel> sampleDeletedItems}) =
      _$DeletionSummaryModelImpl;

  factory _DeletionSummaryModel.fromJson(Map<String, dynamic> json) =
      _$DeletionSummaryModelImpl.fromJson;

  @override
  @JsonKey(name: 'reporting_date')
  String get reportingDate;
  @override
  @JsonKey(name: 'total_records_deleted')
  int get totalRecordsDeleted;
  @override
  @JsonKey(name: 'unique_items')
  int get uniqueItems;
  @override
  @JsonKey(name: 'unique_locations')
  int get uniqueLocations;
  @override
  @JsonKey(name: 'total_quantity')
  int get totalQuantity;
  @override
  @JsonKey(name: 'total_value')
  double get totalValue;
  @override
  @JsonKey(name: 'uploaded_by')
  String get uploadedBy;
  @override
  @JsonKey(name: 'upload_time')
  String get uploadTime;
  @override
  @JsonKey(name: 'sample_deleted_items')
  List<DeletedStockItemModel> get sampleDeletedItems;

  /// Create a copy of DeletionSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeletionSummaryModelImplCopyWith<_$DeletionSummaryModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

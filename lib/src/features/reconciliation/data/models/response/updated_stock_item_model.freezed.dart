// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'updated_stock_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdatedStockItemModel _$UpdatedStockItemModelFromJson(
    Map<String, dynamic> json) {
  return _UpdatedStockItemModel.fromJson(json);
}

/// @nodoc
mixin _$UpdatedStockItemModel {
  String get name => throw _privateConstructorUsedError;
  String get item => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'reporting_date')
  String get reportingDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'previous_quantity')
  double get previousQuantity => throw _privateConstructorUsedError;
  double get rate => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  @JsonKey(name: 'batch_number')
  String get batchNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'expiry_date')
  String get expiryDate => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'modified_by')
  String get modifiedBy => throw _privateConstructorUsedError;
  String get modified => throw _privateConstructorUsedError;

  /// Serializes this UpdatedStockItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdatedStockItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdatedStockItemModelCopyWith<UpdatedStockItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatedStockItemModelCopyWith<$Res> {
  factory $UpdatedStockItemModelCopyWith(UpdatedStockItemModel value,
          $Res Function(UpdatedStockItemModel) then) =
      _$UpdatedStockItemModelCopyWithImpl<$Res, UpdatedStockItemModel>;
  @useResult
  $Res call(
      {String name,
      String item,
      String location,
      @JsonKey(name: 'reporting_date') String reportingDate,
      @JsonKey(name: 'previous_quantity') double previousQuantity,
      double rate,
      double value,
      @JsonKey(name: 'batch_number') String batchNumber,
      @JsonKey(name: 'expiry_date') String expiryDate,
      String? notes,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'modified_by') String modifiedBy,
      String modified});
}

/// @nodoc
class _$UpdatedStockItemModelCopyWithImpl<$Res,
        $Val extends UpdatedStockItemModel>
    implements $UpdatedStockItemModelCopyWith<$Res> {
  _$UpdatedStockItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdatedStockItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? item = null,
    Object? location = null,
    Object? reportingDate = null,
    Object? previousQuantity = null,
    Object? rate = null,
    Object? value = null,
    Object? batchNumber = null,
    Object? expiryDate = null,
    Object? notes = freezed,
    Object? isActive = null,
    Object? modifiedBy = null,
    Object? modified = null,
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
      reportingDate: null == reportingDate
          ? _value.reportingDate
          : reportingDate // ignore: cast_nullable_to_non_nullable
              as String,
      previousQuantity: null == previousQuantity
          ? _value.previousQuantity
          : previousQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      batchNumber: null == batchNumber
          ? _value.batchNumber
          : batchNumber // ignore: cast_nullable_to_non_nullable
              as String,
      expiryDate: null == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      modifiedBy: null == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String,
      modified: null == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdatedStockItemModelImplCopyWith<$Res>
    implements $UpdatedStockItemModelCopyWith<$Res> {
  factory _$$UpdatedStockItemModelImplCopyWith(
          _$UpdatedStockItemModelImpl value,
          $Res Function(_$UpdatedStockItemModelImpl) then) =
      __$$UpdatedStockItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String item,
      String location,
      @JsonKey(name: 'reporting_date') String reportingDate,
      @JsonKey(name: 'previous_quantity') double previousQuantity,
      double rate,
      double value,
      @JsonKey(name: 'batch_number') String batchNumber,
      @JsonKey(name: 'expiry_date') String expiryDate,
      String? notes,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'modified_by') String modifiedBy,
      String modified});
}

/// @nodoc
class __$$UpdatedStockItemModelImplCopyWithImpl<$Res>
    extends _$UpdatedStockItemModelCopyWithImpl<$Res,
        _$UpdatedStockItemModelImpl>
    implements _$$UpdatedStockItemModelImplCopyWith<$Res> {
  __$$UpdatedStockItemModelImplCopyWithImpl(_$UpdatedStockItemModelImpl _value,
      $Res Function(_$UpdatedStockItemModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdatedStockItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? item = null,
    Object? location = null,
    Object? reportingDate = null,
    Object? previousQuantity = null,
    Object? rate = null,
    Object? value = null,
    Object? batchNumber = null,
    Object? expiryDate = null,
    Object? notes = freezed,
    Object? isActive = null,
    Object? modifiedBy = null,
    Object? modified = null,
  }) {
    return _then(_$UpdatedStockItemModelImpl(
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
      reportingDate: null == reportingDate
          ? _value.reportingDate
          : reportingDate // ignore: cast_nullable_to_non_nullable
              as String,
      previousQuantity: null == previousQuantity
          ? _value.previousQuantity
          : previousQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      batchNumber: null == batchNumber
          ? _value.batchNumber
          : batchNumber // ignore: cast_nullable_to_non_nullable
              as String,
      expiryDate: null == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      modifiedBy: null == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String,
      modified: null == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatedStockItemModelImpl implements _UpdatedStockItemModel {
  const _$UpdatedStockItemModelImpl(
      {required this.name,
      required this.item,
      required this.location,
      @JsonKey(name: 'reporting_date') required this.reportingDate,
      @JsonKey(name: 'previous_quantity') required this.previousQuantity,
      required this.rate,
      required this.value,
      @JsonKey(name: 'batch_number') required this.batchNumber,
      @JsonKey(name: 'expiry_date') required this.expiryDate,
      this.notes,
      @JsonKey(name: 'is_active') required this.isActive,
      @JsonKey(name: 'modified_by') required this.modifiedBy,
      required this.modified});

  factory _$UpdatedStockItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdatedStockItemModelImplFromJson(json);

  @override
  final String name;
  @override
  final String item;
  @override
  final String location;
  @override
  @JsonKey(name: 'reporting_date')
  final String reportingDate;
  @override
  @JsonKey(name: 'previous_quantity')
  final double previousQuantity;
  @override
  final double rate;
  @override
  final double value;
  @override
  @JsonKey(name: 'batch_number')
  final String batchNumber;
  @override
  @JsonKey(name: 'expiry_date')
  final String expiryDate;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'modified_by')
  final String modifiedBy;
  @override
  final String modified;

  @override
  String toString() {
    return 'UpdatedStockItemModel(name: $name, item: $item, location: $location, reportingDate: $reportingDate, previousQuantity: $previousQuantity, rate: $rate, value: $value, batchNumber: $batchNumber, expiryDate: $expiryDate, notes: $notes, isActive: $isActive, modifiedBy: $modifiedBy, modified: $modified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatedStockItemModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.reportingDate, reportingDate) ||
                other.reportingDate == reportingDate) &&
            (identical(other.previousQuantity, previousQuantity) ||
                other.previousQuantity == previousQuantity) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.batchNumber, batchNumber) ||
                other.batchNumber == batchNumber) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.modifiedBy, modifiedBy) ||
                other.modifiedBy == modifiedBy) &&
            (identical(other.modified, modified) ||
                other.modified == modified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      item,
      location,
      reportingDate,
      previousQuantity,
      rate,
      value,
      batchNumber,
      expiryDate,
      notes,
      isActive,
      modifiedBy,
      modified);

  /// Create a copy of UpdatedStockItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatedStockItemModelImplCopyWith<_$UpdatedStockItemModelImpl>
      get copyWith => __$$UpdatedStockItemModelImplCopyWithImpl<
          _$UpdatedStockItemModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatedStockItemModelImplToJson(
      this,
    );
  }
}

abstract class _UpdatedStockItemModel implements UpdatedStockItemModel {
  const factory _UpdatedStockItemModel(
      {required final String name,
      required final String item,
      required final String location,
      @JsonKey(name: 'reporting_date') required final String reportingDate,
      @JsonKey(name: 'previous_quantity')
      required final double previousQuantity,
      required final double rate,
      required final double value,
      @JsonKey(name: 'batch_number') required final String batchNumber,
      @JsonKey(name: 'expiry_date') required final String expiryDate,
      final String? notes,
      @JsonKey(name: 'is_active') required final bool isActive,
      @JsonKey(name: 'modified_by') required final String modifiedBy,
      required final String modified}) = _$UpdatedStockItemModelImpl;

  factory _UpdatedStockItemModel.fromJson(Map<String, dynamic> json) =
      _$UpdatedStockItemModelImpl.fromJson;

  @override
  String get name;
  @override
  String get item;
  @override
  String get location;
  @override
  @JsonKey(name: 'reporting_date')
  String get reportingDate;
  @override
  @JsonKey(name: 'previous_quantity')
  double get previousQuantity;
  @override
  double get rate;
  @override
  double get value;
  @override
  @JsonKey(name: 'batch_number')
  String get batchNumber;
  @override
  @JsonKey(name: 'expiry_date')
  String get expiryDate;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'modified_by')
  String get modifiedBy;
  @override
  String get modified;

  /// Create a copy of UpdatedStockItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatedStockItemModelImplCopyWith<_$UpdatedStockItemModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

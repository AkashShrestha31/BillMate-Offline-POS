// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'party_update_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartyTableUpdatesModel _$PartyTableUpdatesModelFromJson(
    Map<String, dynamic> json) {
  return _PartyTableUpdatesModel.fromJson(json);
}

/// @nodoc
mixin _$PartyTableUpdatesModel {
  @JsonKey(name: 'fields_updated')
  List<String>? get fieldsUpdated => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_values')
  Map<String, dynamic>? get updatedValues => throw _privateConstructorUsedError;

  /// Serializes this PartyTableUpdatesModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartyTableUpdatesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartyTableUpdatesModelCopyWith<PartyTableUpdatesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartyTableUpdatesModelCopyWith<$Res> {
  factory $PartyTableUpdatesModelCopyWith(PartyTableUpdatesModel value,
          $Res Function(PartyTableUpdatesModel) then) =
      _$PartyTableUpdatesModelCopyWithImpl<$Res, PartyTableUpdatesModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'fields_updated') List<String>? fieldsUpdated,
      @JsonKey(name: 'updated_values') Map<String, dynamic>? updatedValues});
}

/// @nodoc
class _$PartyTableUpdatesModelCopyWithImpl<$Res,
        $Val extends PartyTableUpdatesModel>
    implements $PartyTableUpdatesModelCopyWith<$Res> {
  _$PartyTableUpdatesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartyTableUpdatesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fieldsUpdated = freezed,
    Object? updatedValues = freezed,
  }) {
    return _then(_value.copyWith(
      fieldsUpdated: freezed == fieldsUpdated
          ? _value.fieldsUpdated
          : fieldsUpdated // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      updatedValues: freezed == updatedValues
          ? _value.updatedValues
          : updatedValues // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartyTableUpdatesModelImplCopyWith<$Res>
    implements $PartyTableUpdatesModelCopyWith<$Res> {
  factory _$$PartyTableUpdatesModelImplCopyWith(
          _$PartyTableUpdatesModelImpl value,
          $Res Function(_$PartyTableUpdatesModelImpl) then) =
      __$$PartyTableUpdatesModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'fields_updated') List<String>? fieldsUpdated,
      @JsonKey(name: 'updated_values') Map<String, dynamic>? updatedValues});
}

/// @nodoc
class __$$PartyTableUpdatesModelImplCopyWithImpl<$Res>
    extends _$PartyTableUpdatesModelCopyWithImpl<$Res,
        _$PartyTableUpdatesModelImpl>
    implements _$$PartyTableUpdatesModelImplCopyWith<$Res> {
  __$$PartyTableUpdatesModelImplCopyWithImpl(
      _$PartyTableUpdatesModelImpl _value,
      $Res Function(_$PartyTableUpdatesModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartyTableUpdatesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fieldsUpdated = freezed,
    Object? updatedValues = freezed,
  }) {
    return _then(_$PartyTableUpdatesModelImpl(
      fieldsUpdated: freezed == fieldsUpdated
          ? _value._fieldsUpdated
          : fieldsUpdated // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      updatedValues: freezed == updatedValues
          ? _value._updatedValues
          : updatedValues // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartyTableUpdatesModelImpl implements _PartyTableUpdatesModel {
  const _$PartyTableUpdatesModelImpl(
      {@JsonKey(name: 'fields_updated') final List<String>? fieldsUpdated,
      @JsonKey(name: 'updated_values')
      final Map<String, dynamic>? updatedValues})
      : _fieldsUpdated = fieldsUpdated,
        _updatedValues = updatedValues;

  factory _$PartyTableUpdatesModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartyTableUpdatesModelImplFromJson(json);

  final List<String>? _fieldsUpdated;
  @override
  @JsonKey(name: 'fields_updated')
  List<String>? get fieldsUpdated {
    final value = _fieldsUpdated;
    if (value == null) return null;
    if (_fieldsUpdated is EqualUnmodifiableListView) return _fieldsUpdated;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _updatedValues;
  @override
  @JsonKey(name: 'updated_values')
  Map<String, dynamic>? get updatedValues {
    final value = _updatedValues;
    if (value == null) return null;
    if (_updatedValues is EqualUnmodifiableMapView) return _updatedValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'PartyTableUpdatesModel(fieldsUpdated: $fieldsUpdated, updatedValues: $updatedValues)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartyTableUpdatesModelImpl &&
            const DeepCollectionEquality()
                .equals(other._fieldsUpdated, _fieldsUpdated) &&
            const DeepCollectionEquality()
                .equals(other._updatedValues, _updatedValues));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_fieldsUpdated),
      const DeepCollectionEquality().hash(_updatedValues));

  /// Create a copy of PartyTableUpdatesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartyTableUpdatesModelImplCopyWith<_$PartyTableUpdatesModelImpl>
      get copyWith => __$$PartyTableUpdatesModelImplCopyWithImpl<
          _$PartyTableUpdatesModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartyTableUpdatesModelImplToJson(
      this,
    );
  }
}

abstract class _PartyTableUpdatesModel implements PartyTableUpdatesModel {
  const factory _PartyTableUpdatesModel(
          {@JsonKey(name: 'fields_updated') final List<String>? fieldsUpdated,
          @JsonKey(name: 'updated_values')
          final Map<String, dynamic>? updatedValues}) =
      _$PartyTableUpdatesModelImpl;

  factory _PartyTableUpdatesModel.fromJson(Map<String, dynamic> json) =
      _$PartyTableUpdatesModelImpl.fromJson;

  @override
  @JsonKey(name: 'fields_updated')
  List<String>? get fieldsUpdated;
  @override
  @JsonKey(name: 'updated_values')
  Map<String, dynamic>? get updatedValues;

  /// Create a copy of PartyTableUpdatesModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartyTableUpdatesModelImplCopyWith<_$PartyTableUpdatesModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ChangeDetailModel _$ChangeDetailModelFromJson(Map<String, dynamic> json) {
  return _ChangeDetailModel.fromJson(json);
}

/// @nodoc
mixin _$ChangeDetailModel {
  dynamic get old => throw _privateConstructorUsedError;
  @JsonKey(name: 'new')
  dynamic get newValue => throw _privateConstructorUsedError;

  /// Serializes this ChangeDetailModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChangeDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChangeDetailModelCopyWith<ChangeDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangeDetailModelCopyWith<$Res> {
  factory $ChangeDetailModelCopyWith(
          ChangeDetailModel value, $Res Function(ChangeDetailModel) then) =
      _$ChangeDetailModelCopyWithImpl<$Res, ChangeDetailModel>;
  @useResult
  $Res call({dynamic old, @JsonKey(name: 'new') dynamic newValue});
}

/// @nodoc
class _$ChangeDetailModelCopyWithImpl<$Res, $Val extends ChangeDetailModel>
    implements $ChangeDetailModelCopyWith<$Res> {
  _$ChangeDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChangeDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? old = freezed,
    Object? newValue = freezed,
  }) {
    return _then(_value.copyWith(
      old: freezed == old
          ? _value.old
          : old // ignore: cast_nullable_to_non_nullable
              as dynamic,
      newValue: freezed == newValue
          ? _value.newValue
          : newValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChangeDetailModelImplCopyWith<$Res>
    implements $ChangeDetailModelCopyWith<$Res> {
  factory _$$ChangeDetailModelImplCopyWith(_$ChangeDetailModelImpl value,
          $Res Function(_$ChangeDetailModelImpl) then) =
      __$$ChangeDetailModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic old, @JsonKey(name: 'new') dynamic newValue});
}

/// @nodoc
class __$$ChangeDetailModelImplCopyWithImpl<$Res>
    extends _$ChangeDetailModelCopyWithImpl<$Res, _$ChangeDetailModelImpl>
    implements _$$ChangeDetailModelImplCopyWith<$Res> {
  __$$ChangeDetailModelImplCopyWithImpl(_$ChangeDetailModelImpl _value,
      $Res Function(_$ChangeDetailModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangeDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? old = freezed,
    Object? newValue = freezed,
  }) {
    return _then(_$ChangeDetailModelImpl(
      old: freezed == old
          ? _value.old
          : old // ignore: cast_nullable_to_non_nullable
              as dynamic,
      newValue: freezed == newValue
          ? _value.newValue
          : newValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChangeDetailModelImpl implements _ChangeDetailModel {
  const _$ChangeDetailModelImpl(
      {this.old, @JsonKey(name: 'new') this.newValue});

  factory _$ChangeDetailModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChangeDetailModelImplFromJson(json);

  @override
  final dynamic old;
  @override
  @JsonKey(name: 'new')
  final dynamic newValue;

  @override
  String toString() {
    return 'ChangeDetailModel(old: $old, newValue: $newValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeDetailModelImpl &&
            const DeepCollectionEquality().equals(other.old, old) &&
            const DeepCollectionEquality().equals(other.newValue, newValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(old),
      const DeepCollectionEquality().hash(newValue));

  /// Create a copy of ChangeDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeDetailModelImplCopyWith<_$ChangeDetailModelImpl> get copyWith =>
      __$$ChangeDetailModelImplCopyWithImpl<_$ChangeDetailModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangeDetailModelImplToJson(
      this,
    );
  }
}

abstract class _ChangeDetailModel implements ChangeDetailModel {
  const factory _ChangeDetailModel(
      {final dynamic old,
      @JsonKey(name: 'new') final dynamic newValue}) = _$ChangeDetailModelImpl;

  factory _ChangeDetailModel.fromJson(Map<String, dynamic> json) =
      _$ChangeDetailModelImpl.fromJson;

  @override
  dynamic get old;
  @override
  @JsonKey(name: 'new')
  dynamic get newValue;

  /// Create a copy of ChangeDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeDetailModelImplCopyWith<_$ChangeDetailModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SearchSummaryModel _$SearchSummaryModelFromJson(Map<String, dynamic> json) {
  return _SearchSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$SearchSummaryModel {
  @JsonKey(name: 'total_tables_searched')
  int? get totalTablesSearched => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_columns_searched')
  int? get totalColumnsSearched => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_rows_updated')
  int? get totalRowsUpdated => throw _privateConstructorUsedError;
  @JsonKey(name: 'tables_with_updates')
  int? get tablesWithUpdates => throw _privateConstructorUsedError;

  /// Serializes this SearchSummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SearchSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchSummaryModelCopyWith<SearchSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchSummaryModelCopyWith<$Res> {
  factory $SearchSummaryModelCopyWith(
          SearchSummaryModel value, $Res Function(SearchSummaryModel) then) =
      _$SearchSummaryModelCopyWithImpl<$Res, SearchSummaryModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_tables_searched') int? totalTablesSearched,
      @JsonKey(name: 'total_columns_searched') int? totalColumnsSearched,
      @JsonKey(name: 'total_rows_updated') int? totalRowsUpdated,
      @JsonKey(name: 'tables_with_updates') int? tablesWithUpdates});
}

/// @nodoc
class _$SearchSummaryModelCopyWithImpl<$Res, $Val extends SearchSummaryModel>
    implements $SearchSummaryModelCopyWith<$Res> {
  _$SearchSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalTablesSearched = freezed,
    Object? totalColumnsSearched = freezed,
    Object? totalRowsUpdated = freezed,
    Object? tablesWithUpdates = freezed,
  }) {
    return _then(_value.copyWith(
      totalTablesSearched: freezed == totalTablesSearched
          ? _value.totalTablesSearched
          : totalTablesSearched // ignore: cast_nullable_to_non_nullable
              as int?,
      totalColumnsSearched: freezed == totalColumnsSearched
          ? _value.totalColumnsSearched
          : totalColumnsSearched // ignore: cast_nullable_to_non_nullable
              as int?,
      totalRowsUpdated: freezed == totalRowsUpdated
          ? _value.totalRowsUpdated
          : totalRowsUpdated // ignore: cast_nullable_to_non_nullable
              as int?,
      tablesWithUpdates: freezed == tablesWithUpdates
          ? _value.tablesWithUpdates
          : tablesWithUpdates // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchSummaryModelImplCopyWith<$Res>
    implements $SearchSummaryModelCopyWith<$Res> {
  factory _$$SearchSummaryModelImplCopyWith(_$SearchSummaryModelImpl value,
          $Res Function(_$SearchSummaryModelImpl) then) =
      __$$SearchSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_tables_searched') int? totalTablesSearched,
      @JsonKey(name: 'total_columns_searched') int? totalColumnsSearched,
      @JsonKey(name: 'total_rows_updated') int? totalRowsUpdated,
      @JsonKey(name: 'tables_with_updates') int? tablesWithUpdates});
}

/// @nodoc
class __$$SearchSummaryModelImplCopyWithImpl<$Res>
    extends _$SearchSummaryModelCopyWithImpl<$Res, _$SearchSummaryModelImpl>
    implements _$$SearchSummaryModelImplCopyWith<$Res> {
  __$$SearchSummaryModelImplCopyWithImpl(_$SearchSummaryModelImpl _value,
      $Res Function(_$SearchSummaryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalTablesSearched = freezed,
    Object? totalColumnsSearched = freezed,
    Object? totalRowsUpdated = freezed,
    Object? tablesWithUpdates = freezed,
  }) {
    return _then(_$SearchSummaryModelImpl(
      totalTablesSearched: freezed == totalTablesSearched
          ? _value.totalTablesSearched
          : totalTablesSearched // ignore: cast_nullable_to_non_nullable
              as int?,
      totalColumnsSearched: freezed == totalColumnsSearched
          ? _value.totalColumnsSearched
          : totalColumnsSearched // ignore: cast_nullable_to_non_nullable
              as int?,
      totalRowsUpdated: freezed == totalRowsUpdated
          ? _value.totalRowsUpdated
          : totalRowsUpdated // ignore: cast_nullable_to_non_nullable
              as int?,
      tablesWithUpdates: freezed == tablesWithUpdates
          ? _value.tablesWithUpdates
          : tablesWithUpdates // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchSummaryModelImpl implements _SearchSummaryModel {
  const _$SearchSummaryModelImpl(
      {@JsonKey(name: 'total_tables_searched') this.totalTablesSearched,
      @JsonKey(name: 'total_columns_searched') this.totalColumnsSearched,
      @JsonKey(name: 'total_rows_updated') this.totalRowsUpdated,
      @JsonKey(name: 'tables_with_updates') this.tablesWithUpdates});

  factory _$SearchSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchSummaryModelImplFromJson(json);

  @override
  @JsonKey(name: 'total_tables_searched')
  final int? totalTablesSearched;
  @override
  @JsonKey(name: 'total_columns_searched')
  final int? totalColumnsSearched;
  @override
  @JsonKey(name: 'total_rows_updated')
  final int? totalRowsUpdated;
  @override
  @JsonKey(name: 'tables_with_updates')
  final int? tablesWithUpdates;

  @override
  String toString() {
    return 'SearchSummaryModel(totalTablesSearched: $totalTablesSearched, totalColumnsSearched: $totalColumnsSearched, totalRowsUpdated: $totalRowsUpdated, tablesWithUpdates: $tablesWithUpdates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchSummaryModelImpl &&
            (identical(other.totalTablesSearched, totalTablesSearched) ||
                other.totalTablesSearched == totalTablesSearched) &&
            (identical(other.totalColumnsSearched, totalColumnsSearched) ||
                other.totalColumnsSearched == totalColumnsSearched) &&
            (identical(other.totalRowsUpdated, totalRowsUpdated) ||
                other.totalRowsUpdated == totalRowsUpdated) &&
            (identical(other.tablesWithUpdates, tablesWithUpdates) ||
                other.tablesWithUpdates == tablesWithUpdates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalTablesSearched,
      totalColumnsSearched, totalRowsUpdated, tablesWithUpdates);

  /// Create a copy of SearchSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchSummaryModelImplCopyWith<_$SearchSummaryModelImpl> get copyWith =>
      __$$SearchSummaryModelImplCopyWithImpl<_$SearchSummaryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchSummaryModelImplToJson(
      this,
    );
  }
}

abstract class _SearchSummaryModel implements SearchSummaryModel {
  const factory _SearchSummaryModel(
      {@JsonKey(name: 'total_tables_searched') final int? totalTablesSearched,
      @JsonKey(name: 'total_columns_searched') final int? totalColumnsSearched,
      @JsonKey(name: 'total_rows_updated') final int? totalRowsUpdated,
      @JsonKey(name: 'tables_with_updates')
      final int? tablesWithUpdates}) = _$SearchSummaryModelImpl;

  factory _SearchSummaryModel.fromJson(Map<String, dynamic> json) =
      _$SearchSummaryModelImpl.fromJson;

  @override
  @JsonKey(name: 'total_tables_searched')
  int? get totalTablesSearched;
  @override
  @JsonKey(name: 'total_columns_searched')
  int? get totalColumnsSearched;
  @override
  @JsonKey(name: 'total_rows_updated')
  int? get totalRowsUpdated;
  @override
  @JsonKey(name: 'tables_with_updates')
  int? get tablesWithUpdates;

  /// Create a copy of SearchSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchSummaryModelImplCopyWith<_$SearchSummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateResultModel _$UpdateResultModelFromJson(Map<String, dynamic> json) {
  return _UpdateResultModel.fromJson(json);
}

/// @nodoc
mixin _$UpdateResultModel {
  String get table => throw _privateConstructorUsedError;
  String get column => throw _privateConstructorUsedError;
  @JsonKey(name: 'column_type')
  String get columnType => throw _privateConstructorUsedError;
  @JsonKey(name: 'rows_affected')
  int? get rowsAffected => throw _privateConstructorUsedError;
  @JsonKey(name: 'update_type')
  String get updateType => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this UpdateResultModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateResultModelCopyWith<UpdateResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateResultModelCopyWith<$Res> {
  factory $UpdateResultModelCopyWith(
          UpdateResultModel value, $Res Function(UpdateResultModel) then) =
      _$UpdateResultModelCopyWithImpl<$Res, UpdateResultModel>;
  @useResult
  $Res call(
      {String table,
      String column,
      @JsonKey(name: 'column_type') String columnType,
      @JsonKey(name: 'rows_affected') int? rowsAffected,
      @JsonKey(name: 'update_type') String updateType,
      String? error});
}

/// @nodoc
class _$UpdateResultModelCopyWithImpl<$Res, $Val extends UpdateResultModel>
    implements $UpdateResultModelCopyWith<$Res> {
  _$UpdateResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? table = null,
    Object? column = null,
    Object? columnType = null,
    Object? rowsAffected = freezed,
    Object? updateType = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String,
      column: null == column
          ? _value.column
          : column // ignore: cast_nullable_to_non_nullable
              as String,
      columnType: null == columnType
          ? _value.columnType
          : columnType // ignore: cast_nullable_to_non_nullable
              as String,
      rowsAffected: freezed == rowsAffected
          ? _value.rowsAffected
          : rowsAffected // ignore: cast_nullable_to_non_nullable
              as int?,
      updateType: null == updateType
          ? _value.updateType
          : updateType // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateResultModelImplCopyWith<$Res>
    implements $UpdateResultModelCopyWith<$Res> {
  factory _$$UpdateResultModelImplCopyWith(_$UpdateResultModelImpl value,
          $Res Function(_$UpdateResultModelImpl) then) =
      __$$UpdateResultModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String table,
      String column,
      @JsonKey(name: 'column_type') String columnType,
      @JsonKey(name: 'rows_affected') int? rowsAffected,
      @JsonKey(name: 'update_type') String updateType,
      String? error});
}

/// @nodoc
class __$$UpdateResultModelImplCopyWithImpl<$Res>
    extends _$UpdateResultModelCopyWithImpl<$Res, _$UpdateResultModelImpl>
    implements _$$UpdateResultModelImplCopyWith<$Res> {
  __$$UpdateResultModelImplCopyWithImpl(_$UpdateResultModelImpl _value,
      $Res Function(_$UpdateResultModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? table = null,
    Object? column = null,
    Object? columnType = null,
    Object? rowsAffected = freezed,
    Object? updateType = null,
    Object? error = freezed,
  }) {
    return _then(_$UpdateResultModelImpl(
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String,
      column: null == column
          ? _value.column
          : column // ignore: cast_nullable_to_non_nullable
              as String,
      columnType: null == columnType
          ? _value.columnType
          : columnType // ignore: cast_nullable_to_non_nullable
              as String,
      rowsAffected: freezed == rowsAffected
          ? _value.rowsAffected
          : rowsAffected // ignore: cast_nullable_to_non_nullable
              as int?,
      updateType: null == updateType
          ? _value.updateType
          : updateType // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateResultModelImpl implements _UpdateResultModel {
  const _$UpdateResultModelImpl(
      {required this.table,
      required this.column,
      @JsonKey(name: 'column_type') required this.columnType,
      @JsonKey(name: 'rows_affected') this.rowsAffected,
      @JsonKey(name: 'update_type') required this.updateType,
      this.error});

  factory _$UpdateResultModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateResultModelImplFromJson(json);

  @override
  final String table;
  @override
  final String column;
  @override
  @JsonKey(name: 'column_type')
  final String columnType;
  @override
  @JsonKey(name: 'rows_affected')
  final int? rowsAffected;
  @override
  @JsonKey(name: 'update_type')
  final String updateType;
  @override
  final String? error;

  @override
  String toString() {
    return 'UpdateResultModel(table: $table, column: $column, columnType: $columnType, rowsAffected: $rowsAffected, updateType: $updateType, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateResultModelImpl &&
            (identical(other.table, table) || other.table == table) &&
            (identical(other.column, column) || other.column == column) &&
            (identical(other.columnType, columnType) ||
                other.columnType == columnType) &&
            (identical(other.rowsAffected, rowsAffected) ||
                other.rowsAffected == rowsAffected) &&
            (identical(other.updateType, updateType) ||
                other.updateType == updateType) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, table, column, columnType, rowsAffected, updateType, error);

  /// Create a copy of UpdateResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateResultModelImplCopyWith<_$UpdateResultModelImpl> get copyWith =>
      __$$UpdateResultModelImplCopyWithImpl<_$UpdateResultModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateResultModelImplToJson(
      this,
    );
  }
}

abstract class _UpdateResultModel implements UpdateResultModel {
  const factory _UpdateResultModel(
      {required final String table,
      required final String column,
      @JsonKey(name: 'column_type') required final String columnType,
      @JsonKey(name: 'rows_affected') final int? rowsAffected,
      @JsonKey(name: 'update_type') required final String updateType,
      final String? error}) = _$UpdateResultModelImpl;

  factory _UpdateResultModel.fromJson(Map<String, dynamic> json) =
      _$UpdateResultModelImpl.fromJson;

  @override
  String get table;
  @override
  String get column;
  @override
  @JsonKey(name: 'column_type')
  String get columnType;
  @override
  @JsonKey(name: 'rows_affected')
  int? get rowsAffected;
  @override
  @JsonKey(name: 'update_type')
  String get updateType;
  @override
  String? get error;

  /// Create a copy of UpdateResultModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateResultModelImplCopyWith<_$UpdateResultModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PartyUpdateResponseModel _$PartyUpdateResponseModelFromJson(
    Map<String, dynamic> json) {
  return _PartyUpdateResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PartyUpdateResponseModel {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  PartyModel get party => throw _privateConstructorUsedError;
  @JsonKey(name: 'party_table_updates')
  PartyTableUpdatesModel? get partyTableUpdates =>
      throw _privateConstructorUsedError;
  Map<String, ChangeDetailModel>? get changes =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'modified_at')
  String? get modifiedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'modified_by')
  String? get modifiedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'search_summary')
  SearchSummaryModel? get searchSummary => throw _privateConstructorUsedError;
  List<UpdateResultModel>? get updates => throw _privateConstructorUsedError;

  /// Serializes this PartyUpdateResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartyUpdateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartyUpdateResponseModelCopyWith<PartyUpdateResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartyUpdateResponseModelCopyWith<$Res> {
  factory $PartyUpdateResponseModelCopyWith(PartyUpdateResponseModel value,
          $Res Function(PartyUpdateResponseModel) then) =
      _$PartyUpdateResponseModelCopyWithImpl<$Res, PartyUpdateResponseModel>;
  @useResult
  $Res call(
      {bool success,
      String message,
      PartyModel party,
      @JsonKey(name: 'party_table_updates')
      PartyTableUpdatesModel? partyTableUpdates,
      Map<String, ChangeDetailModel>? changes,
      @JsonKey(name: 'modified_at') String? modifiedAt,
      @JsonKey(name: 'modified_by') String? modifiedBy,
      @JsonKey(name: 'search_summary') SearchSummaryModel? searchSummary,
      List<UpdateResultModel>? updates});

  $PartyTableUpdatesModelCopyWith<$Res>? get partyTableUpdates;
  $SearchSummaryModelCopyWith<$Res>? get searchSummary;
}

/// @nodoc
class _$PartyUpdateResponseModelCopyWithImpl<$Res,
        $Val extends PartyUpdateResponseModel>
    implements $PartyUpdateResponseModelCopyWith<$Res> {
  _$PartyUpdateResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartyUpdateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? party = null,
    Object? partyTableUpdates = freezed,
    Object? changes = freezed,
    Object? modifiedAt = freezed,
    Object? modifiedBy = freezed,
    Object? searchSummary = freezed,
    Object? updates = freezed,
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
      party: null == party
          ? _value.party
          : party // ignore: cast_nullable_to_non_nullable
              as PartyModel,
      partyTableUpdates: freezed == partyTableUpdates
          ? _value.partyTableUpdates
          : partyTableUpdates // ignore: cast_nullable_to_non_nullable
              as PartyTableUpdatesModel?,
      changes: freezed == changes
          ? _value.changes
          : changes // ignore: cast_nullable_to_non_nullable
              as Map<String, ChangeDetailModel>?,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedBy: freezed == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      searchSummary: freezed == searchSummary
          ? _value.searchSummary
          : searchSummary // ignore: cast_nullable_to_non_nullable
              as SearchSummaryModel?,
      updates: freezed == updates
          ? _value.updates
          : updates // ignore: cast_nullable_to_non_nullable
              as List<UpdateResultModel>?,
    ) as $Val);
  }

  /// Create a copy of PartyUpdateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PartyTableUpdatesModelCopyWith<$Res>? get partyTableUpdates {
    if (_value.partyTableUpdates == null) {
      return null;
    }

    return $PartyTableUpdatesModelCopyWith<$Res>(_value.partyTableUpdates!,
        (value) {
      return _then(_value.copyWith(partyTableUpdates: value) as $Val);
    });
  }

  /// Create a copy of PartyUpdateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SearchSummaryModelCopyWith<$Res>? get searchSummary {
    if (_value.searchSummary == null) {
      return null;
    }

    return $SearchSummaryModelCopyWith<$Res>(_value.searchSummary!, (value) {
      return _then(_value.copyWith(searchSummary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PartyUpdateResponseModelImplCopyWith<$Res>
    implements $PartyUpdateResponseModelCopyWith<$Res> {
  factory _$$PartyUpdateResponseModelImplCopyWith(
          _$PartyUpdateResponseModelImpl value,
          $Res Function(_$PartyUpdateResponseModelImpl) then) =
      __$$PartyUpdateResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String message,
      PartyModel party,
      @JsonKey(name: 'party_table_updates')
      PartyTableUpdatesModel? partyTableUpdates,
      Map<String, ChangeDetailModel>? changes,
      @JsonKey(name: 'modified_at') String? modifiedAt,
      @JsonKey(name: 'modified_by') String? modifiedBy,
      @JsonKey(name: 'search_summary') SearchSummaryModel? searchSummary,
      List<UpdateResultModel>? updates});

  @override
  $PartyTableUpdatesModelCopyWith<$Res>? get partyTableUpdates;
  @override
  $SearchSummaryModelCopyWith<$Res>? get searchSummary;
}

/// @nodoc
class __$$PartyUpdateResponseModelImplCopyWithImpl<$Res>
    extends _$PartyUpdateResponseModelCopyWithImpl<$Res,
        _$PartyUpdateResponseModelImpl>
    implements _$$PartyUpdateResponseModelImplCopyWith<$Res> {
  __$$PartyUpdateResponseModelImplCopyWithImpl(
      _$PartyUpdateResponseModelImpl _value,
      $Res Function(_$PartyUpdateResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartyUpdateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? party = null,
    Object? partyTableUpdates = freezed,
    Object? changes = freezed,
    Object? modifiedAt = freezed,
    Object? modifiedBy = freezed,
    Object? searchSummary = freezed,
    Object? updates = freezed,
  }) {
    return _then(_$PartyUpdateResponseModelImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      party: null == party
          ? _value.party
          : party // ignore: cast_nullable_to_non_nullable
              as PartyModel,
      partyTableUpdates: freezed == partyTableUpdates
          ? _value.partyTableUpdates
          : partyTableUpdates // ignore: cast_nullable_to_non_nullable
              as PartyTableUpdatesModel?,
      changes: freezed == changes
          ? _value._changes
          : changes // ignore: cast_nullable_to_non_nullable
              as Map<String, ChangeDetailModel>?,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedBy: freezed == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      searchSummary: freezed == searchSummary
          ? _value.searchSummary
          : searchSummary // ignore: cast_nullable_to_non_nullable
              as SearchSummaryModel?,
      updates: freezed == updates
          ? _value._updates
          : updates // ignore: cast_nullable_to_non_nullable
              as List<UpdateResultModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartyUpdateResponseModelImpl implements _PartyUpdateResponseModel {
  const _$PartyUpdateResponseModelImpl(
      {required this.success,
      required this.message,
      required this.party,
      @JsonKey(name: 'party_table_updates') this.partyTableUpdates,
      final Map<String, ChangeDetailModel>? changes,
      @JsonKey(name: 'modified_at') this.modifiedAt,
      @JsonKey(name: 'modified_by') this.modifiedBy,
      @JsonKey(name: 'search_summary') this.searchSummary,
      final List<UpdateResultModel>? updates})
      : _changes = changes,
        _updates = updates;

  factory _$PartyUpdateResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartyUpdateResponseModelImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final PartyModel party;
  @override
  @JsonKey(name: 'party_table_updates')
  final PartyTableUpdatesModel? partyTableUpdates;
  final Map<String, ChangeDetailModel>? _changes;
  @override
  Map<String, ChangeDetailModel>? get changes {
    final value = _changes;
    if (value == null) return null;
    if (_changes is EqualUnmodifiableMapView) return _changes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'modified_at')
  final String? modifiedAt;
  @override
  @JsonKey(name: 'modified_by')
  final String? modifiedBy;
  @override
  @JsonKey(name: 'search_summary')
  final SearchSummaryModel? searchSummary;
  final List<UpdateResultModel>? _updates;
  @override
  List<UpdateResultModel>? get updates {
    final value = _updates;
    if (value == null) return null;
    if (_updates is EqualUnmodifiableListView) return _updates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PartyUpdateResponseModel(success: $success, message: $message, party: $party, partyTableUpdates: $partyTableUpdates, changes: $changes, modifiedAt: $modifiedAt, modifiedBy: $modifiedBy, searchSummary: $searchSummary, updates: $updates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartyUpdateResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.party, party) || other.party == party) &&
            (identical(other.partyTableUpdates, partyTableUpdates) ||
                other.partyTableUpdates == partyTableUpdates) &&
            const DeepCollectionEquality().equals(other._changes, _changes) &&
            (identical(other.modifiedAt, modifiedAt) ||
                other.modifiedAt == modifiedAt) &&
            (identical(other.modifiedBy, modifiedBy) ||
                other.modifiedBy == modifiedBy) &&
            (identical(other.searchSummary, searchSummary) ||
                other.searchSummary == searchSummary) &&
            const DeepCollectionEquality().equals(other._updates, _updates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      message,
      party,
      partyTableUpdates,
      const DeepCollectionEquality().hash(_changes),
      modifiedAt,
      modifiedBy,
      searchSummary,
      const DeepCollectionEquality().hash(_updates));

  /// Create a copy of PartyUpdateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartyUpdateResponseModelImplCopyWith<_$PartyUpdateResponseModelImpl>
      get copyWith => __$$PartyUpdateResponseModelImplCopyWithImpl<
          _$PartyUpdateResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartyUpdateResponseModelImplToJson(
      this,
    );
  }
}

abstract class _PartyUpdateResponseModel implements PartyUpdateResponseModel {
  const factory _PartyUpdateResponseModel(
      {required final bool success,
      required final String message,
      required final PartyModel party,
      @JsonKey(name: 'party_table_updates')
      final PartyTableUpdatesModel? partyTableUpdates,
      final Map<String, ChangeDetailModel>? changes,
      @JsonKey(name: 'modified_at') final String? modifiedAt,
      @JsonKey(name: 'modified_by') final String? modifiedBy,
      @JsonKey(name: 'search_summary') final SearchSummaryModel? searchSummary,
      final List<UpdateResultModel>? updates}) = _$PartyUpdateResponseModelImpl;

  factory _PartyUpdateResponseModel.fromJson(Map<String, dynamic> json) =
      _$PartyUpdateResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  PartyModel get party;
  @override
  @JsonKey(name: 'party_table_updates')
  PartyTableUpdatesModel? get partyTableUpdates;
  @override
  Map<String, ChangeDetailModel>? get changes;
  @override
  @JsonKey(name: 'modified_at')
  String? get modifiedAt;
  @override
  @JsonKey(name: 'modified_by')
  String? get modifiedBy;
  @override
  @JsonKey(name: 'search_summary')
  SearchSummaryModel? get searchSummary;
  @override
  List<UpdateResultModel>? get updates;

  /// Create a copy of PartyUpdateResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartyUpdateResponseModelImplCopyWith<_$PartyUpdateResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

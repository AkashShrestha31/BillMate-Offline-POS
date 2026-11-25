// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'party_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartyResponseModel _$PartyResponseModelFromJson(Map<String, dynamic> json) {
  return _PartyResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PartyResponseModel {
  List<PartyItem>? get data => throw _privateConstructorUsedError;
  Pagination get pagination => throw _privateConstructorUsedError;

  /// Serializes this PartyResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartyResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartyResponseModelCopyWith<PartyResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartyResponseModelCopyWith<$Res> {
  factory $PartyResponseModelCopyWith(
          PartyResponseModel value, $Res Function(PartyResponseModel) then) =
      _$PartyResponseModelCopyWithImpl<$Res, PartyResponseModel>;
  @useResult
  $Res call({List<PartyItem>? data, Pagination pagination});

  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class _$PartyResponseModelCopyWithImpl<$Res, $Val extends PartyResponseModel>
    implements $PartyResponseModelCopyWith<$Res> {
  _$PartyResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartyResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? pagination = null,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PartyItem>?,
      pagination: null == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Pagination,
    ) as $Val);
  }

  /// Create a copy of PartyResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationCopyWith<$Res> get pagination {
    return $PaginationCopyWith<$Res>(_value.pagination, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PartyResponseModelImplCopyWith<$Res>
    implements $PartyResponseModelCopyWith<$Res> {
  factory _$$PartyResponseModelImplCopyWith(_$PartyResponseModelImpl value,
          $Res Function(_$PartyResponseModelImpl) then) =
      __$$PartyResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<PartyItem>? data, Pagination pagination});

  @override
  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$PartyResponseModelImplCopyWithImpl<$Res>
    extends _$PartyResponseModelCopyWithImpl<$Res, _$PartyResponseModelImpl>
    implements _$$PartyResponseModelImplCopyWith<$Res> {
  __$$PartyResponseModelImplCopyWithImpl(_$PartyResponseModelImpl _value,
      $Res Function(_$PartyResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartyResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? pagination = null,
  }) {
    return _then(_$PartyResponseModelImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PartyItem>?,
      pagination: null == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Pagination,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartyResponseModelImpl implements _PartyResponseModel {
  const _$PartyResponseModelImpl(
      {required final List<PartyItem>? data, required this.pagination})
      : _data = data;

  factory _$PartyResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartyResponseModelImplFromJson(json);

  final List<PartyItem>? _data;
  @override
  List<PartyItem>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Pagination pagination;

  @override
  String toString() {
    return 'PartyResponseModel(data: $data, pagination: $pagination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartyResponseModelImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), pagination);

  /// Create a copy of PartyResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartyResponseModelImplCopyWith<_$PartyResponseModelImpl> get copyWith =>
      __$$PartyResponseModelImplCopyWithImpl<_$PartyResponseModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartyResponseModelImplToJson(
      this,
    );
  }
}

abstract class _PartyResponseModel implements PartyResponseModel {
  const factory _PartyResponseModel(
      {required final List<PartyItem>? data,
      required final Pagination pagination}) = _$PartyResponseModelImpl;

  factory _PartyResponseModel.fromJson(Map<String, dynamic> json) =
      _$PartyResponseModelImpl.fromJson;

  @override
  List<PartyItem>? get data;
  @override
  Pagination get pagination;

  /// Create a copy of PartyResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartyResponseModelImplCopyWith<_$PartyResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PartyItem _$PartyItemFromJson(Map<String, dynamic> json) {
  return _PartyItem.fromJson(json);
}

/// @nodoc
mixin _$PartyItem {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'outstandingAmount', fromJson: _stringToDouble)
  double? get outstandingAmount => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'employeeDetails',
      fromJson: _partyItemEmployeeDetailsFromJson,
      includeToJson: false)
  PartyItemEmployeeDetails? get employeeDetails =>
      throw _privateConstructorUsedError;

  /// Serializes this PartyItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartyItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartyItemCopyWith<PartyItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartyItemCopyWith<$Res> {
  factory $PartyItemCopyWith(PartyItem value, $Res Function(PartyItem) then) =
      _$PartyItemCopyWithImpl<$Res, PartyItem>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? phone,
      @JsonKey(name: 'outstandingAmount', fromJson: _stringToDouble)
      double? outstandingAmount,
      String? role,
      String? currency,
      @JsonKey(
          name: 'employeeDetails',
          fromJson: _partyItemEmployeeDetailsFromJson,
          includeToJson: false)
      PartyItemEmployeeDetails? employeeDetails});
}

/// @nodoc
class _$PartyItemCopyWithImpl<$Res, $Val extends PartyItem>
    implements $PartyItemCopyWith<$Res> {
  _$PartyItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartyItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phone = freezed,
    Object? outstandingAmount = freezed,
    Object? role = freezed,
    Object? currency = freezed,
    Object? employeeDetails = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      outstandingAmount: freezed == outstandingAmount
          ? _value.outstandingAmount
          : outstandingAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      employeeDetails: freezed == employeeDetails
          ? _value.employeeDetails
          : employeeDetails // ignore: cast_nullable_to_non_nullable
              as PartyItemEmployeeDetails?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartyItemImplCopyWith<$Res>
    implements $PartyItemCopyWith<$Res> {
  factory _$$PartyItemImplCopyWith(
          _$PartyItemImpl value, $Res Function(_$PartyItemImpl) then) =
      __$$PartyItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? phone,
      @JsonKey(name: 'outstandingAmount', fromJson: _stringToDouble)
      double? outstandingAmount,
      String? role,
      String? currency,
      @JsonKey(
          name: 'employeeDetails',
          fromJson: _partyItemEmployeeDetailsFromJson,
          includeToJson: false)
      PartyItemEmployeeDetails? employeeDetails});
}

/// @nodoc
class __$$PartyItemImplCopyWithImpl<$Res>
    extends _$PartyItemCopyWithImpl<$Res, _$PartyItemImpl>
    implements _$$PartyItemImplCopyWith<$Res> {
  __$$PartyItemImplCopyWithImpl(
      _$PartyItemImpl _value, $Res Function(_$PartyItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartyItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phone = freezed,
    Object? outstandingAmount = freezed,
    Object? role = freezed,
    Object? currency = freezed,
    Object? employeeDetails = freezed,
  }) {
    return _then(_$PartyItemImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      outstandingAmount: freezed == outstandingAmount
          ? _value.outstandingAmount
          : outstandingAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      employeeDetails: freezed == employeeDetails
          ? _value.employeeDetails
          : employeeDetails // ignore: cast_nullable_to_non_nullable
              as PartyItemEmployeeDetails?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartyItemImpl implements _PartyItem {
  const _$PartyItemImpl(
      {this.id,
      required this.name,
      this.phone,
      @JsonKey(name: 'outstandingAmount', fromJson: _stringToDouble)
      required this.outstandingAmount,
      required this.role,
      this.currency,
      @JsonKey(
          name: 'employeeDetails',
          fromJson: _partyItemEmployeeDetailsFromJson,
          includeToJson: false)
      this.employeeDetails});

  factory _$PartyItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartyItemImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? phone;
  @override
  @JsonKey(name: 'outstandingAmount', fromJson: _stringToDouble)
  final double? outstandingAmount;
  @override
  final String? role;
  @override
  final String? currency;
  @override
  @JsonKey(
      name: 'employeeDetails',
      fromJson: _partyItemEmployeeDetailsFromJson,
      includeToJson: false)
  final PartyItemEmployeeDetails? employeeDetails;

  @override
  String toString() {
    return 'PartyItem(id: $id, name: $name, phone: $phone, outstandingAmount: $outstandingAmount, role: $role, currency: $currency, employeeDetails: $employeeDetails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartyItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.outstandingAmount, outstandingAmount) ||
                other.outstandingAmount == outstandingAmount) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.employeeDetails, employeeDetails) ||
                other.employeeDetails == employeeDetails));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone,
      outstandingAmount, role, currency, employeeDetails);

  /// Create a copy of PartyItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartyItemImplCopyWith<_$PartyItemImpl> get copyWith =>
      __$$PartyItemImplCopyWithImpl<_$PartyItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartyItemImplToJson(
      this,
    );
  }
}

abstract class _PartyItem implements PartyItem {
  const factory _PartyItem(
      {final int? id,
      required final String? name,
      final String? phone,
      @JsonKey(name: 'outstandingAmount', fromJson: _stringToDouble)
      required final double? outstandingAmount,
      required final String? role,
      final String? currency,
      @JsonKey(
          name: 'employeeDetails',
          fromJson: _partyItemEmployeeDetailsFromJson,
          includeToJson: false)
      final PartyItemEmployeeDetails? employeeDetails}) = _$PartyItemImpl;

  factory _PartyItem.fromJson(Map<String, dynamic> json) =
      _$PartyItemImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get phone;
  @override
  @JsonKey(name: 'outstandingAmount', fromJson: _stringToDouble)
  double? get outstandingAmount;
  @override
  String? get role;
  @override
  String? get currency;
  @override
  @JsonKey(
      name: 'employeeDetails',
      fromJson: _partyItemEmployeeDetailsFromJson,
      includeToJson: false)
  PartyItemEmployeeDetails? get employeeDetails;

  /// Create a copy of PartyItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartyItemImplCopyWith<_$PartyItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Pagination _$PaginationFromJson(Map<String, dynamic> json) {
  return _Pagination.fromJson(json);
}

/// @nodoc
mixin _$Pagination {
  int? get current_page => throw _privateConstructorUsedError;
  int? get per_page => throw _privateConstructorUsedError;
  int? get total_pages => throw _privateConstructorUsedError;
  int? get total_rows => throw _privateConstructorUsedError;

  /// Serializes this Pagination to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginationCopyWith<Pagination> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationCopyWith<$Res> {
  factory $PaginationCopyWith(
          Pagination value, $Res Function(Pagination) then) =
      _$PaginationCopyWithImpl<$Res, Pagination>;
  @useResult
  $Res call(
      {int? current_page, int? per_page, int? total_pages, int? total_rows});
}

/// @nodoc
class _$PaginationCopyWithImpl<$Res, $Val extends Pagination>
    implements $PaginationCopyWith<$Res> {
  _$PaginationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? current_page = freezed,
    Object? per_page = freezed,
    Object? total_pages = freezed,
    Object? total_rows = freezed,
  }) {
    return _then(_value.copyWith(
      current_page: freezed == current_page
          ? _value.current_page
          : current_page // ignore: cast_nullable_to_non_nullable
              as int?,
      per_page: freezed == per_page
          ? _value.per_page
          : per_page // ignore: cast_nullable_to_non_nullable
              as int?,
      total_pages: freezed == total_pages
          ? _value.total_pages
          : total_pages // ignore: cast_nullable_to_non_nullable
              as int?,
      total_rows: freezed == total_rows
          ? _value.total_rows
          : total_rows // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaginationImplCopyWith<$Res>
    implements $PaginationCopyWith<$Res> {
  factory _$$PaginationImplCopyWith(
          _$PaginationImpl value, $Res Function(_$PaginationImpl) then) =
      __$$PaginationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? current_page, int? per_page, int? total_pages, int? total_rows});
}

/// @nodoc
class __$$PaginationImplCopyWithImpl<$Res>
    extends _$PaginationCopyWithImpl<$Res, _$PaginationImpl>
    implements _$$PaginationImplCopyWith<$Res> {
  __$$PaginationImplCopyWithImpl(
      _$PaginationImpl _value, $Res Function(_$PaginationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? current_page = freezed,
    Object? per_page = freezed,
    Object? total_pages = freezed,
    Object? total_rows = freezed,
  }) {
    return _then(_$PaginationImpl(
      current_page: freezed == current_page
          ? _value.current_page
          : current_page // ignore: cast_nullable_to_non_nullable
              as int?,
      per_page: freezed == per_page
          ? _value.per_page
          : per_page // ignore: cast_nullable_to_non_nullable
              as int?,
      total_pages: freezed == total_pages
          ? _value.total_pages
          : total_pages // ignore: cast_nullable_to_non_nullable
              as int?,
      total_rows: freezed == total_rows
          ? _value.total_rows
          : total_rows // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginationImpl implements _Pagination {
  const _$PaginationImpl(
      {required this.current_page,
      required this.per_page,
      required this.total_pages,
      required this.total_rows});

  factory _$PaginationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginationImplFromJson(json);

  @override
  final int? current_page;
  @override
  final int? per_page;
  @override
  final int? total_pages;
  @override
  final int? total_rows;

  @override
  String toString() {
    return 'Pagination(current_page: $current_page, per_page: $per_page, total_pages: $total_pages, total_rows: $total_rows)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationImpl &&
            (identical(other.current_page, current_page) ||
                other.current_page == current_page) &&
            (identical(other.per_page, per_page) ||
                other.per_page == per_page) &&
            (identical(other.total_pages, total_pages) ||
                other.total_pages == total_pages) &&
            (identical(other.total_rows, total_rows) ||
                other.total_rows == total_rows));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, current_page, per_page, total_pages, total_rows);

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationImplCopyWith<_$PaginationImpl> get copyWith =>
      __$$PaginationImplCopyWithImpl<_$PaginationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginationImplToJson(
      this,
    );
  }
}

abstract class _Pagination implements Pagination {
  const factory _Pagination(
      {required final int? current_page,
      required final int? per_page,
      required final int? total_pages,
      required final int? total_rows}) = _$PaginationImpl;

  factory _Pagination.fromJson(Map<String, dynamic> json) =
      _$PaginationImpl.fromJson;

  @override
  int? get current_page;
  @override
  int? get per_page;
  @override
  int? get total_pages;
  @override
  int? get total_rows;

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginationImplCopyWith<_$PaginationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

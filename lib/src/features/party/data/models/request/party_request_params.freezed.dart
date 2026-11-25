// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'party_request_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartyRequestParams _$PartyRequestParamsFromJson(Map<String, dynamic> json) {
  return _PartyRequestParams.fromJson(json);
}

/// @nodoc
mixin _$PartyRequestParams {
  int? get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_size')
  int? get pageSize => throw _privateConstructorUsedError;
  String? get search => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;

  /// Active filter for list API, e.g. `1` with [role] `employee`.
  int? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_outstanding')
  bool? get hasOutstanding => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  String? get loyaltyProgram => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_by')
  String? get sortBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  String? get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'exclude_zero_transactions')
  bool? get excludeZeroTransactions => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this PartyRequestParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartyRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartyRequestParamsCopyWith<PartyRequestParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartyRequestParamsCopyWith<$Res> {
  factory $PartyRequestParamsCopyWith(
          PartyRequestParams value, $Res Function(PartyRequestParams) then) =
      _$PartyRequestParamsCopyWithImpl<$Res, PartyRequestParams>;
  @useResult
  $Res call(
      {int? page,
      @JsonKey(name: 'page_size') int? pageSize,
      String? search,
      String? role,
      int? status,
      @JsonKey(name: 'has_outstanding') bool? hasOutstanding,
      String? currency,
      String? loyaltyProgram,
      @JsonKey(name: 'sort_by') String? sortBy,
      @JsonKey(name: 'sort_order') String? sortOrder,
      @JsonKey(name: 'exclude_zero_transactions') bool? excludeZeroTransactions,
      String? name});
}

/// @nodoc
class _$PartyRequestParamsCopyWithImpl<$Res, $Val extends PartyRequestParams>
    implements $PartyRequestParamsCopyWith<$Res> {
  _$PartyRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartyRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? pageSize = freezed,
    Object? search = freezed,
    Object? role = freezed,
    Object? status = freezed,
    Object? hasOutstanding = freezed,
    Object? currency = freezed,
    Object? loyaltyProgram = freezed,
    Object? sortBy = freezed,
    Object? sortOrder = freezed,
    Object? excludeZeroTransactions = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int?,
      search: freezed == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      hasOutstanding: freezed == hasOutstanding
          ? _value.hasOutstanding
          : hasOutstanding // ignore: cast_nullable_to_non_nullable
              as bool?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      loyaltyProgram: freezed == loyaltyProgram
          ? _value.loyaltyProgram
          : loyaltyProgram // ignore: cast_nullable_to_non_nullable
              as String?,
      sortBy: freezed == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String?,
      sortOrder: freezed == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as String?,
      excludeZeroTransactions: freezed == excludeZeroTransactions
          ? _value.excludeZeroTransactions
          : excludeZeroTransactions // ignore: cast_nullable_to_non_nullable
              as bool?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartyRequestParamsImplCopyWith<$Res>
    implements $PartyRequestParamsCopyWith<$Res> {
  factory _$$PartyRequestParamsImplCopyWith(_$PartyRequestParamsImpl value,
          $Res Function(_$PartyRequestParamsImpl) then) =
      __$$PartyRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? page,
      @JsonKey(name: 'page_size') int? pageSize,
      String? search,
      String? role,
      int? status,
      @JsonKey(name: 'has_outstanding') bool? hasOutstanding,
      String? currency,
      String? loyaltyProgram,
      @JsonKey(name: 'sort_by') String? sortBy,
      @JsonKey(name: 'sort_order') String? sortOrder,
      @JsonKey(name: 'exclude_zero_transactions') bool? excludeZeroTransactions,
      String? name});
}

/// @nodoc
class __$$PartyRequestParamsImplCopyWithImpl<$Res>
    extends _$PartyRequestParamsCopyWithImpl<$Res, _$PartyRequestParamsImpl>
    implements _$$PartyRequestParamsImplCopyWith<$Res> {
  __$$PartyRequestParamsImplCopyWithImpl(_$PartyRequestParamsImpl _value,
      $Res Function(_$PartyRequestParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartyRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? pageSize = freezed,
    Object? search = freezed,
    Object? role = freezed,
    Object? status = freezed,
    Object? hasOutstanding = freezed,
    Object? currency = freezed,
    Object? loyaltyProgram = freezed,
    Object? sortBy = freezed,
    Object? sortOrder = freezed,
    Object? excludeZeroTransactions = freezed,
    Object? name = freezed,
  }) {
    return _then(_$PartyRequestParamsImpl(
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int?,
      search: freezed == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      hasOutstanding: freezed == hasOutstanding
          ? _value.hasOutstanding
          : hasOutstanding // ignore: cast_nullable_to_non_nullable
              as bool?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      loyaltyProgram: freezed == loyaltyProgram
          ? _value.loyaltyProgram
          : loyaltyProgram // ignore: cast_nullable_to_non_nullable
              as String?,
      sortBy: freezed == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String?,
      sortOrder: freezed == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as String?,
      excludeZeroTransactions: freezed == excludeZeroTransactions
          ? _value.excludeZeroTransactions
          : excludeZeroTransactions // ignore: cast_nullable_to_non_nullable
              as bool?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartyRequestParamsImpl implements _PartyRequestParams {
  const _$PartyRequestParamsImpl(
      {this.page,
      @JsonKey(name: 'page_size') this.pageSize,
      this.search,
      this.role,
      this.status,
      @JsonKey(name: 'has_outstanding') this.hasOutstanding,
      this.currency,
      this.loyaltyProgram,
      @JsonKey(name: 'sort_by') this.sortBy,
      @JsonKey(name: 'sort_order') this.sortOrder,
      @JsonKey(name: 'exclude_zero_transactions') this.excludeZeroTransactions,
      this.name});

  factory _$PartyRequestParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartyRequestParamsImplFromJson(json);

  @override
  final int? page;
  @override
  @JsonKey(name: 'page_size')
  final int? pageSize;
  @override
  final String? search;
  @override
  final String? role;

  /// Active filter for list API, e.g. `1` with [role] `employee`.
  @override
  final int? status;
  @override
  @JsonKey(name: 'has_outstanding')
  final bool? hasOutstanding;
  @override
  final String? currency;
  @override
  final String? loyaltyProgram;
  @override
  @JsonKey(name: 'sort_by')
  final String? sortBy;
  @override
  @JsonKey(name: 'sort_order')
  final String? sortOrder;
  @override
  @JsonKey(name: 'exclude_zero_transactions')
  final bool? excludeZeroTransactions;
  @override
  final String? name;

  @override
  String toString() {
    return 'PartyRequestParams(page: $page, pageSize: $pageSize, search: $search, role: $role, status: $status, hasOutstanding: $hasOutstanding, currency: $currency, loyaltyProgram: $loyaltyProgram, sortBy: $sortBy, sortOrder: $sortOrder, excludeZeroTransactions: $excludeZeroTransactions, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartyRequestParamsImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.search, search) || other.search == search) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.hasOutstanding, hasOutstanding) ||
                other.hasOutstanding == hasOutstanding) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.loyaltyProgram, loyaltyProgram) ||
                other.loyaltyProgram == loyaltyProgram) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(
                    other.excludeZeroTransactions, excludeZeroTransactions) ||
                other.excludeZeroTransactions == excludeZeroTransactions) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      page,
      pageSize,
      search,
      role,
      status,
      hasOutstanding,
      currency,
      loyaltyProgram,
      sortBy,
      sortOrder,
      excludeZeroTransactions,
      name);

  /// Create a copy of PartyRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartyRequestParamsImplCopyWith<_$PartyRequestParamsImpl> get copyWith =>
      __$$PartyRequestParamsImplCopyWithImpl<_$PartyRequestParamsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartyRequestParamsImplToJson(
      this,
    );
  }
}

abstract class _PartyRequestParams implements PartyRequestParams {
  const factory _PartyRequestParams(
      {final int? page,
      @JsonKey(name: 'page_size') final int? pageSize,
      final String? search,
      final String? role,
      final int? status,
      @JsonKey(name: 'has_outstanding') final bool? hasOutstanding,
      final String? currency,
      final String? loyaltyProgram,
      @JsonKey(name: 'sort_by') final String? sortBy,
      @JsonKey(name: 'sort_order') final String? sortOrder,
      @JsonKey(name: 'exclude_zero_transactions')
      final bool? excludeZeroTransactions,
      final String? name}) = _$PartyRequestParamsImpl;

  factory _PartyRequestParams.fromJson(Map<String, dynamic> json) =
      _$PartyRequestParamsImpl.fromJson;

  @override
  int? get page;
  @override
  @JsonKey(name: 'page_size')
  int? get pageSize;
  @override
  String? get search;
  @override
  String? get role;

  /// Active filter for list API, e.g. `1` with [role] `employee`.
  @override
  int? get status;
  @override
  @JsonKey(name: 'has_outstanding')
  bool? get hasOutstanding;
  @override
  String? get currency;
  @override
  String? get loyaltyProgram;
  @override
  @JsonKey(name: 'sort_by')
  String? get sortBy;
  @override
  @JsonKey(name: 'sort_order')
  String? get sortOrder;
  @override
  @JsonKey(name: 'exclude_zero_transactions')
  bool? get excludeZeroTransactions;
  @override
  String? get name;

  /// Create a copy of PartyRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartyRequestParamsImplCopyWith<_$PartyRequestParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_outstanding_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmployeeOutstandingResponse _$EmployeeOutstandingResponseFromJson(
    Map<String, dynamic> json) {
  return _EmployeeOutstandingResponse.fromJson(json);
}

/// @nodoc
mixin _$EmployeeOutstandingResponse {
  @JsonKey(name: 'search_details')
  SearchDetails get searchDetails => throw _privateConstructorUsedError;
  @JsonKey(name: 'role_summary')
  RoleSummary get roleSummary => throw _privateConstructorUsedError;
  @JsonKey(name: 'outstanding_by_role')
  OutstandingByRole get outstandingByRole => throw _privateConstructorUsedError;
  @JsonKey(name: 'parties_by_role')
  PartiesByRole get partiesByRole => throw _privateConstructorUsedError;

  /// Serializes this EmployeeOutstandingResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmployeeOutstandingResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmployeeOutstandingResponseCopyWith<EmployeeOutstandingResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeOutstandingResponseCopyWith<$Res> {
  factory $EmployeeOutstandingResponseCopyWith(
          EmployeeOutstandingResponse value,
          $Res Function(EmployeeOutstandingResponse) then) =
      _$EmployeeOutstandingResponseCopyWithImpl<$Res,
          EmployeeOutstandingResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'search_details') SearchDetails searchDetails,
      @JsonKey(name: 'role_summary') RoleSummary roleSummary,
      @JsonKey(name: 'outstanding_by_role') OutstandingByRole outstandingByRole,
      @JsonKey(name: 'parties_by_role') PartiesByRole partiesByRole});

  $SearchDetailsCopyWith<$Res> get searchDetails;
  $RoleSummaryCopyWith<$Res> get roleSummary;
  $OutstandingByRoleCopyWith<$Res> get outstandingByRole;
  $PartiesByRoleCopyWith<$Res> get partiesByRole;
}

/// @nodoc
class _$EmployeeOutstandingResponseCopyWithImpl<$Res,
        $Val extends EmployeeOutstandingResponse>
    implements $EmployeeOutstandingResponseCopyWith<$Res> {
  _$EmployeeOutstandingResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmployeeOutstandingResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchDetails = null,
    Object? roleSummary = null,
    Object? outstandingByRole = null,
    Object? partiesByRole = null,
  }) {
    return _then(_value.copyWith(
      searchDetails: null == searchDetails
          ? _value.searchDetails
          : searchDetails // ignore: cast_nullable_to_non_nullable
              as SearchDetails,
      roleSummary: null == roleSummary
          ? _value.roleSummary
          : roleSummary // ignore: cast_nullable_to_non_nullable
              as RoleSummary,
      outstandingByRole: null == outstandingByRole
          ? _value.outstandingByRole
          : outstandingByRole // ignore: cast_nullable_to_non_nullable
              as OutstandingByRole,
      partiesByRole: null == partiesByRole
          ? _value.partiesByRole
          : partiesByRole // ignore: cast_nullable_to_non_nullable
              as PartiesByRole,
    ) as $Val);
  }

  /// Create a copy of EmployeeOutstandingResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SearchDetailsCopyWith<$Res> get searchDetails {
    return $SearchDetailsCopyWith<$Res>(_value.searchDetails, (value) {
      return _then(_value.copyWith(searchDetails: value) as $Val);
    });
  }

  /// Create a copy of EmployeeOutstandingResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RoleSummaryCopyWith<$Res> get roleSummary {
    return $RoleSummaryCopyWith<$Res>(_value.roleSummary, (value) {
      return _then(_value.copyWith(roleSummary: value) as $Val);
    });
  }

  /// Create a copy of EmployeeOutstandingResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OutstandingByRoleCopyWith<$Res> get outstandingByRole {
    return $OutstandingByRoleCopyWith<$Res>(_value.outstandingByRole, (value) {
      return _then(_value.copyWith(outstandingByRole: value) as $Val);
    });
  }

  /// Create a copy of EmployeeOutstandingResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PartiesByRoleCopyWith<$Res> get partiesByRole {
    return $PartiesByRoleCopyWith<$Res>(_value.partiesByRole, (value) {
      return _then(_value.copyWith(partiesByRole: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EmployeeOutstandingResponseImplCopyWith<$Res>
    implements $EmployeeOutstandingResponseCopyWith<$Res> {
  factory _$$EmployeeOutstandingResponseImplCopyWith(
          _$EmployeeOutstandingResponseImpl value,
          $Res Function(_$EmployeeOutstandingResponseImpl) then) =
      __$$EmployeeOutstandingResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'search_details') SearchDetails searchDetails,
      @JsonKey(name: 'role_summary') RoleSummary roleSummary,
      @JsonKey(name: 'outstanding_by_role') OutstandingByRole outstandingByRole,
      @JsonKey(name: 'parties_by_role') PartiesByRole partiesByRole});

  @override
  $SearchDetailsCopyWith<$Res> get searchDetails;
  @override
  $RoleSummaryCopyWith<$Res> get roleSummary;
  @override
  $OutstandingByRoleCopyWith<$Res> get outstandingByRole;
  @override
  $PartiesByRoleCopyWith<$Res> get partiesByRole;
}

/// @nodoc
class __$$EmployeeOutstandingResponseImplCopyWithImpl<$Res>
    extends _$EmployeeOutstandingResponseCopyWithImpl<$Res,
        _$EmployeeOutstandingResponseImpl>
    implements _$$EmployeeOutstandingResponseImplCopyWith<$Res> {
  __$$EmployeeOutstandingResponseImplCopyWithImpl(
      _$EmployeeOutstandingResponseImpl _value,
      $Res Function(_$EmployeeOutstandingResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmployeeOutstandingResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchDetails = null,
    Object? roleSummary = null,
    Object? outstandingByRole = null,
    Object? partiesByRole = null,
  }) {
    return _then(_$EmployeeOutstandingResponseImpl(
      searchDetails: null == searchDetails
          ? _value.searchDetails
          : searchDetails // ignore: cast_nullable_to_non_nullable
              as SearchDetails,
      roleSummary: null == roleSummary
          ? _value.roleSummary
          : roleSummary // ignore: cast_nullable_to_non_nullable
              as RoleSummary,
      outstandingByRole: null == outstandingByRole
          ? _value.outstandingByRole
          : outstandingByRole // ignore: cast_nullable_to_non_nullable
              as OutstandingByRole,
      partiesByRole: null == partiesByRole
          ? _value.partiesByRole
          : partiesByRole // ignore: cast_nullable_to_non_nullable
              as PartiesByRole,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeOutstandingResponseImpl
    implements _EmployeeOutstandingResponse {
  const _$EmployeeOutstandingResponseImpl(
      {@JsonKey(name: 'search_details') required this.searchDetails,
      @JsonKey(name: 'role_summary') required this.roleSummary,
      @JsonKey(name: 'outstanding_by_role') required this.outstandingByRole,
      @JsonKey(name: 'parties_by_role') required this.partiesByRole});

  factory _$EmployeeOutstandingResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$EmployeeOutstandingResponseImplFromJson(json);

  @override
  @JsonKey(name: 'search_details')
  final SearchDetails searchDetails;
  @override
  @JsonKey(name: 'role_summary')
  final RoleSummary roleSummary;
  @override
  @JsonKey(name: 'outstanding_by_role')
  final OutstandingByRole outstandingByRole;
  @override
  @JsonKey(name: 'parties_by_role')
  final PartiesByRole partiesByRole;

  @override
  String toString() {
    return 'EmployeeOutstandingResponse(searchDetails: $searchDetails, roleSummary: $roleSummary, outstandingByRole: $outstandingByRole, partiesByRole: $partiesByRole)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeOutstandingResponseImpl &&
            (identical(other.searchDetails, searchDetails) ||
                other.searchDetails == searchDetails) &&
            (identical(other.roleSummary, roleSummary) ||
                other.roleSummary == roleSummary) &&
            (identical(other.outstandingByRole, outstandingByRole) ||
                other.outstandingByRole == outstandingByRole) &&
            (identical(other.partiesByRole, partiesByRole) ||
                other.partiesByRole == partiesByRole));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, searchDetails, roleSummary,
      outstandingByRole, partiesByRole);

  /// Create a copy of EmployeeOutstandingResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeOutstandingResponseImplCopyWith<_$EmployeeOutstandingResponseImpl>
      get copyWith => __$$EmployeeOutstandingResponseImplCopyWithImpl<
          _$EmployeeOutstandingResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeOutstandingResponseImplToJson(
      this,
    );
  }
}

abstract class _EmployeeOutstandingResponse
    implements EmployeeOutstandingResponse {
  const factory _EmployeeOutstandingResponse(
          {@JsonKey(name: 'search_details')
          required final SearchDetails searchDetails,
          @JsonKey(name: 'role_summary') required final RoleSummary roleSummary,
          @JsonKey(name: 'outstanding_by_role')
          required final OutstandingByRole outstandingByRole,
          @JsonKey(name: 'parties_by_role')
          required final PartiesByRole partiesByRole}) =
      _$EmployeeOutstandingResponseImpl;

  factory _EmployeeOutstandingResponse.fromJson(Map<String, dynamic> json) =
      _$EmployeeOutstandingResponseImpl.fromJson;

  @override
  @JsonKey(name: 'search_details')
  SearchDetails get searchDetails;
  @override
  @JsonKey(name: 'role_summary')
  RoleSummary get roleSummary;
  @override
  @JsonKey(name: 'outstanding_by_role')
  OutstandingByRole get outstandingByRole;
  @override
  @JsonKey(name: 'parties_by_role')
  PartiesByRole get partiesByRole;

  /// Create a copy of EmployeeOutstandingResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeeOutstandingResponseImplCopyWith<_$EmployeeOutstandingResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SearchDetails _$SearchDetailsFromJson(Map<String, dynamic> json) {
  return _SearchDetails.fromJson(json);
}

/// @nodoc
mixin _$SearchDetails {
  @JsonKey(name: 'search_term')
  String get searchTerm => throw _privateConstructorUsedError;
  @JsonKey(name: 'party_role_filter')
  String get partyRoleFilter => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_found')
  int get totalFound => throw _privateConstructorUsedError;

  /// Serializes this SearchDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SearchDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchDetailsCopyWith<SearchDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchDetailsCopyWith<$Res> {
  factory $SearchDetailsCopyWith(
          SearchDetails value, $Res Function(SearchDetails) then) =
      _$SearchDetailsCopyWithImpl<$Res, SearchDetails>;
  @useResult
  $Res call(
      {@JsonKey(name: 'search_term') String searchTerm,
      @JsonKey(name: 'party_role_filter') String partyRoleFilter,
      @JsonKey(name: 'total_found') int totalFound});
}

/// @nodoc
class _$SearchDetailsCopyWithImpl<$Res, $Val extends SearchDetails>
    implements $SearchDetailsCopyWith<$Res> {
  _$SearchDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchTerm = null,
    Object? partyRoleFilter = null,
    Object? totalFound = null,
  }) {
    return _then(_value.copyWith(
      searchTerm: null == searchTerm
          ? _value.searchTerm
          : searchTerm // ignore: cast_nullable_to_non_nullable
              as String,
      partyRoleFilter: null == partyRoleFilter
          ? _value.partyRoleFilter
          : partyRoleFilter // ignore: cast_nullable_to_non_nullable
              as String,
      totalFound: null == totalFound
          ? _value.totalFound
          : totalFound // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchDetailsImplCopyWith<$Res>
    implements $SearchDetailsCopyWith<$Res> {
  factory _$$SearchDetailsImplCopyWith(
          _$SearchDetailsImpl value, $Res Function(_$SearchDetailsImpl) then) =
      __$$SearchDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'search_term') String searchTerm,
      @JsonKey(name: 'party_role_filter') String partyRoleFilter,
      @JsonKey(name: 'total_found') int totalFound});
}

/// @nodoc
class __$$SearchDetailsImplCopyWithImpl<$Res>
    extends _$SearchDetailsCopyWithImpl<$Res, _$SearchDetailsImpl>
    implements _$$SearchDetailsImplCopyWith<$Res> {
  __$$SearchDetailsImplCopyWithImpl(
      _$SearchDetailsImpl _value, $Res Function(_$SearchDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchTerm = null,
    Object? partyRoleFilter = null,
    Object? totalFound = null,
  }) {
    return _then(_$SearchDetailsImpl(
      searchTerm: null == searchTerm
          ? _value.searchTerm
          : searchTerm // ignore: cast_nullable_to_non_nullable
              as String,
      partyRoleFilter: null == partyRoleFilter
          ? _value.partyRoleFilter
          : partyRoleFilter // ignore: cast_nullable_to_non_nullable
              as String,
      totalFound: null == totalFound
          ? _value.totalFound
          : totalFound // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchDetailsImpl implements _SearchDetails {
  const _$SearchDetailsImpl(
      {@JsonKey(name: 'search_term') required this.searchTerm,
      @JsonKey(name: 'party_role_filter') required this.partyRoleFilter,
      @JsonKey(name: 'total_found') required this.totalFound});

  factory _$SearchDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchDetailsImplFromJson(json);

  @override
  @JsonKey(name: 'search_term')
  final String searchTerm;
  @override
  @JsonKey(name: 'party_role_filter')
  final String partyRoleFilter;
  @override
  @JsonKey(name: 'total_found')
  final int totalFound;

  @override
  String toString() {
    return 'SearchDetails(searchTerm: $searchTerm, partyRoleFilter: $partyRoleFilter, totalFound: $totalFound)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchDetailsImpl &&
            (identical(other.searchTerm, searchTerm) ||
                other.searchTerm == searchTerm) &&
            (identical(other.partyRoleFilter, partyRoleFilter) ||
                other.partyRoleFilter == partyRoleFilter) &&
            (identical(other.totalFound, totalFound) ||
                other.totalFound == totalFound));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, searchTerm, partyRoleFilter, totalFound);

  /// Create a copy of SearchDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchDetailsImplCopyWith<_$SearchDetailsImpl> get copyWith =>
      __$$SearchDetailsImplCopyWithImpl<_$SearchDetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchDetailsImplToJson(
      this,
    );
  }
}

abstract class _SearchDetails implements SearchDetails {
  const factory _SearchDetails(
      {@JsonKey(name: 'search_term') required final String searchTerm,
      @JsonKey(name: 'party_role_filter') required final String partyRoleFilter,
      @JsonKey(name: 'total_found')
      required final int totalFound}) = _$SearchDetailsImpl;

  factory _SearchDetails.fromJson(Map<String, dynamic> json) =
      _$SearchDetailsImpl.fromJson;

  @override
  @JsonKey(name: 'search_term')
  String get searchTerm;
  @override
  @JsonKey(name: 'party_role_filter')
  String get partyRoleFilter;
  @override
  @JsonKey(name: 'total_found')
  int get totalFound;

  /// Create a copy of SearchDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchDetailsImplCopyWith<_$SearchDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RoleSummary _$RoleSummaryFromJson(Map<String, dynamic> json) {
  return _RoleSummary.fromJson(json);
}

/// @nodoc
mixin _$RoleSummary {
  @JsonKey(name: 'customer_count')
  int get customerCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'supplier_count')
  int get supplierCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_count')
  int get employeeCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'other_count')
  int get otherCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_outstanding')
  double get totalOutstanding => throw _privateConstructorUsedError;

  /// Serializes this RoleSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoleSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoleSummaryCopyWith<RoleSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoleSummaryCopyWith<$Res> {
  factory $RoleSummaryCopyWith(
          RoleSummary value, $Res Function(RoleSummary) then) =
      _$RoleSummaryCopyWithImpl<$Res, RoleSummary>;
  @useResult
  $Res call(
      {@JsonKey(name: 'customer_count') int customerCount,
      @JsonKey(name: 'supplier_count') int supplierCount,
      @JsonKey(name: 'employee_count') int employeeCount,
      @JsonKey(name: 'other_count') int otherCount,
      @JsonKey(name: 'total_outstanding') double totalOutstanding});
}

/// @nodoc
class _$RoleSummaryCopyWithImpl<$Res, $Val extends RoleSummary>
    implements $RoleSummaryCopyWith<$Res> {
  _$RoleSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoleSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerCount = null,
    Object? supplierCount = null,
    Object? employeeCount = null,
    Object? otherCount = null,
    Object? totalOutstanding = null,
  }) {
    return _then(_value.copyWith(
      customerCount: null == customerCount
          ? _value.customerCount
          : customerCount // ignore: cast_nullable_to_non_nullable
              as int,
      supplierCount: null == supplierCount
          ? _value.supplierCount
          : supplierCount // ignore: cast_nullable_to_non_nullable
              as int,
      employeeCount: null == employeeCount
          ? _value.employeeCount
          : employeeCount // ignore: cast_nullable_to_non_nullable
              as int,
      otherCount: null == otherCount
          ? _value.otherCount
          : otherCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalOutstanding: null == totalOutstanding
          ? _value.totalOutstanding
          : totalOutstanding // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoleSummaryImplCopyWith<$Res>
    implements $RoleSummaryCopyWith<$Res> {
  factory _$$RoleSummaryImplCopyWith(
          _$RoleSummaryImpl value, $Res Function(_$RoleSummaryImpl) then) =
      __$$RoleSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'customer_count') int customerCount,
      @JsonKey(name: 'supplier_count') int supplierCount,
      @JsonKey(name: 'employee_count') int employeeCount,
      @JsonKey(name: 'other_count') int otherCount,
      @JsonKey(name: 'total_outstanding') double totalOutstanding});
}

/// @nodoc
class __$$RoleSummaryImplCopyWithImpl<$Res>
    extends _$RoleSummaryCopyWithImpl<$Res, _$RoleSummaryImpl>
    implements _$$RoleSummaryImplCopyWith<$Res> {
  __$$RoleSummaryImplCopyWithImpl(
      _$RoleSummaryImpl _value, $Res Function(_$RoleSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of RoleSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerCount = null,
    Object? supplierCount = null,
    Object? employeeCount = null,
    Object? otherCount = null,
    Object? totalOutstanding = null,
  }) {
    return _then(_$RoleSummaryImpl(
      customerCount: null == customerCount
          ? _value.customerCount
          : customerCount // ignore: cast_nullable_to_non_nullable
              as int,
      supplierCount: null == supplierCount
          ? _value.supplierCount
          : supplierCount // ignore: cast_nullable_to_non_nullable
              as int,
      employeeCount: null == employeeCount
          ? _value.employeeCount
          : employeeCount // ignore: cast_nullable_to_non_nullable
              as int,
      otherCount: null == otherCount
          ? _value.otherCount
          : otherCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalOutstanding: null == totalOutstanding
          ? _value.totalOutstanding
          : totalOutstanding // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoleSummaryImpl implements _RoleSummary {
  const _$RoleSummaryImpl(
      {@JsonKey(name: 'customer_count') required this.customerCount,
      @JsonKey(name: 'supplier_count') required this.supplierCount,
      @JsonKey(name: 'employee_count') required this.employeeCount,
      @JsonKey(name: 'other_count') required this.otherCount,
      @JsonKey(name: 'total_outstanding') required this.totalOutstanding});

  factory _$RoleSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoleSummaryImplFromJson(json);

  @override
  @JsonKey(name: 'customer_count')
  final int customerCount;
  @override
  @JsonKey(name: 'supplier_count')
  final int supplierCount;
  @override
  @JsonKey(name: 'employee_count')
  final int employeeCount;
  @override
  @JsonKey(name: 'other_count')
  final int otherCount;
  @override
  @JsonKey(name: 'total_outstanding')
  final double totalOutstanding;

  @override
  String toString() {
    return 'RoleSummary(customerCount: $customerCount, supplierCount: $supplierCount, employeeCount: $employeeCount, otherCount: $otherCount, totalOutstanding: $totalOutstanding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoleSummaryImpl &&
            (identical(other.customerCount, customerCount) ||
                other.customerCount == customerCount) &&
            (identical(other.supplierCount, supplierCount) ||
                other.supplierCount == supplierCount) &&
            (identical(other.employeeCount, employeeCount) ||
                other.employeeCount == employeeCount) &&
            (identical(other.otherCount, otherCount) ||
                other.otherCount == otherCount) &&
            (identical(other.totalOutstanding, totalOutstanding) ||
                other.totalOutstanding == totalOutstanding));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, customerCount, supplierCount,
      employeeCount, otherCount, totalOutstanding);

  /// Create a copy of RoleSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoleSummaryImplCopyWith<_$RoleSummaryImpl> get copyWith =>
      __$$RoleSummaryImplCopyWithImpl<_$RoleSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoleSummaryImplToJson(
      this,
    );
  }
}

abstract class _RoleSummary implements RoleSummary {
  const factory _RoleSummary(
      {@JsonKey(name: 'customer_count') required final int customerCount,
      @JsonKey(name: 'supplier_count') required final int supplierCount,
      @JsonKey(name: 'employee_count') required final int employeeCount,
      @JsonKey(name: 'other_count') required final int otherCount,
      @JsonKey(name: 'total_outstanding')
      required final double totalOutstanding}) = _$RoleSummaryImpl;

  factory _RoleSummary.fromJson(Map<String, dynamic> json) =
      _$RoleSummaryImpl.fromJson;

  @override
  @JsonKey(name: 'customer_count')
  int get customerCount;
  @override
  @JsonKey(name: 'supplier_count')
  int get supplierCount;
  @override
  @JsonKey(name: 'employee_count')
  int get employeeCount;
  @override
  @JsonKey(name: 'other_count')
  int get otherCount;
  @override
  @JsonKey(name: 'total_outstanding')
  double get totalOutstanding;

  /// Create a copy of RoleSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoleSummaryImplCopyWith<_$RoleSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OutstandingByRole _$OutstandingByRoleFromJson(Map<String, dynamic> json) {
  return _OutstandingByRole.fromJson(json);
}

/// @nodoc
mixin _$OutstandingByRole {
  @JsonKey(name: 'customer_outstanding')
  double get customerOutstanding => throw _privateConstructorUsedError;
  @JsonKey(name: 'supplier_outstanding')
  double get supplierOutstanding => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_outstanding')
  double get employeeOutstanding => throw _privateConstructorUsedError;
  @JsonKey(name: 'other_outstanding')
  double get otherOutstanding => throw _privateConstructorUsedError;

  /// Serializes this OutstandingByRole to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OutstandingByRole
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OutstandingByRoleCopyWith<OutstandingByRole> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutstandingByRoleCopyWith<$Res> {
  factory $OutstandingByRoleCopyWith(
          OutstandingByRole value, $Res Function(OutstandingByRole) then) =
      _$OutstandingByRoleCopyWithImpl<$Res, OutstandingByRole>;
  @useResult
  $Res call(
      {@JsonKey(name: 'customer_outstanding') double customerOutstanding,
      @JsonKey(name: 'supplier_outstanding') double supplierOutstanding,
      @JsonKey(name: 'employee_outstanding') double employeeOutstanding,
      @JsonKey(name: 'other_outstanding') double otherOutstanding});
}

/// @nodoc
class _$OutstandingByRoleCopyWithImpl<$Res, $Val extends OutstandingByRole>
    implements $OutstandingByRoleCopyWith<$Res> {
  _$OutstandingByRoleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OutstandingByRole
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerOutstanding = null,
    Object? supplierOutstanding = null,
    Object? employeeOutstanding = null,
    Object? otherOutstanding = null,
  }) {
    return _then(_value.copyWith(
      customerOutstanding: null == customerOutstanding
          ? _value.customerOutstanding
          : customerOutstanding // ignore: cast_nullable_to_non_nullable
              as double,
      supplierOutstanding: null == supplierOutstanding
          ? _value.supplierOutstanding
          : supplierOutstanding // ignore: cast_nullable_to_non_nullable
              as double,
      employeeOutstanding: null == employeeOutstanding
          ? _value.employeeOutstanding
          : employeeOutstanding // ignore: cast_nullable_to_non_nullable
              as double,
      otherOutstanding: null == otherOutstanding
          ? _value.otherOutstanding
          : otherOutstanding // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutstandingByRoleImplCopyWith<$Res>
    implements $OutstandingByRoleCopyWith<$Res> {
  factory _$$OutstandingByRoleImplCopyWith(_$OutstandingByRoleImpl value,
          $Res Function(_$OutstandingByRoleImpl) then) =
      __$$OutstandingByRoleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'customer_outstanding') double customerOutstanding,
      @JsonKey(name: 'supplier_outstanding') double supplierOutstanding,
      @JsonKey(name: 'employee_outstanding') double employeeOutstanding,
      @JsonKey(name: 'other_outstanding') double otherOutstanding});
}

/// @nodoc
class __$$OutstandingByRoleImplCopyWithImpl<$Res>
    extends _$OutstandingByRoleCopyWithImpl<$Res, _$OutstandingByRoleImpl>
    implements _$$OutstandingByRoleImplCopyWith<$Res> {
  __$$OutstandingByRoleImplCopyWithImpl(_$OutstandingByRoleImpl _value,
      $Res Function(_$OutstandingByRoleImpl) _then)
      : super(_value, _then);

  /// Create a copy of OutstandingByRole
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerOutstanding = null,
    Object? supplierOutstanding = null,
    Object? employeeOutstanding = null,
    Object? otherOutstanding = null,
  }) {
    return _then(_$OutstandingByRoleImpl(
      customerOutstanding: null == customerOutstanding
          ? _value.customerOutstanding
          : customerOutstanding // ignore: cast_nullable_to_non_nullable
              as double,
      supplierOutstanding: null == supplierOutstanding
          ? _value.supplierOutstanding
          : supplierOutstanding // ignore: cast_nullable_to_non_nullable
              as double,
      employeeOutstanding: null == employeeOutstanding
          ? _value.employeeOutstanding
          : employeeOutstanding // ignore: cast_nullable_to_non_nullable
              as double,
      otherOutstanding: null == otherOutstanding
          ? _value.otherOutstanding
          : otherOutstanding // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OutstandingByRoleImpl implements _OutstandingByRole {
  const _$OutstandingByRoleImpl(
      {@JsonKey(name: 'customer_outstanding') required this.customerOutstanding,
      @JsonKey(name: 'supplier_outstanding') required this.supplierOutstanding,
      @JsonKey(name: 'employee_outstanding') required this.employeeOutstanding,
      @JsonKey(name: 'other_outstanding') required this.otherOutstanding});

  factory _$OutstandingByRoleImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutstandingByRoleImplFromJson(json);

  @override
  @JsonKey(name: 'customer_outstanding')
  final double customerOutstanding;
  @override
  @JsonKey(name: 'supplier_outstanding')
  final double supplierOutstanding;
  @override
  @JsonKey(name: 'employee_outstanding')
  final double employeeOutstanding;
  @override
  @JsonKey(name: 'other_outstanding')
  final double otherOutstanding;

  @override
  String toString() {
    return 'OutstandingByRole(customerOutstanding: $customerOutstanding, supplierOutstanding: $supplierOutstanding, employeeOutstanding: $employeeOutstanding, otherOutstanding: $otherOutstanding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutstandingByRoleImpl &&
            (identical(other.customerOutstanding, customerOutstanding) ||
                other.customerOutstanding == customerOutstanding) &&
            (identical(other.supplierOutstanding, supplierOutstanding) ||
                other.supplierOutstanding == supplierOutstanding) &&
            (identical(other.employeeOutstanding, employeeOutstanding) ||
                other.employeeOutstanding == employeeOutstanding) &&
            (identical(other.otherOutstanding, otherOutstanding) ||
                other.otherOutstanding == otherOutstanding));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, customerOutstanding,
      supplierOutstanding, employeeOutstanding, otherOutstanding);

  /// Create a copy of OutstandingByRole
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OutstandingByRoleImplCopyWith<_$OutstandingByRoleImpl> get copyWith =>
      __$$OutstandingByRoleImplCopyWithImpl<_$OutstandingByRoleImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutstandingByRoleImplToJson(
      this,
    );
  }
}

abstract class _OutstandingByRole implements OutstandingByRole {
  const factory _OutstandingByRole(
      {@JsonKey(name: 'customer_outstanding')
      required final double customerOutstanding,
      @JsonKey(name: 'supplier_outstanding')
      required final double supplierOutstanding,
      @JsonKey(name: 'employee_outstanding')
      required final double employeeOutstanding,
      @JsonKey(name: 'other_outstanding')
      required final double otherOutstanding}) = _$OutstandingByRoleImpl;

  factory _OutstandingByRole.fromJson(Map<String, dynamic> json) =
      _$OutstandingByRoleImpl.fromJson;

  @override
  @JsonKey(name: 'customer_outstanding')
  double get customerOutstanding;
  @override
  @JsonKey(name: 'supplier_outstanding')
  double get supplierOutstanding;
  @override
  @JsonKey(name: 'employee_outstanding')
  double get employeeOutstanding;
  @override
  @JsonKey(name: 'other_outstanding')
  double get otherOutstanding;

  /// Create a copy of OutstandingByRole
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OutstandingByRoleImplCopyWith<_$OutstandingByRoleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PartiesByRole _$PartiesByRoleFromJson(Map<String, dynamic> json) {
  return _PartiesByRole.fromJson(json);
}

/// @nodoc
mixin _$PartiesByRole {
  @JsonKey(name: 'customer_parties')
  List<Party> get customerParties => throw _privateConstructorUsedError;
  @JsonKey(name: 'supplier_parties')
  List<Party> get supplierParties => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_parties')
  List<Party> get employeeParties => throw _privateConstructorUsedError;
  @JsonKey(name: 'other_parties')
  List<Party> get otherParties => throw _privateConstructorUsedError;

  /// Serializes this PartiesByRole to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartiesByRole
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartiesByRoleCopyWith<PartiesByRole> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartiesByRoleCopyWith<$Res> {
  factory $PartiesByRoleCopyWith(
          PartiesByRole value, $Res Function(PartiesByRole) then) =
      _$PartiesByRoleCopyWithImpl<$Res, PartiesByRole>;
  @useResult
  $Res call(
      {@JsonKey(name: 'customer_parties') List<Party> customerParties,
      @JsonKey(name: 'supplier_parties') List<Party> supplierParties,
      @JsonKey(name: 'employee_parties') List<Party> employeeParties,
      @JsonKey(name: 'other_parties') List<Party> otherParties});
}

/// @nodoc
class _$PartiesByRoleCopyWithImpl<$Res, $Val extends PartiesByRole>
    implements $PartiesByRoleCopyWith<$Res> {
  _$PartiesByRoleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartiesByRole
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerParties = null,
    Object? supplierParties = null,
    Object? employeeParties = null,
    Object? otherParties = null,
  }) {
    return _then(_value.copyWith(
      customerParties: null == customerParties
          ? _value.customerParties
          : customerParties // ignore: cast_nullable_to_non_nullable
              as List<Party>,
      supplierParties: null == supplierParties
          ? _value.supplierParties
          : supplierParties // ignore: cast_nullable_to_non_nullable
              as List<Party>,
      employeeParties: null == employeeParties
          ? _value.employeeParties
          : employeeParties // ignore: cast_nullable_to_non_nullable
              as List<Party>,
      otherParties: null == otherParties
          ? _value.otherParties
          : otherParties // ignore: cast_nullable_to_non_nullable
              as List<Party>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartiesByRoleImplCopyWith<$Res>
    implements $PartiesByRoleCopyWith<$Res> {
  factory _$$PartiesByRoleImplCopyWith(
          _$PartiesByRoleImpl value, $Res Function(_$PartiesByRoleImpl) then) =
      __$$PartiesByRoleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'customer_parties') List<Party> customerParties,
      @JsonKey(name: 'supplier_parties') List<Party> supplierParties,
      @JsonKey(name: 'employee_parties') List<Party> employeeParties,
      @JsonKey(name: 'other_parties') List<Party> otherParties});
}

/// @nodoc
class __$$PartiesByRoleImplCopyWithImpl<$Res>
    extends _$PartiesByRoleCopyWithImpl<$Res, _$PartiesByRoleImpl>
    implements _$$PartiesByRoleImplCopyWith<$Res> {
  __$$PartiesByRoleImplCopyWithImpl(
      _$PartiesByRoleImpl _value, $Res Function(_$PartiesByRoleImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartiesByRole
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerParties = null,
    Object? supplierParties = null,
    Object? employeeParties = null,
    Object? otherParties = null,
  }) {
    return _then(_$PartiesByRoleImpl(
      customerParties: null == customerParties
          ? _value._customerParties
          : customerParties // ignore: cast_nullable_to_non_nullable
              as List<Party>,
      supplierParties: null == supplierParties
          ? _value._supplierParties
          : supplierParties // ignore: cast_nullable_to_non_nullable
              as List<Party>,
      employeeParties: null == employeeParties
          ? _value._employeeParties
          : employeeParties // ignore: cast_nullable_to_non_nullable
              as List<Party>,
      otherParties: null == otherParties
          ? _value._otherParties
          : otherParties // ignore: cast_nullable_to_non_nullable
              as List<Party>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartiesByRoleImpl implements _PartiesByRole {
  const _$PartiesByRoleImpl(
      {@JsonKey(name: 'customer_parties')
      required final List<Party> customerParties,
      @JsonKey(name: 'supplier_parties')
      required final List<Party> supplierParties,
      @JsonKey(name: 'employee_parties')
      required final List<Party> employeeParties,
      @JsonKey(name: 'other_parties') required final List<Party> otherParties})
      : _customerParties = customerParties,
        _supplierParties = supplierParties,
        _employeeParties = employeeParties,
        _otherParties = otherParties;

  factory _$PartiesByRoleImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartiesByRoleImplFromJson(json);

  final List<Party> _customerParties;
  @override
  @JsonKey(name: 'customer_parties')
  List<Party> get customerParties {
    if (_customerParties is EqualUnmodifiableListView) return _customerParties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customerParties);
  }

  final List<Party> _supplierParties;
  @override
  @JsonKey(name: 'supplier_parties')
  List<Party> get supplierParties {
    if (_supplierParties is EqualUnmodifiableListView) return _supplierParties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supplierParties);
  }

  final List<Party> _employeeParties;
  @override
  @JsonKey(name: 'employee_parties')
  List<Party> get employeeParties {
    if (_employeeParties is EqualUnmodifiableListView) return _employeeParties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_employeeParties);
  }

  final List<Party> _otherParties;
  @override
  @JsonKey(name: 'other_parties')
  List<Party> get otherParties {
    if (_otherParties is EqualUnmodifiableListView) return _otherParties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_otherParties);
  }

  @override
  String toString() {
    return 'PartiesByRole(customerParties: $customerParties, supplierParties: $supplierParties, employeeParties: $employeeParties, otherParties: $otherParties)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartiesByRoleImpl &&
            const DeepCollectionEquality()
                .equals(other._customerParties, _customerParties) &&
            const DeepCollectionEquality()
                .equals(other._supplierParties, _supplierParties) &&
            const DeepCollectionEquality()
                .equals(other._employeeParties, _employeeParties) &&
            const DeepCollectionEquality()
                .equals(other._otherParties, _otherParties));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_customerParties),
      const DeepCollectionEquality().hash(_supplierParties),
      const DeepCollectionEquality().hash(_employeeParties),
      const DeepCollectionEquality().hash(_otherParties));

  /// Create a copy of PartiesByRole
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartiesByRoleImplCopyWith<_$PartiesByRoleImpl> get copyWith =>
      __$$PartiesByRoleImplCopyWithImpl<_$PartiesByRoleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartiesByRoleImplToJson(
      this,
    );
  }
}

abstract class _PartiesByRole implements PartiesByRole {
  const factory _PartiesByRole(
      {@JsonKey(name: 'customer_parties')
      required final List<Party> customerParties,
      @JsonKey(name: 'supplier_parties')
      required final List<Party> supplierParties,
      @JsonKey(name: 'employee_parties')
      required final List<Party> employeeParties,
      @JsonKey(name: 'other_parties')
      required final List<Party> otherParties}) = _$PartiesByRoleImpl;

  factory _PartiesByRole.fromJson(Map<String, dynamic> json) =
      _$PartiesByRoleImpl.fromJson;

  @override
  @JsonKey(name: 'customer_parties')
  List<Party> get customerParties;
  @override
  @JsonKey(name: 'supplier_parties')
  List<Party> get supplierParties;
  @override
  @JsonKey(name: 'employee_parties')
  List<Party> get employeeParties;
  @override
  @JsonKey(name: 'other_parties')
  List<Party> get otherParties;

  /// Create a copy of PartiesByRole
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartiesByRoleImplCopyWith<_$PartiesByRoleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Party _$PartyFromJson(Map<String, dynamic> json) {
  return _Party.fromJson(json);
}

/// @nodoc
mixin _$Party {
  String get name => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'outstanding_amount')
  double get outstandingAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'outstanding_by_role')
  OutstandingByRole get outstandingByRole => throw _privateConstructorUsedError;
  DateTime get created => throw _privateConstructorUsedError;
  DateTime get modified => throw _privateConstructorUsedError;

  /// Serializes this Party to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Party
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartyCopyWith<Party> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartyCopyWith<$Res> {
  factory $PartyCopyWith(Party value, $Res Function(Party) then) =
      _$PartyCopyWithImpl<$Res, Party>;
  @useResult
  $Res call(
      {String name,
      String role,
      String? email,
      String? phone,
      String currency,
      @JsonKey(name: 'outstanding_amount') double outstandingAmount,
      @JsonKey(name: 'outstanding_by_role') OutstandingByRole outstandingByRole,
      DateTime created,
      DateTime modified});

  $OutstandingByRoleCopyWith<$Res> get outstandingByRole;
}

/// @nodoc
class _$PartyCopyWithImpl<$Res, $Val extends Party>
    implements $PartyCopyWith<$Res> {
  _$PartyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Party
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? role = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? currency = null,
    Object? outstandingAmount = null,
    Object? outstandingByRole = null,
    Object? created = null,
    Object? modified = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      outstandingAmount: null == outstandingAmount
          ? _value.outstandingAmount
          : outstandingAmount // ignore: cast_nullable_to_non_nullable
              as double,
      outstandingByRole: null == outstandingByRole
          ? _value.outstandingByRole
          : outstandingByRole // ignore: cast_nullable_to_non_nullable
              as OutstandingByRole,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      modified: null == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of Party
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OutstandingByRoleCopyWith<$Res> get outstandingByRole {
    return $OutstandingByRoleCopyWith<$Res>(_value.outstandingByRole, (value) {
      return _then(_value.copyWith(outstandingByRole: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PartyImplCopyWith<$Res> implements $PartyCopyWith<$Res> {
  factory _$$PartyImplCopyWith(
          _$PartyImpl value, $Res Function(_$PartyImpl) then) =
      __$$PartyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String role,
      String? email,
      String? phone,
      String currency,
      @JsonKey(name: 'outstanding_amount') double outstandingAmount,
      @JsonKey(name: 'outstanding_by_role') OutstandingByRole outstandingByRole,
      DateTime created,
      DateTime modified});

  @override
  $OutstandingByRoleCopyWith<$Res> get outstandingByRole;
}

/// @nodoc
class __$$PartyImplCopyWithImpl<$Res>
    extends _$PartyCopyWithImpl<$Res, _$PartyImpl>
    implements _$$PartyImplCopyWith<$Res> {
  __$$PartyImplCopyWithImpl(
      _$PartyImpl _value, $Res Function(_$PartyImpl) _then)
      : super(_value, _then);

  /// Create a copy of Party
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? role = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? currency = null,
    Object? outstandingAmount = null,
    Object? outstandingByRole = null,
    Object? created = null,
    Object? modified = null,
  }) {
    return _then(_$PartyImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      outstandingAmount: null == outstandingAmount
          ? _value.outstandingAmount
          : outstandingAmount // ignore: cast_nullable_to_non_nullable
              as double,
      outstandingByRole: null == outstandingByRole
          ? _value.outstandingByRole
          : outstandingByRole // ignore: cast_nullable_to_non_nullable
              as OutstandingByRole,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      modified: null == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartyImpl implements _Party {
  const _$PartyImpl(
      {required this.name,
      required this.role,
      this.email,
      this.phone,
      required this.currency,
      @JsonKey(name: 'outstanding_amount') required this.outstandingAmount,
      @JsonKey(name: 'outstanding_by_role') required this.outstandingByRole,
      required this.created,
      required this.modified});

  factory _$PartyImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartyImplFromJson(json);

  @override
  final String name;
  @override
  final String role;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String currency;
  @override
  @JsonKey(name: 'outstanding_amount')
  final double outstandingAmount;
  @override
  @JsonKey(name: 'outstanding_by_role')
  final OutstandingByRole outstandingByRole;
  @override
  final DateTime created;
  @override
  final DateTime modified;

  @override
  String toString() {
    return 'Party(name: $name, role: $role, email: $email, phone: $phone, currency: $currency, outstandingAmount: $outstandingAmount, outstandingByRole: $outstandingByRole, created: $created, modified: $modified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartyImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.outstandingAmount, outstandingAmount) ||
                other.outstandingAmount == outstandingAmount) &&
            (identical(other.outstandingByRole, outstandingByRole) ||
                other.outstandingByRole == outstandingByRole) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.modified, modified) ||
                other.modified == modified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, role, email, phone,
      currency, outstandingAmount, outstandingByRole, created, modified);

  /// Create a copy of Party
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartyImplCopyWith<_$PartyImpl> get copyWith =>
      __$$PartyImplCopyWithImpl<_$PartyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartyImplToJson(
      this,
    );
  }
}

abstract class _Party implements Party {
  const factory _Party(
      {required final String name,
      required final String role,
      final String? email,
      final String? phone,
      required final String currency,
      @JsonKey(name: 'outstanding_amount')
      required final double outstandingAmount,
      @JsonKey(name: 'outstanding_by_role')
      required final OutstandingByRole outstandingByRole,
      required final DateTime created,
      required final DateTime modified}) = _$PartyImpl;

  factory _Party.fromJson(Map<String, dynamic> json) = _$PartyImpl.fromJson;

  @override
  String get name;
  @override
  String get role;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String get currency;
  @override
  @JsonKey(name: 'outstanding_amount')
  double get outstandingAmount;
  @override
  @JsonKey(name: 'outstanding_by_role')
  OutstandingByRole get outstandingByRole;
  @override
  DateTime get created;
  @override
  DateTime get modified;

  /// Create a copy of Party
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartyImplCopyWith<_$PartyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

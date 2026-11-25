// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reconcile_party_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReconcilePartyResponse _$ReconcilePartyResponseFromJson(
    Map<String, dynamic> json) {
  return _ReconcilePartyResponse.fromJson(json);
}

/// @nodoc
mixin _$ReconcilePartyResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  ReconciliationSummary get summary => throw _privateConstructorUsedError;
  @JsonKey(name: 'reconciliation_results')
  List<ReconciliationResult> get reconciliationResults =>
      throw _privateConstructorUsedError;

  /// Serializes this ReconcilePartyResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReconcilePartyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReconcilePartyResponseCopyWith<ReconcilePartyResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReconcilePartyResponseCopyWith<$Res> {
  factory $ReconcilePartyResponseCopyWith(ReconcilePartyResponse value,
          $Res Function(ReconcilePartyResponse) then) =
      _$ReconcilePartyResponseCopyWithImpl<$Res, ReconcilePartyResponse>;
  @useResult
  $Res call(
      {bool success,
      String message,
      ReconciliationSummary summary,
      @JsonKey(name: 'reconciliation_results')
      List<ReconciliationResult> reconciliationResults});

  $ReconciliationSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class _$ReconcilePartyResponseCopyWithImpl<$Res,
        $Val extends ReconcilePartyResponse>
    implements $ReconcilePartyResponseCopyWith<$Res> {
  _$ReconcilePartyResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReconcilePartyResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? summary = null,
    Object? reconciliationResults = null,
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
              as ReconciliationSummary,
      reconciliationResults: null == reconciliationResults
          ? _value.reconciliationResults
          : reconciliationResults // ignore: cast_nullable_to_non_nullable
              as List<ReconciliationResult>,
    ) as $Val);
  }

  /// Create a copy of ReconcilePartyResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReconciliationSummaryCopyWith<$Res> get summary {
    return $ReconciliationSummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReconcilePartyResponseImplCopyWith<$Res>
    implements $ReconcilePartyResponseCopyWith<$Res> {
  factory _$$ReconcilePartyResponseImplCopyWith(
          _$ReconcilePartyResponseImpl value,
          $Res Function(_$ReconcilePartyResponseImpl) then) =
      __$$ReconcilePartyResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String message,
      ReconciliationSummary summary,
      @JsonKey(name: 'reconciliation_results')
      List<ReconciliationResult> reconciliationResults});

  @override
  $ReconciliationSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class __$$ReconcilePartyResponseImplCopyWithImpl<$Res>
    extends _$ReconcilePartyResponseCopyWithImpl<$Res,
        _$ReconcilePartyResponseImpl>
    implements _$$ReconcilePartyResponseImplCopyWith<$Res> {
  __$$ReconcilePartyResponseImplCopyWithImpl(
      _$ReconcilePartyResponseImpl _value,
      $Res Function(_$ReconcilePartyResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReconcilePartyResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? summary = null,
    Object? reconciliationResults = null,
  }) {
    return _then(_$ReconcilePartyResponseImpl(
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
              as ReconciliationSummary,
      reconciliationResults: null == reconciliationResults
          ? _value._reconciliationResults
          : reconciliationResults // ignore: cast_nullable_to_non_nullable
              as List<ReconciliationResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReconcilePartyResponseImpl implements _ReconcilePartyResponse {
  const _$ReconcilePartyResponseImpl(
      {required this.success,
      required this.message,
      required this.summary,
      @JsonKey(name: 'reconciliation_results')
      required final List<ReconciliationResult> reconciliationResults})
      : _reconciliationResults = reconciliationResults;

  factory _$ReconcilePartyResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReconcilePartyResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final ReconciliationSummary summary;
  final List<ReconciliationResult> _reconciliationResults;
  @override
  @JsonKey(name: 'reconciliation_results')
  List<ReconciliationResult> get reconciliationResults {
    if (_reconciliationResults is EqualUnmodifiableListView)
      return _reconciliationResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reconciliationResults);
  }

  @override
  String toString() {
    return 'ReconcilePartyResponse(success: $success, message: $message, summary: $summary, reconciliationResults: $reconciliationResults)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReconcilePartyResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality()
                .equals(other._reconciliationResults, _reconciliationResults));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, summary,
      const DeepCollectionEquality().hash(_reconciliationResults));

  /// Create a copy of ReconcilePartyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReconcilePartyResponseImplCopyWith<_$ReconcilePartyResponseImpl>
      get copyWith => __$$ReconcilePartyResponseImplCopyWithImpl<
          _$ReconcilePartyResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReconcilePartyResponseImplToJson(
      this,
    );
  }
}

abstract class _ReconcilePartyResponse implements ReconcilePartyResponse {
  const factory _ReconcilePartyResponse(
          {required final bool success,
          required final String message,
          required final ReconciliationSummary summary,
          @JsonKey(name: 'reconciliation_results')
          required final List<ReconciliationResult> reconciliationResults}) =
      _$ReconcilePartyResponseImpl;

  factory _ReconcilePartyResponse.fromJson(Map<String, dynamic> json) =
      _$ReconcilePartyResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  ReconciliationSummary get summary;
  @override
  @JsonKey(name: 'reconciliation_results')
  List<ReconciliationResult> get reconciliationResults;

  /// Create a copy of ReconcilePartyResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReconcilePartyResponseImplCopyWith<_$ReconcilePartyResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ReconciliationSummary _$ReconciliationSummaryFromJson(
    Map<String, dynamic> json) {
  return _ReconciliationSummary.fromJson(json);
}

/// @nodoc
mixin _$ReconciliationSummary {
  @JsonKey(name: 'total_parties_checked')
  int get totalPartiesChecked => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_mismatches')
  int get totalMismatches => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_fixed')
  int get totalFixed => throw _privateConstructorUsedError;
  @JsonKey(name: 'auto_fix_enabled')
  bool get autoFixEnabled => throw _privateConstructorUsedError;
  @JsonKey(name: 'transaction_status')
  String get transactionStatus => throw _privateConstructorUsedError;

  /// Serializes this ReconciliationSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReconciliationSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReconciliationSummaryCopyWith<ReconciliationSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReconciliationSummaryCopyWith<$Res> {
  factory $ReconciliationSummaryCopyWith(ReconciliationSummary value,
          $Res Function(ReconciliationSummary) then) =
      _$ReconciliationSummaryCopyWithImpl<$Res, ReconciliationSummary>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_parties_checked') int totalPartiesChecked,
      @JsonKey(name: 'total_mismatches') int totalMismatches,
      @JsonKey(name: 'total_fixed') int totalFixed,
      @JsonKey(name: 'auto_fix_enabled') bool autoFixEnabled,
      @JsonKey(name: 'transaction_status') String transactionStatus});
}

/// @nodoc
class _$ReconciliationSummaryCopyWithImpl<$Res,
        $Val extends ReconciliationSummary>
    implements $ReconciliationSummaryCopyWith<$Res> {
  _$ReconciliationSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReconciliationSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalPartiesChecked = null,
    Object? totalMismatches = null,
    Object? totalFixed = null,
    Object? autoFixEnabled = null,
    Object? transactionStatus = null,
  }) {
    return _then(_value.copyWith(
      totalPartiesChecked: null == totalPartiesChecked
          ? _value.totalPartiesChecked
          : totalPartiesChecked // ignore: cast_nullable_to_non_nullable
              as int,
      totalMismatches: null == totalMismatches
          ? _value.totalMismatches
          : totalMismatches // ignore: cast_nullable_to_non_nullable
              as int,
      totalFixed: null == totalFixed
          ? _value.totalFixed
          : totalFixed // ignore: cast_nullable_to_non_nullable
              as int,
      autoFixEnabled: null == autoFixEnabled
          ? _value.autoFixEnabled
          : autoFixEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      transactionStatus: null == transactionStatus
          ? _value.transactionStatus
          : transactionStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReconciliationSummaryImplCopyWith<$Res>
    implements $ReconciliationSummaryCopyWith<$Res> {
  factory _$$ReconciliationSummaryImplCopyWith(
          _$ReconciliationSummaryImpl value,
          $Res Function(_$ReconciliationSummaryImpl) then) =
      __$$ReconciliationSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_parties_checked') int totalPartiesChecked,
      @JsonKey(name: 'total_mismatches') int totalMismatches,
      @JsonKey(name: 'total_fixed') int totalFixed,
      @JsonKey(name: 'auto_fix_enabled') bool autoFixEnabled,
      @JsonKey(name: 'transaction_status') String transactionStatus});
}

/// @nodoc
class __$$ReconciliationSummaryImplCopyWithImpl<$Res>
    extends _$ReconciliationSummaryCopyWithImpl<$Res,
        _$ReconciliationSummaryImpl>
    implements _$$ReconciliationSummaryImplCopyWith<$Res> {
  __$$ReconciliationSummaryImplCopyWithImpl(_$ReconciliationSummaryImpl _value,
      $Res Function(_$ReconciliationSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReconciliationSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalPartiesChecked = null,
    Object? totalMismatches = null,
    Object? totalFixed = null,
    Object? autoFixEnabled = null,
    Object? transactionStatus = null,
  }) {
    return _then(_$ReconciliationSummaryImpl(
      totalPartiesChecked: null == totalPartiesChecked
          ? _value.totalPartiesChecked
          : totalPartiesChecked // ignore: cast_nullable_to_non_nullable
              as int,
      totalMismatches: null == totalMismatches
          ? _value.totalMismatches
          : totalMismatches // ignore: cast_nullable_to_non_nullable
              as int,
      totalFixed: null == totalFixed
          ? _value.totalFixed
          : totalFixed // ignore: cast_nullable_to_non_nullable
              as int,
      autoFixEnabled: null == autoFixEnabled
          ? _value.autoFixEnabled
          : autoFixEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      transactionStatus: null == transactionStatus
          ? _value.transactionStatus
          : transactionStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReconciliationSummaryImpl implements _ReconciliationSummary {
  const _$ReconciliationSummaryImpl(
      {@JsonKey(name: 'total_parties_checked')
      required this.totalPartiesChecked,
      @JsonKey(name: 'total_mismatches') required this.totalMismatches,
      @JsonKey(name: 'total_fixed') required this.totalFixed,
      @JsonKey(name: 'auto_fix_enabled') required this.autoFixEnabled,
      @JsonKey(name: 'transaction_status') required this.transactionStatus});

  factory _$ReconciliationSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReconciliationSummaryImplFromJson(json);

  @override
  @JsonKey(name: 'total_parties_checked')
  final int totalPartiesChecked;
  @override
  @JsonKey(name: 'total_mismatches')
  final int totalMismatches;
  @override
  @JsonKey(name: 'total_fixed')
  final int totalFixed;
  @override
  @JsonKey(name: 'auto_fix_enabled')
  final bool autoFixEnabled;
  @override
  @JsonKey(name: 'transaction_status')
  final String transactionStatus;

  @override
  String toString() {
    return 'ReconciliationSummary(totalPartiesChecked: $totalPartiesChecked, totalMismatches: $totalMismatches, totalFixed: $totalFixed, autoFixEnabled: $autoFixEnabled, transactionStatus: $transactionStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReconciliationSummaryImpl &&
            (identical(other.totalPartiesChecked, totalPartiesChecked) ||
                other.totalPartiesChecked == totalPartiesChecked) &&
            (identical(other.totalMismatches, totalMismatches) ||
                other.totalMismatches == totalMismatches) &&
            (identical(other.totalFixed, totalFixed) ||
                other.totalFixed == totalFixed) &&
            (identical(other.autoFixEnabled, autoFixEnabled) ||
                other.autoFixEnabled == autoFixEnabled) &&
            (identical(other.transactionStatus, transactionStatus) ||
                other.transactionStatus == transactionStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalPartiesChecked,
      totalMismatches, totalFixed, autoFixEnabled, transactionStatus);

  /// Create a copy of ReconciliationSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReconciliationSummaryImplCopyWith<_$ReconciliationSummaryImpl>
      get copyWith => __$$ReconciliationSummaryImplCopyWithImpl<
          _$ReconciliationSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReconciliationSummaryImplToJson(
      this,
    );
  }
}

abstract class _ReconciliationSummary implements ReconciliationSummary {
  const factory _ReconciliationSummary(
      {@JsonKey(name: 'total_parties_checked')
      required final int totalPartiesChecked,
      @JsonKey(name: 'total_mismatches') required final int totalMismatches,
      @JsonKey(name: 'total_fixed') required final int totalFixed,
      @JsonKey(name: 'auto_fix_enabled') required final bool autoFixEnabled,
      @JsonKey(name: 'transaction_status')
      required final String transactionStatus}) = _$ReconciliationSummaryImpl;

  factory _ReconciliationSummary.fromJson(Map<String, dynamic> json) =
      _$ReconciliationSummaryImpl.fromJson;

  @override
  @JsonKey(name: 'total_parties_checked')
  int get totalPartiesChecked;
  @override
  @JsonKey(name: 'total_mismatches')
  int get totalMismatches;
  @override
  @JsonKey(name: 'total_fixed')
  int get totalFixed;
  @override
  @JsonKey(name: 'auto_fix_enabled')
  bool get autoFixEnabled;
  @override
  @JsonKey(name: 'transaction_status')
  String get transactionStatus;

  /// Create a copy of ReconciliationSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReconciliationSummaryImplCopyWith<_$ReconciliationSummaryImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ReconciliationResult _$ReconciliationResultFromJson(Map<String, dynamic> json) {
  return _ReconciliationResult.fromJson(json);
}

/// @nodoc
mixin _$ReconciliationResult {
  @JsonKey(name: 'party_name')
  String get partyName => throw _privateConstructorUsedError;
  @JsonKey(name: 'party_outstanding')
  double get partyOutstanding => throw _privateConstructorUsedError;
  @JsonKey(name: 'actual_outstanding')
  double get actualOutstanding => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_grand_total')
  double get totalGrandTotal => throw _privateConstructorUsedError;
  double get difference => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_invoice_count')
  int get totalInvoiceCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'unpaid_invoice_count')
  int get unpaidInvoiceCount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  bool get updated => throw _privateConstructorUsedError;
  @JsonKey(name: 'update_error')
  String? get updateError => throw _privateConstructorUsedError;
  @JsonKey(name: 'unpaid_invoices')
  List<UnpaidInvoice> get unpaidInvoices => throw _privateConstructorUsedError;

  /// Serializes this ReconciliationResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReconciliationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReconciliationResultCopyWith<ReconciliationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReconciliationResultCopyWith<$Res> {
  factory $ReconciliationResultCopyWith(ReconciliationResult value,
          $Res Function(ReconciliationResult) then) =
      _$ReconciliationResultCopyWithImpl<$Res, ReconciliationResult>;
  @useResult
  $Res call(
      {@JsonKey(name: 'party_name') String partyName,
      @JsonKey(name: 'party_outstanding') double partyOutstanding,
      @JsonKey(name: 'actual_outstanding') double actualOutstanding,
      @JsonKey(name: 'total_grand_total') double totalGrandTotal,
      double difference,
      @JsonKey(name: 'total_invoice_count') int totalInvoiceCount,
      @JsonKey(name: 'unpaid_invoice_count') int unpaidInvoiceCount,
      String status,
      bool updated,
      @JsonKey(name: 'update_error') String? updateError,
      @JsonKey(name: 'unpaid_invoices') List<UnpaidInvoice> unpaidInvoices});
}

/// @nodoc
class _$ReconciliationResultCopyWithImpl<$Res,
        $Val extends ReconciliationResult>
    implements $ReconciliationResultCopyWith<$Res> {
  _$ReconciliationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReconciliationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? partyName = null,
    Object? partyOutstanding = null,
    Object? actualOutstanding = null,
    Object? totalGrandTotal = null,
    Object? difference = null,
    Object? totalInvoiceCount = null,
    Object? unpaidInvoiceCount = null,
    Object? status = null,
    Object? updated = null,
    Object? updateError = freezed,
    Object? unpaidInvoices = null,
  }) {
    return _then(_value.copyWith(
      partyName: null == partyName
          ? _value.partyName
          : partyName // ignore: cast_nullable_to_non_nullable
              as String,
      partyOutstanding: null == partyOutstanding
          ? _value.partyOutstanding
          : partyOutstanding // ignore: cast_nullable_to_non_nullable
              as double,
      actualOutstanding: null == actualOutstanding
          ? _value.actualOutstanding
          : actualOutstanding // ignore: cast_nullable_to_non_nullable
              as double,
      totalGrandTotal: null == totalGrandTotal
          ? _value.totalGrandTotal
          : totalGrandTotal // ignore: cast_nullable_to_non_nullable
              as double,
      difference: null == difference
          ? _value.difference
          : difference // ignore: cast_nullable_to_non_nullable
              as double,
      totalInvoiceCount: null == totalInvoiceCount
          ? _value.totalInvoiceCount
          : totalInvoiceCount // ignore: cast_nullable_to_non_nullable
              as int,
      unpaidInvoiceCount: null == unpaidInvoiceCount
          ? _value.unpaidInvoiceCount
          : unpaidInvoiceCount // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      updated: null == updated
          ? _value.updated
          : updated // ignore: cast_nullable_to_non_nullable
              as bool,
      updateError: freezed == updateError
          ? _value.updateError
          : updateError // ignore: cast_nullable_to_non_nullable
              as String?,
      unpaidInvoices: null == unpaidInvoices
          ? _value.unpaidInvoices
          : unpaidInvoices // ignore: cast_nullable_to_non_nullable
              as List<UnpaidInvoice>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReconciliationResultImplCopyWith<$Res>
    implements $ReconciliationResultCopyWith<$Res> {
  factory _$$ReconciliationResultImplCopyWith(_$ReconciliationResultImpl value,
          $Res Function(_$ReconciliationResultImpl) then) =
      __$$ReconciliationResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'party_name') String partyName,
      @JsonKey(name: 'party_outstanding') double partyOutstanding,
      @JsonKey(name: 'actual_outstanding') double actualOutstanding,
      @JsonKey(name: 'total_grand_total') double totalGrandTotal,
      double difference,
      @JsonKey(name: 'total_invoice_count') int totalInvoiceCount,
      @JsonKey(name: 'unpaid_invoice_count') int unpaidInvoiceCount,
      String status,
      bool updated,
      @JsonKey(name: 'update_error') String? updateError,
      @JsonKey(name: 'unpaid_invoices') List<UnpaidInvoice> unpaidInvoices});
}

/// @nodoc
class __$$ReconciliationResultImplCopyWithImpl<$Res>
    extends _$ReconciliationResultCopyWithImpl<$Res, _$ReconciliationResultImpl>
    implements _$$ReconciliationResultImplCopyWith<$Res> {
  __$$ReconciliationResultImplCopyWithImpl(_$ReconciliationResultImpl _value,
      $Res Function(_$ReconciliationResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReconciliationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? partyName = null,
    Object? partyOutstanding = null,
    Object? actualOutstanding = null,
    Object? totalGrandTotal = null,
    Object? difference = null,
    Object? totalInvoiceCount = null,
    Object? unpaidInvoiceCount = null,
    Object? status = null,
    Object? updated = null,
    Object? updateError = freezed,
    Object? unpaidInvoices = null,
  }) {
    return _then(_$ReconciliationResultImpl(
      partyName: null == partyName
          ? _value.partyName
          : partyName // ignore: cast_nullable_to_non_nullable
              as String,
      partyOutstanding: null == partyOutstanding
          ? _value.partyOutstanding
          : partyOutstanding // ignore: cast_nullable_to_non_nullable
              as double,
      actualOutstanding: null == actualOutstanding
          ? _value.actualOutstanding
          : actualOutstanding // ignore: cast_nullable_to_non_nullable
              as double,
      totalGrandTotal: null == totalGrandTotal
          ? _value.totalGrandTotal
          : totalGrandTotal // ignore: cast_nullable_to_non_nullable
              as double,
      difference: null == difference
          ? _value.difference
          : difference // ignore: cast_nullable_to_non_nullable
              as double,
      totalInvoiceCount: null == totalInvoiceCount
          ? _value.totalInvoiceCount
          : totalInvoiceCount // ignore: cast_nullable_to_non_nullable
              as int,
      unpaidInvoiceCount: null == unpaidInvoiceCount
          ? _value.unpaidInvoiceCount
          : unpaidInvoiceCount // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      updated: null == updated
          ? _value.updated
          : updated // ignore: cast_nullable_to_non_nullable
              as bool,
      updateError: freezed == updateError
          ? _value.updateError
          : updateError // ignore: cast_nullable_to_non_nullable
              as String?,
      unpaidInvoices: null == unpaidInvoices
          ? _value._unpaidInvoices
          : unpaidInvoices // ignore: cast_nullable_to_non_nullable
              as List<UnpaidInvoice>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReconciliationResultImpl implements _ReconciliationResult {
  const _$ReconciliationResultImpl(
      {@JsonKey(name: 'party_name') required this.partyName,
      @JsonKey(name: 'party_outstanding') required this.partyOutstanding,
      @JsonKey(name: 'actual_outstanding') required this.actualOutstanding,
      @JsonKey(name: 'total_grand_total') required this.totalGrandTotal,
      required this.difference,
      @JsonKey(name: 'total_invoice_count') required this.totalInvoiceCount,
      @JsonKey(name: 'unpaid_invoice_count') required this.unpaidInvoiceCount,
      required this.status,
      required this.updated,
      @JsonKey(name: 'update_error') this.updateError,
      @JsonKey(name: 'unpaid_invoices')
      required final List<UnpaidInvoice> unpaidInvoices})
      : _unpaidInvoices = unpaidInvoices;

  factory _$ReconciliationResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReconciliationResultImplFromJson(json);

  @override
  @JsonKey(name: 'party_name')
  final String partyName;
  @override
  @JsonKey(name: 'party_outstanding')
  final double partyOutstanding;
  @override
  @JsonKey(name: 'actual_outstanding')
  final double actualOutstanding;
  @override
  @JsonKey(name: 'total_grand_total')
  final double totalGrandTotal;
  @override
  final double difference;
  @override
  @JsonKey(name: 'total_invoice_count')
  final int totalInvoiceCount;
  @override
  @JsonKey(name: 'unpaid_invoice_count')
  final int unpaidInvoiceCount;
  @override
  final String status;
  @override
  final bool updated;
  @override
  @JsonKey(name: 'update_error')
  final String? updateError;
  final List<UnpaidInvoice> _unpaidInvoices;
  @override
  @JsonKey(name: 'unpaid_invoices')
  List<UnpaidInvoice> get unpaidInvoices {
    if (_unpaidInvoices is EqualUnmodifiableListView) return _unpaidInvoices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unpaidInvoices);
  }

  @override
  String toString() {
    return 'ReconciliationResult(partyName: $partyName, partyOutstanding: $partyOutstanding, actualOutstanding: $actualOutstanding, totalGrandTotal: $totalGrandTotal, difference: $difference, totalInvoiceCount: $totalInvoiceCount, unpaidInvoiceCount: $unpaidInvoiceCount, status: $status, updated: $updated, updateError: $updateError, unpaidInvoices: $unpaidInvoices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReconciliationResultImpl &&
            (identical(other.partyName, partyName) ||
                other.partyName == partyName) &&
            (identical(other.partyOutstanding, partyOutstanding) ||
                other.partyOutstanding == partyOutstanding) &&
            (identical(other.actualOutstanding, actualOutstanding) ||
                other.actualOutstanding == actualOutstanding) &&
            (identical(other.totalGrandTotal, totalGrandTotal) ||
                other.totalGrandTotal == totalGrandTotal) &&
            (identical(other.difference, difference) ||
                other.difference == difference) &&
            (identical(other.totalInvoiceCount, totalInvoiceCount) ||
                other.totalInvoiceCount == totalInvoiceCount) &&
            (identical(other.unpaidInvoiceCount, unpaidInvoiceCount) ||
                other.unpaidInvoiceCount == unpaidInvoiceCount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.updated, updated) || other.updated == updated) &&
            (identical(other.updateError, updateError) ||
                other.updateError == updateError) &&
            const DeepCollectionEquality()
                .equals(other._unpaidInvoices, _unpaidInvoices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      partyName,
      partyOutstanding,
      actualOutstanding,
      totalGrandTotal,
      difference,
      totalInvoiceCount,
      unpaidInvoiceCount,
      status,
      updated,
      updateError,
      const DeepCollectionEquality().hash(_unpaidInvoices));

  /// Create a copy of ReconciliationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReconciliationResultImplCopyWith<_$ReconciliationResultImpl>
      get copyWith =>
          __$$ReconciliationResultImplCopyWithImpl<_$ReconciliationResultImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReconciliationResultImplToJson(
      this,
    );
  }
}

abstract class _ReconciliationResult implements ReconciliationResult {
  const factory _ReconciliationResult(
      {@JsonKey(name: 'party_name') required final String partyName,
      @JsonKey(name: 'party_outstanding')
      required final double partyOutstanding,
      @JsonKey(name: 'actual_outstanding')
      required final double actualOutstanding,
      @JsonKey(name: 'total_grand_total') required final double totalGrandTotal,
      required final double difference,
      @JsonKey(name: 'total_invoice_count')
      required final int totalInvoiceCount,
      @JsonKey(name: 'unpaid_invoice_count')
      required final int unpaidInvoiceCount,
      required final String status,
      required final bool updated,
      @JsonKey(name: 'update_error') final String? updateError,
      @JsonKey(name: 'unpaid_invoices')
      required final List<UnpaidInvoice>
          unpaidInvoices}) = _$ReconciliationResultImpl;

  factory _ReconciliationResult.fromJson(Map<String, dynamic> json) =
      _$ReconciliationResultImpl.fromJson;

  @override
  @JsonKey(name: 'party_name')
  String get partyName;
  @override
  @JsonKey(name: 'party_outstanding')
  double get partyOutstanding;
  @override
  @JsonKey(name: 'actual_outstanding')
  double get actualOutstanding;
  @override
  @JsonKey(name: 'total_grand_total')
  double get totalGrandTotal;
  @override
  double get difference;
  @override
  @JsonKey(name: 'total_invoice_count')
  int get totalInvoiceCount;
  @override
  @JsonKey(name: 'unpaid_invoice_count')
  int get unpaidInvoiceCount;
  @override
  String get status;
  @override
  bool get updated;
  @override
  @JsonKey(name: 'update_error')
  String? get updateError;
  @override
  @JsonKey(name: 'unpaid_invoices')
  List<UnpaidInvoice> get unpaidInvoices;

  /// Create a copy of ReconciliationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReconciliationResultImplCopyWith<_$ReconciliationResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UnpaidInvoice _$UnpaidInvoiceFromJson(Map<String, dynamic> json) {
  return _UnpaidInvoice.fromJson(json);
}

/// @nodoc
mixin _$UnpaidInvoice {
  @JsonKey(name: 'invoice_name')
  String get invoiceName => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_amount')
  String get discountAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'grand_total')
  double get grandTotal => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'outstanding_amount')
  double get outstandingAmount => throw _privateConstructorUsedError;

  /// Serializes this UnpaidInvoice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UnpaidInvoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UnpaidInvoiceCopyWith<UnpaidInvoice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnpaidInvoiceCopyWith<$Res> {
  factory $UnpaidInvoiceCopyWith(
          UnpaidInvoice value, $Res Function(UnpaidInvoice) then) =
      _$UnpaidInvoiceCopyWithImpl<$Res, UnpaidInvoice>;
  @useResult
  $Res call(
      {@JsonKey(name: 'invoice_name') String invoiceName,
      @JsonKey(name: 'discount_amount') String discountAmount,
      @JsonKey(name: 'grand_total') double grandTotal,
      DateTime date,
      String status,
      @JsonKey(name: 'outstanding_amount') double outstandingAmount});
}

/// @nodoc
class _$UnpaidInvoiceCopyWithImpl<$Res, $Val extends UnpaidInvoice>
    implements $UnpaidInvoiceCopyWith<$Res> {
  _$UnpaidInvoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UnpaidInvoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceName = null,
    Object? discountAmount = null,
    Object? grandTotal = null,
    Object? date = null,
    Object? status = null,
    Object? outstandingAmount = null,
  }) {
    return _then(_value.copyWith(
      invoiceName: null == invoiceName
          ? _value.invoiceName
          : invoiceName // ignore: cast_nullable_to_non_nullable
              as String,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as String,
      grandTotal: null == grandTotal
          ? _value.grandTotal
          : grandTotal // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      outstandingAmount: null == outstandingAmount
          ? _value.outstandingAmount
          : outstandingAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UnpaidInvoiceImplCopyWith<$Res>
    implements $UnpaidInvoiceCopyWith<$Res> {
  factory _$$UnpaidInvoiceImplCopyWith(
          _$UnpaidInvoiceImpl value, $Res Function(_$UnpaidInvoiceImpl) then) =
      __$$UnpaidInvoiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'invoice_name') String invoiceName,
      @JsonKey(name: 'discount_amount') String discountAmount,
      @JsonKey(name: 'grand_total') double grandTotal,
      DateTime date,
      String status,
      @JsonKey(name: 'outstanding_amount') double outstandingAmount});
}

/// @nodoc
class __$$UnpaidInvoiceImplCopyWithImpl<$Res>
    extends _$UnpaidInvoiceCopyWithImpl<$Res, _$UnpaidInvoiceImpl>
    implements _$$UnpaidInvoiceImplCopyWith<$Res> {
  __$$UnpaidInvoiceImplCopyWithImpl(
      _$UnpaidInvoiceImpl _value, $Res Function(_$UnpaidInvoiceImpl) _then)
      : super(_value, _then);

  /// Create a copy of UnpaidInvoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceName = null,
    Object? discountAmount = null,
    Object? grandTotal = null,
    Object? date = null,
    Object? status = null,
    Object? outstandingAmount = null,
  }) {
    return _then(_$UnpaidInvoiceImpl(
      invoiceName: null == invoiceName
          ? _value.invoiceName
          : invoiceName // ignore: cast_nullable_to_non_nullable
              as String,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as String,
      grandTotal: null == grandTotal
          ? _value.grandTotal
          : grandTotal // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      outstandingAmount: null == outstandingAmount
          ? _value.outstandingAmount
          : outstandingAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnpaidInvoiceImpl implements _UnpaidInvoice {
  const _$UnpaidInvoiceImpl(
      {@JsonKey(name: 'invoice_name') required this.invoiceName,
      @JsonKey(name: 'discount_amount') required this.discountAmount,
      @JsonKey(name: 'grand_total') required this.grandTotal,
      required this.date,
      required this.status,
      @JsonKey(name: 'outstanding_amount') required this.outstandingAmount});

  factory _$UnpaidInvoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnpaidInvoiceImplFromJson(json);

  @override
  @JsonKey(name: 'invoice_name')
  final String invoiceName;
  @override
  @JsonKey(name: 'discount_amount')
  final String discountAmount;
  @override
  @JsonKey(name: 'grand_total')
  final double grandTotal;
  @override
  final DateTime date;
  @override
  final String status;
  @override
  @JsonKey(name: 'outstanding_amount')
  final double outstandingAmount;

  @override
  String toString() {
    return 'UnpaidInvoice(invoiceName: $invoiceName, discountAmount: $discountAmount, grandTotal: $grandTotal, date: $date, status: $status, outstandingAmount: $outstandingAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnpaidInvoiceImpl &&
            (identical(other.invoiceName, invoiceName) ||
                other.invoiceName == invoiceName) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.grandTotal, grandTotal) ||
                other.grandTotal == grandTotal) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.outstandingAmount, outstandingAmount) ||
                other.outstandingAmount == outstandingAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, invoiceName, discountAmount,
      grandTotal, date, status, outstandingAmount);

  /// Create a copy of UnpaidInvoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnpaidInvoiceImplCopyWith<_$UnpaidInvoiceImpl> get copyWith =>
      __$$UnpaidInvoiceImplCopyWithImpl<_$UnpaidInvoiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UnpaidInvoiceImplToJson(
      this,
    );
  }
}

abstract class _UnpaidInvoice implements UnpaidInvoice {
  const factory _UnpaidInvoice(
      {@JsonKey(name: 'invoice_name') required final String invoiceName,
      @JsonKey(name: 'discount_amount') required final String discountAmount,
      @JsonKey(name: 'grand_total') required final double grandTotal,
      required final DateTime date,
      required final String status,
      @JsonKey(name: 'outstanding_amount')
      required final double outstandingAmount}) = _$UnpaidInvoiceImpl;

  factory _UnpaidInvoice.fromJson(Map<String, dynamic> json) =
      _$UnpaidInvoiceImpl.fromJson;

  @override
  @JsonKey(name: 'invoice_name')
  String get invoiceName;
  @override
  @JsonKey(name: 'discount_amount')
  String get discountAmount;
  @override
  @JsonKey(name: 'grand_total')
  double get grandTotal;
  @override
  DateTime get date;
  @override
  String get status;
  @override
  @JsonKey(name: 'outstanding_amount')
  double get outstandingAmount;

  /// Create a copy of UnpaidInvoice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnpaidInvoiceImplCopyWith<_$UnpaidInvoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

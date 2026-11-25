// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'party_detail_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartyDetailResponseModel _$PartyDetailResponseModelFromJson(
    Map<String, dynamic> json) {
  return _PartyDetailResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PartyDetailResponseModel {
  bool get success => throw _privateConstructorUsedError;
  PartyModel get party => throw _privateConstructorUsedError;
  @JsonKey(name: 'transaction_summary')
  PartyTransactionSummaryModel? get transactionSummary =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'recent_activity')
  PartyRecentActivityModel? get recentActivity =>
      throw _privateConstructorUsedError;

  /// Serializes this PartyDetailResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartyDetailResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartyDetailResponseModelCopyWith<PartyDetailResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartyDetailResponseModelCopyWith<$Res> {
  factory $PartyDetailResponseModelCopyWith(PartyDetailResponseModel value,
          $Res Function(PartyDetailResponseModel) then) =
      _$PartyDetailResponseModelCopyWithImpl<$Res, PartyDetailResponseModel>;
  @useResult
  $Res call(
      {bool success,
      PartyModel party,
      @JsonKey(name: 'transaction_summary')
      PartyTransactionSummaryModel? transactionSummary,
      @JsonKey(name: 'recent_activity')
      PartyRecentActivityModel? recentActivity});

  $PartyTransactionSummaryModelCopyWith<$Res>? get transactionSummary;
  $PartyRecentActivityModelCopyWith<$Res>? get recentActivity;
}

/// @nodoc
class _$PartyDetailResponseModelCopyWithImpl<$Res,
        $Val extends PartyDetailResponseModel>
    implements $PartyDetailResponseModelCopyWith<$Res> {
  _$PartyDetailResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartyDetailResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? party = null,
    Object? transactionSummary = freezed,
    Object? recentActivity = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      party: null == party
          ? _value.party
          : party // ignore: cast_nullable_to_non_nullable
              as PartyModel,
      transactionSummary: freezed == transactionSummary
          ? _value.transactionSummary
          : transactionSummary // ignore: cast_nullable_to_non_nullable
              as PartyTransactionSummaryModel?,
      recentActivity: freezed == recentActivity
          ? _value.recentActivity
          : recentActivity // ignore: cast_nullable_to_non_nullable
              as PartyRecentActivityModel?,
    ) as $Val);
  }

  /// Create a copy of PartyDetailResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PartyTransactionSummaryModelCopyWith<$Res>? get transactionSummary {
    if (_value.transactionSummary == null) {
      return null;
    }

    return $PartyTransactionSummaryModelCopyWith<$Res>(
        _value.transactionSummary!, (value) {
      return _then(_value.copyWith(transactionSummary: value) as $Val);
    });
  }

  /// Create a copy of PartyDetailResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PartyRecentActivityModelCopyWith<$Res>? get recentActivity {
    if (_value.recentActivity == null) {
      return null;
    }

    return $PartyRecentActivityModelCopyWith<$Res>(_value.recentActivity!,
        (value) {
      return _then(_value.copyWith(recentActivity: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PartyDetailResponseModelImplCopyWith<$Res>
    implements $PartyDetailResponseModelCopyWith<$Res> {
  factory _$$PartyDetailResponseModelImplCopyWith(
          _$PartyDetailResponseModelImpl value,
          $Res Function(_$PartyDetailResponseModelImpl) then) =
      __$$PartyDetailResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      PartyModel party,
      @JsonKey(name: 'transaction_summary')
      PartyTransactionSummaryModel? transactionSummary,
      @JsonKey(name: 'recent_activity')
      PartyRecentActivityModel? recentActivity});

  @override
  $PartyTransactionSummaryModelCopyWith<$Res>? get transactionSummary;
  @override
  $PartyRecentActivityModelCopyWith<$Res>? get recentActivity;
}

/// @nodoc
class __$$PartyDetailResponseModelImplCopyWithImpl<$Res>
    extends _$PartyDetailResponseModelCopyWithImpl<$Res,
        _$PartyDetailResponseModelImpl>
    implements _$$PartyDetailResponseModelImplCopyWith<$Res> {
  __$$PartyDetailResponseModelImplCopyWithImpl(
      _$PartyDetailResponseModelImpl _value,
      $Res Function(_$PartyDetailResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartyDetailResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? party = null,
    Object? transactionSummary = freezed,
    Object? recentActivity = freezed,
  }) {
    return _then(_$PartyDetailResponseModelImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      party: null == party
          ? _value.party
          : party // ignore: cast_nullable_to_non_nullable
              as PartyModel,
      transactionSummary: freezed == transactionSummary
          ? _value.transactionSummary
          : transactionSummary // ignore: cast_nullable_to_non_nullable
              as PartyTransactionSummaryModel?,
      recentActivity: freezed == recentActivity
          ? _value.recentActivity
          : recentActivity // ignore: cast_nullable_to_non_nullable
              as PartyRecentActivityModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartyDetailResponseModelImpl implements _PartyDetailResponseModel {
  const _$PartyDetailResponseModelImpl(
      {required this.success,
      required this.party,
      @JsonKey(name: 'transaction_summary') this.transactionSummary,
      @JsonKey(name: 'recent_activity') this.recentActivity});

  factory _$PartyDetailResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartyDetailResponseModelImplFromJson(json);

  @override
  final bool success;
  @override
  final PartyModel party;
  @override
  @JsonKey(name: 'transaction_summary')
  final PartyTransactionSummaryModel? transactionSummary;
  @override
  @JsonKey(name: 'recent_activity')
  final PartyRecentActivityModel? recentActivity;

  @override
  String toString() {
    return 'PartyDetailResponseModel(success: $success, party: $party, transactionSummary: $transactionSummary, recentActivity: $recentActivity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartyDetailResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.party, party) || other.party == party) &&
            (identical(other.transactionSummary, transactionSummary) ||
                other.transactionSummary == transactionSummary) &&
            (identical(other.recentActivity, recentActivity) ||
                other.recentActivity == recentActivity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, success, party, transactionSummary, recentActivity);

  /// Create a copy of PartyDetailResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartyDetailResponseModelImplCopyWith<_$PartyDetailResponseModelImpl>
      get copyWith => __$$PartyDetailResponseModelImplCopyWithImpl<
          _$PartyDetailResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartyDetailResponseModelImplToJson(
      this,
    );
  }
}

abstract class _PartyDetailResponseModel implements PartyDetailResponseModel {
  const factory _PartyDetailResponseModel(
          {required final bool success,
          required final PartyModel party,
          @JsonKey(name: 'transaction_summary')
          final PartyTransactionSummaryModel? transactionSummary,
          @JsonKey(name: 'recent_activity')
          final PartyRecentActivityModel? recentActivity}) =
      _$PartyDetailResponseModelImpl;

  factory _PartyDetailResponseModel.fromJson(Map<String, dynamic> json) =
      _$PartyDetailResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  PartyModel get party;
  @override
  @JsonKey(name: 'transaction_summary')
  PartyTransactionSummaryModel? get transactionSummary;
  @override
  @JsonKey(name: 'recent_activity')
  PartyRecentActivityModel? get recentActivity;

  /// Create a copy of PartyDetailResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartyDetailResponseModelImplCopyWith<_$PartyDetailResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

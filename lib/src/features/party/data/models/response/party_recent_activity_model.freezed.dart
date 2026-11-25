// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'party_recent_activity_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartyRecentActivityModel _$PartyRecentActivityModelFromJson(
    Map<String, dynamic> json) {
  return _PartyRecentActivityModel.fromJson(json);
}

/// @nodoc
mixin _$PartyRecentActivityModel {
  @JsonKey(name: 'sales_last_30_days')
  int? get salesLast30Days => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchases_last_30_days')
  int? get purchasesLast30Days => throw _privateConstructorUsedError;
  @JsonKey(name: 'payments_last_30_days')
  int? get paymentsLast30Days => throw _privateConstructorUsedError;

  /// Serializes this PartyRecentActivityModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartyRecentActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartyRecentActivityModelCopyWith<PartyRecentActivityModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartyRecentActivityModelCopyWith<$Res> {
  factory $PartyRecentActivityModelCopyWith(PartyRecentActivityModel value,
          $Res Function(PartyRecentActivityModel) then) =
      _$PartyRecentActivityModelCopyWithImpl<$Res, PartyRecentActivityModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'sales_last_30_days') int? salesLast30Days,
      @JsonKey(name: 'purchases_last_30_days') int? purchasesLast30Days,
      @JsonKey(name: 'payments_last_30_days') int? paymentsLast30Days});
}

/// @nodoc
class _$PartyRecentActivityModelCopyWithImpl<$Res,
        $Val extends PartyRecentActivityModel>
    implements $PartyRecentActivityModelCopyWith<$Res> {
  _$PartyRecentActivityModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartyRecentActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? salesLast30Days = freezed,
    Object? purchasesLast30Days = freezed,
    Object? paymentsLast30Days = freezed,
  }) {
    return _then(_value.copyWith(
      salesLast30Days: freezed == salesLast30Days
          ? _value.salesLast30Days
          : salesLast30Days // ignore: cast_nullable_to_non_nullable
              as int?,
      purchasesLast30Days: freezed == purchasesLast30Days
          ? _value.purchasesLast30Days
          : purchasesLast30Days // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentsLast30Days: freezed == paymentsLast30Days
          ? _value.paymentsLast30Days
          : paymentsLast30Days // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartyRecentActivityModelImplCopyWith<$Res>
    implements $PartyRecentActivityModelCopyWith<$Res> {
  factory _$$PartyRecentActivityModelImplCopyWith(
          _$PartyRecentActivityModelImpl value,
          $Res Function(_$PartyRecentActivityModelImpl) then) =
      __$$PartyRecentActivityModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'sales_last_30_days') int? salesLast30Days,
      @JsonKey(name: 'purchases_last_30_days') int? purchasesLast30Days,
      @JsonKey(name: 'payments_last_30_days') int? paymentsLast30Days});
}

/// @nodoc
class __$$PartyRecentActivityModelImplCopyWithImpl<$Res>
    extends _$PartyRecentActivityModelCopyWithImpl<$Res,
        _$PartyRecentActivityModelImpl>
    implements _$$PartyRecentActivityModelImplCopyWith<$Res> {
  __$$PartyRecentActivityModelImplCopyWithImpl(
      _$PartyRecentActivityModelImpl _value,
      $Res Function(_$PartyRecentActivityModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartyRecentActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? salesLast30Days = freezed,
    Object? purchasesLast30Days = freezed,
    Object? paymentsLast30Days = freezed,
  }) {
    return _then(_$PartyRecentActivityModelImpl(
      salesLast30Days: freezed == salesLast30Days
          ? _value.salesLast30Days
          : salesLast30Days // ignore: cast_nullable_to_non_nullable
              as int?,
      purchasesLast30Days: freezed == purchasesLast30Days
          ? _value.purchasesLast30Days
          : purchasesLast30Days // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentsLast30Days: freezed == paymentsLast30Days
          ? _value.paymentsLast30Days
          : paymentsLast30Days // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartyRecentActivityModelImpl implements _PartyRecentActivityModel {
  const _$PartyRecentActivityModelImpl(
      {@JsonKey(name: 'sales_last_30_days') this.salesLast30Days,
      @JsonKey(name: 'purchases_last_30_days') this.purchasesLast30Days,
      @JsonKey(name: 'payments_last_30_days') this.paymentsLast30Days});

  factory _$PartyRecentActivityModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartyRecentActivityModelImplFromJson(json);

  @override
  @JsonKey(name: 'sales_last_30_days')
  final int? salesLast30Days;
  @override
  @JsonKey(name: 'purchases_last_30_days')
  final int? purchasesLast30Days;
  @override
  @JsonKey(name: 'payments_last_30_days')
  final int? paymentsLast30Days;

  @override
  String toString() {
    return 'PartyRecentActivityModel(salesLast30Days: $salesLast30Days, purchasesLast30Days: $purchasesLast30Days, paymentsLast30Days: $paymentsLast30Days)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartyRecentActivityModelImpl &&
            (identical(other.salesLast30Days, salesLast30Days) ||
                other.salesLast30Days == salesLast30Days) &&
            (identical(other.purchasesLast30Days, purchasesLast30Days) ||
                other.purchasesLast30Days == purchasesLast30Days) &&
            (identical(other.paymentsLast30Days, paymentsLast30Days) ||
                other.paymentsLast30Days == paymentsLast30Days));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, salesLast30Days, purchasesLast30Days, paymentsLast30Days);

  /// Create a copy of PartyRecentActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartyRecentActivityModelImplCopyWith<_$PartyRecentActivityModelImpl>
      get copyWith => __$$PartyRecentActivityModelImplCopyWithImpl<
          _$PartyRecentActivityModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartyRecentActivityModelImplToJson(
      this,
    );
  }
}

abstract class _PartyRecentActivityModel implements PartyRecentActivityModel {
  const factory _PartyRecentActivityModel(
      {@JsonKey(name: 'sales_last_30_days') final int? salesLast30Days,
      @JsonKey(name: 'purchases_last_30_days') final int? purchasesLast30Days,
      @JsonKey(name: 'payments_last_30_days')
      final int? paymentsLast30Days}) = _$PartyRecentActivityModelImpl;

  factory _PartyRecentActivityModel.fromJson(Map<String, dynamic> json) =
      _$PartyRecentActivityModelImpl.fromJson;

  @override
  @JsonKey(name: 'sales_last_30_days')
  int? get salesLast30Days;
  @override
  @JsonKey(name: 'purchases_last_30_days')
  int? get purchasesLast30Days;
  @override
  @JsonKey(name: 'payments_last_30_days')
  int? get paymentsLast30Days;

  /// Create a copy of PartyRecentActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartyRecentActivityModelImplCopyWith<_$PartyRecentActivityModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

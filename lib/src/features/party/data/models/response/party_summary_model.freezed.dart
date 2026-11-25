// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'party_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartySummaryModel _$PartySummaryModelFromJson(Map<String, dynamic> json) {
  return _PartySummaryModel.fromJson(json);
}

/// @nodoc
mixin _$PartySummaryModel {
  @JsonKey(name: 'total_parties')
  int? get totalParties => throw _privateConstructorUsedError;
  @JsonKey(name: 'parties_with_sales')
  int? get partiesWithSales => throw _privateConstructorUsedError;
  @JsonKey(name: 'parties_with_purchases')
  int? get partiesWithPurchases => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_outstanding')
  double? get totalOutstanding => throw _privateConstructorUsedError;
  @JsonKey(name: 'parties_with_outstanding')
  int? get partiesWithOutstanding => throw _privateConstructorUsedError;

  /// Serializes this PartySummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartySummaryModelCopyWith<PartySummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartySummaryModelCopyWith<$Res> {
  factory $PartySummaryModelCopyWith(
          PartySummaryModel value, $Res Function(PartySummaryModel) then) =
      _$PartySummaryModelCopyWithImpl<$Res, PartySummaryModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_parties') int? totalParties,
      @JsonKey(name: 'parties_with_sales') int? partiesWithSales,
      @JsonKey(name: 'parties_with_purchases') int? partiesWithPurchases,
      @JsonKey(name: 'total_outstanding') double? totalOutstanding,
      @JsonKey(name: 'parties_with_outstanding') int? partiesWithOutstanding});
}

/// @nodoc
class _$PartySummaryModelCopyWithImpl<$Res, $Val extends PartySummaryModel>
    implements $PartySummaryModelCopyWith<$Res> {
  _$PartySummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalParties = freezed,
    Object? partiesWithSales = freezed,
    Object? partiesWithPurchases = freezed,
    Object? totalOutstanding = freezed,
    Object? partiesWithOutstanding = freezed,
  }) {
    return _then(_value.copyWith(
      totalParties: freezed == totalParties
          ? _value.totalParties
          : totalParties // ignore: cast_nullable_to_non_nullable
              as int?,
      partiesWithSales: freezed == partiesWithSales
          ? _value.partiesWithSales
          : partiesWithSales // ignore: cast_nullable_to_non_nullable
              as int?,
      partiesWithPurchases: freezed == partiesWithPurchases
          ? _value.partiesWithPurchases
          : partiesWithPurchases // ignore: cast_nullable_to_non_nullable
              as int?,
      totalOutstanding: freezed == totalOutstanding
          ? _value.totalOutstanding
          : totalOutstanding // ignore: cast_nullable_to_non_nullable
              as double?,
      partiesWithOutstanding: freezed == partiesWithOutstanding
          ? _value.partiesWithOutstanding
          : partiesWithOutstanding // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartySummaryModelImplCopyWith<$Res>
    implements $PartySummaryModelCopyWith<$Res> {
  factory _$$PartySummaryModelImplCopyWith(_$PartySummaryModelImpl value,
          $Res Function(_$PartySummaryModelImpl) then) =
      __$$PartySummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_parties') int? totalParties,
      @JsonKey(name: 'parties_with_sales') int? partiesWithSales,
      @JsonKey(name: 'parties_with_purchases') int? partiesWithPurchases,
      @JsonKey(name: 'total_outstanding') double? totalOutstanding,
      @JsonKey(name: 'parties_with_outstanding') int? partiesWithOutstanding});
}

/// @nodoc
class __$$PartySummaryModelImplCopyWithImpl<$Res>
    extends _$PartySummaryModelCopyWithImpl<$Res, _$PartySummaryModelImpl>
    implements _$$PartySummaryModelImplCopyWith<$Res> {
  __$$PartySummaryModelImplCopyWithImpl(_$PartySummaryModelImpl _value,
      $Res Function(_$PartySummaryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalParties = freezed,
    Object? partiesWithSales = freezed,
    Object? partiesWithPurchases = freezed,
    Object? totalOutstanding = freezed,
    Object? partiesWithOutstanding = freezed,
  }) {
    return _then(_$PartySummaryModelImpl(
      totalParties: freezed == totalParties
          ? _value.totalParties
          : totalParties // ignore: cast_nullable_to_non_nullable
              as int?,
      partiesWithSales: freezed == partiesWithSales
          ? _value.partiesWithSales
          : partiesWithSales // ignore: cast_nullable_to_non_nullable
              as int?,
      partiesWithPurchases: freezed == partiesWithPurchases
          ? _value.partiesWithPurchases
          : partiesWithPurchases // ignore: cast_nullable_to_non_nullable
              as int?,
      totalOutstanding: freezed == totalOutstanding
          ? _value.totalOutstanding
          : totalOutstanding // ignore: cast_nullable_to_non_nullable
              as double?,
      partiesWithOutstanding: freezed == partiesWithOutstanding
          ? _value.partiesWithOutstanding
          : partiesWithOutstanding // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartySummaryModelImpl implements _PartySummaryModel {
  const _$PartySummaryModelImpl(
      {@JsonKey(name: 'total_parties') this.totalParties,
      @JsonKey(name: 'parties_with_sales') this.partiesWithSales,
      @JsonKey(name: 'parties_with_purchases') this.partiesWithPurchases,
      @JsonKey(name: 'total_outstanding') this.totalOutstanding,
      @JsonKey(name: 'parties_with_outstanding') this.partiesWithOutstanding});

  factory _$PartySummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartySummaryModelImplFromJson(json);

  @override
  @JsonKey(name: 'total_parties')
  final int? totalParties;
  @override
  @JsonKey(name: 'parties_with_sales')
  final int? partiesWithSales;
  @override
  @JsonKey(name: 'parties_with_purchases')
  final int? partiesWithPurchases;
  @override
  @JsonKey(name: 'total_outstanding')
  final double? totalOutstanding;
  @override
  @JsonKey(name: 'parties_with_outstanding')
  final int? partiesWithOutstanding;

  @override
  String toString() {
    return 'PartySummaryModel(totalParties: $totalParties, partiesWithSales: $partiesWithSales, partiesWithPurchases: $partiesWithPurchases, totalOutstanding: $totalOutstanding, partiesWithOutstanding: $partiesWithOutstanding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartySummaryModelImpl &&
            (identical(other.totalParties, totalParties) ||
                other.totalParties == totalParties) &&
            (identical(other.partiesWithSales, partiesWithSales) ||
                other.partiesWithSales == partiesWithSales) &&
            (identical(other.partiesWithPurchases, partiesWithPurchases) ||
                other.partiesWithPurchases == partiesWithPurchases) &&
            (identical(other.totalOutstanding, totalOutstanding) ||
                other.totalOutstanding == totalOutstanding) &&
            (identical(other.partiesWithOutstanding, partiesWithOutstanding) ||
                other.partiesWithOutstanding == partiesWithOutstanding));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalParties, partiesWithSales,
      partiesWithPurchases, totalOutstanding, partiesWithOutstanding);

  /// Create a copy of PartySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartySummaryModelImplCopyWith<_$PartySummaryModelImpl> get copyWith =>
      __$$PartySummaryModelImplCopyWithImpl<_$PartySummaryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartySummaryModelImplToJson(
      this,
    );
  }
}

abstract class _PartySummaryModel implements PartySummaryModel {
  const factory _PartySummaryModel(
      {@JsonKey(name: 'total_parties') final int? totalParties,
      @JsonKey(name: 'parties_with_sales') final int? partiesWithSales,
      @JsonKey(name: 'parties_with_purchases') final int? partiesWithPurchases,
      @JsonKey(name: 'total_outstanding') final double? totalOutstanding,
      @JsonKey(name: 'parties_with_outstanding')
      final int? partiesWithOutstanding}) = _$PartySummaryModelImpl;

  factory _PartySummaryModel.fromJson(Map<String, dynamic> json) =
      _$PartySummaryModelImpl.fromJson;

  @override
  @JsonKey(name: 'total_parties')
  int? get totalParties;
  @override
  @JsonKey(name: 'parties_with_sales')
  int? get partiesWithSales;
  @override
  @JsonKey(name: 'parties_with_purchases')
  int? get partiesWithPurchases;
  @override
  @JsonKey(name: 'total_outstanding')
  double? get totalOutstanding;
  @override
  @JsonKey(name: 'parties_with_outstanding')
  int? get partiesWithOutstanding;

  /// Create a copy of PartySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartySummaryModelImplCopyWith<_$PartySummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

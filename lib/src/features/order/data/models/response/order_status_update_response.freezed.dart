// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_status_update_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderStatusUpdateResponse _$OrderStatusUpdateResponseFromJson(
    Map<String, dynamic> json) {
  return _OrderStatusUpdateResponse.fromJson(json);
}

/// @nodoc
mixin _$OrderStatusUpdateResponse {
  String? get message => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// e.g. Accepted, Completed, Cancelled
  @JsonKey(name: 'order_status')
  String? get orderStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'sales_invoice_name')
  String? get salesInvoiceName => throw _privateConstructorUsedError;
  @JsonKey(name: 'net_total', fromJson: _netTotalFromJson)
  double? get netTotal => throw _privateConstructorUsedError;

  /// e.g. draft SalesInvoice note when status is Completed
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this OrderStatusUpdateResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderStatusUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderStatusUpdateResponseCopyWith<OrderStatusUpdateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStatusUpdateResponseCopyWith<$Res> {
  factory $OrderStatusUpdateResponseCopyWith(OrderStatusUpdateResponse value,
          $Res Function(OrderStatusUpdateResponse) then) =
      _$OrderStatusUpdateResponseCopyWithImpl<$Res, OrderStatusUpdateResponse>;
  @useResult
  $Res call(
      {String? message,
      String? name,
      @JsonKey(name: 'order_status') String? orderStatus,
      @JsonKey(name: 'sales_invoice_name') String? salesInvoiceName,
      @JsonKey(name: 'net_total', fromJson: _netTotalFromJson) double? netTotal,
      String? note});
}

/// @nodoc
class _$OrderStatusUpdateResponseCopyWithImpl<$Res,
        $Val extends OrderStatusUpdateResponse>
    implements $OrderStatusUpdateResponseCopyWith<$Res> {
  _$OrderStatusUpdateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderStatusUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? name = freezed,
    Object? orderStatus = freezed,
    Object? salesInvoiceName = freezed,
    Object? netTotal = freezed,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      orderStatus: freezed == orderStatus
          ? _value.orderStatus
          : orderStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      salesInvoiceName: freezed == salesInvoiceName
          ? _value.salesInvoiceName
          : salesInvoiceName // ignore: cast_nullable_to_non_nullable
              as String?,
      netTotal: freezed == netTotal
          ? _value.netTotal
          : netTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderStatusUpdateResponseImplCopyWith<$Res>
    implements $OrderStatusUpdateResponseCopyWith<$Res> {
  factory _$$OrderStatusUpdateResponseImplCopyWith(
          _$OrderStatusUpdateResponseImpl value,
          $Res Function(_$OrderStatusUpdateResponseImpl) then) =
      __$$OrderStatusUpdateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? message,
      String? name,
      @JsonKey(name: 'order_status') String? orderStatus,
      @JsonKey(name: 'sales_invoice_name') String? salesInvoiceName,
      @JsonKey(name: 'net_total', fromJson: _netTotalFromJson) double? netTotal,
      String? note});
}

/// @nodoc
class __$$OrderStatusUpdateResponseImplCopyWithImpl<$Res>
    extends _$OrderStatusUpdateResponseCopyWithImpl<$Res,
        _$OrderStatusUpdateResponseImpl>
    implements _$$OrderStatusUpdateResponseImplCopyWith<$Res> {
  __$$OrderStatusUpdateResponseImplCopyWithImpl(
      _$OrderStatusUpdateResponseImpl _value,
      $Res Function(_$OrderStatusUpdateResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderStatusUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? name = freezed,
    Object? orderStatus = freezed,
    Object? salesInvoiceName = freezed,
    Object? netTotal = freezed,
    Object? note = freezed,
  }) {
    return _then(_$OrderStatusUpdateResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      orderStatus: freezed == orderStatus
          ? _value.orderStatus
          : orderStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      salesInvoiceName: freezed == salesInvoiceName
          ? _value.salesInvoiceName
          : salesInvoiceName // ignore: cast_nullable_to_non_nullable
              as String?,
      netTotal: freezed == netTotal
          ? _value.netTotal
          : netTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderStatusUpdateResponseImpl implements _OrderStatusUpdateResponse {
  const _$OrderStatusUpdateResponseImpl(
      {this.message,
      this.name,
      @JsonKey(name: 'order_status') this.orderStatus,
      @JsonKey(name: 'sales_invoice_name') this.salesInvoiceName,
      @JsonKey(name: 'net_total', fromJson: _netTotalFromJson) this.netTotal,
      this.note});

  factory _$OrderStatusUpdateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderStatusUpdateResponseImplFromJson(json);

  @override
  final String? message;
  @override
  final String? name;

  /// e.g. Accepted, Completed, Cancelled
  @override
  @JsonKey(name: 'order_status')
  final String? orderStatus;
  @override
  @JsonKey(name: 'sales_invoice_name')
  final String? salesInvoiceName;
  @override
  @JsonKey(name: 'net_total', fromJson: _netTotalFromJson)
  final double? netTotal;

  /// e.g. draft SalesInvoice note when status is Completed
  @override
  final String? note;

  @override
  String toString() {
    return 'OrderStatusUpdateResponse(message: $message, name: $name, orderStatus: $orderStatus, salesInvoiceName: $salesInvoiceName, netTotal: $netTotal, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderStatusUpdateResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.orderStatus, orderStatus) ||
                other.orderStatus == orderStatus) &&
            (identical(other.salesInvoiceName, salesInvoiceName) ||
                other.salesInvoiceName == salesInvoiceName) &&
            (identical(other.netTotal, netTotal) ||
                other.netTotal == netTotal) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, name, orderStatus,
      salesInvoiceName, netTotal, note);

  /// Create a copy of OrderStatusUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderStatusUpdateResponseImplCopyWith<_$OrderStatusUpdateResponseImpl>
      get copyWith => __$$OrderStatusUpdateResponseImplCopyWithImpl<
          _$OrderStatusUpdateResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderStatusUpdateResponseImplToJson(
      this,
    );
  }
}

abstract class _OrderStatusUpdateResponse implements OrderStatusUpdateResponse {
  const factory _OrderStatusUpdateResponse(
      {final String? message,
      final String? name,
      @JsonKey(name: 'order_status') final String? orderStatus,
      @JsonKey(name: 'sales_invoice_name') final String? salesInvoiceName,
      @JsonKey(name: 'net_total', fromJson: _netTotalFromJson)
      final double? netTotal,
      final String? note}) = _$OrderStatusUpdateResponseImpl;

  factory _OrderStatusUpdateResponse.fromJson(Map<String, dynamic> json) =
      _$OrderStatusUpdateResponseImpl.fromJson;

  @override
  String? get message;
  @override
  String? get name;

  /// e.g. Accepted, Completed, Cancelled
  @override
  @JsonKey(name: 'order_status')
  String? get orderStatus;
  @override
  @JsonKey(name: 'sales_invoice_name')
  String? get salesInvoiceName;
  @override
  @JsonKey(name: 'net_total', fromJson: _netTotalFromJson)
  double? get netTotal;

  /// e.g. draft SalesInvoice note when status is Completed
  @override
  String? get note;

  /// Create a copy of OrderStatusUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderStatusUpdateResponseImplCopyWith<_$OrderStatusUpdateResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

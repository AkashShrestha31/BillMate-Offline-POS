// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrderDetailState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(OrderModel? cachedOrder) loading,
    required TResult Function(OrderModel? cachedOrder) noInternet,
    required TResult Function(String message, OrderModel? cachedOrder) error,
    required TResult Function(
            OrderModel order,
            bool isCheckoutLoading,
            String? errorMessage,
            bool isNoInternet,
            List<OrderActivityEntry> activities,
            bool isActivityLoading,
            String? activityErrorMessage)
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(OrderModel? cachedOrder)? loading,
    TResult? Function(OrderModel? cachedOrder)? noInternet,
    TResult? Function(String message, OrderModel? cachedOrder)? error,
    TResult? Function(
            OrderModel order,
            bool isCheckoutLoading,
            String? errorMessage,
            bool isNoInternet,
            List<OrderActivityEntry> activities,
            bool isActivityLoading,
            String? activityErrorMessage)?
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(OrderModel? cachedOrder)? loading,
    TResult Function(OrderModel? cachedOrder)? noInternet,
    TResult Function(String message, OrderModel? cachedOrder)? error,
    TResult Function(
            OrderModel order,
            bool isCheckoutLoading,
            String? errorMessage,
            bool isNoInternet,
            List<OrderActivityEntry> activities,
            bool isActivityLoading,
            String? activityErrorMessage)?
        loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_Error value)? error,
    TResult? Function(_Loaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderDetailStateCopyWith<$Res> {
  factory $OrderDetailStateCopyWith(
          OrderDetailState value, $Res Function(OrderDetailState) then) =
      _$OrderDetailStateCopyWithImpl<$Res, OrderDetailState>;
}

/// @nodoc
class _$OrderDetailStateCopyWithImpl<$Res, $Val extends OrderDetailState>
    implements $OrderDetailStateCopyWith<$Res> {
  _$OrderDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderDetailState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$OrderDetailStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderDetailState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'OrderDetailState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(OrderModel? cachedOrder) loading,
    required TResult Function(OrderModel? cachedOrder) noInternet,
    required TResult Function(String message, OrderModel? cachedOrder) error,
    required TResult Function(
            OrderModel order,
            bool isCheckoutLoading,
            String? errorMessage,
            bool isNoInternet,
            List<OrderActivityEntry> activities,
            bool isActivityLoading,
            String? activityErrorMessage)
        loaded,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(OrderModel? cachedOrder)? loading,
    TResult? Function(OrderModel? cachedOrder)? noInternet,
    TResult? Function(String message, OrderModel? cachedOrder)? error,
    TResult? Function(
            OrderModel order,
            bool isCheckoutLoading,
            String? errorMessage,
            bool isNoInternet,
            List<OrderActivityEntry> activities,
            bool isActivityLoading,
            String? activityErrorMessage)?
        loaded,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(OrderModel? cachedOrder)? loading,
    TResult Function(OrderModel? cachedOrder)? noInternet,
    TResult Function(String message, OrderModel? cachedOrder)? error,
    TResult Function(
            OrderModel order,
            bool isCheckoutLoading,
            String? errorMessage,
            bool isNoInternet,
            List<OrderActivityEntry> activities,
            bool isActivityLoading,
            String? activityErrorMessage)?
        loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_Error value)? error,
    TResult? Function(_Loaded value)? loaded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements OrderDetailState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({OrderModel? cachedOrder});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$OrderDetailStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cachedOrder = freezed,
  }) {
    return _then(_$LoadingImpl(
      cachedOrder: freezed == cachedOrder
          ? _value.cachedOrder
          : cachedOrder // ignore: cast_nullable_to_non_nullable
              as OrderModel?,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl({this.cachedOrder});

  @override
  final OrderModel? cachedOrder;

  @override
  String toString() {
    return 'OrderDetailState.loading(cachedOrder: $cachedOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.cachedOrder, cachedOrder) ||
                other.cachedOrder == cachedOrder));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cachedOrder);

  /// Create a copy of OrderDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(OrderModel? cachedOrder) loading,
    required TResult Function(OrderModel? cachedOrder) noInternet,
    required TResult Function(String message, OrderModel? cachedOrder) error,
    required TResult Function(
            OrderModel order,
            bool isCheckoutLoading,
            String? errorMessage,
            bool isNoInternet,
            List<OrderActivityEntry> activities,
            bool isActivityLoading,
            String? activityErrorMessage)
        loaded,
  }) {
    return loading(cachedOrder);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(OrderModel? cachedOrder)? loading,
    TResult? Function(OrderModel? cachedOrder)? noInternet,
    TResult? Function(String message, OrderModel? cachedOrder)? error,
    TResult? Function(
            OrderModel order,
            bool isCheckoutLoading,
            String? errorMessage,
            bool isNoInternet,
            List<OrderActivityEntry> activities,
            bool isActivityLoading,
            String? activityErrorMessage)?
        loaded,
  }) {
    return loading?.call(cachedOrder);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(OrderModel? cachedOrder)? loading,
    TResult Function(OrderModel? cachedOrder)? noInternet,
    TResult Function(String message, OrderModel? cachedOrder)? error,
    TResult Function(
            OrderModel order,
            bool isCheckoutLoading,
            String? errorMessage,
            bool isNoInternet,
            List<OrderActivityEntry> activities,
            bool isActivityLoading,
            String? activityErrorMessage)?
        loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(cachedOrder);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_Error value)? error,
    TResult? Function(_Loaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements OrderDetailState {
  const factory _Loading({final OrderModel? cachedOrder}) = _$LoadingImpl;

  OrderModel? get cachedOrder;

  /// Create a copy of OrderDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NoInternetImplCopyWith<$Res> {
  factory _$$NoInternetImplCopyWith(
          _$NoInternetImpl value, $Res Function(_$NoInternetImpl) then) =
      __$$NoInternetImplCopyWithImpl<$Res>;
  @useResult
  $Res call({OrderModel? cachedOrder});
}

/// @nodoc
class __$$NoInternetImplCopyWithImpl<$Res>
    extends _$OrderDetailStateCopyWithImpl<$Res, _$NoInternetImpl>
    implements _$$NoInternetImplCopyWith<$Res> {
  __$$NoInternetImplCopyWithImpl(
      _$NoInternetImpl _value, $Res Function(_$NoInternetImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cachedOrder = freezed,
  }) {
    return _then(_$NoInternetImpl(
      cachedOrder: freezed == cachedOrder
          ? _value.cachedOrder
          : cachedOrder // ignore: cast_nullable_to_non_nullable
              as OrderModel?,
    ));
  }
}

/// @nodoc

class _$NoInternetImpl implements _NoInternet {
  const _$NoInternetImpl({this.cachedOrder});

  @override
  final OrderModel? cachedOrder;

  @override
  String toString() {
    return 'OrderDetailState.noInternet(cachedOrder: $cachedOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoInternetImpl &&
            (identical(other.cachedOrder, cachedOrder) ||
                other.cachedOrder == cachedOrder));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cachedOrder);

  /// Create a copy of OrderDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoInternetImplCopyWith<_$NoInternetImpl> get copyWith =>
      __$$NoInternetImplCopyWithImpl<_$NoInternetImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(OrderModel? cachedOrder) loading,
    required TResult Function(OrderModel? cachedOrder) noInternet,
    required TResult Function(String message, OrderModel? cachedOrder) error,
    required TResult Function(
            OrderModel order,
            bool isCheckoutLoading,
            String? errorMessage,
            bool isNoInternet,
            List<OrderActivityEntry> activities,
            bool isActivityLoading,
            String? activityErrorMessage)
        loaded,
  }) {
    return noInternet(cachedOrder);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(OrderModel? cachedOrder)? loading,
    TResult? Function(OrderModel? cachedOrder)? noInternet,
    TResult? Function(String message, OrderModel? cachedOrder)? error,
    TResult? Function(
            OrderModel order,
            bool isCheckoutLoading,
            String? errorMessage,
            bool isNoInternet,
            List<OrderActivityEntry> activities,
            bool isActivityLoading,
            String? activityErrorMessage)?
        loaded,
  }) {
    return noInternet?.call(cachedOrder);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(OrderModel? cachedOrder)? loading,
    TResult Function(OrderModel? cachedOrder)? noInternet,
    TResult Function(String message, OrderModel? cachedOrder)? error,
    TResult Function(
            OrderModel order,
            bool isCheckoutLoading,
            String? errorMessage,
            bool isNoInternet,
            List<OrderActivityEntry> activities,
            bool isActivityLoading,
            String? activityErrorMessage)?
        loaded,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet(cachedOrder);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) {
    return noInternet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_Error value)? error,
    TResult? Function(_Loaded value)? loaded,
  }) {
    return noInternet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet(this);
    }
    return orElse();
  }
}

abstract class _NoInternet implements OrderDetailState {
  const factory _NoInternet({final OrderModel? cachedOrder}) = _$NoInternetImpl;

  OrderModel? get cachedOrder;

  /// Create a copy of OrderDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoInternetImplCopyWith<_$NoInternetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, OrderModel? cachedOrder});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$OrderDetailStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? cachedOrder = freezed,
  }) {
    return _then(_$ErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      cachedOrder: freezed == cachedOrder
          ? _value.cachedOrder
          : cachedOrder // ignore: cast_nullable_to_non_nullable
              as OrderModel?,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl({required this.message, this.cachedOrder});

  @override
  final String message;
  @override
  final OrderModel? cachedOrder;

  @override
  String toString() {
    return 'OrderDetailState.error(message: $message, cachedOrder: $cachedOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.cachedOrder, cachedOrder) ||
                other.cachedOrder == cachedOrder));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, cachedOrder);

  /// Create a copy of OrderDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(OrderModel? cachedOrder) loading,
    required TResult Function(OrderModel? cachedOrder) noInternet,
    required TResult Function(String message, OrderModel? cachedOrder) error,
    required TResult Function(
            OrderModel order,
            bool isCheckoutLoading,
            String? errorMessage,
            bool isNoInternet,
            List<OrderActivityEntry> activities,
            bool isActivityLoading,
            String? activityErrorMessage)
        loaded,
  }) {
    return error(message, cachedOrder);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(OrderModel? cachedOrder)? loading,
    TResult? Function(OrderModel? cachedOrder)? noInternet,
    TResult? Function(String message, OrderModel? cachedOrder)? error,
    TResult? Function(
            OrderModel order,
            bool isCheckoutLoading,
            String? errorMessage,
            bool isNoInternet,
            List<OrderActivityEntry> activities,
            bool isActivityLoading,
            String? activityErrorMessage)?
        loaded,
  }) {
    return error?.call(message, cachedOrder);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(OrderModel? cachedOrder)? loading,
    TResult Function(OrderModel? cachedOrder)? noInternet,
    TResult Function(String message, OrderModel? cachedOrder)? error,
    TResult Function(
            OrderModel order,
            bool isCheckoutLoading,
            String? errorMessage,
            bool isNoInternet,
            List<OrderActivityEntry> activities,
            bool isActivityLoading,
            String? activityErrorMessage)?
        loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, cachedOrder);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_Error value)? error,
    TResult? Function(_Loaded value)? loaded,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements OrderDetailState {
  const factory _Error(
      {required final String message,
      final OrderModel? cachedOrder}) = _$ErrorImpl;

  String get message;
  OrderModel? get cachedOrder;

  /// Create a copy of OrderDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {OrderModel order,
      bool isCheckoutLoading,
      String? errorMessage,
      bool isNoInternet,
      List<OrderActivityEntry> activities,
      bool isActivityLoading,
      String? activityErrorMessage});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$OrderDetailStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = null,
    Object? isCheckoutLoading = null,
    Object? errorMessage = freezed,
    Object? isNoInternet = null,
    Object? activities = null,
    Object? isActivityLoading = null,
    Object? activityErrorMessage = freezed,
  }) {
    return _then(_$LoadedImpl(
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderModel,
      isCheckoutLoading: null == isCheckoutLoading
          ? _value.isCheckoutLoading
          : isCheckoutLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isNoInternet: null == isNoInternet
          ? _value.isNoInternet
          : isNoInternet // ignore: cast_nullable_to_non_nullable
              as bool,
      activities: null == activities
          ? _value._activities
          : activities // ignore: cast_nullable_to_non_nullable
              as List<OrderActivityEntry>,
      isActivityLoading: null == isActivityLoading
          ? _value.isActivityLoading
          : isActivityLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      activityErrorMessage: freezed == activityErrorMessage
          ? _value.activityErrorMessage
          : activityErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required this.order,
      this.isCheckoutLoading = false,
      this.errorMessage,
      this.isNoInternet = false,
      final List<OrderActivityEntry> activities = const <OrderActivityEntry>[],
      this.isActivityLoading = false,
      this.activityErrorMessage})
      : _activities = activities;

  @override
  final OrderModel order;
  @override
  @JsonKey()
  final bool isCheckoutLoading;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool isNoInternet;
  final List<OrderActivityEntry> _activities;
  @override
  @JsonKey()
  List<OrderActivityEntry> get activities {
    if (_activities is EqualUnmodifiableListView) return _activities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activities);
  }

  @override
  @JsonKey()
  final bool isActivityLoading;
  @override
  final String? activityErrorMessage;

  @override
  String toString() {
    return 'OrderDetailState.loaded(order: $order, isCheckoutLoading: $isCheckoutLoading, errorMessage: $errorMessage, isNoInternet: $isNoInternet, activities: $activities, isActivityLoading: $isActivityLoading, activityErrorMessage: $activityErrorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.isCheckoutLoading, isCheckoutLoading) ||
                other.isCheckoutLoading == isCheckoutLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isNoInternet, isNoInternet) ||
                other.isNoInternet == isNoInternet) &&
            const DeepCollectionEquality()
                .equals(other._activities, _activities) &&
            (identical(other.isActivityLoading, isActivityLoading) ||
                other.isActivityLoading == isActivityLoading) &&
            (identical(other.activityErrorMessage, activityErrorMessage) ||
                other.activityErrorMessage == activityErrorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      order,
      isCheckoutLoading,
      errorMessage,
      isNoInternet,
      const DeepCollectionEquality().hash(_activities),
      isActivityLoading,
      activityErrorMessage);

  /// Create a copy of OrderDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(OrderModel? cachedOrder) loading,
    required TResult Function(OrderModel? cachedOrder) noInternet,
    required TResult Function(String message, OrderModel? cachedOrder) error,
    required TResult Function(
            OrderModel order,
            bool isCheckoutLoading,
            String? errorMessage,
            bool isNoInternet,
            List<OrderActivityEntry> activities,
            bool isActivityLoading,
            String? activityErrorMessage)
        loaded,
  }) {
    return loaded(order, isCheckoutLoading, errorMessage, isNoInternet,
        activities, isActivityLoading, activityErrorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(OrderModel? cachedOrder)? loading,
    TResult? Function(OrderModel? cachedOrder)? noInternet,
    TResult? Function(String message, OrderModel? cachedOrder)? error,
    TResult? Function(
            OrderModel order,
            bool isCheckoutLoading,
            String? errorMessage,
            bool isNoInternet,
            List<OrderActivityEntry> activities,
            bool isActivityLoading,
            String? activityErrorMessage)?
        loaded,
  }) {
    return loaded?.call(order, isCheckoutLoading, errorMessage, isNoInternet,
        activities, isActivityLoading, activityErrorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(OrderModel? cachedOrder)? loading,
    TResult Function(OrderModel? cachedOrder)? noInternet,
    TResult Function(String message, OrderModel? cachedOrder)? error,
    TResult Function(
            OrderModel order,
            bool isCheckoutLoading,
            String? errorMessage,
            bool isNoInternet,
            List<OrderActivityEntry> activities,
            bool isActivityLoading,
            String? activityErrorMessage)?
        loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(order, isCheckoutLoading, errorMessage, isNoInternet,
          activities, isActivityLoading, activityErrorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_Error value)? error,
    TResult? Function(_Loaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements OrderDetailState {
  const factory _Loaded(
      {required final OrderModel order,
      final bool isCheckoutLoading,
      final String? errorMessage,
      final bool isNoInternet,
      final List<OrderActivityEntry> activities,
      final bool isActivityLoading,
      final String? activityErrorMessage}) = _$LoadedImpl;

  OrderModel get order;
  bool get isCheckoutLoading;
  String? get errorMessage;
  bool get isNoInternet;
  List<OrderActivityEntry> get activities;
  bool get isActivityLoading;
  String? get activityErrorMessage;

  /// Create a copy of OrderDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

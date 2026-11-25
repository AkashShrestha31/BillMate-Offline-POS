// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ItemState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ItemModel> items) loadingMore,
    required TResult Function() noInternet,
    required TResult Function(String message) error,
    required TResult Function(ItemResponseModel response, bool hasMore) success,
    required TResult Function(ItemResponseModel response) detailSuccess,
    required TResult Function(ItemModel response) created,
    required TResult Function(ItemUpdateResponseModel response) updated,
    required TResult Function() deleted,
    required TResult Function(MergeItemsBulkOperationResponse response)
        mergeItemsSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ItemModel> items)? loadingMore,
    TResult? Function()? noInternet,
    TResult? Function(String message)? error,
    TResult? Function(ItemResponseModel response, bool hasMore)? success,
    TResult? Function(ItemResponseModel response)? detailSuccess,
    TResult? Function(ItemModel response)? created,
    TResult? Function(ItemUpdateResponseModel response)? updated,
    TResult? Function()? deleted,
    TResult? Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ItemModel> items)? loadingMore,
    TResult Function()? noInternet,
    TResult Function(String message)? error,
    TResult Function(ItemResponseModel response, bool hasMore)? success,
    TResult Function(ItemResponseModel response)? detailSuccess,
    TResult Function(ItemModel response)? created,
    TResult Function(ItemUpdateResponseModel response)? updated,
    TResult Function()? deleted,
    TResult Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadingMore value) loadingMore,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
    required TResult Function(_DetailSuccess value) detailSuccess,
    required TResult Function(_Created value) created,
    required TResult Function(_Updated value) updated,
    required TResult Function(_Deleted value) deleted,
    required TResult Function(_MergeItemsSuccess value) mergeItemsSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadingMore value)? loadingMore,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
    TResult? Function(_DetailSuccess value)? detailSuccess,
    TResult? Function(_Created value)? created,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_Deleted value)? deleted,
    TResult? Function(_MergeItemsSuccess value)? mergeItemsSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadingMore value)? loadingMore,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    TResult Function(_DetailSuccess value)? detailSuccess,
    TResult Function(_Created value)? created,
    TResult Function(_Updated value)? updated,
    TResult Function(_Deleted value)? deleted,
    TResult Function(_MergeItemsSuccess value)? mergeItemsSuccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemStateCopyWith<$Res> {
  factory $ItemStateCopyWith(ItemState value, $Res Function(ItemState) then) =
      _$ItemStateCopyWithImpl<$Res, ItemState>;
}

/// @nodoc
class _$ItemStateCopyWithImpl<$Res, $Val extends ItemState>
    implements $ItemStateCopyWith<$Res> {
  _$ItemStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ItemState
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
    extends _$ItemStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ItemState.initial()';
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
    required TResult Function() loading,
    required TResult Function(List<ItemModel> items) loadingMore,
    required TResult Function() noInternet,
    required TResult Function(String message) error,
    required TResult Function(ItemResponseModel response, bool hasMore) success,
    required TResult Function(ItemResponseModel response) detailSuccess,
    required TResult Function(ItemModel response) created,
    required TResult Function(ItemUpdateResponseModel response) updated,
    required TResult Function() deleted,
    required TResult Function(MergeItemsBulkOperationResponse response)
        mergeItemsSuccess,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ItemModel> items)? loadingMore,
    TResult? Function()? noInternet,
    TResult? Function(String message)? error,
    TResult? Function(ItemResponseModel response, bool hasMore)? success,
    TResult? Function(ItemResponseModel response)? detailSuccess,
    TResult? Function(ItemModel response)? created,
    TResult? Function(ItemUpdateResponseModel response)? updated,
    TResult? Function()? deleted,
    TResult? Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ItemModel> items)? loadingMore,
    TResult Function()? noInternet,
    TResult Function(String message)? error,
    TResult Function(ItemResponseModel response, bool hasMore)? success,
    TResult Function(ItemResponseModel response)? detailSuccess,
    TResult Function(ItemModel response)? created,
    TResult Function(ItemUpdateResponseModel response)? updated,
    TResult Function()? deleted,
    TResult Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
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
    required TResult Function(_LoadingMore value) loadingMore,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
    required TResult Function(_DetailSuccess value) detailSuccess,
    required TResult Function(_Created value) created,
    required TResult Function(_Updated value) updated,
    required TResult Function(_Deleted value) deleted,
    required TResult Function(_MergeItemsSuccess value) mergeItemsSuccess,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadingMore value)? loadingMore,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
    TResult? Function(_DetailSuccess value)? detailSuccess,
    TResult? Function(_Created value)? created,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_Deleted value)? deleted,
    TResult? Function(_MergeItemsSuccess value)? mergeItemsSuccess,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadingMore value)? loadingMore,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    TResult Function(_DetailSuccess value)? detailSuccess,
    TResult Function(_Created value)? created,
    TResult Function(_Updated value)? updated,
    TResult Function(_Deleted value)? deleted,
    TResult Function(_MergeItemsSuccess value)? mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ItemState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$ItemStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'ItemState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ItemModel> items) loadingMore,
    required TResult Function() noInternet,
    required TResult Function(String message) error,
    required TResult Function(ItemResponseModel response, bool hasMore) success,
    required TResult Function(ItemResponseModel response) detailSuccess,
    required TResult Function(ItemModel response) created,
    required TResult Function(ItemUpdateResponseModel response) updated,
    required TResult Function() deleted,
    required TResult Function(MergeItemsBulkOperationResponse response)
        mergeItemsSuccess,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ItemModel> items)? loadingMore,
    TResult? Function()? noInternet,
    TResult? Function(String message)? error,
    TResult? Function(ItemResponseModel response, bool hasMore)? success,
    TResult? Function(ItemResponseModel response)? detailSuccess,
    TResult? Function(ItemModel response)? created,
    TResult? Function(ItemUpdateResponseModel response)? updated,
    TResult? Function()? deleted,
    TResult? Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ItemModel> items)? loadingMore,
    TResult Function()? noInternet,
    TResult Function(String message)? error,
    TResult Function(ItemResponseModel response, bool hasMore)? success,
    TResult Function(ItemResponseModel response)? detailSuccess,
    TResult Function(ItemModel response)? created,
    TResult Function(ItemUpdateResponseModel response)? updated,
    TResult Function()? deleted,
    TResult Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadingMore value) loadingMore,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
    required TResult Function(_DetailSuccess value) detailSuccess,
    required TResult Function(_Created value) created,
    required TResult Function(_Updated value) updated,
    required TResult Function(_Deleted value) deleted,
    required TResult Function(_MergeItemsSuccess value) mergeItemsSuccess,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadingMore value)? loadingMore,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
    TResult? Function(_DetailSuccess value)? detailSuccess,
    TResult? Function(_Created value)? created,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_Deleted value)? deleted,
    TResult? Function(_MergeItemsSuccess value)? mergeItemsSuccess,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadingMore value)? loadingMore,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    TResult Function(_DetailSuccess value)? detailSuccess,
    TResult Function(_Created value)? created,
    TResult Function(_Updated value)? updated,
    TResult Function(_Deleted value)? deleted,
    TResult Function(_MergeItemsSuccess value)? mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ItemState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadingMoreImplCopyWith<$Res> {
  factory _$$LoadingMoreImplCopyWith(
          _$LoadingMoreImpl value, $Res Function(_$LoadingMoreImpl) then) =
      __$$LoadingMoreImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ItemModel> items});
}

/// @nodoc
class __$$LoadingMoreImplCopyWithImpl<$Res>
    extends _$ItemStateCopyWithImpl<$Res, _$LoadingMoreImpl>
    implements _$$LoadingMoreImplCopyWith<$Res> {
  __$$LoadingMoreImplCopyWithImpl(
      _$LoadingMoreImpl _value, $Res Function(_$LoadingMoreImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_$LoadingMoreImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemModel>,
    ));
  }
}

/// @nodoc

class _$LoadingMoreImpl implements _LoadingMore {
  const _$LoadingMoreImpl({required final List<ItemModel> items})
      : _items = items;

  final List<ItemModel> _items;
  @override
  List<ItemModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'ItemState.loadingMore(items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingMoreImpl &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingMoreImplCopyWith<_$LoadingMoreImpl> get copyWith =>
      __$$LoadingMoreImplCopyWithImpl<_$LoadingMoreImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ItemModel> items) loadingMore,
    required TResult Function() noInternet,
    required TResult Function(String message) error,
    required TResult Function(ItemResponseModel response, bool hasMore) success,
    required TResult Function(ItemResponseModel response) detailSuccess,
    required TResult Function(ItemModel response) created,
    required TResult Function(ItemUpdateResponseModel response) updated,
    required TResult Function() deleted,
    required TResult Function(MergeItemsBulkOperationResponse response)
        mergeItemsSuccess,
  }) {
    return loadingMore(items);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ItemModel> items)? loadingMore,
    TResult? Function()? noInternet,
    TResult? Function(String message)? error,
    TResult? Function(ItemResponseModel response, bool hasMore)? success,
    TResult? Function(ItemResponseModel response)? detailSuccess,
    TResult? Function(ItemModel response)? created,
    TResult? Function(ItemUpdateResponseModel response)? updated,
    TResult? Function()? deleted,
    TResult? Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
  }) {
    return loadingMore?.call(items);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ItemModel> items)? loadingMore,
    TResult Function()? noInternet,
    TResult Function(String message)? error,
    TResult Function(ItemResponseModel response, bool hasMore)? success,
    TResult Function(ItemResponseModel response)? detailSuccess,
    TResult Function(ItemModel response)? created,
    TResult Function(ItemUpdateResponseModel response)? updated,
    TResult Function()? deleted,
    TResult Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (loadingMore != null) {
      return loadingMore(items);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadingMore value) loadingMore,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
    required TResult Function(_DetailSuccess value) detailSuccess,
    required TResult Function(_Created value) created,
    required TResult Function(_Updated value) updated,
    required TResult Function(_Deleted value) deleted,
    required TResult Function(_MergeItemsSuccess value) mergeItemsSuccess,
  }) {
    return loadingMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadingMore value)? loadingMore,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
    TResult? Function(_DetailSuccess value)? detailSuccess,
    TResult? Function(_Created value)? created,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_Deleted value)? deleted,
    TResult? Function(_MergeItemsSuccess value)? mergeItemsSuccess,
  }) {
    return loadingMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadingMore value)? loadingMore,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    TResult Function(_DetailSuccess value)? detailSuccess,
    TResult Function(_Created value)? created,
    TResult Function(_Updated value)? updated,
    TResult Function(_Deleted value)? deleted,
    TResult Function(_MergeItemsSuccess value)? mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (loadingMore != null) {
      return loadingMore(this);
    }
    return orElse();
  }
}

abstract class _LoadingMore implements ItemState {
  const factory _LoadingMore({required final List<ItemModel> items}) =
      _$LoadingMoreImpl;

  List<ItemModel> get items;

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingMoreImplCopyWith<_$LoadingMoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NoInternetImplCopyWith<$Res> {
  factory _$$NoInternetImplCopyWith(
          _$NoInternetImpl value, $Res Function(_$NoInternetImpl) then) =
      __$$NoInternetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoInternetImplCopyWithImpl<$Res>
    extends _$ItemStateCopyWithImpl<$Res, _$NoInternetImpl>
    implements _$$NoInternetImplCopyWith<$Res> {
  __$$NoInternetImplCopyWithImpl(
      _$NoInternetImpl _value, $Res Function(_$NoInternetImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NoInternetImpl implements _NoInternet {
  const _$NoInternetImpl();

  @override
  String toString() {
    return 'ItemState.noInternet()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NoInternetImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ItemModel> items) loadingMore,
    required TResult Function() noInternet,
    required TResult Function(String message) error,
    required TResult Function(ItemResponseModel response, bool hasMore) success,
    required TResult Function(ItemResponseModel response) detailSuccess,
    required TResult Function(ItemModel response) created,
    required TResult Function(ItemUpdateResponseModel response) updated,
    required TResult Function() deleted,
    required TResult Function(MergeItemsBulkOperationResponse response)
        mergeItemsSuccess,
  }) {
    return noInternet();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ItemModel> items)? loadingMore,
    TResult? Function()? noInternet,
    TResult? Function(String message)? error,
    TResult? Function(ItemResponseModel response, bool hasMore)? success,
    TResult? Function(ItemResponseModel response)? detailSuccess,
    TResult? Function(ItemModel response)? created,
    TResult? Function(ItemUpdateResponseModel response)? updated,
    TResult? Function()? deleted,
    TResult? Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
  }) {
    return noInternet?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ItemModel> items)? loadingMore,
    TResult Function()? noInternet,
    TResult Function(String message)? error,
    TResult Function(ItemResponseModel response, bool hasMore)? success,
    TResult Function(ItemResponseModel response)? detailSuccess,
    TResult Function(ItemModel response)? created,
    TResult Function(ItemUpdateResponseModel response)? updated,
    TResult Function()? deleted,
    TResult Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadingMore value) loadingMore,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
    required TResult Function(_DetailSuccess value) detailSuccess,
    required TResult Function(_Created value) created,
    required TResult Function(_Updated value) updated,
    required TResult Function(_Deleted value) deleted,
    required TResult Function(_MergeItemsSuccess value) mergeItemsSuccess,
  }) {
    return noInternet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadingMore value)? loadingMore,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
    TResult? Function(_DetailSuccess value)? detailSuccess,
    TResult? Function(_Created value)? created,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_Deleted value)? deleted,
    TResult? Function(_MergeItemsSuccess value)? mergeItemsSuccess,
  }) {
    return noInternet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadingMore value)? loadingMore,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    TResult Function(_DetailSuccess value)? detailSuccess,
    TResult Function(_Created value)? created,
    TResult Function(_Updated value)? updated,
    TResult Function(_Deleted value)? deleted,
    TResult Function(_MergeItemsSuccess value)? mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet(this);
    }
    return orElse();
  }
}

abstract class _NoInternet implements ItemState {
  const factory _NoInternet() = _$NoInternetImpl;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$ItemStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'ItemState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ItemState
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
    required TResult Function() loading,
    required TResult Function(List<ItemModel> items) loadingMore,
    required TResult Function() noInternet,
    required TResult Function(String message) error,
    required TResult Function(ItemResponseModel response, bool hasMore) success,
    required TResult Function(ItemResponseModel response) detailSuccess,
    required TResult Function(ItemModel response) created,
    required TResult Function(ItemUpdateResponseModel response) updated,
    required TResult Function() deleted,
    required TResult Function(MergeItemsBulkOperationResponse response)
        mergeItemsSuccess,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ItemModel> items)? loadingMore,
    TResult? Function()? noInternet,
    TResult? Function(String message)? error,
    TResult? Function(ItemResponseModel response, bool hasMore)? success,
    TResult? Function(ItemResponseModel response)? detailSuccess,
    TResult? Function(ItemModel response)? created,
    TResult? Function(ItemUpdateResponseModel response)? updated,
    TResult? Function()? deleted,
    TResult? Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ItemModel> items)? loadingMore,
    TResult Function()? noInternet,
    TResult Function(String message)? error,
    TResult Function(ItemResponseModel response, bool hasMore)? success,
    TResult Function(ItemResponseModel response)? detailSuccess,
    TResult Function(ItemModel response)? created,
    TResult Function(ItemUpdateResponseModel response)? updated,
    TResult Function()? deleted,
    TResult Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadingMore value) loadingMore,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
    required TResult Function(_DetailSuccess value) detailSuccess,
    required TResult Function(_Created value) created,
    required TResult Function(_Updated value) updated,
    required TResult Function(_Deleted value) deleted,
    required TResult Function(_MergeItemsSuccess value) mergeItemsSuccess,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadingMore value)? loadingMore,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
    TResult? Function(_DetailSuccess value)? detailSuccess,
    TResult? Function(_Created value)? created,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_Deleted value)? deleted,
    TResult? Function(_MergeItemsSuccess value)? mergeItemsSuccess,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadingMore value)? loadingMore,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    TResult Function(_DetailSuccess value)? detailSuccess,
    TResult Function(_Created value)? created,
    TResult Function(_Updated value)? updated,
    TResult Function(_Deleted value)? deleted,
    TResult Function(_MergeItemsSuccess value)? mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ItemState {
  const factory _Error({required final String message}) = _$ErrorImpl;

  String get message;

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ItemResponseModel response, bool hasMore});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$ItemStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
    Object? hasMore = null,
  }) {
    return _then(_$SuccessImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as ItemResponseModel,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl({required this.response, this.hasMore = false});

  @override
  final ItemResponseModel response;
  @override
  @JsonKey()
  final bool hasMore;

  @override
  String toString() {
    return 'ItemState.success(response: $response, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response, hasMore);

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ItemModel> items) loadingMore,
    required TResult Function() noInternet,
    required TResult Function(String message) error,
    required TResult Function(ItemResponseModel response, bool hasMore) success,
    required TResult Function(ItemResponseModel response) detailSuccess,
    required TResult Function(ItemModel response) created,
    required TResult Function(ItemUpdateResponseModel response) updated,
    required TResult Function() deleted,
    required TResult Function(MergeItemsBulkOperationResponse response)
        mergeItemsSuccess,
  }) {
    return success(response, hasMore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ItemModel> items)? loadingMore,
    TResult? Function()? noInternet,
    TResult? Function(String message)? error,
    TResult? Function(ItemResponseModel response, bool hasMore)? success,
    TResult? Function(ItemResponseModel response)? detailSuccess,
    TResult? Function(ItemModel response)? created,
    TResult? Function(ItemUpdateResponseModel response)? updated,
    TResult? Function()? deleted,
    TResult? Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
  }) {
    return success?.call(response, hasMore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ItemModel> items)? loadingMore,
    TResult Function()? noInternet,
    TResult Function(String message)? error,
    TResult Function(ItemResponseModel response, bool hasMore)? success,
    TResult Function(ItemResponseModel response)? detailSuccess,
    TResult Function(ItemModel response)? created,
    TResult Function(ItemUpdateResponseModel response)? updated,
    TResult Function()? deleted,
    TResult Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(response, hasMore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadingMore value) loadingMore,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
    required TResult Function(_DetailSuccess value) detailSuccess,
    required TResult Function(_Created value) created,
    required TResult Function(_Updated value) updated,
    required TResult Function(_Deleted value) deleted,
    required TResult Function(_MergeItemsSuccess value) mergeItemsSuccess,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadingMore value)? loadingMore,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
    TResult? Function(_DetailSuccess value)? detailSuccess,
    TResult? Function(_Created value)? created,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_Deleted value)? deleted,
    TResult? Function(_MergeItemsSuccess value)? mergeItemsSuccess,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadingMore value)? loadingMore,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    TResult Function(_DetailSuccess value)? detailSuccess,
    TResult Function(_Created value)? created,
    TResult Function(_Updated value)? updated,
    TResult Function(_Deleted value)? deleted,
    TResult Function(_MergeItemsSuccess value)? mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements ItemState {
  const factory _Success(
      {required final ItemResponseModel response,
      final bool hasMore}) = _$SuccessImpl;

  ItemResponseModel get response;
  bool get hasMore;

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DetailSuccessImplCopyWith<$Res> {
  factory _$$DetailSuccessImplCopyWith(
          _$DetailSuccessImpl value, $Res Function(_$DetailSuccessImpl) then) =
      __$$DetailSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ItemResponseModel response});
}

/// @nodoc
class __$$DetailSuccessImplCopyWithImpl<$Res>
    extends _$ItemStateCopyWithImpl<$Res, _$DetailSuccessImpl>
    implements _$$DetailSuccessImplCopyWith<$Res> {
  __$$DetailSuccessImplCopyWithImpl(
      _$DetailSuccessImpl _value, $Res Function(_$DetailSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$DetailSuccessImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as ItemResponseModel,
    ));
  }
}

/// @nodoc

class _$DetailSuccessImpl implements _DetailSuccess {
  const _$DetailSuccessImpl({required this.response});

  @override
  final ItemResponseModel response;

  @override
  String toString() {
    return 'ItemState.detailSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetailSuccessImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DetailSuccessImplCopyWith<_$DetailSuccessImpl> get copyWith =>
      __$$DetailSuccessImplCopyWithImpl<_$DetailSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ItemModel> items) loadingMore,
    required TResult Function() noInternet,
    required TResult Function(String message) error,
    required TResult Function(ItemResponseModel response, bool hasMore) success,
    required TResult Function(ItemResponseModel response) detailSuccess,
    required TResult Function(ItemModel response) created,
    required TResult Function(ItemUpdateResponseModel response) updated,
    required TResult Function() deleted,
    required TResult Function(MergeItemsBulkOperationResponse response)
        mergeItemsSuccess,
  }) {
    return detailSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ItemModel> items)? loadingMore,
    TResult? Function()? noInternet,
    TResult? Function(String message)? error,
    TResult? Function(ItemResponseModel response, bool hasMore)? success,
    TResult? Function(ItemResponseModel response)? detailSuccess,
    TResult? Function(ItemModel response)? created,
    TResult? Function(ItemUpdateResponseModel response)? updated,
    TResult? Function()? deleted,
    TResult? Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
  }) {
    return detailSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ItemModel> items)? loadingMore,
    TResult Function()? noInternet,
    TResult Function(String message)? error,
    TResult Function(ItemResponseModel response, bool hasMore)? success,
    TResult Function(ItemResponseModel response)? detailSuccess,
    TResult Function(ItemModel response)? created,
    TResult Function(ItemUpdateResponseModel response)? updated,
    TResult Function()? deleted,
    TResult Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (detailSuccess != null) {
      return detailSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadingMore value) loadingMore,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
    required TResult Function(_DetailSuccess value) detailSuccess,
    required TResult Function(_Created value) created,
    required TResult Function(_Updated value) updated,
    required TResult Function(_Deleted value) deleted,
    required TResult Function(_MergeItemsSuccess value) mergeItemsSuccess,
  }) {
    return detailSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadingMore value)? loadingMore,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
    TResult? Function(_DetailSuccess value)? detailSuccess,
    TResult? Function(_Created value)? created,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_Deleted value)? deleted,
    TResult? Function(_MergeItemsSuccess value)? mergeItemsSuccess,
  }) {
    return detailSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadingMore value)? loadingMore,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    TResult Function(_DetailSuccess value)? detailSuccess,
    TResult Function(_Created value)? created,
    TResult Function(_Updated value)? updated,
    TResult Function(_Deleted value)? deleted,
    TResult Function(_MergeItemsSuccess value)? mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (detailSuccess != null) {
      return detailSuccess(this);
    }
    return orElse();
  }
}

abstract class _DetailSuccess implements ItemState {
  const factory _DetailSuccess({required final ItemResponseModel response}) =
      _$DetailSuccessImpl;

  ItemResponseModel get response;

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DetailSuccessImplCopyWith<_$DetailSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreatedImplCopyWith<$Res> {
  factory _$$CreatedImplCopyWith(
          _$CreatedImpl value, $Res Function(_$CreatedImpl) then) =
      __$$CreatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ItemModel response});
}

/// @nodoc
class __$$CreatedImplCopyWithImpl<$Res>
    extends _$ItemStateCopyWithImpl<$Res, _$CreatedImpl>
    implements _$$CreatedImplCopyWith<$Res> {
  __$$CreatedImplCopyWithImpl(
      _$CreatedImpl _value, $Res Function(_$CreatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$CreatedImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as ItemModel,
    ));
  }
}

/// @nodoc

class _$CreatedImpl implements _Created {
  const _$CreatedImpl({required this.response});

  @override
  final ItemModel response;

  @override
  String toString() {
    return 'ItemState.created(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatedImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatedImplCopyWith<_$CreatedImpl> get copyWith =>
      __$$CreatedImplCopyWithImpl<_$CreatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ItemModel> items) loadingMore,
    required TResult Function() noInternet,
    required TResult Function(String message) error,
    required TResult Function(ItemResponseModel response, bool hasMore) success,
    required TResult Function(ItemResponseModel response) detailSuccess,
    required TResult Function(ItemModel response) created,
    required TResult Function(ItemUpdateResponseModel response) updated,
    required TResult Function() deleted,
    required TResult Function(MergeItemsBulkOperationResponse response)
        mergeItemsSuccess,
  }) {
    return created(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ItemModel> items)? loadingMore,
    TResult? Function()? noInternet,
    TResult? Function(String message)? error,
    TResult? Function(ItemResponseModel response, bool hasMore)? success,
    TResult? Function(ItemResponseModel response)? detailSuccess,
    TResult? Function(ItemModel response)? created,
    TResult? Function(ItemUpdateResponseModel response)? updated,
    TResult? Function()? deleted,
    TResult? Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
  }) {
    return created?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ItemModel> items)? loadingMore,
    TResult Function()? noInternet,
    TResult Function(String message)? error,
    TResult Function(ItemResponseModel response, bool hasMore)? success,
    TResult Function(ItemResponseModel response)? detailSuccess,
    TResult Function(ItemModel response)? created,
    TResult Function(ItemUpdateResponseModel response)? updated,
    TResult Function()? deleted,
    TResult Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadingMore value) loadingMore,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
    required TResult Function(_DetailSuccess value) detailSuccess,
    required TResult Function(_Created value) created,
    required TResult Function(_Updated value) updated,
    required TResult Function(_Deleted value) deleted,
    required TResult Function(_MergeItemsSuccess value) mergeItemsSuccess,
  }) {
    return created(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadingMore value)? loadingMore,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
    TResult? Function(_DetailSuccess value)? detailSuccess,
    TResult? Function(_Created value)? created,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_Deleted value)? deleted,
    TResult? Function(_MergeItemsSuccess value)? mergeItemsSuccess,
  }) {
    return created?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadingMore value)? loadingMore,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    TResult Function(_DetailSuccess value)? detailSuccess,
    TResult Function(_Created value)? created,
    TResult Function(_Updated value)? updated,
    TResult Function(_Deleted value)? deleted,
    TResult Function(_MergeItemsSuccess value)? mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(this);
    }
    return orElse();
  }
}

abstract class _Created implements ItemState {
  const factory _Created({required final ItemModel response}) = _$CreatedImpl;

  ItemModel get response;

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatedImplCopyWith<_$CreatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdatedImplCopyWith<$Res> {
  factory _$$UpdatedImplCopyWith(
          _$UpdatedImpl value, $Res Function(_$UpdatedImpl) then) =
      __$$UpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ItemUpdateResponseModel response});
}

/// @nodoc
class __$$UpdatedImplCopyWithImpl<$Res>
    extends _$ItemStateCopyWithImpl<$Res, _$UpdatedImpl>
    implements _$$UpdatedImplCopyWith<$Res> {
  __$$UpdatedImplCopyWithImpl(
      _$UpdatedImpl _value, $Res Function(_$UpdatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$UpdatedImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as ItemUpdateResponseModel,
    ));
  }
}

/// @nodoc

class _$UpdatedImpl implements _Updated {
  const _$UpdatedImpl({required this.response});

  @override
  final ItemUpdateResponseModel response;

  @override
  String toString() {
    return 'ItemState.updated(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatedImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatedImplCopyWith<_$UpdatedImpl> get copyWith =>
      __$$UpdatedImplCopyWithImpl<_$UpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ItemModel> items) loadingMore,
    required TResult Function() noInternet,
    required TResult Function(String message) error,
    required TResult Function(ItemResponseModel response, bool hasMore) success,
    required TResult Function(ItemResponseModel response) detailSuccess,
    required TResult Function(ItemModel response) created,
    required TResult Function(ItemUpdateResponseModel response) updated,
    required TResult Function() deleted,
    required TResult Function(MergeItemsBulkOperationResponse response)
        mergeItemsSuccess,
  }) {
    return updated(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ItemModel> items)? loadingMore,
    TResult? Function()? noInternet,
    TResult? Function(String message)? error,
    TResult? Function(ItemResponseModel response, bool hasMore)? success,
    TResult? Function(ItemResponseModel response)? detailSuccess,
    TResult? Function(ItemModel response)? created,
    TResult? Function(ItemUpdateResponseModel response)? updated,
    TResult? Function()? deleted,
    TResult? Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
  }) {
    return updated?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ItemModel> items)? loadingMore,
    TResult Function()? noInternet,
    TResult Function(String message)? error,
    TResult Function(ItemResponseModel response, bool hasMore)? success,
    TResult Function(ItemResponseModel response)? detailSuccess,
    TResult Function(ItemModel response)? created,
    TResult Function(ItemUpdateResponseModel response)? updated,
    TResult Function()? deleted,
    TResult Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadingMore value) loadingMore,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
    required TResult Function(_DetailSuccess value) detailSuccess,
    required TResult Function(_Created value) created,
    required TResult Function(_Updated value) updated,
    required TResult Function(_Deleted value) deleted,
    required TResult Function(_MergeItemsSuccess value) mergeItemsSuccess,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadingMore value)? loadingMore,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
    TResult? Function(_DetailSuccess value)? detailSuccess,
    TResult? Function(_Created value)? created,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_Deleted value)? deleted,
    TResult? Function(_MergeItemsSuccess value)? mergeItemsSuccess,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadingMore value)? loadingMore,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    TResult Function(_DetailSuccess value)? detailSuccess,
    TResult Function(_Created value)? created,
    TResult Function(_Updated value)? updated,
    TResult Function(_Deleted value)? deleted,
    TResult Function(_MergeItemsSuccess value)? mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class _Updated implements ItemState {
  const factory _Updated({required final ItemUpdateResponseModel response}) =
      _$UpdatedImpl;

  ItemUpdateResponseModel get response;

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatedImplCopyWith<_$UpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeletedImplCopyWith<$Res> {
  factory _$$DeletedImplCopyWith(
          _$DeletedImpl value, $Res Function(_$DeletedImpl) then) =
      __$$DeletedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeletedImplCopyWithImpl<$Res>
    extends _$ItemStateCopyWithImpl<$Res, _$DeletedImpl>
    implements _$$DeletedImplCopyWith<$Res> {
  __$$DeletedImplCopyWithImpl(
      _$DeletedImpl _value, $Res Function(_$DeletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DeletedImpl implements _Deleted {
  const _$DeletedImpl();

  @override
  String toString() {
    return 'ItemState.deleted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DeletedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ItemModel> items) loadingMore,
    required TResult Function() noInternet,
    required TResult Function(String message) error,
    required TResult Function(ItemResponseModel response, bool hasMore) success,
    required TResult Function(ItemResponseModel response) detailSuccess,
    required TResult Function(ItemModel response) created,
    required TResult Function(ItemUpdateResponseModel response) updated,
    required TResult Function() deleted,
    required TResult Function(MergeItemsBulkOperationResponse response)
        mergeItemsSuccess,
  }) {
    return deleted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ItemModel> items)? loadingMore,
    TResult? Function()? noInternet,
    TResult? Function(String message)? error,
    TResult? Function(ItemResponseModel response, bool hasMore)? success,
    TResult? Function(ItemResponseModel response)? detailSuccess,
    TResult? Function(ItemModel response)? created,
    TResult? Function(ItemUpdateResponseModel response)? updated,
    TResult? Function()? deleted,
    TResult? Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
  }) {
    return deleted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ItemModel> items)? loadingMore,
    TResult Function()? noInternet,
    TResult Function(String message)? error,
    TResult Function(ItemResponseModel response, bool hasMore)? success,
    TResult Function(ItemResponseModel response)? detailSuccess,
    TResult Function(ItemModel response)? created,
    TResult Function(ItemUpdateResponseModel response)? updated,
    TResult Function()? deleted,
    TResult Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadingMore value) loadingMore,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
    required TResult Function(_DetailSuccess value) detailSuccess,
    required TResult Function(_Created value) created,
    required TResult Function(_Updated value) updated,
    required TResult Function(_Deleted value) deleted,
    required TResult Function(_MergeItemsSuccess value) mergeItemsSuccess,
  }) {
    return deleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadingMore value)? loadingMore,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
    TResult? Function(_DetailSuccess value)? detailSuccess,
    TResult? Function(_Created value)? created,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_Deleted value)? deleted,
    TResult? Function(_MergeItemsSuccess value)? mergeItemsSuccess,
  }) {
    return deleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadingMore value)? loadingMore,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    TResult Function(_DetailSuccess value)? detailSuccess,
    TResult Function(_Created value)? created,
    TResult Function(_Updated value)? updated,
    TResult Function(_Deleted value)? deleted,
    TResult Function(_MergeItemsSuccess value)? mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(this);
    }
    return orElse();
  }
}

abstract class _Deleted implements ItemState {
  const factory _Deleted() = _$DeletedImpl;
}

/// @nodoc
abstract class _$$MergeItemsSuccessImplCopyWith<$Res> {
  factory _$$MergeItemsSuccessImplCopyWith(_$MergeItemsSuccessImpl value,
          $Res Function(_$MergeItemsSuccessImpl) then) =
      __$$MergeItemsSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MergeItemsBulkOperationResponse response});

  $MergeItemsBulkOperationResponseCopyWith<$Res> get response;
}

/// @nodoc
class __$$MergeItemsSuccessImplCopyWithImpl<$Res>
    extends _$ItemStateCopyWithImpl<$Res, _$MergeItemsSuccessImpl>
    implements _$$MergeItemsSuccessImplCopyWith<$Res> {
  __$$MergeItemsSuccessImplCopyWithImpl(_$MergeItemsSuccessImpl _value,
      $Res Function(_$MergeItemsSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$MergeItemsSuccessImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as MergeItemsBulkOperationResponse,
    ));
  }

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MergeItemsBulkOperationResponseCopyWith<$Res> get response {
    return $MergeItemsBulkOperationResponseCopyWith<$Res>(_value.response,
        (value) {
      return _then(_value.copyWith(response: value));
    });
  }
}

/// @nodoc

class _$MergeItemsSuccessImpl implements _MergeItemsSuccess {
  const _$MergeItemsSuccessImpl({required this.response});

  @override
  final MergeItemsBulkOperationResponse response;

  @override
  String toString() {
    return 'ItemState.mergeItemsSuccess(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MergeItemsSuccessImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MergeItemsSuccessImplCopyWith<_$MergeItemsSuccessImpl> get copyWith =>
      __$$MergeItemsSuccessImplCopyWithImpl<_$MergeItemsSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ItemModel> items) loadingMore,
    required TResult Function() noInternet,
    required TResult Function(String message) error,
    required TResult Function(ItemResponseModel response, bool hasMore) success,
    required TResult Function(ItemResponseModel response) detailSuccess,
    required TResult Function(ItemModel response) created,
    required TResult Function(ItemUpdateResponseModel response) updated,
    required TResult Function() deleted,
    required TResult Function(MergeItemsBulkOperationResponse response)
        mergeItemsSuccess,
  }) {
    return mergeItemsSuccess(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ItemModel> items)? loadingMore,
    TResult? Function()? noInternet,
    TResult? Function(String message)? error,
    TResult? Function(ItemResponseModel response, bool hasMore)? success,
    TResult? Function(ItemResponseModel response)? detailSuccess,
    TResult? Function(ItemModel response)? created,
    TResult? Function(ItemUpdateResponseModel response)? updated,
    TResult? Function()? deleted,
    TResult? Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
  }) {
    return mergeItemsSuccess?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ItemModel> items)? loadingMore,
    TResult Function()? noInternet,
    TResult Function(String message)? error,
    TResult Function(ItemResponseModel response, bool hasMore)? success,
    TResult Function(ItemResponseModel response)? detailSuccess,
    TResult Function(ItemModel response)? created,
    TResult Function(ItemUpdateResponseModel response)? updated,
    TResult Function()? deleted,
    TResult Function(MergeItemsBulkOperationResponse response)?
        mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (mergeItemsSuccess != null) {
      return mergeItemsSuccess(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LoadingMore value) loadingMore,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
    required TResult Function(_DetailSuccess value) detailSuccess,
    required TResult Function(_Created value) created,
    required TResult Function(_Updated value) updated,
    required TResult Function(_Deleted value) deleted,
    required TResult Function(_MergeItemsSuccess value) mergeItemsSuccess,
  }) {
    return mergeItemsSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LoadingMore value)? loadingMore,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
    TResult? Function(_DetailSuccess value)? detailSuccess,
    TResult? Function(_Created value)? created,
    TResult? Function(_Updated value)? updated,
    TResult? Function(_Deleted value)? deleted,
    TResult? Function(_MergeItemsSuccess value)? mergeItemsSuccess,
  }) {
    return mergeItemsSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LoadingMore value)? loadingMore,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    TResult Function(_DetailSuccess value)? detailSuccess,
    TResult Function(_Created value)? created,
    TResult Function(_Updated value)? updated,
    TResult Function(_Deleted value)? deleted,
    TResult Function(_MergeItemsSuccess value)? mergeItemsSuccess,
    required TResult orElse(),
  }) {
    if (mergeItemsSuccess != null) {
      return mergeItemsSuccess(this);
    }
    return orElse();
  }
}

abstract class _MergeItemsSuccess implements ItemState {
  const factory _MergeItemsSuccess(
          {required final MergeItemsBulkOperationResponse response}) =
      _$MergeItemsSuccessImpl;

  MergeItemsBulkOperationResponse get response;

  /// Create a copy of ItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MergeItemsSuccessImplCopyWith<_$MergeItemsSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

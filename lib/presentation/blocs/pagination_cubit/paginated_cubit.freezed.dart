// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PaginatedState<T> {
  List<T> get items =>
      throw _privateConstructorUsedError; // everything loaded so far
  bool get isInitialLoading =>
      throw _privateConstructorUsedError; // first page in progress
  bool get isLoadingMore =>
      throw _privateConstructorUsedError; // next page in progress
  bool get isRefreshing =>
      throw _privateConstructorUsedError; // NEW: reloading page 1, old items still shown
  bool get hasMore =>
      throw _privateConstructorUsedError; // false => show "No more data"
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PaginatedStateCopyWith<T, PaginatedState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedStateCopyWith<T, $Res> {
  factory $PaginatedStateCopyWith(
          PaginatedState<T> value, $Res Function(PaginatedState<T>) then) =
      _$PaginatedStateCopyWithImpl<T, $Res, PaginatedState<T>>;
  @useResult
  $Res call(
      {List<T> items,
      bool isInitialLoading,
      bool isLoadingMore,
      bool isRefreshing,
      bool hasMore,
      String? error});
}

/// @nodoc
class _$PaginatedStateCopyWithImpl<T, $Res, $Val extends PaginatedState<T>>
    implements $PaginatedStateCopyWith<T, $Res> {
  _$PaginatedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isInitialLoading = null,
    Object? isLoadingMore = null,
    Object? isRefreshing = null,
    Object? hasMore = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
      isInitialLoading: null == isInitialLoading
          ? _value.isInitialLoading
          : isInitialLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      isRefreshing: null == isRefreshing
          ? _value.isRefreshing
          : isRefreshing // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaginatedStateImplCopyWith<T, $Res>
    implements $PaginatedStateCopyWith<T, $Res> {
  factory _$$PaginatedStateImplCopyWith(_$PaginatedStateImpl<T> value,
          $Res Function(_$PaginatedStateImpl<T>) then) =
      __$$PaginatedStateImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {List<T> items,
      bool isInitialLoading,
      bool isLoadingMore,
      bool isRefreshing,
      bool hasMore,
      String? error});
}

/// @nodoc
class __$$PaginatedStateImplCopyWithImpl<T, $Res>
    extends _$PaginatedStateCopyWithImpl<T, $Res, _$PaginatedStateImpl<T>>
    implements _$$PaginatedStateImplCopyWith<T, $Res> {
  __$$PaginatedStateImplCopyWithImpl(_$PaginatedStateImpl<T> _value,
      $Res Function(_$PaginatedStateImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isInitialLoading = null,
    Object? isLoadingMore = null,
    Object? isRefreshing = null,
    Object? hasMore = null,
    Object? error = freezed,
  }) {
    return _then(_$PaginatedStateImpl<T>(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
      isInitialLoading: null == isInitialLoading
          ? _value.isInitialLoading
          : isInitialLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      isRefreshing: null == isRefreshing
          ? _value.isRefreshing
          : isRefreshing // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PaginatedStateImpl<T> implements _PaginatedState<T> {
  const _$PaginatedStateImpl(
      {List<T> items = const [],
      this.isInitialLoading = true,
      this.isLoadingMore = false,
      this.isRefreshing = false,
      this.hasMore = true,
      this.error})
      : _items = items;

  final List<T> _items;
  @override
  @JsonKey()
  List<T> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

// everything loaded so far
  @override
  @JsonKey()
  final bool isInitialLoading;
// first page in progress
  @override
  @JsonKey()
  final bool isLoadingMore;
// next page in progress
  @override
  @JsonKey()
  final bool isRefreshing;
// NEW: reloading page 1, old items still shown
  @override
  @JsonKey()
  final bool hasMore;
// false => show "No more data"
  @override
  final String? error;

  @override
  String toString() {
    return 'PaginatedState<$T>(items: $items, isInitialLoading: $isInitialLoading, isLoadingMore: $isLoadingMore, isRefreshing: $isRefreshing, hasMore: $hasMore, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedStateImpl<T> &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.isInitialLoading, isInitialLoading) ||
                other.isInitialLoading == isInitialLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.isRefreshing, isRefreshing) ||
                other.isRefreshing == isRefreshing) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      isInitialLoading,
      isLoadingMore,
      isRefreshing,
      hasMore,
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedStateImplCopyWith<T, _$PaginatedStateImpl<T>> get copyWith =>
      __$$PaginatedStateImplCopyWithImpl<T, _$PaginatedStateImpl<T>>(
          this, _$identity);
}

abstract class _PaginatedState<T> implements PaginatedState<T> {
  const factory _PaginatedState(
      { List<T> items,
       bool isInitialLoading,
       bool isLoadingMore,
       bool isRefreshing,
       bool hasMore,
       String? error}) = _$PaginatedStateImpl<T>;

  @override
  List<T> get items;
  @override // everything loaded so far
  bool get isInitialLoading;
  @override // first page in progress
  bool get isLoadingMore;
  @override // next page in progress
  bool get isRefreshing;
  @override // NEW: reloading page 1, old items still shown
  bool get hasMore;
  @override // false => show "No more data"
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$PaginatedStateImplCopyWith<T, _$PaginatedStateImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BookingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BookingEntity> bookings) loaded,
    required TResult Function(String message, BookingEntity? booking) success,
    required TResult Function(String message) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BookingEntity> bookings)? loaded,
    TResult? Function(String message, BookingEntity? booking)? success,
    TResult? Function(String message)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BookingEntity> bookings)? loaded,
    TResult Function(String message, BookingEntity? booking)? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookingInitial value) initial,
    required TResult Function(BookingLoading value) loading,
    required TResult Function(BookingLoaded value) loaded,
    required TResult Function(BookingSuccess value) success,
    required TResult Function(BookingFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookingInitial value)? initial,
    TResult? Function(BookingLoading value)? loading,
    TResult? Function(BookingLoaded value)? loaded,
    TResult? Function(BookingSuccess value)? success,
    TResult? Function(BookingFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookingInitial value)? initial,
    TResult Function(BookingLoading value)? loading,
    TResult Function(BookingLoaded value)? loaded,
    TResult Function(BookingSuccess value)? success,
    TResult Function(BookingFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingStateCopyWith<$Res> {
  factory $BookingStateCopyWith(
          BookingState value, $Res Function(BookingState) then) =
      _$BookingStateCopyWithImpl<$Res, BookingState>;
}

/// @nodoc
class _$BookingStateCopyWithImpl<$Res, $Val extends BookingState>
    implements $BookingStateCopyWith<$Res> {
  _$BookingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$BookingInitialImplCopyWith<$Res> {
  factory _$$BookingInitialImplCopyWith(_$BookingInitialImpl value,
          $Res Function(_$BookingInitialImpl) then) =
      __$$BookingInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookingInitialImplCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res, _$BookingInitialImpl>
    implements _$$BookingInitialImplCopyWith<$Res> {
  __$$BookingInitialImplCopyWithImpl(
      _$BookingInitialImpl _value, $Res Function(_$BookingInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BookingInitialImpl
    with DiagnosticableTreeMixin
    implements BookingInitial {
  const _$BookingInitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'BookingState.initial'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BookingInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BookingEntity> bookings) loaded,
    required TResult Function(String message, BookingEntity? booking) success,
    required TResult Function(String message) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BookingEntity> bookings)? loaded,
    TResult? Function(String message, BookingEntity? booking)? success,
    TResult? Function(String message)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BookingEntity> bookings)? loaded,
    TResult Function(String message, BookingEntity? booking)? success,
    TResult Function(String message)? failure,
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
    required TResult Function(BookingInitial value) initial,
    required TResult Function(BookingLoading value) loading,
    required TResult Function(BookingLoaded value) loaded,
    required TResult Function(BookingSuccess value) success,
    required TResult Function(BookingFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookingInitial value)? initial,
    TResult? Function(BookingLoading value)? loading,
    TResult? Function(BookingLoaded value)? loaded,
    TResult? Function(BookingSuccess value)? success,
    TResult? Function(BookingFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookingInitial value)? initial,
    TResult Function(BookingLoading value)? loading,
    TResult Function(BookingLoaded value)? loaded,
    TResult Function(BookingSuccess value)? success,
    TResult Function(BookingFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class BookingInitial implements BookingState {
  const factory BookingInitial() = _$BookingInitialImpl;
}

/// @nodoc
abstract class _$$BookingLoadingImplCopyWith<$Res> {
  factory _$$BookingLoadingImplCopyWith(_$BookingLoadingImpl value,
          $Res Function(_$BookingLoadingImpl) then) =
      __$$BookingLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookingLoadingImplCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res, _$BookingLoadingImpl>
    implements _$$BookingLoadingImplCopyWith<$Res> {
  __$$BookingLoadingImplCopyWithImpl(
      _$BookingLoadingImpl _value, $Res Function(_$BookingLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BookingLoadingImpl
    with DiagnosticableTreeMixin
    implements BookingLoading {
  const _$BookingLoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'BookingState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BookingLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BookingEntity> bookings) loaded,
    required TResult Function(String message, BookingEntity? booking) success,
    required TResult Function(String message) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BookingEntity> bookings)? loaded,
    TResult? Function(String message, BookingEntity? booking)? success,
    TResult? Function(String message)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BookingEntity> bookings)? loaded,
    TResult Function(String message, BookingEntity? booking)? success,
    TResult Function(String message)? failure,
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
    required TResult Function(BookingInitial value) initial,
    required TResult Function(BookingLoading value) loading,
    required TResult Function(BookingLoaded value) loaded,
    required TResult Function(BookingSuccess value) success,
    required TResult Function(BookingFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookingInitial value)? initial,
    TResult? Function(BookingLoading value)? loading,
    TResult? Function(BookingLoaded value)? loaded,
    TResult? Function(BookingSuccess value)? success,
    TResult? Function(BookingFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookingInitial value)? initial,
    TResult Function(BookingLoading value)? loading,
    TResult Function(BookingLoaded value)? loaded,
    TResult Function(BookingSuccess value)? success,
    TResult Function(BookingFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class BookingLoading implements BookingState {
  const factory BookingLoading() = _$BookingLoadingImpl;
}

/// @nodoc
abstract class _$$BookingLoadedImplCopyWith<$Res> {
  factory _$$BookingLoadedImplCopyWith(
          _$BookingLoadedImpl value, $Res Function(_$BookingLoadedImpl) then) =
      __$$BookingLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<BookingEntity> bookings});
}

/// @nodoc
class __$$BookingLoadedImplCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res, _$BookingLoadedImpl>
    implements _$$BookingLoadedImplCopyWith<$Res> {
  __$$BookingLoadedImplCopyWithImpl(
      _$BookingLoadedImpl _value, $Res Function(_$BookingLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookings = null,
  }) {
    return _then(_$BookingLoadedImpl(
      null == bookings
          ? _value._bookings
          : bookings // ignore: cast_nullable_to_non_nullable
              as List<BookingEntity>,
    ));
  }
}

/// @nodoc

class _$BookingLoadedImpl
    with DiagnosticableTreeMixin
    implements BookingLoaded {
  const _$BookingLoadedImpl(List<BookingEntity> bookings)
      : _bookings = bookings;

  final List<BookingEntity> _bookings;
  @override
  List<BookingEntity> get bookings {
    if (_bookings is EqualUnmodifiableListView) return _bookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookings);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingState.loaded(bookings: $bookings)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BookingState.loaded'))
      ..add(DiagnosticsProperty('bookings', bookings));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingLoadedImpl &&
            const DeepCollectionEquality().equals(other._bookings, _bookings));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_bookings));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingLoadedImplCopyWith<_$BookingLoadedImpl> get copyWith =>
      __$$BookingLoadedImplCopyWithImpl<_$BookingLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BookingEntity> bookings) loaded,
    required TResult Function(String message, BookingEntity? booking) success,
    required TResult Function(String message) failure,
  }) {
    return loaded(bookings);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BookingEntity> bookings)? loaded,
    TResult? Function(String message, BookingEntity? booking)? success,
    TResult? Function(String message)? failure,
  }) {
    return loaded?.call(bookings);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BookingEntity> bookings)? loaded,
    TResult Function(String message, BookingEntity? booking)? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(bookings);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookingInitial value) initial,
    required TResult Function(BookingLoading value) loading,
    required TResult Function(BookingLoaded value) loaded,
    required TResult Function(BookingSuccess value) success,
    required TResult Function(BookingFailure value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookingInitial value)? initial,
    TResult? Function(BookingLoading value)? loading,
    TResult? Function(BookingLoaded value)? loaded,
    TResult? Function(BookingSuccess value)? success,
    TResult? Function(BookingFailure value)? failure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookingInitial value)? initial,
    TResult Function(BookingLoading value)? loading,
    TResult Function(BookingLoaded value)? loaded,
    TResult Function(BookingSuccess value)? success,
    TResult Function(BookingFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class BookingLoaded implements BookingState {
  const factory BookingLoaded(List<BookingEntity> bookings) =
      _$BookingLoadedImpl;

  List<BookingEntity> get bookings;
  @JsonKey(ignore: true)
  _$$BookingLoadedImplCopyWith<_$BookingLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BookingSuccessImplCopyWith<$Res> {
  factory _$$BookingSuccessImplCopyWith(_$BookingSuccessImpl value,
          $Res Function(_$BookingSuccessImpl) then) =
      __$$BookingSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, BookingEntity? booking});
}

/// @nodoc
class __$$BookingSuccessImplCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res, _$BookingSuccessImpl>
    implements _$$BookingSuccessImplCopyWith<$Res> {
  __$$BookingSuccessImplCopyWithImpl(
      _$BookingSuccessImpl _value, $Res Function(_$BookingSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? booking = freezed,
  }) {
    return _then(_$BookingSuccessImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      booking: freezed == booking
          ? _value.booking
          : booking // ignore: cast_nullable_to_non_nullable
              as BookingEntity?,
    ));
  }
}

/// @nodoc

class _$BookingSuccessImpl
    with DiagnosticableTreeMixin
    implements BookingSuccess {
  const _$BookingSuccessImpl({required this.message, this.booking});

  @override
  final String message;
  @override
  final BookingEntity? booking;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingState.success(message: $message, booking: $booking)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BookingState.success'))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('booking', booking));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingSuccessImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.booking, booking) || other.booking == booking));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, booking);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingSuccessImplCopyWith<_$BookingSuccessImpl> get copyWith =>
      __$$BookingSuccessImplCopyWithImpl<_$BookingSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BookingEntity> bookings) loaded,
    required TResult Function(String message, BookingEntity? booking) success,
    required TResult Function(String message) failure,
  }) {
    return success(message, booking);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BookingEntity> bookings)? loaded,
    TResult? Function(String message, BookingEntity? booking)? success,
    TResult? Function(String message)? failure,
  }) {
    return success?.call(message, booking);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BookingEntity> bookings)? loaded,
    TResult Function(String message, BookingEntity? booking)? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(message, booking);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookingInitial value) initial,
    required TResult Function(BookingLoading value) loading,
    required TResult Function(BookingLoaded value) loaded,
    required TResult Function(BookingSuccess value) success,
    required TResult Function(BookingFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookingInitial value)? initial,
    TResult? Function(BookingLoading value)? loading,
    TResult? Function(BookingLoaded value)? loaded,
    TResult? Function(BookingSuccess value)? success,
    TResult? Function(BookingFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookingInitial value)? initial,
    TResult Function(BookingLoading value)? loading,
    TResult Function(BookingLoaded value)? loaded,
    TResult Function(BookingSuccess value)? success,
    TResult Function(BookingFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class BookingSuccess implements BookingState {
  const factory BookingSuccess(
      {required String message,
      BookingEntity? booking}) = _$BookingSuccessImpl;

  String get message;
  BookingEntity? get booking;
  @JsonKey(ignore: true)
  _$$BookingSuccessImplCopyWith<_$BookingSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BookingFailureImplCopyWith<$Res> {
  factory _$$BookingFailureImplCopyWith(_$BookingFailureImpl value,
          $Res Function(_$BookingFailureImpl) then) =
      __$$BookingFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$BookingFailureImplCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res, _$BookingFailureImpl>
    implements _$$BookingFailureImplCopyWith<$Res> {
  __$$BookingFailureImplCopyWithImpl(
      _$BookingFailureImpl _value, $Res Function(_$BookingFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$BookingFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BookingFailureImpl
    with DiagnosticableTreeMixin
    implements BookingFailure {
  const _$BookingFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingState.failure(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BookingState.failure'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingFailureImplCopyWith<_$BookingFailureImpl> get copyWith =>
      __$$BookingFailureImplCopyWithImpl<_$BookingFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BookingEntity> bookings) loaded,
    required TResult Function(String message, BookingEntity? booking) success,
    required TResult Function(String message) failure,
  }) {
    return failure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BookingEntity> bookings)? loaded,
    TResult? Function(String message, BookingEntity? booking)? success,
    TResult? Function(String message)? failure,
  }) {
    return failure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BookingEntity> bookings)? loaded,
    TResult Function(String message, BookingEntity? booking)? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookingInitial value) initial,
    required TResult Function(BookingLoading value) loading,
    required TResult Function(BookingLoaded value) loaded,
    required TResult Function(BookingSuccess value) success,
    required TResult Function(BookingFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookingInitial value)? initial,
    TResult? Function(BookingLoading value)? loading,
    TResult? Function(BookingLoaded value)? loaded,
    TResult? Function(BookingSuccess value)? success,
    TResult? Function(BookingFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookingInitial value)? initial,
    TResult Function(BookingLoading value)? loading,
    TResult Function(BookingLoaded value)? loaded,
    TResult Function(BookingSuccess value)? success,
    TResult Function(BookingFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class BookingFailure implements BookingState {
  const factory BookingFailure(String message) = _$BookingFailureImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$BookingFailureImplCopyWith<_$BookingFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

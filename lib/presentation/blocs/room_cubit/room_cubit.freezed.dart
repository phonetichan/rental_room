// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RoomState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RoomEntity> rooms) loaded,
    required TResult Function(String message, RoomEntity? room) success,
    required TResult Function(String message) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RoomEntity> rooms)? loaded,
    TResult? Function(String message, RoomEntity? room)? success,
    TResult? Function(String message)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RoomEntity> rooms)? loaded,
    TResult Function(String message, RoomEntity? room)? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RoomInitial value) initial,
    required TResult Function(RoomLoading value) loading,
    required TResult Function(RoomLoaded value) loaded,
    required TResult Function(RoomSuccess value) success,
    required TResult Function(RoomFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoomInitial value)? initial,
    TResult? Function(RoomLoading value)? loading,
    TResult? Function(RoomLoaded value)? loaded,
    TResult? Function(RoomSuccess value)? success,
    TResult? Function(RoomFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoomInitial value)? initial,
    TResult Function(RoomLoading value)? loading,
    TResult Function(RoomLoaded value)? loaded,
    TResult Function(RoomSuccess value)? success,
    TResult Function(RoomFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomStateCopyWith<$Res> {
  factory $RoomStateCopyWith(RoomState value, $Res Function(RoomState) then) =
      _$RoomStateCopyWithImpl<$Res, RoomState>;
}

/// @nodoc
class _$RoomStateCopyWithImpl<$Res, $Val extends RoomState>
    implements $RoomStateCopyWith<$Res> {
  _$RoomStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$RoomInitialImplCopyWith<$Res> {
  factory _$$RoomInitialImplCopyWith(
          _$RoomInitialImpl value, $Res Function(_$RoomInitialImpl) then) =
      __$$RoomInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RoomInitialImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$RoomInitialImpl>
    implements _$$RoomInitialImplCopyWith<$Res> {
  __$$RoomInitialImplCopyWithImpl(
      _$RoomInitialImpl _value, $Res Function(_$RoomInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RoomInitialImpl with DiagnosticableTreeMixin implements RoomInitial {
  const _$RoomInitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RoomState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'RoomState.initial'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RoomInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RoomEntity> rooms) loaded,
    required TResult Function(String message, RoomEntity? room) success,
    required TResult Function(String message) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RoomEntity> rooms)? loaded,
    TResult? Function(String message, RoomEntity? room)? success,
    TResult? Function(String message)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RoomEntity> rooms)? loaded,
    TResult Function(String message, RoomEntity? room)? success,
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
    required TResult Function(RoomInitial value) initial,
    required TResult Function(RoomLoading value) loading,
    required TResult Function(RoomLoaded value) loaded,
    required TResult Function(RoomSuccess value) success,
    required TResult Function(RoomFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoomInitial value)? initial,
    TResult? Function(RoomLoading value)? loading,
    TResult? Function(RoomLoaded value)? loaded,
    TResult? Function(RoomSuccess value)? success,
    TResult? Function(RoomFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoomInitial value)? initial,
    TResult Function(RoomLoading value)? loading,
    TResult Function(RoomLoaded value)? loaded,
    TResult Function(RoomSuccess value)? success,
    TResult Function(RoomFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class RoomInitial implements RoomState {
  const factory RoomInitial() = _$RoomInitialImpl;
}

/// @nodoc
abstract class _$$RoomLoadingImplCopyWith<$Res> {
  factory _$$RoomLoadingImplCopyWith(
          _$RoomLoadingImpl value, $Res Function(_$RoomLoadingImpl) then) =
      __$$RoomLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RoomLoadingImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$RoomLoadingImpl>
    implements _$$RoomLoadingImplCopyWith<$Res> {
  __$$RoomLoadingImplCopyWithImpl(
      _$RoomLoadingImpl _value, $Res Function(_$RoomLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RoomLoadingImpl with DiagnosticableTreeMixin implements RoomLoading {
  const _$RoomLoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RoomState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'RoomState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RoomLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RoomEntity> rooms) loaded,
    required TResult Function(String message, RoomEntity? room) success,
    required TResult Function(String message) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RoomEntity> rooms)? loaded,
    TResult? Function(String message, RoomEntity? room)? success,
    TResult? Function(String message)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RoomEntity> rooms)? loaded,
    TResult Function(String message, RoomEntity? room)? success,
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
    required TResult Function(RoomInitial value) initial,
    required TResult Function(RoomLoading value) loading,
    required TResult Function(RoomLoaded value) loaded,
    required TResult Function(RoomSuccess value) success,
    required TResult Function(RoomFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoomInitial value)? initial,
    TResult? Function(RoomLoading value)? loading,
    TResult? Function(RoomLoaded value)? loaded,
    TResult? Function(RoomSuccess value)? success,
    TResult? Function(RoomFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoomInitial value)? initial,
    TResult Function(RoomLoading value)? loading,
    TResult Function(RoomLoaded value)? loaded,
    TResult Function(RoomSuccess value)? success,
    TResult Function(RoomFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class RoomLoading implements RoomState {
  const factory RoomLoading() = _$RoomLoadingImpl;
}

/// @nodoc
abstract class _$$RoomLoadedImplCopyWith<$Res> {
  factory _$$RoomLoadedImplCopyWith(
          _$RoomLoadedImpl value, $Res Function(_$RoomLoadedImpl) then) =
      __$$RoomLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<RoomEntity> rooms});
}

/// @nodoc
class __$$RoomLoadedImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$RoomLoadedImpl>
    implements _$$RoomLoadedImplCopyWith<$Res> {
  __$$RoomLoadedImplCopyWithImpl(
      _$RoomLoadedImpl _value, $Res Function(_$RoomLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rooms = null,
  }) {
    return _then(_$RoomLoadedImpl(
      null == rooms
          ? _value._rooms
          : rooms // ignore: cast_nullable_to_non_nullable
              as List<RoomEntity>,
    ));
  }
}

/// @nodoc

class _$RoomLoadedImpl with DiagnosticableTreeMixin implements RoomLoaded {
  const _$RoomLoadedImpl(List<RoomEntity> rooms) : _rooms = rooms;

  final List<RoomEntity> _rooms;
  @override
  List<RoomEntity> get rooms {
    if (_rooms is EqualUnmodifiableListView) return _rooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rooms);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RoomState.loaded(rooms: $rooms)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RoomState.loaded'))
      ..add(DiagnosticsProperty('rooms', rooms));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomLoadedImpl &&
            const DeepCollectionEquality().equals(other._rooms, _rooms));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_rooms));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomLoadedImplCopyWith<_$RoomLoadedImpl> get copyWith =>
      __$$RoomLoadedImplCopyWithImpl<_$RoomLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RoomEntity> rooms) loaded,
    required TResult Function(String message, RoomEntity? room) success,
    required TResult Function(String message) failure,
  }) {
    return loaded(rooms);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RoomEntity> rooms)? loaded,
    TResult? Function(String message, RoomEntity? room)? success,
    TResult? Function(String message)? failure,
  }) {
    return loaded?.call(rooms);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RoomEntity> rooms)? loaded,
    TResult Function(String message, RoomEntity? room)? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(rooms);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RoomInitial value) initial,
    required TResult Function(RoomLoading value) loading,
    required TResult Function(RoomLoaded value) loaded,
    required TResult Function(RoomSuccess value) success,
    required TResult Function(RoomFailure value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoomInitial value)? initial,
    TResult? Function(RoomLoading value)? loading,
    TResult? Function(RoomLoaded value)? loaded,
    TResult? Function(RoomSuccess value)? success,
    TResult? Function(RoomFailure value)? failure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoomInitial value)? initial,
    TResult Function(RoomLoading value)? loading,
    TResult Function(RoomLoaded value)? loaded,
    TResult Function(RoomSuccess value)? success,
    TResult Function(RoomFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class RoomLoaded implements RoomState {
  const factory RoomLoaded(List<RoomEntity> rooms) = _$RoomLoadedImpl;

  List<RoomEntity> get rooms;
  @JsonKey(ignore: true)
  _$$RoomLoadedImplCopyWith<_$RoomLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RoomSuccessImplCopyWith<$Res> {
  factory _$$RoomSuccessImplCopyWith(
          _$RoomSuccessImpl value, $Res Function(_$RoomSuccessImpl) then) =
      __$$RoomSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, RoomEntity? room});
}

/// @nodoc
class __$$RoomSuccessImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$RoomSuccessImpl>
    implements _$$RoomSuccessImplCopyWith<$Res> {
  __$$RoomSuccessImplCopyWithImpl(
      _$RoomSuccessImpl _value, $Res Function(_$RoomSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? room = freezed,
  }) {
    return _then(_$RoomSuccessImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      room: freezed == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as RoomEntity?,
    ));
  }
}

/// @nodoc

class _$RoomSuccessImpl with DiagnosticableTreeMixin implements RoomSuccess {
  const _$RoomSuccessImpl({required this.message, this.room});

  @override
  final String message;
  @override
  final RoomEntity? room;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RoomState.success(message: $message, room: $room)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RoomState.success'))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('room', room));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomSuccessImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.room, room) || other.room == room));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, room);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomSuccessImplCopyWith<_$RoomSuccessImpl> get copyWith =>
      __$$RoomSuccessImplCopyWithImpl<_$RoomSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RoomEntity> rooms) loaded,
    required TResult Function(String message, RoomEntity? room) success,
    required TResult Function(String message) failure,
  }) {
    return success(message, room);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RoomEntity> rooms)? loaded,
    TResult? Function(String message, RoomEntity? room)? success,
    TResult? Function(String message)? failure,
  }) {
    return success?.call(message, room);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RoomEntity> rooms)? loaded,
    TResult Function(String message, RoomEntity? room)? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(message, room);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RoomInitial value) initial,
    required TResult Function(RoomLoading value) loading,
    required TResult Function(RoomLoaded value) loaded,
    required TResult Function(RoomSuccess value) success,
    required TResult Function(RoomFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoomInitial value)? initial,
    TResult? Function(RoomLoading value)? loading,
    TResult? Function(RoomLoaded value)? loaded,
    TResult? Function(RoomSuccess value)? success,
    TResult? Function(RoomFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoomInitial value)? initial,
    TResult Function(RoomLoading value)? loading,
    TResult Function(RoomLoaded value)? loaded,
    TResult Function(RoomSuccess value)? success,
    TResult Function(RoomFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class RoomSuccess implements RoomState {
  const factory RoomSuccess(
      {required String message,
      RoomEntity? room}) = _$RoomSuccessImpl;

  String get message;
  RoomEntity? get room;
  @JsonKey(ignore: true)
  _$$RoomSuccessImplCopyWith<_$RoomSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RoomFailureImplCopyWith<$Res> {
  factory _$$RoomFailureImplCopyWith(
          _$RoomFailureImpl value, $Res Function(_$RoomFailureImpl) then) =
      __$$RoomFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$RoomFailureImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$RoomFailureImpl>
    implements _$$RoomFailureImplCopyWith<$Res> {
  __$$RoomFailureImplCopyWithImpl(
      _$RoomFailureImpl _value, $Res Function(_$RoomFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$RoomFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RoomFailureImpl with DiagnosticableTreeMixin implements RoomFailure {
  const _$RoomFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RoomState.failure(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RoomState.failure'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomFailureImplCopyWith<_$RoomFailureImpl> get copyWith =>
      __$$RoomFailureImplCopyWithImpl<_$RoomFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RoomEntity> rooms) loaded,
    required TResult Function(String message, RoomEntity? room) success,
    required TResult Function(String message) failure,
  }) {
    return failure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RoomEntity> rooms)? loaded,
    TResult? Function(String message, RoomEntity? room)? success,
    TResult? Function(String message)? failure,
  }) {
    return failure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RoomEntity> rooms)? loaded,
    TResult Function(String message, RoomEntity? room)? success,
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
    required TResult Function(RoomInitial value) initial,
    required TResult Function(RoomLoading value) loading,
    required TResult Function(RoomLoaded value) loaded,
    required TResult Function(RoomSuccess value) success,
    required TResult Function(RoomFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RoomInitial value)? initial,
    TResult? Function(RoomLoading value)? loading,
    TResult? Function(RoomLoaded value)? loaded,
    TResult? Function(RoomSuccess value)? success,
    TResult? Function(RoomFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RoomInitial value)? initial,
    TResult Function(RoomLoading value)? loading,
    TResult Function(RoomLoaded value)? loaded,
    TResult Function(RoomSuccess value)? success,
    TResult Function(RoomFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class RoomFailure implements RoomState {
  const factory RoomFailure(String message) = _$RoomFailureImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$RoomFailureImplCopyWith<_$RoomFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

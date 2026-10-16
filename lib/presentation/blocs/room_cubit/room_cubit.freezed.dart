// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RoomState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'RoomState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RoomState()';
}


}

/// @nodoc
class $RoomStateCopyWith<$Res>  {
$RoomStateCopyWith(RoomState _, $Res Function(RoomState) __);
}


/// Adds pattern-matching-related methods to [RoomState].
extension RoomStatePatterns on RoomState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RoomInitial value)?  initial,TResult Function( RoomLoading value)?  loading,TResult Function( RoomLoaded value)?  loaded,TResult Function( RoomSuccess value)?  success,TResult Function( RoomFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RoomInitial() when initial != null:
return initial(_that);case RoomLoading() when loading != null:
return loading(_that);case RoomLoaded() when loaded != null:
return loaded(_that);case RoomSuccess() when success != null:
return success(_that);case RoomFailure() when failure != null:
return failure(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RoomInitial value)  initial,required TResult Function( RoomLoading value)  loading,required TResult Function( RoomLoaded value)  loaded,required TResult Function( RoomSuccess value)  success,required TResult Function( RoomFailure value)  failure,}){
final _that = this;
switch (_that) {
case RoomInitial():
return initial(_that);case RoomLoading():
return loading(_that);case RoomLoaded():
return loaded(_that);case RoomSuccess():
return success(_that);case RoomFailure():
return failure(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RoomInitial value)?  initial,TResult? Function( RoomLoading value)?  loading,TResult? Function( RoomLoaded value)?  loaded,TResult? Function( RoomSuccess value)?  success,TResult? Function( RoomFailure value)?  failure,}){
final _that = this;
switch (_that) {
case RoomInitial() when initial != null:
return initial(_that);case RoomLoading() when loading != null:
return loading(_that);case RoomLoaded() when loaded != null:
return loaded(_that);case RoomSuccess() when success != null:
return success(_that);case RoomFailure() when failure != null:
return failure(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<RoomEntity> rooms)?  loaded,TResult Function( String message,  RoomEntity? room)?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RoomInitial() when initial != null:
return initial();case RoomLoading() when loading != null:
return loading();case RoomLoaded() when loaded != null:
return loaded(_that.rooms);case RoomSuccess() when success != null:
return success(_that.message,_that.room);case RoomFailure() when failure != null:
return failure(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<RoomEntity> rooms)  loaded,required TResult Function( String message,  RoomEntity? room)  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case RoomInitial():
return initial();case RoomLoading():
return loading();case RoomLoaded():
return loaded(_that.rooms);case RoomSuccess():
return success(_that.message,_that.room);case RoomFailure():
return failure(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<RoomEntity> rooms)?  loaded,TResult? Function( String message,  RoomEntity? room)?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case RoomInitial() when initial != null:
return initial();case RoomLoading() when loading != null:
return loading();case RoomLoaded() when loaded != null:
return loaded(_that.rooms);case RoomSuccess() when success != null:
return success(_that.message,_that.room);case RoomFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class RoomInitial with DiagnosticableTreeMixin implements RoomState {
  const RoomInitial();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'RoomState.initial'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RoomState.initial()';
}


}




/// @nodoc


class RoomLoading with DiagnosticableTreeMixin implements RoomState {
  const RoomLoading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'RoomState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RoomState.loading()';
}


}




/// @nodoc


class RoomLoaded with DiagnosticableTreeMixin implements RoomState {
  const RoomLoaded(final  List<RoomEntity> rooms): _rooms = rooms;
  

 final  List<RoomEntity> _rooms;
 List<RoomEntity> get rooms {
  if (_rooms is EqualUnmodifiableListView) return _rooms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rooms);
}


/// Create a copy of RoomState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomLoadedCopyWith<RoomLoaded> get copyWith => _$RoomLoadedCopyWithImpl<RoomLoaded>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'RoomState.loaded'))
    ..add(DiagnosticsProperty('rooms', rooms));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomLoaded&&const DeepCollectionEquality().equals(other._rooms, _rooms));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_rooms));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RoomState.loaded(rooms: $rooms)';
}


}

/// @nodoc
abstract mixin class $RoomLoadedCopyWith<$Res> implements $RoomStateCopyWith<$Res> {
  factory $RoomLoadedCopyWith(RoomLoaded value, $Res Function(RoomLoaded) _then) = _$RoomLoadedCopyWithImpl;
@useResult
$Res call({
 List<RoomEntity> rooms
});




}
/// @nodoc
class _$RoomLoadedCopyWithImpl<$Res>
    implements $RoomLoadedCopyWith<$Res> {
  _$RoomLoadedCopyWithImpl(this._self, this._then);

  final RoomLoaded _self;
  final $Res Function(RoomLoaded) _then;

/// Create a copy of RoomState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rooms = null,}) {
  return _then(RoomLoaded(
null == rooms ? _self._rooms : rooms // ignore: cast_nullable_to_non_nullable
as List<RoomEntity>,
  ));
}


}

/// @nodoc


class RoomSuccess with DiagnosticableTreeMixin implements RoomState {
  const RoomSuccess({required this.message, this.room});
  

 final  String message;
 final  RoomEntity? room;

/// Create a copy of RoomState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomSuccessCopyWith<RoomSuccess> get copyWith => _$RoomSuccessCopyWithImpl<RoomSuccess>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'RoomState.success'))
    ..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('room', room));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomSuccess&&(identical(other.message, message) || other.message == message)&&(identical(other.room, room) || other.room == room));
}


@override
int get hashCode => Object.hash(runtimeType,message,room);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RoomState.success(message: $message, room: $room)';
}


}

/// @nodoc
abstract mixin class $RoomSuccessCopyWith<$Res> implements $RoomStateCopyWith<$Res> {
  factory $RoomSuccessCopyWith(RoomSuccess value, $Res Function(RoomSuccess) _then) = _$RoomSuccessCopyWithImpl;
@useResult
$Res call({
 String message, RoomEntity? room
});




}
/// @nodoc
class _$RoomSuccessCopyWithImpl<$Res>
    implements $RoomSuccessCopyWith<$Res> {
  _$RoomSuccessCopyWithImpl(this._self, this._then);

  final RoomSuccess _self;
  final $Res Function(RoomSuccess) _then;

/// Create a copy of RoomState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? room = freezed,}) {
  return _then(RoomSuccess(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as RoomEntity?,
  ));
}


}

/// @nodoc


class RoomFailure with DiagnosticableTreeMixin implements RoomState {
  const RoomFailure(this.message);
  

 final  String message;

/// Create a copy of RoomState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomFailureCopyWith<RoomFailure> get copyWith => _$RoomFailureCopyWithImpl<RoomFailure>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'RoomState.failure'))
    ..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RoomState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $RoomFailureCopyWith<$Res> implements $RoomStateCopyWith<$Res> {
  factory $RoomFailureCopyWith(RoomFailure value, $Res Function(RoomFailure) _then) = _$RoomFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$RoomFailureCopyWithImpl<$Res>
    implements $RoomFailureCopyWith<$Res> {
  _$RoomFailureCopyWithImpl(this._self, this._then);

  final RoomFailure _self;
  final $Res Function(RoomFailure) _then;

/// Create a copy of RoomState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(RoomFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

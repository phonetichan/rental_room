// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavoriteState {

 Set<String> get userFavoriteRoomIds; Map<String, int> get favoriteCounts; bool get isLoading; String? get errorMessage;
/// Create a copy of FavoriteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteStateCopyWith<FavoriteState> get copyWith => _$FavoriteStateCopyWithImpl<FavoriteState>(this as FavoriteState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteState&&const DeepCollectionEquality().equals(other.userFavoriteRoomIds, userFavoriteRoomIds)&&const DeepCollectionEquality().equals(other.favoriteCounts, favoriteCounts)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(userFavoriteRoomIds),const DeepCollectionEquality().hash(favoriteCounts),isLoading,errorMessage);

@override
String toString() {
  return 'FavoriteState(userFavoriteRoomIds: $userFavoriteRoomIds, favoriteCounts: $favoriteCounts, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $FavoriteStateCopyWith<$Res>  {
  factory $FavoriteStateCopyWith(FavoriteState value, $Res Function(FavoriteState) _then) = _$FavoriteStateCopyWithImpl;
@useResult
$Res call({
 Set<String> userFavoriteRoomIds, Map<String, int> favoriteCounts, bool isLoading, String? errorMessage
});




}
/// @nodoc
class _$FavoriteStateCopyWithImpl<$Res>
    implements $FavoriteStateCopyWith<$Res> {
  _$FavoriteStateCopyWithImpl(this._self, this._then);

  final FavoriteState _self;
  final $Res Function(FavoriteState) _then;

/// Create a copy of FavoriteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userFavoriteRoomIds = null,Object? favoriteCounts = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
userFavoriteRoomIds: null == userFavoriteRoomIds ? _self.userFavoriteRoomIds : userFavoriteRoomIds // ignore: cast_nullable_to_non_nullable
as Set<String>,favoriteCounts: null == favoriteCounts ? _self.favoriteCounts : favoriteCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteState].
extension FavoriteStatePatterns on FavoriteState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoriteState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoriteState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoriteState value)  $default,){
final _that = this;
switch (_that) {
case _FavoriteState():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoriteState value)?  $default,){
final _that = this;
switch (_that) {
case _FavoriteState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Set<String> userFavoriteRoomIds,  Map<String, int> favoriteCounts,  bool isLoading,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoriteState() when $default != null:
return $default(_that.userFavoriteRoomIds,_that.favoriteCounts,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Set<String> userFavoriteRoomIds,  Map<String, int> favoriteCounts,  bool isLoading,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _FavoriteState():
return $default(_that.userFavoriteRoomIds,_that.favoriteCounts,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Set<String> userFavoriteRoomIds,  Map<String, int> favoriteCounts,  bool isLoading,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _FavoriteState() when $default != null:
return $default(_that.userFavoriteRoomIds,_that.favoriteCounts,_that.isLoading,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _FavoriteState extends FavoriteState {
  const _FavoriteState({final  Set<String> userFavoriteRoomIds = const {}, final  Map<String, int> favoriteCounts = const {}, this.isLoading = false, this.errorMessage}): _userFavoriteRoomIds = userFavoriteRoomIds,_favoriteCounts = favoriteCounts,super._();
  

 final  Set<String> _userFavoriteRoomIds;
@override@JsonKey() Set<String> get userFavoriteRoomIds {
  if (_userFavoriteRoomIds is EqualUnmodifiableSetView) return _userFavoriteRoomIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_userFavoriteRoomIds);
}

 final  Map<String, int> _favoriteCounts;
@override@JsonKey() Map<String, int> get favoriteCounts {
  if (_favoriteCounts is EqualUnmodifiableMapView) return _favoriteCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_favoriteCounts);
}

@override@JsonKey() final  bool isLoading;
@override final  String? errorMessage;

/// Create a copy of FavoriteState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteStateCopyWith<_FavoriteState> get copyWith => __$FavoriteStateCopyWithImpl<_FavoriteState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteState&&const DeepCollectionEquality().equals(other._userFavoriteRoomIds, _userFavoriteRoomIds)&&const DeepCollectionEquality().equals(other._favoriteCounts, _favoriteCounts)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_userFavoriteRoomIds),const DeepCollectionEquality().hash(_favoriteCounts),isLoading,errorMessage);

@override
String toString() {
  return 'FavoriteState(userFavoriteRoomIds: $userFavoriteRoomIds, favoriteCounts: $favoriteCounts, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$FavoriteStateCopyWith<$Res> implements $FavoriteStateCopyWith<$Res> {
  factory _$FavoriteStateCopyWith(_FavoriteState value, $Res Function(_FavoriteState) _then) = __$FavoriteStateCopyWithImpl;
@override @useResult
$Res call({
 Set<String> userFavoriteRoomIds, Map<String, int> favoriteCounts, bool isLoading, String? errorMessage
});




}
/// @nodoc
class __$FavoriteStateCopyWithImpl<$Res>
    implements _$FavoriteStateCopyWith<$Res> {
  __$FavoriteStateCopyWithImpl(this._self, this._then);

  final _FavoriteState _self;
  final $Res Function(_FavoriteState) _then;

/// Create a copy of FavoriteState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userFavoriteRoomIds = null,Object? favoriteCounts = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_FavoriteState(
userFavoriteRoomIds: null == userFavoriteRoomIds ? _self._userFavoriteRoomIds : userFavoriteRoomIds // ignore: cast_nullable_to_non_nullable
as Set<String>,favoriteCounts: null == favoriteCounts ? _self._favoriteCounts : favoriteCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

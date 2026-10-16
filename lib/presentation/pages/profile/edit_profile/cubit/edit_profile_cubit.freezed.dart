// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditProfileState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'EditProfileState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'EditProfileState()';
}


}

/// @nodoc
class $EditProfileStateCopyWith<$Res>  {
$EditProfileStateCopyWith(EditProfileState _, $Res Function(EditProfileState) __);
}


/// Adds pattern-matching-related methods to [EditProfileState].
extension EditProfileStatePatterns on EditProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EditProfileInitial value)?  initial,TResult Function( EditProfileLoading value)?  loading,TResult Function( EditProfileSuccess value)?  success,TResult Function( EditProfileFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EditProfileInitial() when initial != null:
return initial(_that);case EditProfileLoading() when loading != null:
return loading(_that);case EditProfileSuccess() when success != null:
return success(_that);case EditProfileFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EditProfileInitial value)  initial,required TResult Function( EditProfileLoading value)  loading,required TResult Function( EditProfileSuccess value)  success,required TResult Function( EditProfileFailure value)  failure,}){
final _that = this;
switch (_that) {
case EditProfileInitial():
return initial(_that);case EditProfileLoading():
return loading(_that);case EditProfileSuccess():
return success(_that);case EditProfileFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EditProfileInitial value)?  initial,TResult? Function( EditProfileLoading value)?  loading,TResult? Function( EditProfileSuccess value)?  success,TResult? Function( EditProfileFailure value)?  failure,}){
final _that = this;
switch (_that) {
case EditProfileInitial() when initial != null:
return initial(_that);case EditProfileLoading() when loading != null:
return loading(_that);case EditProfileSuccess() when success != null:
return success(_that);case EditProfileFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( UserEntity user)?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EditProfileInitial() when initial != null:
return initial();case EditProfileLoading() when loading != null:
return loading();case EditProfileSuccess() when success != null:
return success(_that.user);case EditProfileFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( UserEntity user)  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case EditProfileInitial():
return initial();case EditProfileLoading():
return loading();case EditProfileSuccess():
return success(_that.user);case EditProfileFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( UserEntity user)?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case EditProfileInitial() when initial != null:
return initial();case EditProfileLoading() when loading != null:
return loading();case EditProfileSuccess() when success != null:
return success(_that.user);case EditProfileFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class EditProfileInitial with DiagnosticableTreeMixin implements EditProfileState {
  const EditProfileInitial();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'EditProfileState.initial'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'EditProfileState.initial()';
}


}




/// @nodoc


class EditProfileLoading with DiagnosticableTreeMixin implements EditProfileState {
  const EditProfileLoading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'EditProfileState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'EditProfileState.loading()';
}


}




/// @nodoc


class EditProfileSuccess with DiagnosticableTreeMixin implements EditProfileState {
  const EditProfileSuccess(this.user);
  

 final  UserEntity user;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditProfileSuccessCopyWith<EditProfileSuccess> get copyWith => _$EditProfileSuccessCopyWithImpl<EditProfileSuccess>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'EditProfileState.success'))
    ..add(DiagnosticsProperty('user', user));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileSuccess&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'EditProfileState.success(user: $user)';
}


}

/// @nodoc
abstract mixin class $EditProfileSuccessCopyWith<$Res> implements $EditProfileStateCopyWith<$Res> {
  factory $EditProfileSuccessCopyWith(EditProfileSuccess value, $Res Function(EditProfileSuccess) _then) = _$EditProfileSuccessCopyWithImpl;
@useResult
$Res call({
 UserEntity user
});




}
/// @nodoc
class _$EditProfileSuccessCopyWithImpl<$Res>
    implements $EditProfileSuccessCopyWith<$Res> {
  _$EditProfileSuccessCopyWithImpl(this._self, this._then);

  final EditProfileSuccess _self;
  final $Res Function(EditProfileSuccess) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(EditProfileSuccess(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity,
  ));
}


}

/// @nodoc


class EditProfileFailure with DiagnosticableTreeMixin implements EditProfileState {
  const EditProfileFailure(this.message);
  

 final  String message;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditProfileFailureCopyWith<EditProfileFailure> get copyWith => _$EditProfileFailureCopyWithImpl<EditProfileFailure>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'EditProfileState.failure'))
    ..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'EditProfileState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $EditProfileFailureCopyWith<$Res> implements $EditProfileStateCopyWith<$Res> {
  factory $EditProfileFailureCopyWith(EditProfileFailure value, $Res Function(EditProfileFailure) _then) = _$EditProfileFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$EditProfileFailureCopyWithImpl<$Res>
    implements $EditProfileFailureCopyWith<$Res> {
  _$EditProfileFailureCopyWithImpl(this._self, this._then);

  final EditProfileFailure _self;
  final $Res Function(EditProfileFailure) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(EditProfileFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_password_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditPasswordState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'EditPasswordState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditPasswordState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'EditPasswordState()';
}


}

/// @nodoc
class $EditPasswordStateCopyWith<$Res>  {
$EditPasswordStateCopyWith(EditPasswordState _, $Res Function(EditPasswordState) __);
}


/// Adds pattern-matching-related methods to [EditPasswordState].
extension EditPasswordStatePatterns on EditPasswordState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EditPasswordInitial value)?  initial,TResult Function( EditPasswordLoading value)?  loading,TResult Function( EditPasswordSuccess value)?  success,TResult Function( EditPasswordFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EditPasswordInitial() when initial != null:
return initial(_that);case EditPasswordLoading() when loading != null:
return loading(_that);case EditPasswordSuccess() when success != null:
return success(_that);case EditPasswordFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EditPasswordInitial value)  initial,required TResult Function( EditPasswordLoading value)  loading,required TResult Function( EditPasswordSuccess value)  success,required TResult Function( EditPasswordFailure value)  failure,}){
final _that = this;
switch (_that) {
case EditPasswordInitial():
return initial(_that);case EditPasswordLoading():
return loading(_that);case EditPasswordSuccess():
return success(_that);case EditPasswordFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EditPasswordInitial value)?  initial,TResult? Function( EditPasswordLoading value)?  loading,TResult? Function( EditPasswordSuccess value)?  success,TResult? Function( EditPasswordFailure value)?  failure,}){
final _that = this;
switch (_that) {
case EditPasswordInitial() when initial != null:
return initial(_that);case EditPasswordLoading() when loading != null:
return loading(_that);case EditPasswordSuccess() when success != null:
return success(_that);case EditPasswordFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String message)?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EditPasswordInitial() when initial != null:
return initial();case EditPasswordLoading() when loading != null:
return loading();case EditPasswordSuccess() when success != null:
return success(_that.message);case EditPasswordFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String message)  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case EditPasswordInitial():
return initial();case EditPasswordLoading():
return loading();case EditPasswordSuccess():
return success(_that.message);case EditPasswordFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String message)?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case EditPasswordInitial() when initial != null:
return initial();case EditPasswordLoading() when loading != null:
return loading();case EditPasswordSuccess() when success != null:
return success(_that.message);case EditPasswordFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class EditPasswordInitial with DiagnosticableTreeMixin implements EditPasswordState {
  const EditPasswordInitial();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'EditPasswordState.initial'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditPasswordInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'EditPasswordState.initial()';
}


}




/// @nodoc


class EditPasswordLoading with DiagnosticableTreeMixin implements EditPasswordState {
  const EditPasswordLoading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'EditPasswordState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditPasswordLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'EditPasswordState.loading()';
}


}




/// @nodoc


class EditPasswordSuccess with DiagnosticableTreeMixin implements EditPasswordState {
  const EditPasswordSuccess(this.message);
  

 final  String message;

/// Create a copy of EditPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditPasswordSuccessCopyWith<EditPasswordSuccess> get copyWith => _$EditPasswordSuccessCopyWithImpl<EditPasswordSuccess>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'EditPasswordState.success'))
    ..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditPasswordSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'EditPasswordState.success(message: $message)';
}


}

/// @nodoc
abstract mixin class $EditPasswordSuccessCopyWith<$Res> implements $EditPasswordStateCopyWith<$Res> {
  factory $EditPasswordSuccessCopyWith(EditPasswordSuccess value, $Res Function(EditPasswordSuccess) _then) = _$EditPasswordSuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$EditPasswordSuccessCopyWithImpl<$Res>
    implements $EditPasswordSuccessCopyWith<$Res> {
  _$EditPasswordSuccessCopyWithImpl(this._self, this._then);

  final EditPasswordSuccess _self;
  final $Res Function(EditPasswordSuccess) _then;

/// Create a copy of EditPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(EditPasswordSuccess(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class EditPasswordFailure with DiagnosticableTreeMixin implements EditPasswordState {
  const EditPasswordFailure(this.message);
  

 final  String message;

/// Create a copy of EditPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditPasswordFailureCopyWith<EditPasswordFailure> get copyWith => _$EditPasswordFailureCopyWithImpl<EditPasswordFailure>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'EditPasswordState.failure'))
    ..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditPasswordFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'EditPasswordState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $EditPasswordFailureCopyWith<$Res> implements $EditPasswordStateCopyWith<$Res> {
  factory $EditPasswordFailureCopyWith(EditPasswordFailure value, $Res Function(EditPasswordFailure) _then) = _$EditPasswordFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$EditPasswordFailureCopyWithImpl<$Res>
    implements $EditPasswordFailureCopyWith<$Res> {
  _$EditPasswordFailureCopyWithImpl(this._self, this._then);

  final EditPasswordFailure _self;
  final $Res Function(EditPasswordFailure) _then;

/// Create a copy of EditPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(EditPasswordFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

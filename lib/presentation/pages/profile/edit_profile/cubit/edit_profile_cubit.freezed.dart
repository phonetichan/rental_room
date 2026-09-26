// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditProfileState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserEntity user) success,
    required TResult Function(String message) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserEntity user)? success,
    TResult? Function(String message)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserEntity user)? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditProfileInitial value) initial,
    required TResult Function(EditProfileLoading value) loading,
    required TResult Function(EditProfileSuccess value) success,
    required TResult Function(EditProfileFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditProfileInitial value)? initial,
    TResult? Function(EditProfileLoading value)? loading,
    TResult? Function(EditProfileSuccess value)? success,
    TResult? Function(EditProfileFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditProfileInitial value)? initial,
    TResult Function(EditProfileLoading value)? loading,
    TResult Function(EditProfileSuccess value)? success,
    TResult Function(EditProfileFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditProfileStateCopyWith<$Res> {
  factory $EditProfileStateCopyWith(
          EditProfileState value, $Res Function(EditProfileState) then) =
      _$EditProfileStateCopyWithImpl<$Res, EditProfileState>;
}

/// @nodoc
class _$EditProfileStateCopyWithImpl<$Res, $Val extends EditProfileState>
    implements $EditProfileStateCopyWith<$Res> {
  _$EditProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$EditProfileInitialImplCopyWith<$Res> {
  factory _$$EditProfileInitialImplCopyWith(_$EditProfileInitialImpl value,
          $Res Function(_$EditProfileInitialImpl) then) =
      __$$EditProfileInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EditProfileInitialImplCopyWithImpl<$Res>
    extends _$EditProfileStateCopyWithImpl<$Res, _$EditProfileInitialImpl>
    implements _$$EditProfileInitialImplCopyWith<$Res> {
  __$$EditProfileInitialImplCopyWithImpl(_$EditProfileInitialImpl _value,
      $Res Function(_$EditProfileInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$EditProfileInitialImpl
    with DiagnosticableTreeMixin
    implements EditProfileInitial {
  const _$EditProfileInitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditProfileState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'EditProfileState.initial'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EditProfileInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserEntity user) success,
    required TResult Function(String message) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserEntity user)? success,
    TResult? Function(String message)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserEntity user)? success,
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
    required TResult Function(EditProfileInitial value) initial,
    required TResult Function(EditProfileLoading value) loading,
    required TResult Function(EditProfileSuccess value) success,
    required TResult Function(EditProfileFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditProfileInitial value)? initial,
    TResult? Function(EditProfileLoading value)? loading,
    TResult? Function(EditProfileSuccess value)? success,
    TResult? Function(EditProfileFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditProfileInitial value)? initial,
    TResult Function(EditProfileLoading value)? loading,
    TResult Function(EditProfileSuccess value)? success,
    TResult Function(EditProfileFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class EditProfileInitial implements EditProfileState {
  const factory EditProfileInitial() = _$EditProfileInitialImpl;
}

/// @nodoc
abstract class _$$EditProfileLoadingImplCopyWith<$Res> {
  factory _$$EditProfileLoadingImplCopyWith(_$EditProfileLoadingImpl value,
          $Res Function(_$EditProfileLoadingImpl) then) =
      __$$EditProfileLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EditProfileLoadingImplCopyWithImpl<$Res>
    extends _$EditProfileStateCopyWithImpl<$Res, _$EditProfileLoadingImpl>
    implements _$$EditProfileLoadingImplCopyWith<$Res> {
  __$$EditProfileLoadingImplCopyWithImpl(_$EditProfileLoadingImpl _value,
      $Res Function(_$EditProfileLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$EditProfileLoadingImpl
    with DiagnosticableTreeMixin
    implements EditProfileLoading {
  const _$EditProfileLoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditProfileState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'EditProfileState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EditProfileLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserEntity user) success,
    required TResult Function(String message) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserEntity user)? success,
    TResult? Function(String message)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserEntity user)? success,
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
    required TResult Function(EditProfileInitial value) initial,
    required TResult Function(EditProfileLoading value) loading,
    required TResult Function(EditProfileSuccess value) success,
    required TResult Function(EditProfileFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditProfileInitial value)? initial,
    TResult? Function(EditProfileLoading value)? loading,
    TResult? Function(EditProfileSuccess value)? success,
    TResult? Function(EditProfileFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditProfileInitial value)? initial,
    TResult Function(EditProfileLoading value)? loading,
    TResult Function(EditProfileSuccess value)? success,
    TResult Function(EditProfileFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class EditProfileLoading implements EditProfileState {
  const factory EditProfileLoading() = _$EditProfileLoadingImpl;
}

/// @nodoc
abstract class _$$EditProfileSuccessImplCopyWith<$Res> {
  factory _$$EditProfileSuccessImplCopyWith(_$EditProfileSuccessImpl value,
          $Res Function(_$EditProfileSuccessImpl) then) =
      __$$EditProfileSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserEntity user});
}

/// @nodoc
class __$$EditProfileSuccessImplCopyWithImpl<$Res>
    extends _$EditProfileStateCopyWithImpl<$Res, _$EditProfileSuccessImpl>
    implements _$$EditProfileSuccessImplCopyWith<$Res> {
  __$$EditProfileSuccessImplCopyWithImpl(_$EditProfileSuccessImpl _value,
      $Res Function(_$EditProfileSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$EditProfileSuccessImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity,
    ));
  }
}

/// @nodoc

class _$EditProfileSuccessImpl
    with DiagnosticableTreeMixin
    implements EditProfileSuccess {
  const _$EditProfileSuccessImpl(this.user);

  @override
  final UserEntity user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditProfileState.success(user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditProfileState.success'))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditProfileSuccessImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditProfileSuccessImplCopyWith<_$EditProfileSuccessImpl> get copyWith =>
      __$$EditProfileSuccessImplCopyWithImpl<_$EditProfileSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserEntity user) success,
    required TResult Function(String message) failure,
  }) {
    return success(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserEntity user)? success,
    TResult? Function(String message)? failure,
  }) {
    return success?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserEntity user)? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditProfileInitial value) initial,
    required TResult Function(EditProfileLoading value) loading,
    required TResult Function(EditProfileSuccess value) success,
    required TResult Function(EditProfileFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditProfileInitial value)? initial,
    TResult? Function(EditProfileLoading value)? loading,
    TResult? Function(EditProfileSuccess value)? success,
    TResult? Function(EditProfileFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditProfileInitial value)? initial,
    TResult Function(EditProfileLoading value)? loading,
    TResult Function(EditProfileSuccess value)? success,
    TResult Function(EditProfileFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class EditProfileSuccess implements EditProfileState {
  const factory EditProfileSuccess(UserEntity user) =
      _$EditProfileSuccessImpl;

  UserEntity get user;
  @JsonKey(ignore: true)
  _$$EditProfileSuccessImplCopyWith<_$EditProfileSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditProfileFailureImplCopyWith<$Res> {
  factory _$$EditProfileFailureImplCopyWith(_$EditProfileFailureImpl value,
          $Res Function(_$EditProfileFailureImpl) then) =
      __$$EditProfileFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$EditProfileFailureImplCopyWithImpl<$Res>
    extends _$EditProfileStateCopyWithImpl<$Res, _$EditProfileFailureImpl>
    implements _$$EditProfileFailureImplCopyWith<$Res> {
  __$$EditProfileFailureImplCopyWithImpl(_$EditProfileFailureImpl _value,
      $Res Function(_$EditProfileFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$EditProfileFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EditProfileFailureImpl
    with DiagnosticableTreeMixin
    implements EditProfileFailure {
  const _$EditProfileFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditProfileState.failure(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditProfileState.failure'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditProfileFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditProfileFailureImplCopyWith<_$EditProfileFailureImpl> get copyWith =>
      __$$EditProfileFailureImplCopyWithImpl<_$EditProfileFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserEntity user) success,
    required TResult Function(String message) failure,
  }) {
    return failure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserEntity user)? success,
    TResult? Function(String message)? failure,
  }) {
    return failure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserEntity user)? success,
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
    required TResult Function(EditProfileInitial value) initial,
    required TResult Function(EditProfileLoading value) loading,
    required TResult Function(EditProfileSuccess value) success,
    required TResult Function(EditProfileFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditProfileInitial value)? initial,
    TResult? Function(EditProfileLoading value)? loading,
    TResult? Function(EditProfileSuccess value)? success,
    TResult? Function(EditProfileFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditProfileInitial value)? initial,
    TResult Function(EditProfileLoading value)? loading,
    TResult Function(EditProfileSuccess value)? success,
    TResult Function(EditProfileFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class EditProfileFailure implements EditProfileState {
  const factory EditProfileFailure(String message) =
      _$EditProfileFailureImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$EditProfileFailureImplCopyWith<_$EditProfileFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

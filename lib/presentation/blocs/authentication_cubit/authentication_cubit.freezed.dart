// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthenticationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserEntity user) authenticated,
    required TResult Function() unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserEntity user)? authenticated,
    TResult? Function()? unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserEntity user)? authenticated,
    TResult Function()? unauthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationInitial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationAuthenticated value) authenticated,
    required TResult Function(AuthenticationUnauthenticated value)
        unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationInitial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationAuthenticated value)? authenticated,
    TResult? Function(AuthenticationUnauthenticated value)? unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationInitial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationAuthenticated value)? authenticated,
    TResult Function(AuthenticationUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationStateCopyWith(
          AuthenticationState value, $Res Function(AuthenticationState) then) =
      _$AuthenticationStateCopyWithImpl<$Res, AuthenticationState>;
}

/// @nodoc
class _$AuthenticationStateCopyWithImpl<$Res, $Val extends AuthenticationState>
    implements $AuthenticationStateCopyWith<$Res> {
  _$AuthenticationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AuthenticationInitialImplCopyWith<$Res> {
  factory _$$AuthenticationInitialImplCopyWith(
          _$AuthenticationInitialImpl value,
          $Res Function(_$AuthenticationInitialImpl) then) =
      __$$AuthenticationInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationInitialImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationInitialImpl>
    implements _$$AuthenticationInitialImplCopyWith<$Res> {
  __$$AuthenticationInitialImplCopyWithImpl(_$AuthenticationInitialImpl _value,
      $Res Function(_$AuthenticationInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationInitialImpl implements AuthenticationInitial {
  const _$AuthenticationInitialImpl();

  @override
  String toString() {
    return 'AuthenticationState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserEntity user) authenticated,
    required TResult Function() unauthenticated,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserEntity user)? authenticated,
    TResult? Function()? unauthenticated,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserEntity user)? authenticated,
    TResult Function()? unauthenticated,
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
    required TResult Function(AuthenticationInitial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationAuthenticated value) authenticated,
    required TResult Function(AuthenticationUnauthenticated value)
        unauthenticated,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationInitial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationAuthenticated value)? authenticated,
    TResult? Function(AuthenticationUnauthenticated value)? unauthenticated,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationInitial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationAuthenticated value)? authenticated,
    TResult Function(AuthenticationUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AuthenticationInitial implements AuthenticationState {
  const factory AuthenticationInitial() = _$AuthenticationInitialImpl;
}

/// @nodoc
abstract class _$$AuthenticationLoadingImplCopyWith<$Res> {
  factory _$$AuthenticationLoadingImplCopyWith(
          _$AuthenticationLoadingImpl value,
          $Res Function(_$AuthenticationLoadingImpl) then) =
      __$$AuthenticationLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationLoadingImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationLoadingImpl>
    implements _$$AuthenticationLoadingImplCopyWith<$Res> {
  __$$AuthenticationLoadingImplCopyWithImpl(_$AuthenticationLoadingImpl _value,
      $Res Function(_$AuthenticationLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationLoadingImpl implements AuthenticationLoading {
  const _$AuthenticationLoadingImpl();

  @override
  String toString() {
    return 'AuthenticationState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserEntity user) authenticated,
    required TResult Function() unauthenticated,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserEntity user)? authenticated,
    TResult? Function()? unauthenticated,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserEntity user)? authenticated,
    TResult Function()? unauthenticated,
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
    required TResult Function(AuthenticationInitial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationAuthenticated value) authenticated,
    required TResult Function(AuthenticationUnauthenticated value)
        unauthenticated,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationInitial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationAuthenticated value)? authenticated,
    TResult? Function(AuthenticationUnauthenticated value)? unauthenticated,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationInitial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationAuthenticated value)? authenticated,
    TResult Function(AuthenticationUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AuthenticationLoading implements AuthenticationState {
  const factory AuthenticationLoading() = _$AuthenticationLoadingImpl;
}

/// @nodoc
abstract class _$$AuthenticationAuthenticatedImplCopyWith<$Res> {
  factory _$$AuthenticationAuthenticatedImplCopyWith(
          _$AuthenticationAuthenticatedImpl value,
          $Res Function(_$AuthenticationAuthenticatedImpl) then) =
      __$$AuthenticationAuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserEntity user});
}

/// @nodoc
class __$$AuthenticationAuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res,
        _$AuthenticationAuthenticatedImpl>
    implements _$$AuthenticationAuthenticatedImplCopyWith<$Res> {
  __$$AuthenticationAuthenticatedImplCopyWithImpl(
      _$AuthenticationAuthenticatedImpl _value,
      $Res Function(_$AuthenticationAuthenticatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$AuthenticationAuthenticatedImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity,
    ));
  }
}

/// @nodoc

class _$AuthenticationAuthenticatedImpl implements AuthenticationAuthenticated {
  const _$AuthenticationAuthenticatedImpl(this.user);

  @override
  final UserEntity user;

  @override
  String toString() {
    return 'AuthenticationState.authenticated(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationAuthenticatedImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationAuthenticatedImplCopyWith<_$AuthenticationAuthenticatedImpl>
      get copyWith => __$$AuthenticationAuthenticatedImplCopyWithImpl<
          _$AuthenticationAuthenticatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserEntity user) authenticated,
    required TResult Function() unauthenticated,
  }) {
    return authenticated(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserEntity user)? authenticated,
    TResult? Function()? unauthenticated,
  }) {
    return authenticated?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserEntity user)? authenticated,
    TResult Function()? unauthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationInitial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationAuthenticated value) authenticated,
    required TResult Function(AuthenticationUnauthenticated value)
        unauthenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationInitial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationAuthenticated value)? authenticated,
    TResult? Function(AuthenticationUnauthenticated value)? unauthenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationInitial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationAuthenticated value)? authenticated,
    TResult Function(AuthenticationUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthenticationAuthenticated implements AuthenticationState {
  const factory AuthenticationAuthenticated(UserEntity user) =
      _$AuthenticationAuthenticatedImpl;

  UserEntity get user;
  @JsonKey(ignore: true)
  _$$AuthenticationAuthenticatedImplCopyWith<_$AuthenticationAuthenticatedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticationUnauthenticatedImplCopyWith<$Res> {
  factory _$$AuthenticationUnauthenticatedImplCopyWith(
          _$AuthenticationUnauthenticatedImpl value,
          $Res Function(_$AuthenticationUnauthenticatedImpl) then) =
      __$$AuthenticationUnauthenticatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationUnauthenticatedImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res,
        _$AuthenticationUnauthenticatedImpl>
    implements _$$AuthenticationUnauthenticatedImplCopyWith<$Res> {
  __$$AuthenticationUnauthenticatedImplCopyWithImpl(
      _$AuthenticationUnauthenticatedImpl _value,
      $Res Function(_$AuthenticationUnauthenticatedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationUnauthenticatedImpl
    implements AuthenticationUnauthenticated {
  const _$AuthenticationUnauthenticatedImpl();

  @override
  String toString() {
    return 'AuthenticationState.unauthenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationUnauthenticatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserEntity user) authenticated,
    required TResult Function() unauthenticated,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserEntity user)? authenticated,
    TResult? Function()? unauthenticated,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserEntity user)? authenticated,
    TResult Function()? unauthenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationInitial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationAuthenticated value) authenticated,
    required TResult Function(AuthenticationUnauthenticated value)
        unauthenticated,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationInitial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationAuthenticated value)? authenticated,
    TResult? Function(AuthenticationUnauthenticated value)? unauthenticated,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationInitial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationAuthenticated value)? authenticated,
    TResult Function(AuthenticationUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class AuthenticationUnauthenticated implements AuthenticationState {
  const factory AuthenticationUnauthenticated() =
      _$AuthenticationUnauthenticatedImpl;
}

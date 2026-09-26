// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_password_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditPasswordState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) success,
    required TResult Function(String message) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? success,
    TResult? Function(String message)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditPasswordInitial value) initial,
    required TResult Function(EditPasswordLoading value) loading,
    required TResult Function(EditPasswordSuccess value) success,
    required TResult Function(EditPasswordFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditPasswordInitial value)? initial,
    TResult? Function(EditPasswordLoading value)? loading,
    TResult? Function(EditPasswordSuccess value)? success,
    TResult? Function(EditPasswordFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditPasswordInitial value)? initial,
    TResult Function(EditPasswordLoading value)? loading,
    TResult Function(EditPasswordSuccess value)? success,
    TResult Function(EditPasswordFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditPasswordStateCopyWith<$Res> {
  factory $EditPasswordStateCopyWith(
          EditPasswordState value, $Res Function(EditPasswordState) then) =
      _$EditPasswordStateCopyWithImpl<$Res, EditPasswordState>;
}

/// @nodoc
class _$EditPasswordStateCopyWithImpl<$Res, $Val extends EditPasswordState>
    implements $EditPasswordStateCopyWith<$Res> {
  _$EditPasswordStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$EditPasswordInitialImplCopyWith<$Res> {
  factory _$$EditPasswordInitialImplCopyWith(_$EditPasswordInitialImpl value,
          $Res Function(_$EditPasswordInitialImpl) then) =
      __$$EditPasswordInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EditPasswordInitialImplCopyWithImpl<$Res>
    extends _$EditPasswordStateCopyWithImpl<$Res, _$EditPasswordInitialImpl>
    implements _$$EditPasswordInitialImplCopyWith<$Res> {
  __$$EditPasswordInitialImplCopyWithImpl(_$EditPasswordInitialImpl _value,
      $Res Function(_$EditPasswordInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$EditPasswordInitialImpl
    with DiagnosticableTreeMixin
    implements EditPasswordInitial {
  const _$EditPasswordInitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditPasswordState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'EditPasswordState.initial'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditPasswordInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) success,
    required TResult Function(String message) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? success,
    TResult? Function(String message)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? success,
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
    required TResult Function(EditPasswordInitial value) initial,
    required TResult Function(EditPasswordLoading value) loading,
    required TResult Function(EditPasswordSuccess value) success,
    required TResult Function(EditPasswordFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditPasswordInitial value)? initial,
    TResult? Function(EditPasswordLoading value)? loading,
    TResult? Function(EditPasswordSuccess value)? success,
    TResult? Function(EditPasswordFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditPasswordInitial value)? initial,
    TResult Function(EditPasswordLoading value)? loading,
    TResult Function(EditPasswordSuccess value)? success,
    TResult Function(EditPasswordFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class EditPasswordInitial implements EditPasswordState {
  const factory EditPasswordInitial() = _$EditPasswordInitialImpl;
}

/// @nodoc
abstract class _$$EditPasswordLoadingImplCopyWith<$Res> {
  factory _$$EditPasswordLoadingImplCopyWith(_$EditPasswordLoadingImpl value,
          $Res Function(_$EditPasswordLoadingImpl) then) =
      __$$EditPasswordLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EditPasswordLoadingImplCopyWithImpl<$Res>
    extends _$EditPasswordStateCopyWithImpl<$Res, _$EditPasswordLoadingImpl>
    implements _$$EditPasswordLoadingImplCopyWith<$Res> {
  __$$EditPasswordLoadingImplCopyWithImpl(_$EditPasswordLoadingImpl _value,
      $Res Function(_$EditPasswordLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$EditPasswordLoadingImpl
    with DiagnosticableTreeMixin
    implements EditPasswordLoading {
  const _$EditPasswordLoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditPasswordState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'EditPasswordState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditPasswordLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) success,
    required TResult Function(String message) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? success,
    TResult? Function(String message)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? success,
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
    required TResult Function(EditPasswordInitial value) initial,
    required TResult Function(EditPasswordLoading value) loading,
    required TResult Function(EditPasswordSuccess value) success,
    required TResult Function(EditPasswordFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditPasswordInitial value)? initial,
    TResult? Function(EditPasswordLoading value)? loading,
    TResult? Function(EditPasswordSuccess value)? success,
    TResult? Function(EditPasswordFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditPasswordInitial value)? initial,
    TResult Function(EditPasswordLoading value)? loading,
    TResult Function(EditPasswordSuccess value)? success,
    TResult Function(EditPasswordFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class EditPasswordLoading implements EditPasswordState {
  const factory EditPasswordLoading() = _$EditPasswordLoadingImpl;
}

/// @nodoc
abstract class _$$EditPasswordSuccessImplCopyWith<$Res> {
  factory _$$EditPasswordSuccessImplCopyWith(_$EditPasswordSuccessImpl value,
          $Res Function(_$EditPasswordSuccessImpl) then) =
      __$$EditPasswordSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$EditPasswordSuccessImplCopyWithImpl<$Res>
    extends _$EditPasswordStateCopyWithImpl<$Res, _$EditPasswordSuccessImpl>
    implements _$$EditPasswordSuccessImplCopyWith<$Res> {
  __$$EditPasswordSuccessImplCopyWithImpl(_$EditPasswordSuccessImpl _value,
      $Res Function(_$EditPasswordSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$EditPasswordSuccessImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EditPasswordSuccessImpl
    with DiagnosticableTreeMixin
    implements EditPasswordSuccess {
  const _$EditPasswordSuccessImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditPasswordState.success(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditPasswordState.success'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditPasswordSuccessImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditPasswordSuccessImplCopyWith<_$EditPasswordSuccessImpl> get copyWith =>
      __$$EditPasswordSuccessImplCopyWithImpl<_$EditPasswordSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) success,
    required TResult Function(String message) failure,
  }) {
    return success(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? success,
    TResult? Function(String message)? failure,
  }) {
    return success?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditPasswordInitial value) initial,
    required TResult Function(EditPasswordLoading value) loading,
    required TResult Function(EditPasswordSuccess value) success,
    required TResult Function(EditPasswordFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditPasswordInitial value)? initial,
    TResult? Function(EditPasswordLoading value)? loading,
    TResult? Function(EditPasswordSuccess value)? success,
    TResult? Function(EditPasswordFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditPasswordInitial value)? initial,
    TResult Function(EditPasswordLoading value)? loading,
    TResult Function(EditPasswordSuccess value)? success,
    TResult Function(EditPasswordFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class EditPasswordSuccess implements EditPasswordState {
  const factory EditPasswordSuccess(String message) =
      _$EditPasswordSuccessImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$EditPasswordSuccessImplCopyWith<_$EditPasswordSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditPasswordFailureImplCopyWith<$Res> {
  factory _$$EditPasswordFailureImplCopyWith(_$EditPasswordFailureImpl value,
          $Res Function(_$EditPasswordFailureImpl) then) =
      __$$EditPasswordFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$EditPasswordFailureImplCopyWithImpl<$Res>
    extends _$EditPasswordStateCopyWithImpl<$Res, _$EditPasswordFailureImpl>
    implements _$$EditPasswordFailureImplCopyWith<$Res> {
  __$$EditPasswordFailureImplCopyWithImpl(_$EditPasswordFailureImpl _value,
      $Res Function(_$EditPasswordFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$EditPasswordFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EditPasswordFailureImpl
    with DiagnosticableTreeMixin
    implements EditPasswordFailure {
  const _$EditPasswordFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditPasswordState.failure(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditPasswordState.failure'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditPasswordFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditPasswordFailureImplCopyWith<_$EditPasswordFailureImpl> get copyWith =>
      __$$EditPasswordFailureImplCopyWithImpl<_$EditPasswordFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) success,
    required TResult Function(String message) failure,
  }) {
    return failure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? success,
    TResult? Function(String message)? failure,
  }) {
    return failure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? success,
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
    required TResult Function(EditPasswordInitial value) initial,
    required TResult Function(EditPasswordLoading value) loading,
    required TResult Function(EditPasswordSuccess value) success,
    required TResult Function(EditPasswordFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditPasswordInitial value)? initial,
    TResult? Function(EditPasswordLoading value)? loading,
    TResult? Function(EditPasswordSuccess value)? success,
    TResult? Function(EditPasswordFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditPasswordInitial value)? initial,
    TResult Function(EditPasswordLoading value)? loading,
    TResult Function(EditPasswordSuccess value)? success,
    TResult Function(EditPasswordFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class EditPasswordFailure implements EditPasswordState {
  const factory EditPasswordFailure(String message) =
      _$EditPasswordFailureImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$EditPasswordFailureImplCopyWith<_$EditPasswordFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

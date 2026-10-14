// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FavoriteState {
  Set<String> get userFavoriteRoomIds => throw _privateConstructorUsedError;
  Map<String, int> get favoriteCounts => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FavoriteStateCopyWith<FavoriteState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteStateCopyWith<$Res> {
  factory $FavoriteStateCopyWith(
          FavoriteState value, $Res Function(FavoriteState) then) =
      _$FavoriteStateCopyWithImpl<$Res, FavoriteState>;
  @useResult
  $Res call(
      {Set<String> userFavoriteRoomIds,
      Map<String, int> favoriteCounts,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class _$FavoriteStateCopyWithImpl<$Res, $Val extends FavoriteState>
    implements $FavoriteStateCopyWith<$Res> {
  _$FavoriteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userFavoriteRoomIds = null,
    Object? favoriteCounts = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      userFavoriteRoomIds: null == userFavoriteRoomIds
          ? _value.userFavoriteRoomIds
          : userFavoriteRoomIds // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      favoriteCounts: null == favoriteCounts
          ? _value.favoriteCounts
          : favoriteCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FavoriteStateImplCopyWith<$Res>
    implements $FavoriteStateCopyWith<$Res> {
  factory _$$FavoriteStateImplCopyWith(
          _$FavoriteStateImpl value, $Res Function(_$FavoriteStateImpl) then) =
      __$$FavoriteStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Set<String> userFavoriteRoomIds,
      Map<String, int> favoriteCounts,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class __$$FavoriteStateImplCopyWithImpl<$Res>
    extends _$FavoriteStateCopyWithImpl<$Res, _$FavoriteStateImpl>
    implements _$$FavoriteStateImplCopyWith<$Res> {
  __$$FavoriteStateImplCopyWithImpl(
      _$FavoriteStateImpl _value, $Res Function(_$FavoriteStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userFavoriteRoomIds = null,
    Object? favoriteCounts = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$FavoriteStateImpl(
      userFavoriteRoomIds: null == userFavoriteRoomIds
          ? _value._userFavoriteRoomIds
          : userFavoriteRoomIds // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      favoriteCounts: null == favoriteCounts
          ? _value._favoriteCounts
          : favoriteCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$FavoriteStateImpl extends _FavoriteState {
  const _$FavoriteStateImpl(
      {Set<String> userFavoriteRoomIds = const {},
      Map<String, int> favoriteCounts = const {},
      this.isLoading = false,
      this.errorMessage})
      : _userFavoriteRoomIds = userFavoriteRoomIds,
        _favoriteCounts = favoriteCounts,
        super._();

  final Set<String> _userFavoriteRoomIds;
  @override
  @JsonKey()
  Set<String> get userFavoriteRoomIds {
    if (_userFavoriteRoomIds is EqualUnmodifiableSetView)
      return _userFavoriteRoomIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_userFavoriteRoomIds);
  }

  final Map<String, int> _favoriteCounts;
  @override
  @JsonKey()
  Map<String, int> get favoriteCounts {
    if (_favoriteCounts is EqualUnmodifiableMapView) return _favoriteCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_favoriteCounts);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'FavoriteState(userFavoriteRoomIds: $userFavoriteRoomIds, favoriteCounts: $favoriteCounts, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteStateImpl &&
            const DeepCollectionEquality()
                .equals(other._userFavoriteRoomIds, _userFavoriteRoomIds) &&
            const DeepCollectionEquality()
                .equals(other._favoriteCounts, _favoriteCounts) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_userFavoriteRoomIds),
      const DeepCollectionEquality().hash(_favoriteCounts),
      isLoading,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteStateImplCopyWith<_$FavoriteStateImpl> get copyWith =>
      __$$FavoriteStateImplCopyWithImpl<_$FavoriteStateImpl>(this, _$identity);
}

abstract class _FavoriteState extends FavoriteState {
  const factory _FavoriteState(
      {Set<String> userFavoriteRoomIds,
      Map<String, int> favoriteCounts,
      bool isLoading,
      String? errorMessage}) = _$FavoriteStateImpl;
  const _FavoriteState._() : super._();

  @override
  Set<String> get userFavoriteRoomIds;
  @override
  Map<String, int> get favoriteCounts;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$FavoriteStateImplCopyWith<_$FavoriteStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

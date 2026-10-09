// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RoomViewModel {
  String get id => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get viewedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RoomViewModelCopyWith<RoomViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomViewModelCopyWith<$Res> {
  factory $RoomViewModelCopyWith(
          RoomViewModel value, $Res Function(RoomViewModel) then) =
      _$RoomViewModelCopyWithImpl<$Res, RoomViewModel>;
  @useResult
  $Res call({String id, String roomId, String userId, DateTime viewedAt});
}

/// @nodoc
class _$RoomViewModelCopyWithImpl<$Res, $Val extends RoomViewModel>
    implements $RoomViewModelCopyWith<$Res> {
  _$RoomViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? userId = null,
    Object? viewedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      viewedAt: null == viewedAt
          ? _value.viewedAt
          : viewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomViewModelImplCopyWith<$Res>
    implements $RoomViewModelCopyWith<$Res> {
  factory _$$RoomViewModelImplCopyWith(
          _$RoomViewModelImpl value, $Res Function(_$RoomViewModelImpl) then) =
      __$$RoomViewModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String roomId, String userId, DateTime viewedAt});
}

/// @nodoc
class __$$RoomViewModelImplCopyWithImpl<$Res>
    extends _$RoomViewModelCopyWithImpl<$Res, _$RoomViewModelImpl>
    implements _$$RoomViewModelImplCopyWith<$Res> {
  __$$RoomViewModelImplCopyWithImpl(
      _$RoomViewModelImpl _value, $Res Function(_$RoomViewModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? userId = null,
    Object? viewedAt = null,
  }) {
    return _then(_$RoomViewModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      viewedAt: null == viewedAt
          ? _value.viewedAt
          : viewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$RoomViewModelImpl extends _RoomViewModel {
  const _$RoomViewModelImpl(
      {required this.id,
      required this.roomId,
      required this.userId,
      required this.viewedAt})
      : super._();

  @override
  final String id;
  @override
  final String roomId;
  @override
  final String userId;
  @override
  final DateTime viewedAt;

  @override
  String toString() {
    return 'RoomViewModel(id: $id, roomId: $roomId, userId: $userId, viewedAt: $viewedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomViewModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.viewedAt, viewedAt) ||
                other.viewedAt == viewedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, roomId, userId, viewedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomViewModelImplCopyWith<_$RoomViewModelImpl> get copyWith =>
      __$$RoomViewModelImplCopyWithImpl<_$RoomViewModelImpl>(this, _$identity);
}

abstract class _RoomViewModel extends RoomViewModel {
  const factory _RoomViewModel(
      {required String id,
      required String roomId,
      required String userId,
      required DateTime viewedAt}) = _$RoomViewModelImpl;
  const _RoomViewModel._() : super._();

  @override
  String get id;
  @override
  String get roomId;
  @override
  String get userId;
  @override
  DateTime get viewedAt;
  @override
  @JsonKey(ignore: true)
  _$$RoomViewModelImplCopyWith<_$RoomViewModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

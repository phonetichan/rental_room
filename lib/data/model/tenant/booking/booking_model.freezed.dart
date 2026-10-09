// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BookingModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  String? get ownerId => throw _privateConstructorUsedError;
  bool get isPhoneContacted => throw _privateConstructorUsedError;
  bool get isVisited => throw _privateConstructorUsedError;
  bool get isReadByTenant => throw _privateConstructorUsedError;
  bool get isReadByOwner => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get roomName => throw _privateConstructorUsedError;
  double? get roomPrice => throw _privateConstructorUsedError;
  String? get roomImageUrl => throw _privateConstructorUsedError;
  String? get tenantName => throw _privateConstructorUsedError;
  String? get tenantPhone => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BookingModelCopyWith<BookingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingModelCopyWith<$Res> {
  factory $BookingModelCopyWith(
          BookingModel value, $Res Function(BookingModel) then) =
      _$BookingModelCopyWithImpl<$Res, BookingModel>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String roomId,
      String? ownerId,
      bool isPhoneContacted,
      bool isVisited,
      bool isReadByTenant,
      bool isReadByOwner,
      String status,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? roomName,
      double? roomPrice,
      String? roomImageUrl,
      String? tenantName,
      String? tenantPhone});
}

/// @nodoc
class _$BookingModelCopyWithImpl<$Res, $Val extends BookingModel>
    implements $BookingModelCopyWith<$Res> {
  _$BookingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? roomId = null,
    Object? ownerId = freezed,
    Object? isPhoneContacted = null,
    Object? isVisited = null,
    Object? isReadByTenant = null,
    Object? isReadByOwner = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? roomName = freezed,
    Object? roomPrice = freezed,
    Object? roomImageUrl = freezed,
    Object? tenantName = freezed,
    Object? tenantPhone = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      isPhoneContacted: null == isPhoneContacted
          ? _value.isPhoneContacted
          : isPhoneContacted // ignore: cast_nullable_to_non_nullable
              as bool,
      isVisited: null == isVisited
          ? _value.isVisited
          : isVisited // ignore: cast_nullable_to_non_nullable
              as bool,
      isReadByTenant: null == isReadByTenant
          ? _value.isReadByTenant
          : isReadByTenant // ignore: cast_nullable_to_non_nullable
              as bool,
      isReadByOwner: null == isReadByOwner
          ? _value.isReadByOwner
          : isReadByOwner // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      roomName: freezed == roomName
          ? _value.roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as String?,
      roomPrice: freezed == roomPrice
          ? _value.roomPrice
          : roomPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      roomImageUrl: freezed == roomImageUrl
          ? _value.roomImageUrl
          : roomImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantName: freezed == tenantName
          ? _value.tenantName
          : tenantName // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantPhone: freezed == tenantPhone
          ? _value.tenantPhone
          : tenantPhone // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookingModelImplCopyWith<$Res>
    implements $BookingModelCopyWith<$Res> {
  factory _$$BookingModelImplCopyWith(
          _$BookingModelImpl value, $Res Function(_$BookingModelImpl) then) =
      __$$BookingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String roomId,
      String? ownerId,
      bool isPhoneContacted,
      bool isVisited,
      bool isReadByTenant,
      bool isReadByOwner,
      String status,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? roomName,
      double? roomPrice,
      String? roomImageUrl,
      String? tenantName,
      String? tenantPhone});
}

/// @nodoc
class __$$BookingModelImplCopyWithImpl<$Res>
    extends _$BookingModelCopyWithImpl<$Res, _$BookingModelImpl>
    implements _$$BookingModelImplCopyWith<$Res> {
  __$$BookingModelImplCopyWithImpl(
      _$BookingModelImpl _value, $Res Function(_$BookingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? roomId = null,
    Object? ownerId = freezed,
    Object? isPhoneContacted = null,
    Object? isVisited = null,
    Object? isReadByTenant = null,
    Object? isReadByOwner = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? roomName = freezed,
    Object? roomPrice = freezed,
    Object? roomImageUrl = freezed,
    Object? tenantName = freezed,
    Object? tenantPhone = freezed,
  }) {
    return _then(_$BookingModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      isPhoneContacted: null == isPhoneContacted
          ? _value.isPhoneContacted
          : isPhoneContacted // ignore: cast_nullable_to_non_nullable
              as bool,
      isVisited: null == isVisited
          ? _value.isVisited
          : isVisited // ignore: cast_nullable_to_non_nullable
              as bool,
      isReadByTenant: null == isReadByTenant
          ? _value.isReadByTenant
          : isReadByTenant // ignore: cast_nullable_to_non_nullable
              as bool,
      isReadByOwner: null == isReadByOwner
          ? _value.isReadByOwner
          : isReadByOwner // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      roomName: freezed == roomName
          ? _value.roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as String?,
      roomPrice: freezed == roomPrice
          ? _value.roomPrice
          : roomPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      roomImageUrl: freezed == roomImageUrl
          ? _value.roomImageUrl
          : roomImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantName: freezed == tenantName
          ? _value.tenantName
          : tenantName // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantPhone: freezed == tenantPhone
          ? _value.tenantPhone
          : tenantPhone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$BookingModelImpl extends _BookingModel {
  const _$BookingModelImpl(
      {required this.id,
      required this.userId,
      required this.roomId,
      this.ownerId,
      this.isPhoneContacted = false,
      this.isVisited = false,
      this.isReadByTenant = false,
      this.isReadByOwner = false,
      this.status = 'draft',
      this.createdAt,
      this.updatedAt,
      this.roomName,
      this.roomPrice,
      this.roomImageUrl,
      this.tenantName,
      this.tenantPhone})
      : super._();

  @override
  final String id;
  @override
  final String userId;
  @override
  final String roomId;
  @override
  final String? ownerId;
  @override
  @JsonKey()
  final bool isPhoneContacted;
  @override
  @JsonKey()
  final bool isVisited;
  @override
  @JsonKey()
  final bool isReadByTenant;
  @override
  @JsonKey()
  final bool isReadByOwner;
  @override
  @JsonKey()
  final String status;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? roomName;
  @override
  final double? roomPrice;
  @override
  final String? roomImageUrl;
  @override
  final String? tenantName;
  @override
  final String? tenantPhone;

  @override
  String toString() {
    return 'BookingModel(id: $id, userId: $userId, roomId: $roomId, ownerId: $ownerId, isPhoneContacted: $isPhoneContacted, isVisited: $isVisited, isReadByTenant: $isReadByTenant, isReadByOwner: $isReadByOwner, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, roomName: $roomName, roomPrice: $roomPrice, roomImageUrl: $roomImageUrl, tenantName: $tenantName, tenantPhone: $tenantPhone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.isPhoneContacted, isPhoneContacted) ||
                other.isPhoneContacted == isPhoneContacted) &&
            (identical(other.isVisited, isVisited) ||
                other.isVisited == isVisited) &&
            (identical(other.isReadByTenant, isReadByTenant) ||
                other.isReadByTenant == isReadByTenant) &&
            (identical(other.isReadByOwner, isReadByOwner) ||
                other.isReadByOwner == isReadByOwner) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.roomName, roomName) ||
                other.roomName == roomName) &&
            (identical(other.roomPrice, roomPrice) ||
                other.roomPrice == roomPrice) &&
            (identical(other.roomImageUrl, roomImageUrl) ||
                other.roomImageUrl == roomImageUrl) &&
            (identical(other.tenantName, tenantName) ||
                other.tenantName == tenantName) &&
            (identical(other.tenantPhone, tenantPhone) ||
                other.tenantPhone == tenantPhone));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      roomId,
      ownerId,
      isPhoneContacted,
      isVisited,
      isReadByTenant,
      isReadByOwner,
      status,
      createdAt,
      updatedAt,
      roomName,
      roomPrice,
      roomImageUrl,
      tenantName,
      tenantPhone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingModelImplCopyWith<_$BookingModelImpl> get copyWith =>
      __$$BookingModelImplCopyWithImpl<_$BookingModelImpl>(this, _$identity);
}

abstract class _BookingModel extends BookingModel {
  const factory _BookingModel(
      {required String id,
      required String userId,
      required String roomId,
       String? ownerId,
       bool isPhoneContacted,
       bool isVisited,
       bool isReadByTenant,
       bool isReadByOwner,
       String status,
       DateTime? createdAt,
       DateTime? updatedAt,
       String? roomName,
       double? roomPrice,
       String? roomImageUrl,
       String? tenantName,
       String? tenantPhone}) = _$BookingModelImpl;
  const _BookingModel._() : super._();

  @override
  String get id;
  @override
  String get userId;
  @override
  String get roomId;
  @override
  String? get ownerId;
  @override
  bool get isPhoneContacted;
  @override
  bool get isVisited;
  @override
  bool get isReadByTenant;
  @override
  bool get isReadByOwner;
  @override
  String get status;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  String? get roomName;
  @override
  double? get roomPrice;
  @override
  String? get roomImageUrl;
  @override
  String? get tenantName;
  @override
  String? get tenantPhone;
  @override
  @JsonKey(ignore: true)
  _$$BookingModelImplCopyWith<_$BookingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

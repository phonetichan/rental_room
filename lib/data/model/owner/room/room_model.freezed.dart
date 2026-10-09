// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RoomImageModel {
  String get id => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  bool get isPrimary => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RoomImageModelCopyWith<RoomImageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomImageModelCopyWith<$Res> {
  factory $RoomImageModelCopyWith(
          RoomImageModel value, $Res Function(RoomImageModel) then) =
      _$RoomImageModelCopyWithImpl<$Res, RoomImageModel>;
  @useResult
  $Res call({String id, String roomId, String imageUrl, bool isPrimary});
}

/// @nodoc
class _$RoomImageModelCopyWithImpl<$Res, $Val extends RoomImageModel>
    implements $RoomImageModelCopyWith<$Res> {
  _$RoomImageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? imageUrl = null,
    Object? isPrimary = null,
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
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isPrimary: null == isPrimary
          ? _value.isPrimary
          : isPrimary // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomImageModelImplCopyWith<$Res>
    implements $RoomImageModelCopyWith<$Res> {
  factory _$$RoomImageModelImplCopyWith(_$RoomImageModelImpl value,
          $Res Function(_$RoomImageModelImpl) then) =
      __$$RoomImageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String roomId, String imageUrl, bool isPrimary});
}

/// @nodoc
class __$$RoomImageModelImplCopyWithImpl<$Res>
    extends _$RoomImageModelCopyWithImpl<$Res, _$RoomImageModelImpl>
    implements _$$RoomImageModelImplCopyWith<$Res> {
  __$$RoomImageModelImplCopyWithImpl(
      _$RoomImageModelImpl _value, $Res Function(_$RoomImageModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? imageUrl = null,
    Object? isPrimary = null,
  }) {
    return _then(_$RoomImageModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isPrimary: null == isPrimary
          ? _value.isPrimary
          : isPrimary // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$RoomImageModelImpl extends _RoomImageModel {
  const _$RoomImageModelImpl(
      {required this.id,
      required this.roomId,
      required this.imageUrl,
      this.isPrimary = false})
      : super._();

  @override
  final String id;
  @override
  final String roomId;
  @override
  final String imageUrl;
  @override
  @JsonKey()
  final bool isPrimary;

  @override
  String toString() {
    return 'RoomImageModel(id: $id, roomId: $roomId, imageUrl: $imageUrl, isPrimary: $isPrimary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomImageModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isPrimary, isPrimary) ||
                other.isPrimary == isPrimary));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, roomId, imageUrl, isPrimary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomImageModelImplCopyWith<_$RoomImageModelImpl> get copyWith =>
      __$$RoomImageModelImplCopyWithImpl<_$RoomImageModelImpl>(
          this, _$identity);
}

abstract class _RoomImageModel extends RoomImageModel {
  const factory _RoomImageModel(
      {required String id,
      required String roomId,
      required String imageUrl,
      bool isPrimary}) = _$RoomImageModelImpl;
  const _RoomImageModel._() : super._();

  @override
  String get id;
  @override
  String get roomId;
  @override
  String get imageUrl;
  @override
  bool get isPrimary;
  @override
  @JsonKey(ignore: true)
  _$$RoomImageModelImplCopyWith<_$RoomImageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RoomModel {
  String get id => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  String get roomTypeId => throw _privateConstructorUsedError;
  String get roomNumber => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get floor => throw _privateConstructorUsedError;
  int get maxGuests => throw _privateConstructorUsedError;
  double get pricePerMonth => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  int get numberBedrooms => throw _privateConstructorUsedError;
  double get roomSqft => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get amenityIds => throw _privateConstructorUsedError;
  List<RoomImageModel> get images => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RoomModelCopyWith<RoomModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomModelCopyWith<$Res> {
  factory $RoomModelCopyWith(RoomModel value, $Res Function(RoomModel) then) =
      _$RoomModelCopyWithImpl<$Res, RoomModel>;
  @useResult
  $Res call(
      {String id,
      String ownerId,
      String roomTypeId,
      String roomNumber,
      String name,
      String floor,
      int maxGuests,
      double pricePerMonth,
      String location,
      int numberBedrooms,
      double roomSqft,
      String? description,
      List<String> amenityIds,
      List<RoomImageModel> images,
      double? latitude,
      double? longitude,
      String status,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$RoomModelCopyWithImpl<$Res, $Val extends RoomModel>
    implements $RoomModelCopyWith<$Res> {
  _$RoomModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerId = null,
    Object? roomTypeId = null,
    Object? roomNumber = null,
    Object? name = null,
    Object? floor = null,
    Object? maxGuests = null,
    Object? pricePerMonth = null,
    Object? location = null,
    Object? numberBedrooms = null,
    Object? roomSqft = null,
    Object? description = freezed,
    Object? amenityIds = null,
    Object? images = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? status = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      roomTypeId: null == roomTypeId
          ? _value.roomTypeId
          : roomTypeId // ignore: cast_nullable_to_non_nullable
              as String,
      roomNumber: null == roomNumber
          ? _value.roomNumber
          : roomNumber // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      floor: null == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String,
      maxGuests: null == maxGuests
          ? _value.maxGuests
          : maxGuests // ignore: cast_nullable_to_non_nullable
              as int,
      pricePerMonth: null == pricePerMonth
          ? _value.pricePerMonth
          : pricePerMonth // ignore: cast_nullable_to_non_nullable
              as double,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      numberBedrooms: null == numberBedrooms
          ? _value.numberBedrooms
          : numberBedrooms // ignore: cast_nullable_to_non_nullable
              as int,
      roomSqft: null == roomSqft
          ? _value.roomSqft
          : roomSqft // ignore: cast_nullable_to_non_nullable
              as double,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      amenityIds: null == amenityIds
          ? _value.amenityIds
          : amenityIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<RoomImageModel>,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomModelImplCopyWith<$Res>
    implements $RoomModelCopyWith<$Res> {
  factory _$$RoomModelImplCopyWith(
          _$RoomModelImpl value, $Res Function(_$RoomModelImpl) then) =
      __$$RoomModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String ownerId,
      String roomTypeId,
      String roomNumber,
      String name,
      String floor,
      int maxGuests,
      double pricePerMonth,
      String location,
      int numberBedrooms,
      double roomSqft,
      String? description,
      List<String> amenityIds,
      List<RoomImageModel> images,
      double? latitude,
      double? longitude,
      String status,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$RoomModelImplCopyWithImpl<$Res>
    extends _$RoomModelCopyWithImpl<$Res, _$RoomModelImpl>
    implements _$$RoomModelImplCopyWith<$Res> {
  __$$RoomModelImplCopyWithImpl(
      _$RoomModelImpl _value, $Res Function(_$RoomModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerId = null,
    Object? roomTypeId = null,
    Object? roomNumber = null,
    Object? name = null,
    Object? floor = null,
    Object? maxGuests = null,
    Object? pricePerMonth = null,
    Object? location = null,
    Object? numberBedrooms = null,
    Object? roomSqft = null,
    Object? description = freezed,
    Object? amenityIds = null,
    Object? images = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? status = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$RoomModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      roomTypeId: null == roomTypeId
          ? _value.roomTypeId
          : roomTypeId // ignore: cast_nullable_to_non_nullable
              as String,
      roomNumber: null == roomNumber
          ? _value.roomNumber
          : roomNumber // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      floor: null == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String,
      maxGuests: null == maxGuests
          ? _value.maxGuests
          : maxGuests // ignore: cast_nullable_to_non_nullable
              as int,
      pricePerMonth: null == pricePerMonth
          ? _value.pricePerMonth
          : pricePerMonth // ignore: cast_nullable_to_non_nullable
              as double,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      numberBedrooms: null == numberBedrooms
          ? _value.numberBedrooms
          : numberBedrooms // ignore: cast_nullable_to_non_nullable
              as int,
      roomSqft: null == roomSqft
          ? _value.roomSqft
          : roomSqft // ignore: cast_nullable_to_non_nullable
              as double,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      amenityIds: null == amenityIds
          ? _value._amenityIds
          : amenityIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<RoomImageModel>,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
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
    ));
  }
}

/// @nodoc

class _$RoomModelImpl extends _RoomModel {
  const _$RoomModelImpl(
      {required this.id,
      required this.ownerId,
      required this.roomTypeId,
      required this.roomNumber,
      required this.name,
      required this.floor,
      required this.maxGuests,
      required this.pricePerMonth,
      required this.location,
      required this.numberBedrooms,
      required this.roomSqft,
      this.description,
      List<String> amenityIds = const [],
      List<RoomImageModel> images = const [],
      this.latitude,
      this.longitude,
      this.status = 'available',
      this.createdAt,
      this.updatedAt})
      : _amenityIds = amenityIds,
        _images = images,
        super._();

  @override
  final String id;
  @override
  final String ownerId;
  @override
  final String roomTypeId;
  @override
  final String roomNumber;
  @override
  final String name;
  @override
  final String floor;
  @override
  final int maxGuests;
  @override
  final double pricePerMonth;
  @override
  final String location;
  @override
  final int numberBedrooms;
  @override
  final double roomSqft;
  @override
  final String? description;
  final List<String> _amenityIds;
  @override
  @JsonKey()
  List<String> get amenityIds {
    if (_amenityIds is EqualUnmodifiableListView) return _amenityIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_amenityIds);
  }

  final List<RoomImageModel> _images;
  @override
  @JsonKey()
  List<RoomImageModel> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey()
  final String status;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'RoomModel(id: $id, ownerId: $ownerId, roomTypeId: $roomTypeId, roomNumber: $roomNumber, name: $name, floor: $floor, maxGuests: $maxGuests, pricePerMonth: $pricePerMonth, location: $location, numberBedrooms: $numberBedrooms, roomSqft: $roomSqft, description: $description, amenityIds: $amenityIds, images: $images, latitude: $latitude, longitude: $longitude, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.roomTypeId, roomTypeId) ||
                other.roomTypeId == roomTypeId) &&
            (identical(other.roomNumber, roomNumber) ||
                other.roomNumber == roomNumber) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.maxGuests, maxGuests) ||
                other.maxGuests == maxGuests) &&
            (identical(other.pricePerMonth, pricePerMonth) ||
                other.pricePerMonth == pricePerMonth) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.numberBedrooms, numberBedrooms) ||
                other.numberBedrooms == numberBedrooms) &&
            (identical(other.roomSqft, roomSqft) ||
                other.roomSqft == roomSqft) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._amenityIds, _amenityIds) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        ownerId,
        roomTypeId,
        roomNumber,
        name,
        floor,
        maxGuests,
        pricePerMonth,
        location,
        numberBedrooms,
        roomSqft,
        description,
        const DeepCollectionEquality().hash(_amenityIds),
        const DeepCollectionEquality().hash(_images),
        latitude,
        longitude,
        status,
        createdAt,
        updatedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomModelImplCopyWith<_$RoomModelImpl> get copyWith =>
      __$$RoomModelImplCopyWithImpl<_$RoomModelImpl>(this, _$identity);
}

abstract class _RoomModel extends RoomModel {
  const factory _RoomModel(
      {required String id,
      required String ownerId,
      required String roomTypeId,
      required String roomNumber,
      required String name,
      required String floor,
      required int maxGuests,
      required double pricePerMonth,
      required String location,
      required int numberBedrooms,
      required double roomSqft,
       String? description,
       List<String> amenityIds,
       List<RoomImageModel> images,
       double? latitude,
       double? longitude,
       String status,
       DateTime? createdAt,
       DateTime? updatedAt}) = _$RoomModelImpl;
  const _RoomModel._() : super._();

  @override
  String get id;
  @override
  String get ownerId;
  @override
  String get roomTypeId;
  @override
  String get roomNumber;
  @override
  String get name;
  @override
  String get floor;
  @override
  int get maxGuests;
  @override
  double get pricePerMonth;
  @override
  String get location;
  @override
  int get numberBedrooms;
  @override
  double get roomSqft;
  @override
  String? get description;
  @override
  List<String> get amenityIds;
  @override
  List<RoomImageModel> get images;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String get status;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$RoomModelImplCopyWith<_$RoomModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

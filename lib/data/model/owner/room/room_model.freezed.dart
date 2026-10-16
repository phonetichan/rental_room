// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RoomImageModel {

 String get id; String get roomId; String get imageUrl; bool get isPrimary;
/// Create a copy of RoomImageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomImageModelCopyWith<RoomImageModel> get copyWith => _$RoomImageModelCopyWithImpl<RoomImageModel>(this as RoomImageModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomImageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary));
}


@override
int get hashCode => Object.hash(runtimeType,id,roomId,imageUrl,isPrimary);

@override
String toString() {
  return 'RoomImageModel(id: $id, roomId: $roomId, imageUrl: $imageUrl, isPrimary: $isPrimary)';
}


}

/// @nodoc
abstract mixin class $RoomImageModelCopyWith<$Res>  {
  factory $RoomImageModelCopyWith(RoomImageModel value, $Res Function(RoomImageModel) _then) = _$RoomImageModelCopyWithImpl;
@useResult
$Res call({
 String id, String roomId, String imageUrl, bool isPrimary
});




}
/// @nodoc
class _$RoomImageModelCopyWithImpl<$Res>
    implements $RoomImageModelCopyWith<$Res> {
  _$RoomImageModelCopyWithImpl(this._self, this._then);

  final RoomImageModel _self;
  final $Res Function(RoomImageModel) _then;

/// Create a copy of RoomImageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roomId = null,Object? imageUrl = null,Object? isPrimary = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomImageModel].
extension RoomImageModelPatterns on RoomImageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoomImageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomImageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoomImageModel value)  $default,){
final _that = this;
switch (_that) {
case _RoomImageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoomImageModel value)?  $default,){
final _that = this;
switch (_that) {
case _RoomImageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String roomId,  String imageUrl,  bool isPrimary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomImageModel() when $default != null:
return $default(_that.id,_that.roomId,_that.imageUrl,_that.isPrimary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String roomId,  String imageUrl,  bool isPrimary)  $default,) {final _that = this;
switch (_that) {
case _RoomImageModel():
return $default(_that.id,_that.roomId,_that.imageUrl,_that.isPrimary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String roomId,  String imageUrl,  bool isPrimary)?  $default,) {final _that = this;
switch (_that) {
case _RoomImageModel() when $default != null:
return $default(_that.id,_that.roomId,_that.imageUrl,_that.isPrimary);case _:
  return null;

}
}

}

/// @nodoc


class _RoomImageModel extends RoomImageModel {
  const _RoomImageModel({required this.id, required this.roomId, required this.imageUrl, this.isPrimary = false}): super._();
  

@override final  String id;
@override final  String roomId;
@override final  String imageUrl;
@override@JsonKey() final  bool isPrimary;

/// Create a copy of RoomImageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomImageModelCopyWith<_RoomImageModel> get copyWith => __$RoomImageModelCopyWithImpl<_RoomImageModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomImageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary));
}


@override
int get hashCode => Object.hash(runtimeType,id,roomId,imageUrl,isPrimary);

@override
String toString() {
  return 'RoomImageModel(id: $id, roomId: $roomId, imageUrl: $imageUrl, isPrimary: $isPrimary)';
}


}

/// @nodoc
abstract mixin class _$RoomImageModelCopyWith<$Res> implements $RoomImageModelCopyWith<$Res> {
  factory _$RoomImageModelCopyWith(_RoomImageModel value, $Res Function(_RoomImageModel) _then) = __$RoomImageModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String roomId, String imageUrl, bool isPrimary
});




}
/// @nodoc
class __$RoomImageModelCopyWithImpl<$Res>
    implements _$RoomImageModelCopyWith<$Res> {
  __$RoomImageModelCopyWithImpl(this._self, this._then);

  final _RoomImageModel _self;
  final $Res Function(_RoomImageModel) _then;

/// Create a copy of RoomImageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roomId = null,Object? imageUrl = null,Object? isPrimary = null,}) {
  return _then(_RoomImageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$RoomModel {

 String get id; String get ownerId; String get roomTypeId; String get roomNumber; String get name; String get floor; int get maxGuests; double get pricePerMonth; String get location; int get numberBedrooms; double get roomSqft; String? get description; List<String> get amenityIds; List<RoomImageModel> get images; double? get latitude; double? get longitude; String get status; double? get depositeAmount; String? get agentName; double? get agentFees; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of RoomModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomModelCopyWith<RoomModel> get copyWith => _$RoomModelCopyWithImpl<RoomModel>(this as RoomModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomModel&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.roomTypeId, roomTypeId) || other.roomTypeId == roomTypeId)&&(identical(other.roomNumber, roomNumber) || other.roomNumber == roomNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.floor, floor) || other.floor == floor)&&(identical(other.maxGuests, maxGuests) || other.maxGuests == maxGuests)&&(identical(other.pricePerMonth, pricePerMonth) || other.pricePerMonth == pricePerMonth)&&(identical(other.location, location) || other.location == location)&&(identical(other.numberBedrooms, numberBedrooms) || other.numberBedrooms == numberBedrooms)&&(identical(other.roomSqft, roomSqft) || other.roomSqft == roomSqft)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.amenityIds, amenityIds)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.status, status) || other.status == status)&&(identical(other.depositeAmount, depositeAmount) || other.depositeAmount == depositeAmount)&&(identical(other.agentName, agentName) || other.agentName == agentName)&&(identical(other.agentFees, agentFees) || other.agentFees == agentFees)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,ownerId,roomTypeId,roomNumber,name,floor,maxGuests,pricePerMonth,location,numberBedrooms,roomSqft,description,const DeepCollectionEquality().hash(amenityIds),const DeepCollectionEquality().hash(images),latitude,longitude,status,depositeAmount,agentName,agentFees,createdAt,updatedAt]);

@override
String toString() {
  return 'RoomModel(id: $id, ownerId: $ownerId, roomTypeId: $roomTypeId, roomNumber: $roomNumber, name: $name, floor: $floor, maxGuests: $maxGuests, pricePerMonth: $pricePerMonth, location: $location, numberBedrooms: $numberBedrooms, roomSqft: $roomSqft, description: $description, amenityIds: $amenityIds, images: $images, latitude: $latitude, longitude: $longitude, status: $status, depositeAmount: $depositeAmount, agentName: $agentName, agentFees: $agentFees, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RoomModelCopyWith<$Res>  {
  factory $RoomModelCopyWith(RoomModel value, $Res Function(RoomModel) _then) = _$RoomModelCopyWithImpl;
@useResult
$Res call({
 String id, String ownerId, String roomTypeId, String roomNumber, String name, String floor, int maxGuests, double pricePerMonth, String location, int numberBedrooms, double roomSqft, String? description, List<String> amenityIds, List<RoomImageModel> images, double? latitude, double? longitude, String status, double? depositeAmount, String? agentName, double? agentFees, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$RoomModelCopyWithImpl<$Res>
    implements $RoomModelCopyWith<$Res> {
  _$RoomModelCopyWithImpl(this._self, this._then);

  final RoomModel _self;
  final $Res Function(RoomModel) _then;

/// Create a copy of RoomModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ownerId = null,Object? roomTypeId = null,Object? roomNumber = null,Object? name = null,Object? floor = null,Object? maxGuests = null,Object? pricePerMonth = null,Object? location = null,Object? numberBedrooms = null,Object? roomSqft = null,Object? description = freezed,Object? amenityIds = null,Object? images = null,Object? latitude = freezed,Object? longitude = freezed,Object? status = null,Object? depositeAmount = freezed,Object? agentName = freezed,Object? agentFees = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,roomTypeId: null == roomTypeId ? _self.roomTypeId : roomTypeId // ignore: cast_nullable_to_non_nullable
as String,roomNumber: null == roomNumber ? _self.roomNumber : roomNumber // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,floor: null == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as String,maxGuests: null == maxGuests ? _self.maxGuests : maxGuests // ignore: cast_nullable_to_non_nullable
as int,pricePerMonth: null == pricePerMonth ? _self.pricePerMonth : pricePerMonth // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,numberBedrooms: null == numberBedrooms ? _self.numberBedrooms : numberBedrooms // ignore: cast_nullable_to_non_nullable
as int,roomSqft: null == roomSqft ? _self.roomSqft : roomSqft // ignore: cast_nullable_to_non_nullable
as double,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,amenityIds: null == amenityIds ? _self.amenityIds : amenityIds // ignore: cast_nullable_to_non_nullable
as List<String>,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<RoomImageModel>,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,depositeAmount: freezed == depositeAmount ? _self.depositeAmount : depositeAmount // ignore: cast_nullable_to_non_nullable
as double?,agentName: freezed == agentName ? _self.agentName : agentName // ignore: cast_nullable_to_non_nullable
as String?,agentFees: freezed == agentFees ? _self.agentFees : agentFees // ignore: cast_nullable_to_non_nullable
as double?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomModel].
extension RoomModelPatterns on RoomModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoomModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoomModel value)  $default,){
final _that = this;
switch (_that) {
case _RoomModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoomModel value)?  $default,){
final _that = this;
switch (_that) {
case _RoomModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ownerId,  String roomTypeId,  String roomNumber,  String name,  String floor,  int maxGuests,  double pricePerMonth,  String location,  int numberBedrooms,  double roomSqft,  String? description,  List<String> amenityIds,  List<RoomImageModel> images,  double? latitude,  double? longitude,  String status,  double? depositeAmount,  String? agentName,  double? agentFees,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomModel() when $default != null:
return $default(_that.id,_that.ownerId,_that.roomTypeId,_that.roomNumber,_that.name,_that.floor,_that.maxGuests,_that.pricePerMonth,_that.location,_that.numberBedrooms,_that.roomSqft,_that.description,_that.amenityIds,_that.images,_that.latitude,_that.longitude,_that.status,_that.depositeAmount,_that.agentName,_that.agentFees,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ownerId,  String roomTypeId,  String roomNumber,  String name,  String floor,  int maxGuests,  double pricePerMonth,  String location,  int numberBedrooms,  double roomSqft,  String? description,  List<String> amenityIds,  List<RoomImageModel> images,  double? latitude,  double? longitude,  String status,  double? depositeAmount,  String? agentName,  double? agentFees,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _RoomModel():
return $default(_that.id,_that.ownerId,_that.roomTypeId,_that.roomNumber,_that.name,_that.floor,_that.maxGuests,_that.pricePerMonth,_that.location,_that.numberBedrooms,_that.roomSqft,_that.description,_that.amenityIds,_that.images,_that.latitude,_that.longitude,_that.status,_that.depositeAmount,_that.agentName,_that.agentFees,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ownerId,  String roomTypeId,  String roomNumber,  String name,  String floor,  int maxGuests,  double pricePerMonth,  String location,  int numberBedrooms,  double roomSqft,  String? description,  List<String> amenityIds,  List<RoomImageModel> images,  double? latitude,  double? longitude,  String status,  double? depositeAmount,  String? agentName,  double? agentFees,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _RoomModel() when $default != null:
return $default(_that.id,_that.ownerId,_that.roomTypeId,_that.roomNumber,_that.name,_that.floor,_that.maxGuests,_that.pricePerMonth,_that.location,_that.numberBedrooms,_that.roomSqft,_that.description,_that.amenityIds,_that.images,_that.latitude,_that.longitude,_that.status,_that.depositeAmount,_that.agentName,_that.agentFees,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _RoomModel extends RoomModel {
  const _RoomModel({required this.id, required this.ownerId, required this.roomTypeId, required this.roomNumber, required this.name, required this.floor, required this.maxGuests, required this.pricePerMonth, required this.location, required this.numberBedrooms, required this.roomSqft, this.description, final  List<String> amenityIds = const [], final  List<RoomImageModel> images = const [], this.latitude, this.longitude, this.status = 'available', this.depositeAmount, this.agentName, this.agentFees, this.createdAt, this.updatedAt}): _amenityIds = amenityIds,_images = images,super._();
  

@override final  String id;
@override final  String ownerId;
@override final  String roomTypeId;
@override final  String roomNumber;
@override final  String name;
@override final  String floor;
@override final  int maxGuests;
@override final  double pricePerMonth;
@override final  String location;
@override final  int numberBedrooms;
@override final  double roomSqft;
@override final  String? description;
 final  List<String> _amenityIds;
@override@JsonKey() List<String> get amenityIds {
  if (_amenityIds is EqualUnmodifiableListView) return _amenityIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_amenityIds);
}

 final  List<RoomImageModel> _images;
@override@JsonKey() List<RoomImageModel> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override final  double? latitude;
@override final  double? longitude;
@override@JsonKey() final  String status;
@override final  double? depositeAmount;
@override final  String? agentName;
@override final  double? agentFees;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of RoomModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomModelCopyWith<_RoomModel> get copyWith => __$RoomModelCopyWithImpl<_RoomModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomModel&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.roomTypeId, roomTypeId) || other.roomTypeId == roomTypeId)&&(identical(other.roomNumber, roomNumber) || other.roomNumber == roomNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.floor, floor) || other.floor == floor)&&(identical(other.maxGuests, maxGuests) || other.maxGuests == maxGuests)&&(identical(other.pricePerMonth, pricePerMonth) || other.pricePerMonth == pricePerMonth)&&(identical(other.location, location) || other.location == location)&&(identical(other.numberBedrooms, numberBedrooms) || other.numberBedrooms == numberBedrooms)&&(identical(other.roomSqft, roomSqft) || other.roomSqft == roomSqft)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._amenityIds, _amenityIds)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.status, status) || other.status == status)&&(identical(other.depositeAmount, depositeAmount) || other.depositeAmount == depositeAmount)&&(identical(other.agentName, agentName) || other.agentName == agentName)&&(identical(other.agentFees, agentFees) || other.agentFees == agentFees)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,ownerId,roomTypeId,roomNumber,name,floor,maxGuests,pricePerMonth,location,numberBedrooms,roomSqft,description,const DeepCollectionEquality().hash(_amenityIds),const DeepCollectionEquality().hash(_images),latitude,longitude,status,depositeAmount,agentName,agentFees,createdAt,updatedAt]);

@override
String toString() {
  return 'RoomModel(id: $id, ownerId: $ownerId, roomTypeId: $roomTypeId, roomNumber: $roomNumber, name: $name, floor: $floor, maxGuests: $maxGuests, pricePerMonth: $pricePerMonth, location: $location, numberBedrooms: $numberBedrooms, roomSqft: $roomSqft, description: $description, amenityIds: $amenityIds, images: $images, latitude: $latitude, longitude: $longitude, status: $status, depositeAmount: $depositeAmount, agentName: $agentName, agentFees: $agentFees, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RoomModelCopyWith<$Res> implements $RoomModelCopyWith<$Res> {
  factory _$RoomModelCopyWith(_RoomModel value, $Res Function(_RoomModel) _then) = __$RoomModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String ownerId, String roomTypeId, String roomNumber, String name, String floor, int maxGuests, double pricePerMonth, String location, int numberBedrooms, double roomSqft, String? description, List<String> amenityIds, List<RoomImageModel> images, double? latitude, double? longitude, String status, double? depositeAmount, String? agentName, double? agentFees, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$RoomModelCopyWithImpl<$Res>
    implements _$RoomModelCopyWith<$Res> {
  __$RoomModelCopyWithImpl(this._self, this._then);

  final _RoomModel _self;
  final $Res Function(_RoomModel) _then;

/// Create a copy of RoomModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ownerId = null,Object? roomTypeId = null,Object? roomNumber = null,Object? name = null,Object? floor = null,Object? maxGuests = null,Object? pricePerMonth = null,Object? location = null,Object? numberBedrooms = null,Object? roomSqft = null,Object? description = freezed,Object? amenityIds = null,Object? images = null,Object? latitude = freezed,Object? longitude = freezed,Object? status = null,Object? depositeAmount = freezed,Object? agentName = freezed,Object? agentFees = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_RoomModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,roomTypeId: null == roomTypeId ? _self.roomTypeId : roomTypeId // ignore: cast_nullable_to_non_nullable
as String,roomNumber: null == roomNumber ? _self.roomNumber : roomNumber // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,floor: null == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as String,maxGuests: null == maxGuests ? _self.maxGuests : maxGuests // ignore: cast_nullable_to_non_nullable
as int,pricePerMonth: null == pricePerMonth ? _self.pricePerMonth : pricePerMonth // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,numberBedrooms: null == numberBedrooms ? _self.numberBedrooms : numberBedrooms // ignore: cast_nullable_to_non_nullable
as int,roomSqft: null == roomSqft ? _self.roomSqft : roomSqft // ignore: cast_nullable_to_non_nullable
as double,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,amenityIds: null == amenityIds ? _self._amenityIds : amenityIds // ignore: cast_nullable_to_non_nullable
as List<String>,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<RoomImageModel>,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,depositeAmount: freezed == depositeAmount ? _self.depositeAmount : depositeAmount // ignore: cast_nullable_to_non_nullable
as double?,agentName: freezed == agentName ? _self.agentName : agentName // ignore: cast_nullable_to_non_nullable
as String?,agentFees: freezed == agentFees ? _self.agentFees : agentFees // ignore: cast_nullable_to_non_nullable
as double?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

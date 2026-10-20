// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingModel {

 String get id; String get userId; String get roomId; String? get ownerId; bool get isPhoneContacted; bool get isVisited; bool get isReadByTenant; bool get isReadByOwner; bool get isRemovedByTenant; bool get isRemovedByOwner; String get status; DateTime? get createdAt; DateTime? get updatedAt; String? get roomName; double? get roomPrice; String? get roomImageUrl; String? get tenantName; String? get tenantPhone;
/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingModelCopyWith<BookingModel> get copyWith => _$BookingModelCopyWithImpl<BookingModel>(this as BookingModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.isPhoneContacted, isPhoneContacted) || other.isPhoneContacted == isPhoneContacted)&&(identical(other.isVisited, isVisited) || other.isVisited == isVisited)&&(identical(other.isReadByTenant, isReadByTenant) || other.isReadByTenant == isReadByTenant)&&(identical(other.isReadByOwner, isReadByOwner) || other.isReadByOwner == isReadByOwner)&&(identical(other.isRemovedByTenant, isRemovedByTenant) || other.isRemovedByTenant == isRemovedByTenant)&&(identical(other.isRemovedByOwner, isRemovedByOwner) || other.isRemovedByOwner == isRemovedByOwner)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.roomName, roomName) || other.roomName == roomName)&&(identical(other.roomPrice, roomPrice) || other.roomPrice == roomPrice)&&(identical(other.roomImageUrl, roomImageUrl) || other.roomImageUrl == roomImageUrl)&&(identical(other.tenantName, tenantName) || other.tenantName == tenantName)&&(identical(other.tenantPhone, tenantPhone) || other.tenantPhone == tenantPhone));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,roomId,ownerId,isPhoneContacted,isVisited,isReadByTenant,isReadByOwner,isRemovedByTenant,isRemovedByOwner,status,createdAt,updatedAt,roomName,roomPrice,roomImageUrl,tenantName,tenantPhone);

@override
String toString() {
  return 'BookingModel(id: $id, userId: $userId, roomId: $roomId, ownerId: $ownerId, isPhoneContacted: $isPhoneContacted, isVisited: $isVisited, isReadByTenant: $isReadByTenant, isReadByOwner: $isReadByOwner, isRemovedByTenant: $isRemovedByTenant, isRemovedByOwner: $isRemovedByOwner, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, roomName: $roomName, roomPrice: $roomPrice, roomImageUrl: $roomImageUrl, tenantName: $tenantName, tenantPhone: $tenantPhone)';
}


}

/// @nodoc
abstract mixin class $BookingModelCopyWith<$Res>  {
  factory $BookingModelCopyWith(BookingModel value, $Res Function(BookingModel) _then) = _$BookingModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String roomId, String? ownerId, bool isPhoneContacted, bool isVisited, bool isReadByTenant, bool isReadByOwner, bool isRemovedByTenant, bool isRemovedByOwner, String status, DateTime? createdAt, DateTime? updatedAt, String? roomName, double? roomPrice, String? roomImageUrl, String? tenantName, String? tenantPhone
});




}
/// @nodoc
class _$BookingModelCopyWithImpl<$Res>
    implements $BookingModelCopyWith<$Res> {
  _$BookingModelCopyWithImpl(this._self, this._then);

  final BookingModel _self;
  final $Res Function(BookingModel) _then;

/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? roomId = null,Object? ownerId = freezed,Object? isPhoneContacted = null,Object? isVisited = null,Object? isReadByTenant = null,Object? isReadByOwner = null,Object? isRemovedByTenant = null,Object? isRemovedByOwner = null,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? roomName = freezed,Object? roomPrice = freezed,Object? roomImageUrl = freezed,Object? tenantName = freezed,Object? tenantPhone = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,isPhoneContacted: null == isPhoneContacted ? _self.isPhoneContacted : isPhoneContacted // ignore: cast_nullable_to_non_nullable
as bool,isVisited: null == isVisited ? _self.isVisited : isVisited // ignore: cast_nullable_to_non_nullable
as bool,isReadByTenant: null == isReadByTenant ? _self.isReadByTenant : isReadByTenant // ignore: cast_nullable_to_non_nullable
as bool,isReadByOwner: null == isReadByOwner ? _self.isReadByOwner : isReadByOwner // ignore: cast_nullable_to_non_nullable
as bool,isRemovedByTenant: null == isRemovedByTenant ? _self.isRemovedByTenant : isRemovedByTenant // ignore: cast_nullable_to_non_nullable
as bool,isRemovedByOwner: null == isRemovedByOwner ? _self.isRemovedByOwner : isRemovedByOwner // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,roomName: freezed == roomName ? _self.roomName : roomName // ignore: cast_nullable_to_non_nullable
as String?,roomPrice: freezed == roomPrice ? _self.roomPrice : roomPrice // ignore: cast_nullable_to_non_nullable
as double?,roomImageUrl: freezed == roomImageUrl ? _self.roomImageUrl : roomImageUrl // ignore: cast_nullable_to_non_nullable
as String?,tenantName: freezed == tenantName ? _self.tenantName : tenantName // ignore: cast_nullable_to_non_nullable
as String?,tenantPhone: freezed == tenantPhone ? _self.tenantPhone : tenantPhone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingModel].
extension BookingModelPatterns on BookingModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingModel value)  $default,){
final _that = this;
switch (_that) {
case _BookingModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingModel value)?  $default,){
final _that = this;
switch (_that) {
case _BookingModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String roomId,  String? ownerId,  bool isPhoneContacted,  bool isVisited,  bool isReadByTenant,  bool isReadByOwner,  bool isRemovedByTenant,  bool isRemovedByOwner,  String status,  DateTime? createdAt,  DateTime? updatedAt,  String? roomName,  double? roomPrice,  String? roomImageUrl,  String? tenantName,  String? tenantPhone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingModel() when $default != null:
return $default(_that.id,_that.userId,_that.roomId,_that.ownerId,_that.isPhoneContacted,_that.isVisited,_that.isReadByTenant,_that.isReadByOwner,_that.isRemovedByTenant,_that.isRemovedByOwner,_that.status,_that.createdAt,_that.updatedAt,_that.roomName,_that.roomPrice,_that.roomImageUrl,_that.tenantName,_that.tenantPhone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String roomId,  String? ownerId,  bool isPhoneContacted,  bool isVisited,  bool isReadByTenant,  bool isReadByOwner,  bool isRemovedByTenant,  bool isRemovedByOwner,  String status,  DateTime? createdAt,  DateTime? updatedAt,  String? roomName,  double? roomPrice,  String? roomImageUrl,  String? tenantName,  String? tenantPhone)  $default,) {final _that = this;
switch (_that) {
case _BookingModel():
return $default(_that.id,_that.userId,_that.roomId,_that.ownerId,_that.isPhoneContacted,_that.isVisited,_that.isReadByTenant,_that.isReadByOwner,_that.isRemovedByTenant,_that.isRemovedByOwner,_that.status,_that.createdAt,_that.updatedAt,_that.roomName,_that.roomPrice,_that.roomImageUrl,_that.tenantName,_that.tenantPhone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String roomId,  String? ownerId,  bool isPhoneContacted,  bool isVisited,  bool isReadByTenant,  bool isReadByOwner,  bool isRemovedByTenant,  bool isRemovedByOwner,  String status,  DateTime? createdAt,  DateTime? updatedAt,  String? roomName,  double? roomPrice,  String? roomImageUrl,  String? tenantName,  String? tenantPhone)?  $default,) {final _that = this;
switch (_that) {
case _BookingModel() when $default != null:
return $default(_that.id,_that.userId,_that.roomId,_that.ownerId,_that.isPhoneContacted,_that.isVisited,_that.isReadByTenant,_that.isReadByOwner,_that.isRemovedByTenant,_that.isRemovedByOwner,_that.status,_that.createdAt,_that.updatedAt,_that.roomName,_that.roomPrice,_that.roomImageUrl,_that.tenantName,_that.tenantPhone);case _:
  return null;

}
}

}

/// @nodoc


class _BookingModel extends BookingModel {
  const _BookingModel({required this.id, required this.userId, required this.roomId, this.ownerId, this.isPhoneContacted = false, this.isVisited = false, this.isReadByTenant = false, this.isReadByOwner = false, this.isRemovedByTenant = false, this.isRemovedByOwner = false, this.status = BookingStatus.draft, this.createdAt, this.updatedAt, this.roomName, this.roomPrice, this.roomImageUrl, this.tenantName, this.tenantPhone}): super._();
  

@override final  String id;
@override final  String userId;
@override final  String roomId;
@override final  String? ownerId;
@override@JsonKey() final  bool isPhoneContacted;
@override@JsonKey() final  bool isVisited;
@override@JsonKey() final  bool isReadByTenant;
@override@JsonKey() final  bool isReadByOwner;
@override@JsonKey() final  bool isRemovedByTenant;
@override@JsonKey() final  bool isRemovedByOwner;
@override@JsonKey() final  String status;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override final  String? roomName;
@override final  double? roomPrice;
@override final  String? roomImageUrl;
@override final  String? tenantName;
@override final  String? tenantPhone;

/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingModelCopyWith<_BookingModel> get copyWith => __$BookingModelCopyWithImpl<_BookingModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.isPhoneContacted, isPhoneContacted) || other.isPhoneContacted == isPhoneContacted)&&(identical(other.isVisited, isVisited) || other.isVisited == isVisited)&&(identical(other.isReadByTenant, isReadByTenant) || other.isReadByTenant == isReadByTenant)&&(identical(other.isReadByOwner, isReadByOwner) || other.isReadByOwner == isReadByOwner)&&(identical(other.isRemovedByTenant, isRemovedByTenant) || other.isRemovedByTenant == isRemovedByTenant)&&(identical(other.isRemovedByOwner, isRemovedByOwner) || other.isRemovedByOwner == isRemovedByOwner)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.roomName, roomName) || other.roomName == roomName)&&(identical(other.roomPrice, roomPrice) || other.roomPrice == roomPrice)&&(identical(other.roomImageUrl, roomImageUrl) || other.roomImageUrl == roomImageUrl)&&(identical(other.tenantName, tenantName) || other.tenantName == tenantName)&&(identical(other.tenantPhone, tenantPhone) || other.tenantPhone == tenantPhone));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,roomId,ownerId,isPhoneContacted,isVisited,isReadByTenant,isReadByOwner,isRemovedByTenant,isRemovedByOwner,status,createdAt,updatedAt,roomName,roomPrice,roomImageUrl,tenantName,tenantPhone);

@override
String toString() {
  return 'BookingModel(id: $id, userId: $userId, roomId: $roomId, ownerId: $ownerId, isPhoneContacted: $isPhoneContacted, isVisited: $isVisited, isReadByTenant: $isReadByTenant, isReadByOwner: $isReadByOwner, isRemovedByTenant: $isRemovedByTenant, isRemovedByOwner: $isRemovedByOwner, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, roomName: $roomName, roomPrice: $roomPrice, roomImageUrl: $roomImageUrl, tenantName: $tenantName, tenantPhone: $tenantPhone)';
}


}

/// @nodoc
abstract mixin class _$BookingModelCopyWith<$Res> implements $BookingModelCopyWith<$Res> {
  factory _$BookingModelCopyWith(_BookingModel value, $Res Function(_BookingModel) _then) = __$BookingModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String roomId, String? ownerId, bool isPhoneContacted, bool isVisited, bool isReadByTenant, bool isReadByOwner, bool isRemovedByTenant, bool isRemovedByOwner, String status, DateTime? createdAt, DateTime? updatedAt, String? roomName, double? roomPrice, String? roomImageUrl, String? tenantName, String? tenantPhone
});




}
/// @nodoc
class __$BookingModelCopyWithImpl<$Res>
    implements _$BookingModelCopyWith<$Res> {
  __$BookingModelCopyWithImpl(this._self, this._then);

  final _BookingModel _self;
  final $Res Function(_BookingModel) _then;

/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? roomId = null,Object? ownerId = freezed,Object? isPhoneContacted = null,Object? isVisited = null,Object? isReadByTenant = null,Object? isReadByOwner = null,Object? isRemovedByTenant = null,Object? isRemovedByOwner = null,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? roomName = freezed,Object? roomPrice = freezed,Object? roomImageUrl = freezed,Object? tenantName = freezed,Object? tenantPhone = freezed,}) {
  return _then(_BookingModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,isPhoneContacted: null == isPhoneContacted ? _self.isPhoneContacted : isPhoneContacted // ignore: cast_nullable_to_non_nullable
as bool,isVisited: null == isVisited ? _self.isVisited : isVisited // ignore: cast_nullable_to_non_nullable
as bool,isReadByTenant: null == isReadByTenant ? _self.isReadByTenant : isReadByTenant // ignore: cast_nullable_to_non_nullable
as bool,isReadByOwner: null == isReadByOwner ? _self.isReadByOwner : isReadByOwner // ignore: cast_nullable_to_non_nullable
as bool,isRemovedByTenant: null == isRemovedByTenant ? _self.isRemovedByTenant : isRemovedByTenant // ignore: cast_nullable_to_non_nullable
as bool,isRemovedByOwner: null == isRemovedByOwner ? _self.isRemovedByOwner : isRemovedByOwner // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,roomName: freezed == roomName ? _self.roomName : roomName // ignore: cast_nullable_to_non_nullable
as String?,roomPrice: freezed == roomPrice ? _self.roomPrice : roomPrice // ignore: cast_nullable_to_non_nullable
as double?,roomImageUrl: freezed == roomImageUrl ? _self.roomImageUrl : roomImageUrl // ignore: cast_nullable_to_non_nullable
as String?,tenantName: freezed == tenantName ? _self.tenantName : tenantName // ignore: cast_nullable_to_non_nullable
as String?,tenantPhone: freezed == tenantPhone ? _self.tenantPhone : tenantPhone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

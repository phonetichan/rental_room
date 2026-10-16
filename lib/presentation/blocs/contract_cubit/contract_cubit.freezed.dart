// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contract_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContractState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContractState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContractState()';
}


}

/// @nodoc
class $ContractStateCopyWith<$Res>  {
$ContractStateCopyWith(ContractState _, $Res Function(ContractState) __);
}


/// Adds pattern-matching-related methods to [ContractState].
extension ContractStatePatterns on ContractState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ContractInitial value)?  initial,TResult Function( ContractLoading value)?  loading,TResult Function( ContractLoaded value)?  contractLoaded,TResult Function( ContractHistoryLoaded value)?  historyLoaded,TResult Function( VoucherDetailsLoaded value)?  voucherDetailsLoaded,TResult Function( ContractRevenueCalculated value)?  revenueCalculated,TResult Function( ContractSuccess value)?  success,TResult Function( ContractFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ContractInitial() when initial != null:
return initial(_that);case ContractLoading() when loading != null:
return loading(_that);case ContractLoaded() when contractLoaded != null:
return contractLoaded(_that);case ContractHistoryLoaded() when historyLoaded != null:
return historyLoaded(_that);case VoucherDetailsLoaded() when voucherDetailsLoaded != null:
return voucherDetailsLoaded(_that);case ContractRevenueCalculated() when revenueCalculated != null:
return revenueCalculated(_that);case ContractSuccess() when success != null:
return success(_that);case ContractFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ContractInitial value)  initial,required TResult Function( ContractLoading value)  loading,required TResult Function( ContractLoaded value)  contractLoaded,required TResult Function( ContractHistoryLoaded value)  historyLoaded,required TResult Function( VoucherDetailsLoaded value)  voucherDetailsLoaded,required TResult Function( ContractRevenueCalculated value)  revenueCalculated,required TResult Function( ContractSuccess value)  success,required TResult Function( ContractFailure value)  failure,}){
final _that = this;
switch (_that) {
case ContractInitial():
return initial(_that);case ContractLoading():
return loading(_that);case ContractLoaded():
return contractLoaded(_that);case ContractHistoryLoaded():
return historyLoaded(_that);case VoucherDetailsLoaded():
return voucherDetailsLoaded(_that);case ContractRevenueCalculated():
return revenueCalculated(_that);case ContractSuccess():
return success(_that);case ContractFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ContractInitial value)?  initial,TResult? Function( ContractLoading value)?  loading,TResult? Function( ContractLoaded value)?  contractLoaded,TResult? Function( ContractHistoryLoaded value)?  historyLoaded,TResult? Function( VoucherDetailsLoaded value)?  voucherDetailsLoaded,TResult? Function( ContractRevenueCalculated value)?  revenueCalculated,TResult? Function( ContractSuccess value)?  success,TResult? Function( ContractFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ContractInitial() when initial != null:
return initial(_that);case ContractLoading() when loading != null:
return loading(_that);case ContractLoaded() when contractLoaded != null:
return contractLoaded(_that);case ContractHistoryLoaded() when historyLoaded != null:
return historyLoaded(_that);case VoucherDetailsLoaded() when voucherDetailsLoaded != null:
return voucherDetailsLoaded(_that);case ContractRevenueCalculated() when revenueCalculated != null:
return revenueCalculated(_that);case ContractSuccess() when success != null:
return success(_that);case ContractFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ContractEntity? contract)?  contractLoaded,TResult Function( List<ContractEntity> contracts,  Map<String, RoomEntity> roomsByRoomId)?  historyLoaded,TResult Function( ContractEntity? contract,  RoomEntity? room,  UserEntity? tenantUser,  UserEntity? ownerUser)?  voucherDetailsLoaded,TResult Function( double totalMonthlyRevenue,  List<ContractEntity> contracts)?  revenueCalculated,TResult Function( String message,  ContractEntity? contract)?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ContractInitial() when initial != null:
return initial();case ContractLoading() when loading != null:
return loading();case ContractLoaded() when contractLoaded != null:
return contractLoaded(_that.contract);case ContractHistoryLoaded() when historyLoaded != null:
return historyLoaded(_that.contracts,_that.roomsByRoomId);case VoucherDetailsLoaded() when voucherDetailsLoaded != null:
return voucherDetailsLoaded(_that.contract,_that.room,_that.tenantUser,_that.ownerUser);case ContractRevenueCalculated() when revenueCalculated != null:
return revenueCalculated(_that.totalMonthlyRevenue,_that.contracts);case ContractSuccess() when success != null:
return success(_that.message,_that.contract);case ContractFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ContractEntity? contract)  contractLoaded,required TResult Function( List<ContractEntity> contracts,  Map<String, RoomEntity> roomsByRoomId)  historyLoaded,required TResult Function( ContractEntity? contract,  RoomEntity? room,  UserEntity? tenantUser,  UserEntity? ownerUser)  voucherDetailsLoaded,required TResult Function( double totalMonthlyRevenue,  List<ContractEntity> contracts)  revenueCalculated,required TResult Function( String message,  ContractEntity? contract)  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case ContractInitial():
return initial();case ContractLoading():
return loading();case ContractLoaded():
return contractLoaded(_that.contract);case ContractHistoryLoaded():
return historyLoaded(_that.contracts,_that.roomsByRoomId);case VoucherDetailsLoaded():
return voucherDetailsLoaded(_that.contract,_that.room,_that.tenantUser,_that.ownerUser);case ContractRevenueCalculated():
return revenueCalculated(_that.totalMonthlyRevenue,_that.contracts);case ContractSuccess():
return success(_that.message,_that.contract);case ContractFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ContractEntity? contract)?  contractLoaded,TResult? Function( List<ContractEntity> contracts,  Map<String, RoomEntity> roomsByRoomId)?  historyLoaded,TResult? Function( ContractEntity? contract,  RoomEntity? room,  UserEntity? tenantUser,  UserEntity? ownerUser)?  voucherDetailsLoaded,TResult? Function( double totalMonthlyRevenue,  List<ContractEntity> contracts)?  revenueCalculated,TResult? Function( String message,  ContractEntity? contract)?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case ContractInitial() when initial != null:
return initial();case ContractLoading() when loading != null:
return loading();case ContractLoaded() when contractLoaded != null:
return contractLoaded(_that.contract);case ContractHistoryLoaded() when historyLoaded != null:
return historyLoaded(_that.contracts,_that.roomsByRoomId);case VoucherDetailsLoaded() when voucherDetailsLoaded != null:
return voucherDetailsLoaded(_that.contract,_that.room,_that.tenantUser,_that.ownerUser);case ContractRevenueCalculated() when revenueCalculated != null:
return revenueCalculated(_that.totalMonthlyRevenue,_that.contracts);case ContractSuccess() when success != null:
return success(_that.message,_that.contract);case ContractFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ContractInitial implements ContractState {
  const ContractInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContractInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContractState.initial()';
}


}




/// @nodoc


class ContractLoading implements ContractState {
  const ContractLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContractLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContractState.loading()';
}


}




/// @nodoc


class ContractLoaded implements ContractState {
  const ContractLoaded(this.contract);
  

 final  ContractEntity? contract;

/// Create a copy of ContractState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContractLoadedCopyWith<ContractLoaded> get copyWith => _$ContractLoadedCopyWithImpl<ContractLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContractLoaded&&(identical(other.contract, contract) || other.contract == contract));
}


@override
int get hashCode => Object.hash(runtimeType,contract);

@override
String toString() {
  return 'ContractState.contractLoaded(contract: $contract)';
}


}

/// @nodoc
abstract mixin class $ContractLoadedCopyWith<$Res> implements $ContractStateCopyWith<$Res> {
  factory $ContractLoadedCopyWith(ContractLoaded value, $Res Function(ContractLoaded) _then) = _$ContractLoadedCopyWithImpl;
@useResult
$Res call({
 ContractEntity? contract
});




}
/// @nodoc
class _$ContractLoadedCopyWithImpl<$Res>
    implements $ContractLoadedCopyWith<$Res> {
  _$ContractLoadedCopyWithImpl(this._self, this._then);

  final ContractLoaded _self;
  final $Res Function(ContractLoaded) _then;

/// Create a copy of ContractState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contract = freezed,}) {
  return _then(ContractLoaded(
freezed == contract ? _self.contract : contract // ignore: cast_nullable_to_non_nullable
as ContractEntity?,
  ));
}


}

/// @nodoc


class ContractHistoryLoaded implements ContractState {
  const ContractHistoryLoaded({required final  List<ContractEntity> contracts, required final  Map<String, RoomEntity> roomsByRoomId}): _contracts = contracts,_roomsByRoomId = roomsByRoomId;
  

 final  List<ContractEntity> _contracts;
 List<ContractEntity> get contracts {
  if (_contracts is EqualUnmodifiableListView) return _contracts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contracts);
}

 final  Map<String, RoomEntity> _roomsByRoomId;
 Map<String, RoomEntity> get roomsByRoomId {
  if (_roomsByRoomId is EqualUnmodifiableMapView) return _roomsByRoomId;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_roomsByRoomId);
}


/// Create a copy of ContractState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContractHistoryLoadedCopyWith<ContractHistoryLoaded> get copyWith => _$ContractHistoryLoadedCopyWithImpl<ContractHistoryLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContractHistoryLoaded&&const DeepCollectionEquality().equals(other._contracts, _contracts)&&const DeepCollectionEquality().equals(other._roomsByRoomId, _roomsByRoomId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_contracts),const DeepCollectionEquality().hash(_roomsByRoomId));

@override
String toString() {
  return 'ContractState.historyLoaded(contracts: $contracts, roomsByRoomId: $roomsByRoomId)';
}


}

/// @nodoc
abstract mixin class $ContractHistoryLoadedCopyWith<$Res> implements $ContractStateCopyWith<$Res> {
  factory $ContractHistoryLoadedCopyWith(ContractHistoryLoaded value, $Res Function(ContractHistoryLoaded) _then) = _$ContractHistoryLoadedCopyWithImpl;
@useResult
$Res call({
 List<ContractEntity> contracts, Map<String, RoomEntity> roomsByRoomId
});




}
/// @nodoc
class _$ContractHistoryLoadedCopyWithImpl<$Res>
    implements $ContractHistoryLoadedCopyWith<$Res> {
  _$ContractHistoryLoadedCopyWithImpl(this._self, this._then);

  final ContractHistoryLoaded _self;
  final $Res Function(ContractHistoryLoaded) _then;

/// Create a copy of ContractState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contracts = null,Object? roomsByRoomId = null,}) {
  return _then(ContractHistoryLoaded(
contracts: null == contracts ? _self._contracts : contracts // ignore: cast_nullable_to_non_nullable
as List<ContractEntity>,roomsByRoomId: null == roomsByRoomId ? _self._roomsByRoomId : roomsByRoomId // ignore: cast_nullable_to_non_nullable
as Map<String, RoomEntity>,
  ));
}


}

/// @nodoc


class VoucherDetailsLoaded implements ContractState {
  const VoucherDetailsLoaded({required this.contract, required this.room, required this.tenantUser, required this.ownerUser});
  

 final  ContractEntity? contract;
 final  RoomEntity? room;
 final  UserEntity? tenantUser;
 final  UserEntity? ownerUser;

/// Create a copy of ContractState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoucherDetailsLoadedCopyWith<VoucherDetailsLoaded> get copyWith => _$VoucherDetailsLoadedCopyWithImpl<VoucherDetailsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoucherDetailsLoaded&&(identical(other.contract, contract) || other.contract == contract)&&(identical(other.room, room) || other.room == room)&&(identical(other.tenantUser, tenantUser) || other.tenantUser == tenantUser)&&(identical(other.ownerUser, ownerUser) || other.ownerUser == ownerUser));
}


@override
int get hashCode => Object.hash(runtimeType,contract,room,tenantUser,ownerUser);

@override
String toString() {
  return 'ContractState.voucherDetailsLoaded(contract: $contract, room: $room, tenantUser: $tenantUser, ownerUser: $ownerUser)';
}


}

/// @nodoc
abstract mixin class $VoucherDetailsLoadedCopyWith<$Res> implements $ContractStateCopyWith<$Res> {
  factory $VoucherDetailsLoadedCopyWith(VoucherDetailsLoaded value, $Res Function(VoucherDetailsLoaded) _then) = _$VoucherDetailsLoadedCopyWithImpl;
@useResult
$Res call({
 ContractEntity? contract, RoomEntity? room, UserEntity? tenantUser, UserEntity? ownerUser
});




}
/// @nodoc
class _$VoucherDetailsLoadedCopyWithImpl<$Res>
    implements $VoucherDetailsLoadedCopyWith<$Res> {
  _$VoucherDetailsLoadedCopyWithImpl(this._self, this._then);

  final VoucherDetailsLoaded _self;
  final $Res Function(VoucherDetailsLoaded) _then;

/// Create a copy of ContractState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contract = freezed,Object? room = freezed,Object? tenantUser = freezed,Object? ownerUser = freezed,}) {
  return _then(VoucherDetailsLoaded(
contract: freezed == contract ? _self.contract : contract // ignore: cast_nullable_to_non_nullable
as ContractEntity?,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as RoomEntity?,tenantUser: freezed == tenantUser ? _self.tenantUser : tenantUser // ignore: cast_nullable_to_non_nullable
as UserEntity?,ownerUser: freezed == ownerUser ? _self.ownerUser : ownerUser // ignore: cast_nullable_to_non_nullable
as UserEntity?,
  ));
}


}

/// @nodoc


class ContractRevenueCalculated implements ContractState {
  const ContractRevenueCalculated({required this.totalMonthlyRevenue, required final  List<ContractEntity> contracts}): _contracts = contracts;
  

 final  double totalMonthlyRevenue;
 final  List<ContractEntity> _contracts;
 List<ContractEntity> get contracts {
  if (_contracts is EqualUnmodifiableListView) return _contracts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contracts);
}


/// Create a copy of ContractState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContractRevenueCalculatedCopyWith<ContractRevenueCalculated> get copyWith => _$ContractRevenueCalculatedCopyWithImpl<ContractRevenueCalculated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContractRevenueCalculated&&(identical(other.totalMonthlyRevenue, totalMonthlyRevenue) || other.totalMonthlyRevenue == totalMonthlyRevenue)&&const DeepCollectionEquality().equals(other._contracts, _contracts));
}


@override
int get hashCode => Object.hash(runtimeType,totalMonthlyRevenue,const DeepCollectionEquality().hash(_contracts));

@override
String toString() {
  return 'ContractState.revenueCalculated(totalMonthlyRevenue: $totalMonthlyRevenue, contracts: $contracts)';
}


}

/// @nodoc
abstract mixin class $ContractRevenueCalculatedCopyWith<$Res> implements $ContractStateCopyWith<$Res> {
  factory $ContractRevenueCalculatedCopyWith(ContractRevenueCalculated value, $Res Function(ContractRevenueCalculated) _then) = _$ContractRevenueCalculatedCopyWithImpl;
@useResult
$Res call({
 double totalMonthlyRevenue, List<ContractEntity> contracts
});




}
/// @nodoc
class _$ContractRevenueCalculatedCopyWithImpl<$Res>
    implements $ContractRevenueCalculatedCopyWith<$Res> {
  _$ContractRevenueCalculatedCopyWithImpl(this._self, this._then);

  final ContractRevenueCalculated _self;
  final $Res Function(ContractRevenueCalculated) _then;

/// Create a copy of ContractState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? totalMonthlyRevenue = null,Object? contracts = null,}) {
  return _then(ContractRevenueCalculated(
totalMonthlyRevenue: null == totalMonthlyRevenue ? _self.totalMonthlyRevenue : totalMonthlyRevenue // ignore: cast_nullable_to_non_nullable
as double,contracts: null == contracts ? _self._contracts : contracts // ignore: cast_nullable_to_non_nullable
as List<ContractEntity>,
  ));
}


}

/// @nodoc


class ContractSuccess implements ContractState {
  const ContractSuccess({required this.message, this.contract});
  

 final  String message;
 final  ContractEntity? contract;

/// Create a copy of ContractState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContractSuccessCopyWith<ContractSuccess> get copyWith => _$ContractSuccessCopyWithImpl<ContractSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContractSuccess&&(identical(other.message, message) || other.message == message)&&(identical(other.contract, contract) || other.contract == contract));
}


@override
int get hashCode => Object.hash(runtimeType,message,contract);

@override
String toString() {
  return 'ContractState.success(message: $message, contract: $contract)';
}


}

/// @nodoc
abstract mixin class $ContractSuccessCopyWith<$Res> implements $ContractStateCopyWith<$Res> {
  factory $ContractSuccessCopyWith(ContractSuccess value, $Res Function(ContractSuccess) _then) = _$ContractSuccessCopyWithImpl;
@useResult
$Res call({
 String message, ContractEntity? contract
});




}
/// @nodoc
class _$ContractSuccessCopyWithImpl<$Res>
    implements $ContractSuccessCopyWith<$Res> {
  _$ContractSuccessCopyWithImpl(this._self, this._then);

  final ContractSuccess _self;
  final $Res Function(ContractSuccess) _then;

/// Create a copy of ContractState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? contract = freezed,}) {
  return _then(ContractSuccess(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,contract: freezed == contract ? _self.contract : contract // ignore: cast_nullable_to_non_nullable
as ContractEntity?,
  ));
}


}

/// @nodoc


class ContractFailure implements ContractState {
  const ContractFailure(this.message);
  

 final  String message;

/// Create a copy of ContractState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContractFailureCopyWith<ContractFailure> get copyWith => _$ContractFailureCopyWithImpl<ContractFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContractFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ContractState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $ContractFailureCopyWith<$Res> implements $ContractStateCopyWith<$Res> {
  factory $ContractFailureCopyWith(ContractFailure value, $Res Function(ContractFailure) _then) = _$ContractFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ContractFailureCopyWithImpl<$Res>
    implements $ContractFailureCopyWith<$Res> {
  _$ContractFailureCopyWithImpl(this._self, this._then);

  final ContractFailure _self;
  final $Res Function(ContractFailure) _then;

/// Create a copy of ContractState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ContractFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

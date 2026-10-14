// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contract_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ContractState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ContractEntity? contract) contractLoaded,
    required TResult Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)
        revenueCalculated,
    required TResult Function(String message, ContractEntity? contract) success,
    required TResult Function(String message) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ContractEntity? contract)? contractLoaded,
    TResult? Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)?
        revenueCalculated,
    TResult? Function(String message, ContractEntity? contract)? success,
    TResult? Function(String message)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ContractEntity? contract)? contractLoaded,
    TResult Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)?
        revenueCalculated,
    TResult Function(String message, ContractEntity? contract)? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContractInitial value) initial,
    required TResult Function(ContractLoading value) loading,
    required TResult Function(ContractLoaded value) contractLoaded,
    required TResult Function(ContractRevenueCalculated value)
        revenueCalculated,
    required TResult Function(ContractSuccess value) success,
    required TResult Function(ContractFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ContractInitial value)? initial,
    TResult? Function(ContractLoading value)? loading,
    TResult? Function(ContractLoaded value)? contractLoaded,
    TResult? Function(ContractRevenueCalculated value)? revenueCalculated,
    TResult? Function(ContractSuccess value)? success,
    TResult? Function(ContractFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContractInitial value)? initial,
    TResult Function(ContractLoading value)? loading,
    TResult Function(ContractLoaded value)? contractLoaded,
    TResult Function(ContractRevenueCalculated value)? revenueCalculated,
    TResult Function(ContractSuccess value)? success,
    TResult Function(ContractFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContractStateCopyWith<$Res> {
  factory $ContractStateCopyWith(
          ContractState value, $Res Function(ContractState) then) =
      _$ContractStateCopyWithImpl<$Res, ContractState>;
}

/// @nodoc
class _$ContractStateCopyWithImpl<$Res, $Val extends ContractState>
    implements $ContractStateCopyWith<$Res> {
  _$ContractStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ContractInitialImplCopyWith<$Res> {
  factory _$$ContractInitialImplCopyWith(_$ContractInitialImpl value,
          $Res Function(_$ContractInitialImpl) then) =
      __$$ContractInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ContractInitialImplCopyWithImpl<$Res>
    extends _$ContractStateCopyWithImpl<$Res, _$ContractInitialImpl>
    implements _$$ContractInitialImplCopyWith<$Res> {
  __$$ContractInitialImplCopyWithImpl(
      _$ContractInitialImpl _value, $Res Function(_$ContractInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ContractInitialImpl implements ContractInitial {
  const _$ContractInitialImpl();

  @override
  String toString() {
    return 'ContractState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ContractInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ContractEntity? contract) contractLoaded,
    required TResult Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)
        revenueCalculated,
    required TResult Function(String message, ContractEntity? contract) success,
    required TResult Function(String message) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ContractEntity? contract)? contractLoaded,
    TResult? Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)?
        revenueCalculated,
    TResult? Function(String message, ContractEntity? contract)? success,
    TResult? Function(String message)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ContractEntity? contract)? contractLoaded,
    TResult Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)?
        revenueCalculated,
    TResult Function(String message, ContractEntity? contract)? success,
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
    required TResult Function(ContractInitial value) initial,
    required TResult Function(ContractLoading value) loading,
    required TResult Function(ContractLoaded value) contractLoaded,
    required TResult Function(ContractRevenueCalculated value)
        revenueCalculated,
    required TResult Function(ContractSuccess value) success,
    required TResult Function(ContractFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ContractInitial value)? initial,
    TResult? Function(ContractLoading value)? loading,
    TResult? Function(ContractLoaded value)? contractLoaded,
    TResult? Function(ContractRevenueCalculated value)? revenueCalculated,
    TResult? Function(ContractSuccess value)? success,
    TResult? Function(ContractFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContractInitial value)? initial,
    TResult Function(ContractLoading value)? loading,
    TResult Function(ContractLoaded value)? contractLoaded,
    TResult Function(ContractRevenueCalculated value)? revenueCalculated,
    TResult Function(ContractSuccess value)? success,
    TResult Function(ContractFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ContractInitial implements ContractState {
  const factory ContractInitial() = _$ContractInitialImpl;
}

/// @nodoc
abstract class _$$ContractLoadingImplCopyWith<$Res> {
  factory _$$ContractLoadingImplCopyWith(_$ContractLoadingImpl value,
          $Res Function(_$ContractLoadingImpl) then) =
      __$$ContractLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ContractLoadingImplCopyWithImpl<$Res>
    extends _$ContractStateCopyWithImpl<$Res, _$ContractLoadingImpl>
    implements _$$ContractLoadingImplCopyWith<$Res> {
  __$$ContractLoadingImplCopyWithImpl(
      _$ContractLoadingImpl _value, $Res Function(_$ContractLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ContractLoadingImpl implements ContractLoading {
  const _$ContractLoadingImpl();

  @override
  String toString() {
    return 'ContractState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ContractLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ContractEntity? contract) contractLoaded,
    required TResult Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)
        revenueCalculated,
    required TResult Function(String message, ContractEntity? contract) success,
    required TResult Function(String message) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ContractEntity? contract)? contractLoaded,
    TResult? Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)?
        revenueCalculated,
    TResult? Function(String message, ContractEntity? contract)? success,
    TResult? Function(String message)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ContractEntity? contract)? contractLoaded,
    TResult Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)?
        revenueCalculated,
    TResult Function(String message, ContractEntity? contract)? success,
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
    required TResult Function(ContractInitial value) initial,
    required TResult Function(ContractLoading value) loading,
    required TResult Function(ContractLoaded value) contractLoaded,
    required TResult Function(ContractRevenueCalculated value)
        revenueCalculated,
    required TResult Function(ContractSuccess value) success,
    required TResult Function(ContractFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ContractInitial value)? initial,
    TResult? Function(ContractLoading value)? loading,
    TResult? Function(ContractLoaded value)? contractLoaded,
    TResult? Function(ContractRevenueCalculated value)? revenueCalculated,
    TResult? Function(ContractSuccess value)? success,
    TResult? Function(ContractFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContractInitial value)? initial,
    TResult Function(ContractLoading value)? loading,
    TResult Function(ContractLoaded value)? contractLoaded,
    TResult Function(ContractRevenueCalculated value)? revenueCalculated,
    TResult Function(ContractSuccess value)? success,
    TResult Function(ContractFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ContractLoading implements ContractState {
  const factory ContractLoading() = _$ContractLoadingImpl;
}

/// @nodoc
abstract class _$$ContractLoadedImplCopyWith<$Res> {
  factory _$$ContractLoadedImplCopyWith(_$ContractLoadedImpl value,
          $Res Function(_$ContractLoadedImpl) then) =
      __$$ContractLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ContractEntity? contract});
}

/// @nodoc
class __$$ContractLoadedImplCopyWithImpl<$Res>
    extends _$ContractStateCopyWithImpl<$Res, _$ContractLoadedImpl>
    implements _$$ContractLoadedImplCopyWith<$Res> {
  __$$ContractLoadedImplCopyWithImpl(
      _$ContractLoadedImpl _value, $Res Function(_$ContractLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contract = freezed,
  }) {
    return _then(_$ContractLoadedImpl(
      freezed == contract
          ? _value.contract
          : contract // ignore: cast_nullable_to_non_nullable
              as ContractEntity?,
    ));
  }
}

/// @nodoc

class _$ContractLoadedImpl implements ContractLoaded {
  const _$ContractLoadedImpl(this.contract);

  @override
  final ContractEntity? contract;

  @override
  String toString() {
    return 'ContractState.contractLoaded(contract: $contract)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContractLoadedImpl &&
            (identical(other.contract, contract) ||
                other.contract == contract));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contract);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContractLoadedImplCopyWith<_$ContractLoadedImpl> get copyWith =>
      __$$ContractLoadedImplCopyWithImpl<_$ContractLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ContractEntity? contract) contractLoaded,
    required TResult Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)
        revenueCalculated,
    required TResult Function(String message, ContractEntity? contract) success,
    required TResult Function(String message) failure,
  }) {
    return contractLoaded(contract);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ContractEntity? contract)? contractLoaded,
    TResult? Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)?
        revenueCalculated,
    TResult? Function(String message, ContractEntity? contract)? success,
    TResult? Function(String message)? failure,
  }) {
    return contractLoaded?.call(contract);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ContractEntity? contract)? contractLoaded,
    TResult Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)?
        revenueCalculated,
    TResult Function(String message, ContractEntity? contract)? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (contractLoaded != null) {
      return contractLoaded(contract);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContractInitial value) initial,
    required TResult Function(ContractLoading value) loading,
    required TResult Function(ContractLoaded value) contractLoaded,
    required TResult Function(ContractRevenueCalculated value)
        revenueCalculated,
    required TResult Function(ContractSuccess value) success,
    required TResult Function(ContractFailure value) failure,
  }) {
    return contractLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ContractInitial value)? initial,
    TResult? Function(ContractLoading value)? loading,
    TResult? Function(ContractLoaded value)? contractLoaded,
    TResult? Function(ContractRevenueCalculated value)? revenueCalculated,
    TResult? Function(ContractSuccess value)? success,
    TResult? Function(ContractFailure value)? failure,
  }) {
    return contractLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContractInitial value)? initial,
    TResult Function(ContractLoading value)? loading,
    TResult Function(ContractLoaded value)? contractLoaded,
    TResult Function(ContractRevenueCalculated value)? revenueCalculated,
    TResult Function(ContractSuccess value)? success,
    TResult Function(ContractFailure value)? failure,
    required TResult orElse(),
  }) {
    if (contractLoaded != null) {
      return contractLoaded(this);
    }
    return orElse();
  }
}

abstract class ContractLoaded implements ContractState {
  const factory ContractLoaded(ContractEntity? contract) =
      _$ContractLoadedImpl;

  ContractEntity? get contract;
  @JsonKey(ignore: true)
  _$$ContractLoadedImplCopyWith<_$ContractLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContractRevenueCalculatedImplCopyWith<$Res> {
  factory _$$ContractRevenueCalculatedImplCopyWith(
          _$ContractRevenueCalculatedImpl value,
          $Res Function(_$ContractRevenueCalculatedImpl) then) =
      __$$ContractRevenueCalculatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double totalMonthlyRevenue, List<ContractEntity> contracts});
}

/// @nodoc
class __$$ContractRevenueCalculatedImplCopyWithImpl<$Res>
    extends _$ContractStateCopyWithImpl<$Res, _$ContractRevenueCalculatedImpl>
    implements _$$ContractRevenueCalculatedImplCopyWith<$Res> {
  __$$ContractRevenueCalculatedImplCopyWithImpl(
      _$ContractRevenueCalculatedImpl _value,
      $Res Function(_$ContractRevenueCalculatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalMonthlyRevenue = null,
    Object? contracts = null,
  }) {
    return _then(_$ContractRevenueCalculatedImpl(
      totalMonthlyRevenue: null == totalMonthlyRevenue
          ? _value.totalMonthlyRevenue
          : totalMonthlyRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      contracts: null == contracts
          ? _value._contracts
          : contracts // ignore: cast_nullable_to_non_nullable
              as List<ContractEntity>,
    ));
  }
}

/// @nodoc

class _$ContractRevenueCalculatedImpl implements ContractRevenueCalculated {
  const _$ContractRevenueCalculatedImpl(
      {required this.totalMonthlyRevenue,
      required List<ContractEntity> contracts})
      : _contracts = contracts;

  @override
  final double totalMonthlyRevenue;
  final List<ContractEntity> _contracts;
  @override
  List<ContractEntity> get contracts {
    if (_contracts is EqualUnmodifiableListView) return _contracts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contracts);
  }

  @override
  String toString() {
    return 'ContractState.revenueCalculated(totalMonthlyRevenue: $totalMonthlyRevenue, contracts: $contracts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContractRevenueCalculatedImpl &&
            (identical(other.totalMonthlyRevenue, totalMonthlyRevenue) ||
                other.totalMonthlyRevenue == totalMonthlyRevenue) &&
            const DeepCollectionEquality()
                .equals(other._contracts, _contracts));
  }

  @override
  int get hashCode => Object.hash(runtimeType, totalMonthlyRevenue,
      const DeepCollectionEquality().hash(_contracts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContractRevenueCalculatedImplCopyWith<_$ContractRevenueCalculatedImpl>
      get copyWith => __$$ContractRevenueCalculatedImplCopyWithImpl<
          _$ContractRevenueCalculatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ContractEntity? contract) contractLoaded,
    required TResult Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)
        revenueCalculated,
    required TResult Function(String message, ContractEntity? contract) success,
    required TResult Function(String message) failure,
  }) {
    return revenueCalculated(totalMonthlyRevenue, contracts);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ContractEntity? contract)? contractLoaded,
    TResult? Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)?
        revenueCalculated,
    TResult? Function(String message, ContractEntity? contract)? success,
    TResult? Function(String message)? failure,
  }) {
    return revenueCalculated?.call(totalMonthlyRevenue, contracts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ContractEntity? contract)? contractLoaded,
    TResult Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)?
        revenueCalculated,
    TResult Function(String message, ContractEntity? contract)? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (revenueCalculated != null) {
      return revenueCalculated(totalMonthlyRevenue, contracts);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContractInitial value) initial,
    required TResult Function(ContractLoading value) loading,
    required TResult Function(ContractLoaded value) contractLoaded,
    required TResult Function(ContractRevenueCalculated value)
        revenueCalculated,
    required TResult Function(ContractSuccess value) success,
    required TResult Function(ContractFailure value) failure,
  }) {
    return revenueCalculated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ContractInitial value)? initial,
    TResult? Function(ContractLoading value)? loading,
    TResult? Function(ContractLoaded value)? contractLoaded,
    TResult? Function(ContractRevenueCalculated value)? revenueCalculated,
    TResult? Function(ContractSuccess value)? success,
    TResult? Function(ContractFailure value)? failure,
  }) {
    return revenueCalculated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContractInitial value)? initial,
    TResult Function(ContractLoading value)? loading,
    TResult Function(ContractLoaded value)? contractLoaded,
    TResult Function(ContractRevenueCalculated value)? revenueCalculated,
    TResult Function(ContractSuccess value)? success,
    TResult Function(ContractFailure value)? failure,
    required TResult orElse(),
  }) {
    if (revenueCalculated != null) {
      return revenueCalculated(this);
    }
    return orElse();
  }
}

abstract class ContractRevenueCalculated implements ContractState {
  const factory ContractRevenueCalculated(
          {required double totalMonthlyRevenue,
          required List<ContractEntity> contracts}) =
      _$ContractRevenueCalculatedImpl;

  double get totalMonthlyRevenue;
  List<ContractEntity> get contracts;
  @JsonKey(ignore: true)
  _$$ContractRevenueCalculatedImplCopyWith<_$ContractRevenueCalculatedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContractSuccessImplCopyWith<$Res> {
  factory _$$ContractSuccessImplCopyWith(_$ContractSuccessImpl value,
          $Res Function(_$ContractSuccessImpl) then) =
      __$$ContractSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, ContractEntity? contract});
}

/// @nodoc
class __$$ContractSuccessImplCopyWithImpl<$Res>
    extends _$ContractStateCopyWithImpl<$Res, _$ContractSuccessImpl>
    implements _$$ContractSuccessImplCopyWith<$Res> {
  __$$ContractSuccessImplCopyWithImpl(
      _$ContractSuccessImpl _value, $Res Function(_$ContractSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? contract = freezed,
  }) {
    return _then(_$ContractSuccessImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      contract: freezed == contract
          ? _value.contract
          : contract // ignore: cast_nullable_to_non_nullable
              as ContractEntity?,
    ));
  }
}

/// @nodoc

class _$ContractSuccessImpl implements ContractSuccess {
  const _$ContractSuccessImpl({required this.message, this.contract});

  @override
  final String message;
  @override
  final ContractEntity? contract;

  @override
  String toString() {
    return 'ContractState.success(message: $message, contract: $contract)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContractSuccessImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.contract, contract) ||
                other.contract == contract));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, contract);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContractSuccessImplCopyWith<_$ContractSuccessImpl> get copyWith =>
      __$$ContractSuccessImplCopyWithImpl<_$ContractSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ContractEntity? contract) contractLoaded,
    required TResult Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)
        revenueCalculated,
    required TResult Function(String message, ContractEntity? contract) success,
    required TResult Function(String message) failure,
  }) {
    return success(message, contract);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ContractEntity? contract)? contractLoaded,
    TResult? Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)?
        revenueCalculated,
    TResult? Function(String message, ContractEntity? contract)? success,
    TResult? Function(String message)? failure,
  }) {
    return success?.call(message, contract);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ContractEntity? contract)? contractLoaded,
    TResult Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)?
        revenueCalculated,
    TResult Function(String message, ContractEntity? contract)? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(message, contract);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ContractInitial value) initial,
    required TResult Function(ContractLoading value) loading,
    required TResult Function(ContractLoaded value) contractLoaded,
    required TResult Function(ContractRevenueCalculated value)
        revenueCalculated,
    required TResult Function(ContractSuccess value) success,
    required TResult Function(ContractFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ContractInitial value)? initial,
    TResult? Function(ContractLoading value)? loading,
    TResult? Function(ContractLoaded value)? contractLoaded,
    TResult? Function(ContractRevenueCalculated value)? revenueCalculated,
    TResult? Function(ContractSuccess value)? success,
    TResult? Function(ContractFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContractInitial value)? initial,
    TResult Function(ContractLoading value)? loading,
    TResult Function(ContractLoaded value)? contractLoaded,
    TResult Function(ContractRevenueCalculated value)? revenueCalculated,
    TResult Function(ContractSuccess value)? success,
    TResult Function(ContractFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ContractSuccess implements ContractState {
  const factory ContractSuccess(
      {required String message,
      ContractEntity? contract}) = _$ContractSuccessImpl;

  String get message;
  ContractEntity? get contract;
  @JsonKey(ignore: true)
  _$$ContractSuccessImplCopyWith<_$ContractSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContractFailureImplCopyWith<$Res> {
  factory _$$ContractFailureImplCopyWith(_$ContractFailureImpl value,
          $Res Function(_$ContractFailureImpl) then) =
      __$$ContractFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ContractFailureImplCopyWithImpl<$Res>
    extends _$ContractStateCopyWithImpl<$Res, _$ContractFailureImpl>
    implements _$$ContractFailureImplCopyWith<$Res> {
  __$$ContractFailureImplCopyWithImpl(
      _$ContractFailureImpl _value, $Res Function(_$ContractFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ContractFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ContractFailureImpl implements ContractFailure {
  const _$ContractFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ContractState.failure(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContractFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContractFailureImplCopyWith<_$ContractFailureImpl> get copyWith =>
      __$$ContractFailureImplCopyWithImpl<_$ContractFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ContractEntity? contract) contractLoaded,
    required TResult Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)
        revenueCalculated,
    required TResult Function(String message, ContractEntity? contract) success,
    required TResult Function(String message) failure,
  }) {
    return failure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ContractEntity? contract)? contractLoaded,
    TResult? Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)?
        revenueCalculated,
    TResult? Function(String message, ContractEntity? contract)? success,
    TResult? Function(String message)? failure,
  }) {
    return failure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ContractEntity? contract)? contractLoaded,
    TResult Function(
            double totalMonthlyRevenue, List<ContractEntity> contracts)?
        revenueCalculated,
    TResult Function(String message, ContractEntity? contract)? success,
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
    required TResult Function(ContractInitial value) initial,
    required TResult Function(ContractLoading value) loading,
    required TResult Function(ContractLoaded value) contractLoaded,
    required TResult Function(ContractRevenueCalculated value)
        revenueCalculated,
    required TResult Function(ContractSuccess value) success,
    required TResult Function(ContractFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ContractInitial value)? initial,
    TResult? Function(ContractLoading value)? loading,
    TResult? Function(ContractLoaded value)? contractLoaded,
    TResult? Function(ContractRevenueCalculated value)? revenueCalculated,
    TResult? Function(ContractSuccess value)? success,
    TResult? Function(ContractFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ContractInitial value)? initial,
    TResult Function(ContractLoading value)? loading,
    TResult Function(ContractLoaded value)? contractLoaded,
    TResult Function(ContractRevenueCalculated value)? revenueCalculated,
    TResult Function(ContractSuccess value)? success,
    TResult Function(ContractFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class ContractFailure implements ContractState {
  const factory ContractFailure(String message) = _$ContractFailureImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ContractFailureImplCopyWith<_$ContractFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

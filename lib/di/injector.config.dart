// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:rental_room/data/data.dart' as _i582;
import 'package:rental_room/data/datasource/local/app_storage.dart' as _i45;
import 'package:rental_room/data/datasource/remote/auth_data_source.dart'
    as _i952;
import 'package:rental_room/data/datasource/remote/booking_data_source.dart'
    as _i738;
import 'package:rental_room/data/datasource/remote/contract_data_source.dart'
    as _i5;
import 'package:rental_room/data/datasource/remote/favorite_data_source.dart'
    as _i420;
import 'package:rental_room/data/datasource/remote/room_data_source.dart'
    as _i753;
import 'package:rental_room/data/datasource/remote/room_view_data_source.dart'
    as _i165;
import 'package:rental_room/data/datasource/remote/user_data_source.dart'
    as _i62;
import 'package:rental_room/data/repository/auth_repository_impl.dart' as _i348;
import 'package:rental_room/data/repository/booking_repository_impl.dart'
    as _i607;
import 'package:rental_room/data/repository/contract_repository_impl.dart'
    as _i586;
import 'package:rental_room/data/repository/favorite_repository_impl.dart'
    as _i553;
import 'package:rental_room/data/repository/room_repository_impl.dart' as _i847;
import 'package:rental_room/data/repository/room_view_impl.dart' as _i318;
import 'package:rental_room/data/repository/user_repository_impl.dart' as _i849;
import 'package:rental_room/data/services/snack_shower.dart' as _i615;
import 'package:rental_room/di/modules/firebase.dart' as _i388;
import 'package:rental_room/di/modules/logger.dart' as _i169;
import 'package:rental_room/di/modules/shared_preferences_provider.dart'
    as _i1011;
import 'package:rental_room/domain/domain.dart' as _i156;
import 'package:rental_room/domain/repository/auth_repository.dart' as _i267;
import 'package:rental_room/domain/repository/booking_repository.dart' as _i905;
import 'package:rental_room/domain/repository/contract_repository.dart'
    as _i643;
import 'package:rental_room/domain/repository/favorite_repository.dart'
    as _i549;
import 'package:rental_room/domain/repository/room_repository.dart' as _i899;
import 'package:rental_room/domain/repository/room_view_respository.dart'
    as _i680;
import 'package:rental_room/domain/repository/user_repository.dart' as _i993;
import 'package:rental_room/domain/usecase/create_booking_usecase.dart' as _i75;
import 'package:rental_room/domain/usecase/create_contract_usecase.dart'
    as _i394;
import 'package:rental_room/domain/usecase/create_room_usecase.dart' as _i92;
import 'package:rental_room/domain/usecase/delete_booking_usecase.dart'
    as _i108;
import 'package:rental_room/domain/usecase/delete_room_usecase.dart' as _i1026;
import 'package:rental_room/domain/usecase/get_bookings_usecase.dart' as _i588;
import 'package:rental_room/domain/usecase/get_contract_by_booking_usecase.dart'
    as _i255;
import 'package:rental_room/domain/usecase/get_favorite_counts_usecase.dart'
    as _i14;
import 'package:rental_room/domain/usecase/get_room_visitor_count_usecase.dart'
    as _i219;
import 'package:rental_room/domain/usecase/get_rooms_usecase.dart' as _i529;
import 'package:rental_room/domain/usecase/get_user_favorites_usecase.dart'
    as _i64;
import 'package:rental_room/domain/usecase/get_user_usecase.dart' as _i411;
import 'package:rental_room/domain/usecase/record_room_view_usecase.dart'
    as _i283;
import 'package:rental_room/domain/usecase/sign_in_usecase.dart' as _i472;
import 'package:rental_room/domain/usecase/sign_out_usecase.dart' as _i165;
import 'package:rental_room/domain/usecase/sign_up_usecase.dart' as _i619;
import 'package:rental_room/domain/usecase/toggle_favorite_usecase.dart'
    as _i968;
import 'package:rental_room/domain/usecase/update_booking_usecase.dart' as _i99;
import 'package:rental_room/domain/usecase/update_contract_usecase.dart'
    as _i486;
import 'package:rental_room/domain/usecase/update_password_usecase.dart'
    as _i464;
import 'package:rental_room/domain/usecase/update_room_usecase.dart' as _i450;
import 'package:rental_room/domain/usecase/update_user_profile_param.dart'
    as _i255;
import 'package:rental_room/presentation/blocs/authentication_cubit/authentication_cubit.dart'
    as _i912;
import 'package:rental_room/presentation/blocs/booking_cubit/booking_cubit.dart'
    as _i128;
import 'package:rental_room/presentation/blocs/favorite_cubit/favorite_cubit.dart'
    as _i1044;
import 'package:rental_room/presentation/blocs/room_cubit/room_cubit.dart'
    as _i83;
import 'package:rental_room/presentation/navigation/navigation_key_provider.dart'
    as _i383;
import 'package:rental_room/presentation/navigation/router.dart' as _i828;
import 'package:rental_room/presentation/pages/landing/login/cubit/login_cubit.dart'
    as _i391;
import 'package:rental_room/presentation/pages/landing/sign_up/cubit/sign_up_cubit.dart'
    as _i116;
import 'package:rental_room/presentation/pages/profile/edit_password/cubit/edit_password_cubit.dart'
    as _i722;
import 'package:rental_room/presentation/pages/profile/edit_profile/cubit/edit_profile_cubit.dart'
    as _i725;
import 'package:rental_room/presentation/presentation.dart' as _i276;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final storageModule = _$StorageModule();
    final firebaseModule = _$FirebaseModule();
    final loggerModule = _$LoggerModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => storageModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(
        () => firebaseModule.firebaseFireStore);
    gh.lazySingleton<_i974.Logger>(() => loggerModule.logger);
    gh.lazySingleton<_i45.AppStorage>(
        () => _i45.AppStorage(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i383.INavigationKeyProvider>(
        () => _i383.NavigationKeyProviderImpl());
    gh.lazySingleton<_i5.ContractRemoteDataSource>(
        () => _i5.ContractRemoteDataSource(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i738.BookingRemoteDataSource>(
        () => _i738.BookingRemoteDataSource(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i753.RoomRemoteDataSource>(
        () => _i753.RoomRemoteDataSource(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i420.FavoriteRemoteDataSource>(
        () => _i420.FavoriteRemoteDataSource(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i899.RoomRepository>(
        () => _i847.RoomRepositoryImpl(gh<_i753.RoomRemoteDataSource>()));
    gh.lazySingleton<_i165.RoomViewRemoteDataSource>(() =>
        _i165.RoomViewRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i1026.DeleteRoomUseCase>(
        () => _i1026.DeleteRoomUseCase(gh<_i899.RoomRepository>()));
    gh.lazySingleton<_i92.CreateRoomUseCase>(
        () => _i92.CreateRoomUseCase(gh<_i899.RoomRepository>()));
    gh.lazySingleton<_i450.UpdateRoomUseCase>(
        () => _i450.UpdateRoomUseCase(gh<_i899.RoomRepository>()));
    gh.lazySingleton<_i529.GetRoomsUseCase>(
        () => _i529.GetRoomsUseCase(gh<_i899.RoomRepository>()));
    gh.lazySingleton<_i549.FavoriteRepository>(() =>
        _i553.FavoriteRepositoryImpl(gh<_i420.FavoriteRemoteDataSource>()));
    gh.lazySingleton<_i952.AuthDataSource>(() => _i952.AuthDataSource(
          gh<_i59.FirebaseAuth>(),
          gh<_i974.FirebaseFirestore>(),
        ));
    gh.lazySingleton<_i62.UserRemoteDataSource>(() => _i62.UserRemoteDataSource(
          gh<_i59.FirebaseAuth>(),
          gh<_i974.FirebaseFirestore>(),
        ));
    gh.lazySingleton<_i64.GetUserFavoritesUseCase>(
        () => _i64.GetUserFavoritesUseCase(gh<_i549.FavoriteRepository>()));
    gh.lazySingleton<_i968.ToggleFavoriteUseCase>(
        () => _i968.ToggleFavoriteUseCase(gh<_i549.FavoriteRepository>()));
    gh.lazySingleton<_i14.GetFavoriteCountsUseCase>(
        () => _i14.GetFavoriteCountsUseCase(gh<_i549.FavoriteRepository>()));
    gh.lazySingleton<_i993.UserRepository>(
        () => _i849.UserRepositoryImpl(gh<_i62.UserRemoteDataSource>()));
    gh.lazySingleton<_i615.ISnackShower>(
        () => _i615.SnackShowerImpl(gh<_i383.INavigationKeyProvider>()));
    gh.factory<_i83.RoomCubit>(() => _i83.RoomCubit(
          gh<_i156.GetRoomsUseCase>(),
          gh<_i156.CreateRoomUseCase>(),
          gh<_i156.UpdateRoomUseCase>(),
          gh<_i156.DeleteRoomUseCase>(),
        ));
    gh.lazySingleton<_i267.AuthRepository>(
        () => _i348.AuthRepositoryImpl(gh<_i952.AuthDataSource>()));
    gh.lazySingleton<_i905.BookingRepository>(
        () => _i607.BookingRepositoryImpl(gh<_i738.BookingRemoteDataSource>()));
    gh.factory<_i1044.FavoriteCubit>(() => _i1044.FavoriteCubit(
          gh<_i968.ToggleFavoriteUseCase>(),
          gh<_i64.GetUserFavoritesUseCase>(),
          gh<_i14.GetFavoriteCountsUseCase>(),
        ));
    gh.lazySingleton<_i643.ContractRepository>(
        () => _i586.ContractRepositoryImpl(gh<_i5.ContractRemoteDataSource>()));
    gh.lazySingleton<_i165.SignOutUseCase>(
        () => _i165.SignOutUseCase(gh<_i156.AuthRepository>()));
    gh.lazySingleton<_i486.UpdateContractUseCase>(
        () => _i486.UpdateContractUseCase(gh<_i643.ContractRepository>()));
    gh.lazySingleton<_i680.RoomViewRepository>(() =>
        _i318.RoomViewRepositoryImpl(gh<_i165.RoomViewRemoteDataSource>()));
    gh.lazySingleton<_i255.UpdateUserProfileUseCase>(
        () => _i255.UpdateUserProfileUseCase(gh<_i993.UserRepository>()));
    gh.lazySingleton<_i464.UpdatePasswordUseCase>(
        () => _i464.UpdatePasswordUseCase(gh<_i267.AuthRepository>()));
    gh.lazySingleton<_i411.GetUserUseCase>(
        () => _i411.GetUserUseCase(gh<_i267.AuthRepository>()));
    gh.lazySingleton<_i472.SignInUseCase>(
        () => _i472.SignInUseCase(gh<_i267.AuthRepository>()));
    gh.lazySingleton<_i619.SignUpUseCase>(
        () => _i619.SignUpUseCase(gh<_i267.AuthRepository>()));
    gh.factory<_i116.SignUpCubit>(
        () => _i116.SignUpCubit(gh<_i156.SignUpUseCase>()));
    gh.lazySingleton<_i108.DeleteBookingUseCase>(
        () => _i108.DeleteBookingUseCase(gh<_i905.BookingRepository>()));
    gh.lazySingleton<_i99.UpdateBookingUseCase>(
        () => _i99.UpdateBookingUseCase(gh<_i905.BookingRepository>()));
    gh.lazySingleton<_i588.GetBookingsUseCase>(
        () => _i588.GetBookingsUseCase(gh<_i905.BookingRepository>()));
    gh.lazySingleton<_i75.CreateBookingUseCase>(
        () => _i75.CreateBookingUseCase(gh<_i905.BookingRepository>()));
    gh.lazySingleton<_i394.CreateContractUseCase>(
        () => _i394.CreateContractUseCase(gh<_i643.ContractRepository>()));
    gh.lazySingleton<_i255.GetContractByBookingUseCase>(() =>
        _i255.GetContractByBookingUseCase(gh<_i643.ContractRepository>()));
    gh.lazySingleton<_i219.GetRoomVisitorCountUseCase>(
        () => _i219.GetRoomVisitorCountUseCase(gh<_i680.RoomViewRepository>()));
    gh.lazySingleton<_i283.RecordRoomViewUseCase>(
        () => _i283.RecordRoomViewUseCase(gh<_i680.RoomViewRepository>()));
    gh.lazySingleton<_i156.RemoveRoomViewUseCase>(
        () => _i156.RemoveRoomViewUseCase(gh<_i680.RoomViewRepository>()));
    gh.lazySingleton<_i912.AuthenticationCubit>(() => _i912.AuthenticationCubit(
          gh<_i582.AppStorage>(),
          gh<_i156.SignOutUseCase>(),
          gh<_i156.GetUserUseCase>(),
        ));
    gh.factory<_i128.BookingCubit>(() => _i128.BookingCubit(
          gh<_i156.GetBookingsUseCase>(),
          gh<_i156.CreateBookingUseCase>(),
          gh<_i156.UpdateBookingUseCase>(),
          gh<_i108.DeleteBookingUseCase>(),
          gh<_i156.BookingRepository>(),
        ));
    gh.factory<_i391.LoginCubit>(
        () => _i391.LoginCubit(gh<_i472.SignInUseCase>()));
    gh.lazySingleton<_i828.NavigationRouter>(() => _i828.NavigationRouter(
          gh<_i276.INavigationKeyProvider>(),
          gh<_i582.AppStorage>(),
          gh<_i582.ISnackShower>(),
          gh<_i276.AuthenticationCubit>(),
        ));
    gh.factory<_i722.EditPasswordCubit>(() => _i722.EditPasswordCubit(
          gh<_i464.UpdatePasswordUseCase>(),
          gh<_i912.AuthenticationCubit>(),
        ));
    gh.factory<_i725.EditProfileCubit>(() => _i725.EditProfileCubit(
          gh<_i255.UpdateUserProfileUseCase>(),
          gh<_i45.AppStorage>(),
          gh<_i912.AuthenticationCubit>(),
        ));
    return this;
  }
}

class _$StorageModule extends _i1011.StorageModule {}

class _$FirebaseModule extends _i388.FirebaseModule {}

class _$LoggerModule extends _i169.LoggerModule {}

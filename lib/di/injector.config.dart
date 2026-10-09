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
import 'package:rental_room/data/datasource/remote/firebase_api/auth_data_source/auth_data_source.dart'
    as _i544;
import 'package:rental_room/data/datasource/remote/firebase_api/auth_data_source/user_data_source.dart'
    as _i1022;
import 'package:rental_room/data/datasource/remote/firebase_api/owner_data_source/contract_data_source.dart'
    as _i54;
import 'package:rental_room/data/datasource/remote/firebase_api/owner_data_source/room_data_source.dart'
    as _i760;
import 'package:rental_room/data/datasource/remote/firebase_api/owner_data_source/room_view_data_source.dart'
    as _i541;
import 'package:rental_room/data/datasource/remote/firebase_api/tenant_data_source/booking_data_source.dart'
    as _i905;
import 'package:rental_room/data/datasource/remote/firebase_api/tenant_data_source/favorite_data_source.dart'
    as _i686;
import 'package:rental_room/data/repository/auth/auth_repository_impl.dart'
    as _i1001;
import 'package:rental_room/data/repository/booking/booking_repository_impl.dart'
    as _i586;
import 'package:rental_room/data/repository/contract/contract_repository_impl.dart'
    as _i682;
import 'package:rental_room/data/repository/favourite/favorite_repository_impl.dart'
    as _i828;
import 'package:rental_room/data/repository/room/room_repository_impl.dart'
    as _i1032;
import 'package:rental_room/data/repository/room/room_view_impl.dart' as _i195;
import 'package:rental_room/data/repository/user/user_repository_impl.dart'
    as _i252;
import 'package:rental_room/data/services/snack_shower.dart' as _i615;
import 'package:rental_room/di/modules/firebase.dart' as _i388;
import 'package:rental_room/di/modules/logger.dart' as _i169;
import 'package:rental_room/di/modules/shared_preferences_provider.dart'
    as _i1011;
import 'package:rental_room/domain/domain.dart' as _i156;
import 'package:rental_room/domain/repository/auth/auth_repository.dart'
    as _i794;
import 'package:rental_room/domain/repository/booking/booking_repository.dart'
    as _i312;
import 'package:rental_room/domain/repository/contract/contract_repository.dart'
    as _i1024;
import 'package:rental_room/domain/repository/favorite/favorite_repository.dart'
    as _i809;
import 'package:rental_room/domain/repository/room/room_repository.dart'
    as _i956;
import 'package:rental_room/domain/repository/room/room_view_respository.dart'
    as _i296;
import 'package:rental_room/domain/repository/user/user_repository.dart'
    as _i795;
import 'package:rental_room/domain/usecase/booking/create_booking_usecase.dart'
    as _i179;
import 'package:rental_room/domain/usecase/booking/delete_booking_usecase.dart'
    as _i954;
import 'package:rental_room/domain/usecase/booking/get_bookings_usecase.dart'
    as _i486;
import 'package:rental_room/domain/usecase/booking/update_booking_usecase.dart'
    as _i552;
import 'package:rental_room/domain/usecase/contract/create_contract_usecase.dart'
    as _i355;
import 'package:rental_room/domain/usecase/contract/get_contract_by_booking_usecase.dart'
    as _i375;
import 'package:rental_room/domain/usecase/contract/update_contract_usecase.dart'
    as _i374;
import 'package:rental_room/domain/usecase/favorite/get_favorite_counts_usecase.dart'
    as _i516;
import 'package:rental_room/domain/usecase/favorite/get_user_favorites_usecase.dart'
    as _i195;
import 'package:rental_room/domain/usecase/favorite/toggle_favorite_usecase.dart'
    as _i1052;
import 'package:rental_room/domain/usecase/room/create_room_usecase.dart'
    as _i401;
import 'package:rental_room/domain/usecase/room/delete_room_usecase.dart'
    as _i379;
import 'package:rental_room/domain/usecase/room/get_room_visitor_count_usecase.dart'
    as _i522;
import 'package:rental_room/domain/usecase/room/get_rooms_usecase.dart'
    as _i304;
import 'package:rental_room/domain/usecase/room/record_room_view_usecase.dart'
    as _i74;
import 'package:rental_room/domain/usecase/room/remove_room_view_usecase.dart'
    as _i1066;
import 'package:rental_room/domain/usecase/room/update_room_usecase.dart'
    as _i146;
import 'package:rental_room/domain/usecase/user/get_user_usecase.dart' as _i560;
import 'package:rental_room/domain/usecase/user/sign_in_usecase.dart' as _i986;
import 'package:rental_room/domain/usecase/user/sign_out_usecase.dart' as _i622;
import 'package:rental_room/domain/usecase/user/sign_up_usecase.dart' as _i448;
import 'package:rental_room/domain/usecase/user/update_password_usecase.dart'
    as _i247;
import 'package:rental_room/domain/usecase/user/update_user_profile_param.dart'
    as _i275;
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
import 'package:rental_room/presentation/pages/auth/login/cubit/login_cubit.dart'
    as _i141;
import 'package:rental_room/presentation/pages/auth/sign_up/cubit/sign_up_cubit.dart'
    as _i435;
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
    gh.lazySingleton<_i541.RoomViewRemoteDataSource>(() =>
        _i541.RoomViewRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i54.ContractRemoteDataSource>(
        () => _i54.ContractRemoteDataSource(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i760.RoomRemoteDataSource>(
        () => _i760.RoomRemoteDataSource(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i905.BookingRemoteDataSource>(
        () => _i905.BookingRemoteDataSource(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i686.FavoriteRemoteDataSource>(
        () => _i686.FavoriteRemoteDataSource(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i296.RoomViewRepository>(() =>
        _i195.RoomViewRepositoryImpl(gh<_i582.RoomViewRemoteDataSource>()));
    gh.lazySingleton<_i544.AuthDataSource>(() => _i544.AuthDataSource(
          gh<_i59.FirebaseAuth>(),
          gh<_i974.FirebaseFirestore>(),
        ));
    gh.lazySingleton<_i1022.UserRemoteDataSource>(
        () => _i1022.UserRemoteDataSource(
              gh<_i59.FirebaseAuth>(),
              gh<_i974.FirebaseFirestore>(),
            ));
    gh.lazySingleton<_i615.ISnackShower>(
        () => _i615.SnackShowerImpl(gh<_i383.INavigationKeyProvider>()));
    gh.lazySingleton<_i1066.RemoveRoomViewUseCase>(
        () => _i1066.RemoveRoomViewUseCase(gh<_i296.RoomViewRepository>()));
    gh.lazySingleton<_i522.GetRoomVisitorCountUseCase>(
        () => _i522.GetRoomVisitorCountUseCase(gh<_i296.RoomViewRepository>()));
    gh.lazySingleton<_i74.RecordRoomViewUseCase>(
        () => _i74.RecordRoomViewUseCase(gh<_i296.RoomViewRepository>()));
    gh.lazySingleton<_i794.AuthRepository>(
        () => _i1001.AuthRepositoryImpl(gh<_i582.AuthDataSource>()));
    gh.lazySingleton<_i795.UserRepository>(
        () => _i252.UserRepositoryImpl(gh<_i582.UserRemoteDataSource>()));
    gh.lazySingleton<_i956.RoomRepository>(
        () => _i1032.RoomRepositoryImpl(gh<_i760.RoomRemoteDataSource>()));
    gh.lazySingleton<_i1024.ContractRepository>(() =>
        _i682.ContractRepositoryImpl(gh<_i54.ContractRemoteDataSource>()));
    gh.lazySingleton<_i809.FavoriteRepository>(() =>
        _i828.FavoriteRepositoryImpl(gh<_i686.FavoriteRemoteDataSource>()));
    gh.lazySingleton<_i275.UpdateUserProfileUseCase>(
        () => _i275.UpdateUserProfileUseCase(gh<_i795.UserRepository>()));
    gh.lazySingleton<_i312.BookingRepository>(
        () => _i586.BookingRepositoryImpl(gh<_i905.BookingRemoteDataSource>()));
    gh.lazySingleton<_i954.DeleteBookingUseCase>(
        () => _i954.DeleteBookingUseCase(gh<_i312.BookingRepository>()));
    gh.lazySingleton<_i552.UpdateBookingUseCase>(
        () => _i552.UpdateBookingUseCase(gh<_i312.BookingRepository>()));
    gh.lazySingleton<_i486.GetBookingsUseCase>(
        () => _i486.GetBookingsUseCase(gh<_i312.BookingRepository>()));
    gh.lazySingleton<_i179.CreateBookingUseCase>(
        () => _i179.CreateBookingUseCase(gh<_i312.BookingRepository>()));
    gh.lazySingleton<_i247.UpdatePasswordUseCase>(
        () => _i247.UpdatePasswordUseCase(gh<_i794.AuthRepository>()));
    gh.lazySingleton<_i560.GetUserUseCase>(
        () => _i560.GetUserUseCase(gh<_i794.AuthRepository>()));
    gh.lazySingleton<_i986.SignInUseCase>(
        () => _i986.SignInUseCase(gh<_i794.AuthRepository>()));
    gh.lazySingleton<_i448.SignUpUseCase>(
        () => _i448.SignUpUseCase(gh<_i794.AuthRepository>()));
    gh.lazySingleton<_i195.GetUserFavoritesUseCase>(
        () => _i195.GetUserFavoritesUseCase(gh<_i809.FavoriteRepository>()));
    gh.lazySingleton<_i1052.ToggleFavoriteUseCase>(
        () => _i1052.ToggleFavoriteUseCase(gh<_i809.FavoriteRepository>()));
    gh.lazySingleton<_i516.GetFavoriteCountsUseCase>(
        () => _i516.GetFavoriteCountsUseCase(gh<_i809.FavoriteRepository>()));
    gh.factory<_i141.LoginCubit>(
        () => _i141.LoginCubit(gh<_i986.SignInUseCase>()));
    gh.lazySingleton<_i379.DeleteRoomUseCase>(
        () => _i379.DeleteRoomUseCase(gh<_i956.RoomRepository>()));
    gh.lazySingleton<_i401.CreateRoomUseCase>(
        () => _i401.CreateRoomUseCase(gh<_i956.RoomRepository>()));
    gh.lazySingleton<_i146.UpdateRoomUseCase>(
        () => _i146.UpdateRoomUseCase(gh<_i956.RoomRepository>()));
    gh.lazySingleton<_i304.GetRoomsUseCase>(
        () => _i304.GetRoomsUseCase(gh<_i956.RoomRepository>()));
    gh.factory<_i435.SignUpCubit>(
        () => _i435.SignUpCubit(gh<_i156.SignUpUseCase>()));
    gh.lazySingleton<_i622.SignOutUseCase>(
        () => _i622.SignOutUseCase(gh<_i156.AuthRepository>()));
    gh.lazySingleton<_i355.CreateContractUseCase>(
        () => _i355.CreateContractUseCase(gh<_i1024.ContractRepository>()));
    gh.lazySingleton<_i375.GetContractByBookingUseCase>(() =>
        _i375.GetContractByBookingUseCase(gh<_i1024.ContractRepository>()));
    gh.lazySingleton<_i374.UpdateContractUseCase>(
        () => _i374.UpdateContractUseCase(gh<_i1024.ContractRepository>()));
    gh.factory<_i1044.FavoriteCubit>(() => _i1044.FavoriteCubit(
          gh<_i1052.ToggleFavoriteUseCase>(),
          gh<_i195.GetUserFavoritesUseCase>(),
          gh<_i516.GetFavoriteCountsUseCase>(),
        ));
    gh.factory<_i83.RoomCubit>(() => _i83.RoomCubit(
          gh<_i156.GetRoomsUseCase>(),
          gh<_i156.CreateRoomUseCase>(),
          gh<_i156.UpdateRoomUseCase>(),
          gh<_i156.DeleteRoomUseCase>(),
        ));
    gh.lazySingleton<_i912.AuthenticationCubit>(() => _i912.AuthenticationCubit(
          gh<_i582.AppStorage>(),
          gh<_i156.SignOutUseCase>(),
          gh<_i156.GetUserUseCase>(),
        ));
    gh.factory<_i722.EditPasswordCubit>(() => _i722.EditPasswordCubit(
          gh<_i247.UpdatePasswordUseCase>(),
          gh<_i912.AuthenticationCubit>(),
        ));
    gh.factory<_i128.BookingCubit>(() => _i128.BookingCubit(
          gh<_i156.GetBookingsUseCase>(),
          gh<_i156.CreateBookingUseCase>(),
          gh<_i156.UpdateBookingUseCase>(),
          gh<_i954.DeleteBookingUseCase>(),
          gh<_i156.BookingRepository>(),
        ));
    gh.factory<_i725.EditProfileCubit>(() => _i725.EditProfileCubit(
          gh<_i275.UpdateUserProfileUseCase>(),
          gh<_i45.AppStorage>(),
          gh<_i912.AuthenticationCubit>(),
        ));
    gh.lazySingleton<_i828.NavigationRouter>(() => _i828.NavigationRouter(
          gh<_i276.INavigationKeyProvider>(),
          gh<_i582.AppStorage>(),
          gh<_i582.ISnackShower>(),
          gh<_i276.AuthenticationCubit>(),
        ));
    return this;
  }
}

class _$StorageModule extends _i1011.StorageModule {}

class _$FirebaseModule extends _i388.FirebaseModule {}

class _$LoggerModule extends _i169.LoggerModule {}

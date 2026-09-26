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
import 'package:rental_room/data/datasource/remote/user_data_source.dart'
    as _i62;
import 'package:rental_room/data/repository/auth_repository_impl.dart' as _i348;
import 'package:rental_room/data/repository/user_repository_impl.dart' as _i849;
import 'package:rental_room/data/services/snack_shower.dart' as _i615;
import 'package:rental_room/di/modules/firebase.dart' as _i388;
import 'package:rental_room/di/modules/logger.dart' as _i169;
import 'package:rental_room/di/modules/shared_preferences_provider.dart'
    as _i1011;
import 'package:rental_room/domain/domain.dart' as _i156;
import 'package:rental_room/domain/repository/auth_repository.dart' as _i267;
import 'package:rental_room/domain/repository/user_repository.dart' as _i993;
import 'package:rental_room/domain/usecase/get_user_usecase.dart' as _i411;
import 'package:rental_room/domain/usecase/sign_in_usecase.dart' as _i472;
import 'package:rental_room/domain/usecase/sign_out_usecase.dart' as _i165;
import 'package:rental_room/domain/usecase/sign_up_usecase.dart' as _i619;
import 'package:rental_room/domain/usecase/update_password_usecase.dart'
    as _i464;
import 'package:rental_room/domain/usecase/update_user_profile_param.dart'
    as _i255;
import 'package:rental_room/presentation/blocs/authentication_cubit/authentication_cubit.dart'
    as _i912;
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
    gh.lazySingleton<_i952.AuthDataSource>(() => _i952.AuthDataSource(
          gh<_i59.FirebaseAuth>(),
          gh<_i974.FirebaseFirestore>(),
        ));
    gh.lazySingleton<_i62.UserRemoteDataSource>(() => _i62.UserRemoteDataSource(
          gh<_i59.FirebaseAuth>(),
          gh<_i974.FirebaseFirestore>(),
        ));
    gh.lazySingleton<_i993.UserRepository>(
        () => _i849.UserRepositoryImpl(gh<_i62.UserRemoteDataSource>()));
    gh.lazySingleton<_i615.ISnackShower>(
        () => _i615.SnackShowerImpl(gh<_i383.INavigationKeyProvider>()));
    gh.lazySingleton<_i267.AuthRepository>(
        () => _i348.AuthRepositoryImpl(gh<_i952.AuthDataSource>()));
    gh.lazySingleton<_i165.SignOutUseCase>(
        () => _i165.SignOutUseCase(gh<_i156.AuthRepository>()));
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
    gh.lazySingleton<_i912.AuthenticationCubit>(() => _i912.AuthenticationCubit(
          gh<_i582.AppStorage>(),
          gh<_i156.SignOutUseCase>(),
          gh<_i156.GetUserUseCase>(),
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

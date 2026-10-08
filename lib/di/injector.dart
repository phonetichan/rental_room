import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rental_room/presentation/blocs/contract_cubit/contract_cubit.dart';

import 'injector.config.dart';

// You defined _getIt with an underscore
final _getIt = GetIt.instance;

T inject<T extends Object>({
  String? instanceName,
  Type? type,
}) =>
    _getIt.get<T>(
      instanceName: instanceName,
      type: type,
    );

T register<T extends Object>(
    T instance, {
      String? instanceName,
    }) =>
    _getIt.registerSingleton<T>(
      instance,
      instanceName: instanceName,
    );

@InjectableInit()
Future<GetIt> configureDependencies() async {
  await _getIt.init();
  if (!_getIt.isRegistered<ContractCubit>()) {
    _getIt.registerFactory(() => ContractCubit(
          _getIt(),
          _getIt(),
          _getIt(),
          _getIt(),
        ));
  }
  return _getIt;
}
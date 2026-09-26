import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../presentation/navigation/navigation_key_provider.dart';
import '../../presentation/prompt/snacks.dart';

abstract interface class ISnackShower {
  void info({BuildContext? context, required String message, SnackGravity gravity = SnackGravity.top});

  void error({BuildContext? context, required String message, SnackGravity gravity = SnackGravity.top});

  void success({BuildContext? context, required String message, SnackGravity gravity = SnackGravity.top});
}

@LazySingleton(as: ISnackShower)
class SnackShowerImpl implements ISnackShower {
  final INavigationKeyProvider _navKeyProvider;

  SnackShowerImpl(this._navKeyProvider);

  @override
  void info({BuildContext? context, required String message, SnackGravity gravity = SnackGravity.top}) {
    final ctx = context ?? _navKeyProvider.globalKey.currentContext;
    if (ctx != null) {
      Snacks.info(ctx, message: message, gravity: gravity);
    }
  }

  @override
  void error({BuildContext? context, required String message, SnackGravity gravity = SnackGravity.top}) {
    final ctx = context ?? _navKeyProvider.globalKey.currentContext;
    if (ctx != null) {
      Snacks.error(ctx, message: message, gravity: gravity);
    }
  }

  @override
  void success({BuildContext? context, required String message, SnackGravity gravity = SnackGravity.top}) {
    final ctx = context ?? _navKeyProvider.globalKey.currentContext;
    if (ctx != null) {
      Snacks.success(ctx, message: message, gravity: gravity);
    }
  }
}

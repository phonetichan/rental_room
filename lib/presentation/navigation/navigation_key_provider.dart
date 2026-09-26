import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

abstract class INavigationKeyProvider {
  GlobalKey<NavigatorState> get globalKey;

  // Add getter and setter to the interface contract
  BuildContext? get scaffoldContext;
  set scaffoldContext(BuildContext? context);
}

@LazySingleton(as: INavigationKeyProvider)
class NavigationKeyProviderImpl implements INavigationKeyProvider {
  @override
  final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  BuildContext? _scaffoldContext;

  @override
  BuildContext? get scaffoldContext => _scaffoldContext;

  @override
  set scaffoldContext(BuildContext? context) {
    _scaffoldContext = context;
  }
}
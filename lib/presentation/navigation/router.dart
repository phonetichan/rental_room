import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:rental_room/domain/domain.dart';
import '../../data/data.dart';
import '../../di/di.dart';
import '../pages/index.dart';
import '../presentation.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<AuthenticationState> _subscription;
  Type? _lastStateRuntimeType;

  GoRouterRefreshStream(Stream<AuthenticationState> stream, {VoidCallback? onUnauthenticated}) {
    _subscription = stream.asBroadcastStream().listen((state) {
      final isAuth = state is AuthenticationAuthenticated;
      final isUnauth = state is AuthenticationUnauthenticated;

      if (isUnauth) {
        onUnauthenticated?.call();
      }

      if (_lastStateRuntimeType != state.runtimeType) {
        _lastStateRuntimeType = state.runtimeType;
        if (isAuth || isUnauth) {
          notifyListeners();
        }
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

@lazySingleton
class NavigationRouter {
  final INavigationKeyProvider _navigationKeyProvider;
  final AppStorage _storage;
  final ISnackShower _snackShower;
  final AuthenticationCubit _authCubit;

  NavigationRouter(
    this._navigationKeyProvider,
    this._storage,
    this._snackShower,
    this._authCubit,
  );

  late final router = GoRouter(
    navigatorKey: _navigationKeyProvider.globalKey,
    refreshListenable: GoRouterRefreshStream(
      _authCubit.stream,
      onUnauthenticated: () {
        final context = _navigationKeyProvider.globalKey.currentContext;
        if (context != null && GoRouter.of(context).routerDelegate.currentConfiguration.uri.path != LoginPage.routePath) {
          context.go(LoginPage.routePath);
        }
      },
    ),
    redirect: (context, state) {
      // Use matchedLocation to get the exact active route path (robust for shell routes and tabs like owner/tenant profiles)
      final currentRoute = state.matchedLocation;

      // 1. Check onboarding status for new installs
      if (_storage.isNewInstall && currentRoute != LandingPage.routePath) {
        return LandingPage.routePath;
      }

      final authState = _authCubit.state;

      // 2. Do not redirect while authentication check is in progress
      if (authState is AuthenticationInitial ||
          authState is AuthenticationLoading) {
        return null;
      }

      final isAuthenticated = authState is AuthenticationAuthenticated;

      // 3. Redirect authenticated users away from auth/landing pages to main IndexPage
      if (isAuthenticated) {
        if (currentRoute == LoginPage.routePath ||
            currentRoute == SignUpPage.routePath ||
            currentRoute == LandingPage.routePath) {
          return IndexPage.routePath;
        }
      } else {
        // 4. Redirect unauthenticated users (e.g. after sign out or password update) to LoginPage if on protected routes
        if (currentRoute != LandingPage.routePath &&
            currentRoute != TermsAndConditionsPage.routePath &&
            currentRoute != UserGuidancePage.routePath &&
            currentRoute != LoginPage.routePath &&
            currentRoute != SignUpPage.routePath) {
          return LoginPage.routePath;
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: LandingPage.routePath,
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: TermsAndConditionsPage.routePath,
        builder: (context, state) => const TermsAndConditionsPage(),
      ),
      GoRoute(
        path: UserGuidancePage.routePath,
        builder: (context, state) => const UserGuidancePage(),
      ),

      // Auth routes
      GoRoute(
        path: LoginPage.routePath,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => inject<LoginCubit>(),
            child: const LoginPage(),
          );
        },
      ),
      GoRoute(
        path: SignUpPage.routePath,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => inject<SignUpCubit>(),
            child: const SignUpPage(),
          );
        },
      ),

      // Profile routes
      GoRoute(
        path: EditProfileScreen.routePath,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => inject<EditProfileCubit>(),
            child: const EditProfileScreen(),
          );
        },
      ),
      GoRoute(
        path: EditPasswordScreen.routePath,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => inject<EditPasswordCubit>(),
            child: const EditPasswordScreen(),
          );
        },
      ),

      // Room routes
      GoRoute(
        path: AddEditRoomScreen.routePath,
        builder: (context, state) {
          final room = state.extra as RoomEntity?;
          return BlocProvider(
            create: (context) => inject<RoomCubit>(),
            child: AddEditRoomScreen(room: room),
          );
        },
      ),
      GoRoute(
        path: RoomDetailScreen.routePath,
        builder: (context, state) {
          final room = state.extra as RoomEntity;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => inject<RoomCubit>()),
              BlocProvider(create: (context) => inject<FavoriteCubit>()),
            ],
            child: RoomDetailScreen(room: room),
          );
        },
      ),

      // Main Entry Point
      GoRoute(
        onExit: _handleDoubleTapToExit,
        path: IndexPage.routePath,
        builder: (context, state) => const IndexPage(),
      ),
    ],
  );

  DateTime? currentBackPressTime;

  Future<bool> _handleDoubleTapToExit(
    BuildContext context,
    GoRouterState state,
  ) async {
    final now = DateTime.now();
    const thresholdInterval = Duration(seconds: 2);

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > thresholdInterval) {
      currentBackPressTime = now;
      _snackShower.info(message: "Press again to exit app");
      return false;
    }

    return true;
  }
}

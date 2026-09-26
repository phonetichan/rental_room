import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/datasource/remote/auth_data_source.dart';
import 'di/di.dart';
import 'presentation/presentation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configureDependencies();

  // Automatically seed master data on app startup
  try {
    await inject<AuthDataSource>().seedInitialData();
  } catch (e) {
    debugPrint('Error seeding master data on startup: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthenticationCubitProvider(
      child: Builder(
        builder: (context) {
          final authCubit = context.read<AuthenticationCubit>();
          return ValueListenableBuilder<ThemeMode>(
            valueListenable: authCubit.themeModeNotifier,
            builder: (context, themeMode, child) {
              // 1. Removed AnimatedTheme wrapper
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: $styles.light,
                darkTheme: $styles.dark,
                themeMode: themeMode,
                // 2. Disables MaterialApp's theme switch animation instantly
                themeAnimationDuration: Duration.zero,
                title: "Rental Room",
                routerConfig: inject<NavigationRouter>().router,
              );
            },
          );
        },
      ),
    );
  }
}
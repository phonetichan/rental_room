import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/injector.dart';
import 'authentication_cubit.dart';

class AuthenticationCubitProvider extends StatelessWidget {
  final Widget child;

  const AuthenticationCubitProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationCubit>(
      create: (_) => inject<AuthenticationCubit>(),
      child: child,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';
import '../../presentation.dart';
import 'widgets/profile_header_card.dart';
import 'widgets/profile_settings_card.dart';
import 'widgets/profile_sign_out_button.dart';

class ProfileView extends StatelessWidget {
  final UserEntity user;

  const ProfileView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        // Resolve the latest user entity from state or fallback to widget.user
        UserEntity currentUser = user;
        if (state is AuthenticationAuthenticated) {
          currentUser = state.user;
        }

        final primaryColor = Theme.of(context).primaryColor;
        final authCubit = context.read<AuthenticationCubit>();
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // PROFILE HEADER CARD
              ProfileHeaderCard(
                currentUser: currentUser,
                primaryColor: primaryColor,
                isDarkMode: isDarkMode,
              ),
              const SizedBox(height: 28),

              // SETTINGS SECTION
              ProfileSettingsCard(
                currentUser: currentUser,
                primaryColor: primaryColor,
                isDarkMode: isDarkMode,
                authCubit: authCubit,
              ),
              const SizedBox(height: 28),

              // SIGN OUT BUTTON
              ProfileSignOutButton(
                onSignOut: () {
                  LogoutModal.show(
                    context,
                    onLogout: () {
                      context.read<AuthenticationCubit>().signOut();
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

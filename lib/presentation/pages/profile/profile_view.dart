import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entity/user_entity.dart';
import '../../../../domain/enum/role.dart';
import '../../blocs/authentication_cubit/authentication_cubit.dart';
import '../../components/modal/logout_modal.dart';
import '../setting_pages/terms_n_conditions.dart';
import '../setting_pages/user_guidance.dart';
import 'edit_password/edit_password.dart';
import 'edit_profile/edit_profile.dart';

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
        final isOwner = currentUser.role == UserRole.owner;
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // PROFILE HEADER CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                  ),
                ),
                child: Column(
                  children: [
                    // PROFILE IMAGE WITH EDIT BADGE
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primaryColor.withValues(alpha: 0.3),
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 46,
                            backgroundColor: primaryColor.withValues(alpha: 0.12),
                            backgroundImage:
                                currentUser.image != null && currentUser.image!.trim().isNotEmpty
                                    ? NetworkImage(currentUser.image!)
                                    : null,
                            child:
                                (currentUser.image == null || currentUser.image!.trim().isEmpty)
                                    ? Icon(
                                        Icons.person_rounded,
                                        size: 50,
                                        color: primaryColor,
                                      )
                                    : null,
                          ),
                        ),
                        Material(
                          color: primaryColor,
                          shape: const CircleBorder(),
                          elevation: 2,
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () => context.push(EditProfileScreen.routePath),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.edit_rounded,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // USER NAME
                    Text(
                      currentUser.name.isNotEmpty ? currentUser.name : 'Rental Room User',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // USER EMAIL
                    Text(
                      currentUser.email,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // ROLE BADGE
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isOwner
                                ? Icons.home_work_rounded
                                : Icons.person_rounded,
                            size: 14,
                            color: primaryColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isOwner ? 'Property Owner' : 'Tenant',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // SETTINGS SECTION HEADER
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Settings & Preferences',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),

              // SETTINGS CARD GROUP
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                  ),
                ),
                color: isDarkMode ? Colors.grey.shade900 : Colors.white,
                child: Column(
                  children: [
                    // 1. THEME SWITCH
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      leading: _SettingIcon(
                        icon: isDarkMode
                            ? Icons.dark_mode_rounded
                            : Icons.light_mode_rounded,
                        color: Colors.purple,
                      ),
                      title: const Text(
                        'Theme',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      subtitle: Text(
                        isDarkMode ? 'Dark Mode' : 'Light Mode',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12.5),
                      ),
                      trailing: Switch(
                        value: isDarkMode,
                        activeThumbColor: primaryColor,
                        onChanged: (val) {
                          authCubit.toggleTheme();
                        },
                      ),
                    ),
                    Divider(
                      height: 1,
                      indent: 64,
                      color: isDarkMode
                          ? Colors.grey.shade800
                          : Colors.grey.shade100,
                    ),

                    // 2. EDIT PROFILE NAVIGATION
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      leading: const _SettingIcon(
                        icon: Icons.person_outline_rounded,
                        color: Colors.blue,
                      ),
                      title: const Text(
                        'Edit Profile',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.grey,
                      ),
                      onTap: () => context.push(EditProfileScreen.routePath),
                    ),
                    Divider(
                      height: 1,
                      indent: 64,
                      color: isDarkMode
                          ? Colors.grey.shade800
                          : Colors.grey.shade100,
                    ),

                    // 3. EDIT PASSWORD NAVIGATION
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      leading: const _SettingIcon(
                        icon: Icons.lock_outline_rounded,
                        color: Colors.indigo,
                      ),
                      title: const Text(
                        'Edit Password',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.grey,
                      ),
                      onTap: () => context.push(EditPasswordScreen.routePath),
                    ),
                    Divider(
                      height: 1,
                      indent: 64,
                      color: isDarkMode
                          ? Colors.grey.shade800
                          : Colors.grey.shade100,
                    ),

                    // 4. TERMS AND CONDITIONS
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      leading: const _SettingIcon(
                        icon: Icons.description_outlined,
                        color: Colors.orange,
                      ),
                      title: const Text(
                        'Terms and Conditions',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        context.push(TermsAndConditionsPage.routePath);
                      },
                    ),
                    Divider(
                      height: 1,
                      indent: 64,
                      color: isDarkMode
                          ? Colors.grey.shade800
                          : Colors.grey.shade100,
                    ),

                    // 5. USER GUIDANCE
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      leading: const _SettingIcon(
                        icon: Icons.help_outline_rounded,
                        color: Colors.teal,
                      ),
                      title: const Text(
                        'User Guidance & Help',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        context.push(UserGuidancePage.routePath);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // SIGN OUT BUTTON
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: Colors.white,
                    overlayColor: Colors.red.shade800,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.logout_rounded, size: 20),
                  label: const Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    LogoutModal.show(
                      context,
                      onLogout: () {
                        context.read<AuthenticationCubit>().signOut();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SettingIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _SettingIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color, size: 22),
    );
  }
}

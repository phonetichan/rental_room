import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entity/user_entity.dart';
import '../../../blocs/authentication_cubit/authentication_cubit.dart';
import '../edit_password/edit_password.dart';
import '../edit_profile/edit_profile.dart';
import '../../setting_pages/terms_n_conditions.dart';
import '../../setting_pages/user_guidance.dart';
import 'setting_icon.dart';

class ProfileSettingsCard extends StatelessWidget {
  final UserEntity currentUser;
  final Color primaryColor;
  final bool isDarkMode;
  final AuthenticationCubit authCubit;

  const ProfileSettingsCard({
    super.key,
    required this.currentUser,
    required this.primaryColor,
    required this.isDarkMode,
    required this.authCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SETTINGS SECTION HEADER
        Text(
          'Settings & Preferences',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
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
                leading: SettingIcon(
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
                leading: const SettingIcon(
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
                leading: const SettingIcon(
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
                leading: const SettingIcon(
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
                leading: const SettingIcon(
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
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entity/user/user_entity.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../blocs/authentication_cubit/authentication_cubit.dart';
import '../edit_location/edit_location.dart';
import '../edit_password/edit_password.dart';
import '../edit_profile/edit_profile.dart';
import '../../setting_pages/terms_n_conditions.dart';
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
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SETTINGS SECTION HEADER
        Text(
          l10n.settingsPreferences,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

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
                title: Text(
                  l10n.theme,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  isDarkMode ? l10n.darkMode : l10n.lightMode,
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
                color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
              ),

              // 2. LANGUAGE SWITCHER
              ValueListenableBuilder<Locale>(
                valueListenable: authCubit.localeNotifier,
                builder: (context, locale, child) {
                  final isMyanmar = locale.languageCode == 'my';
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    leading: const SettingIcon(
                      icon: Icons.language_rounded,
                      color: Colors.green,
                    ),
                    title: Text(
                      l10n.language,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      isMyanmar ? l10n.myanmar : l10n.english,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12.5),
                    ),
                    trailing: DropdownButton<String>(
                      value: isMyanmar ? 'my' : 'en',
                      underline: const SizedBox.shrink(),
                      items: [
                        DropdownMenuItem(
                          value: 'en',
                          child: Text(l10n.english),
                        ),
                        DropdownMenuItem(
                          value: 'my',
                          child: Text(l10n.myanmar),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          authCubit.setLocale(Locale(val));
                        }
                      },
                    ),
                  );
                },
              ),
              Divider(
                height: 1,
                indent: 64,
                color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
              ),

              // 3. EDIT PROFILE
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                leading: const SettingIcon(
                  icon: Icons.person_outline_rounded,
                  color: Colors.blue,
                ),
                title: Text(
                  l10n.editProfile,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
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
                color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
              ),

              // 4. EDIT PASSWORD
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                leading: const SettingIcon(
                  icon: Icons.lock_outline_rounded,
                  color: Colors.indigo,
                ),
                title: Text(
                  l10n.editPassword,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
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
                color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
              ),

              // 5. UPDATE LOCATION
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                leading: const SettingIcon(
                  icon: Icons.location_on_outlined,
                  color: Colors.redAccent,
                ),
                title: Text(
                  l10n.updateLocation,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.grey,
                ),
                onTap: () => context.push(EditLocationScreen.routePath),
              ),
              Divider(
                height: 1,
                indent: 64,
                color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
              ),

              // 6. TERMS AND CONDITIONS
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                leading: const SettingIcon(
                  icon: Icons.description_rounded,
                  color: Colors.orange,
                ),
                title: Text(
                  l10n.termsAndConditions,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.grey,
                ),
                onTap: () => context.push(TermsAndConditionsPage.routePath),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

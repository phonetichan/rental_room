import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/di.dart';
import 'package:rental_room/domain/domain.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:rental_room/presentation/extensions/contract/contract_extensions.dart';
import '../../presentation.dart';
import '../contract/contract_history_page.dart';
import 'widgets/profile_header_card.dart';
import 'widgets/profile_settings_card.dart';
import 'widgets/profile_sign_out_button.dart';
import 'widgets/setting_icon.dart';

class ProfileView extends StatefulWidget {
  final UserEntity user;

  const ProfileView({super.key, required this.user});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int _contractBadgeCount = 0;

  @override
  void initState() {
    super.initState();
    _loadContractCount();
  }

  Future<void> _loadContractCount() async {
    try {
      final repo = inject<ContractRepository>();
      final isOwner = widget.user.role == UserRole.owner;
      final List<ContractEntity> list = isOwner
          ? await repo.getContractsByOwnerId(widget.user.id)
          : await repo.getContractsByTenantId(widget.user.id);
      if (mounted) {
        setState(() {
          _contractBadgeCount = list.where((c) => ContractStatusX(c).countsForBadge).length;
        });
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        UserEntity currentUser = widget.user;
        if (state is AuthenticationAuthenticated) {
          currentUser = state.user;
        }

        final primaryColor = Theme.of(context).primaryColor;
        final authCubit = context.read<AuthenticationCubit>();
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        final l10n = AppLocalizations.of(context)!;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PROFILE HEADER CARD
              Center(
                child: ProfileHeaderCard(
                  currentUser: currentUser,
                  primaryColor: primaryColor,
                  isDarkMode: isDarkMode,
                ),
              ),
              const SizedBox(height: 28),

              // HISTORY SECTION
              Text(
                l10n.history,
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
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  leading: const SettingIcon(
                    icon: Icons.assignment_outlined,
                    color: Colors.teal,
                  ),
                  title: Text(
                    l10n.contractHistory,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_contractBadgeCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '$_contractBadgeCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  onTap: () async {
                    await context.push(
                      ContractHistoryPage.routePath,
                      extra: currentUser,
                    );
                    if (mounted) {
                      _loadContractCount();
                    }
                  },
                ),
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
              Center(
                child: ProfileSignOutButton(
                  onSignOut: () {
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

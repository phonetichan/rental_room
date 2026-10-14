import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_room/domain/domain.dart';
import 'package:rental_room/presentation/extensions/extensions.dart';

import '../../../presentation.dart';
import '../../room/owner/add_edit_room_page.dart';
import '../../room/tenant/saved_rooms_page.dart';

class DashboardHeader extends StatelessWidget {
  final bool isOwner;
  final String? address;
  final UserEntity? user;
  final VoidCallback onLocationPressed;
  final VoidCallback? onCreatePressed;
  final VoidCallback? onSavedRoomsPressed;

  const DashboardHeader({
    super.key,
    required this.isOwner,
    required this.address,
    this.user,
    required this.onLocationPressed,
    this.onCreatePressed,
    this.onSavedRoomsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final l10n = context.l10n;
    final text = address?.trim() ?? '';

    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onLocationPressed,
            borderRadius: BorderRadius.circular(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.location,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,
                      color: primary,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 22, color: primary),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        text.isEmpty ? l10n.selectLocation : text.shortAddress,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          // slightly smaller so 4 lines fit nicely
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (isOwner) ...[
          const SizedBox(width: 12),
          HeaderIconButton(
            icon: Icons.add_rounded,
            onPressed:
                onCreatePressed ??
                () async {
                  await context.push(AddEditRoomScreen.routePath);
                  if (context.mounted) context.read<RoomCubit>().fetchRooms();
                },
          ),
        ] else ...[
          const SizedBox(width: 12),
          SavedRoomsButton(
            onTap:
                onSavedRoomsPressed ??
                () {
                  final targetUser =
                      user ??
                      (context.read<AuthenticationCubit>().state
                              is AuthenticationAuthenticated
                          ? (context.read<AuthenticationCubit>().state
                                  as AuthenticationAuthenticated)
                              .user
                          : context.read<AuthenticationCubit>().user);
                  if (targetUser != null) {
                    context.push(SavedRoomsPage.routePath, extra: targetUser);
                  }
                },
          ),
        ],
      ],
    );
  }
}

class HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const HeaderIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      shape: CircleBorder(
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, size: 22, color: theme.colorScheme.onSurface),
        ),
      ),
    );
  }
}

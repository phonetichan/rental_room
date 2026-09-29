import 'package:flutter/material.dart';
import '../../../../domain/domain.dart';

class DashboardHeader extends StatelessWidget {
  final UserEntity user;
  final bool isOwner;
  final VoidCallback? onAddPressed;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onProfilePressed;
  final int notificationCount;

  const DashboardHeader({
    super.key,
    required this.user,
    required this.isOwner,
    this.onAddPressed,
    this.onNotificationPressed,
    this.onProfilePressed,
    this.notificationCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.primaryColor;
    final textTheme = theme.textTheme;

    // Theme-adaptive color palette
    final textColor = isDark ? Colors.white : theme.colorScheme.onSurface;
    final subtitleColor = isDark
        ? Colors.white60
        : textTheme.bodySmall?.color ?? Colors.grey.shade600;
    final iconBgColor = isDark
        ? Colors.white.withOpacity(0.08)
        : primaryColor.withOpacity(0.08);
    final iconBorderColor = isDark
        ? Colors.white.withOpacity(0.12)
        : primaryColor.withOpacity(0.15);
    final iconColor = isDark ? Colors.white : primaryColor;

    final hasImage = user.image != null && user.image!.trim().isNotEmpty;
    final displayName = user.name.isNotEmpty ? user.name : 'User';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // USER PROFILE AVATAR
          CircleAvatar(
            radius: 22,
            backgroundColor: primaryColor.withOpacity(0.15),
            backgroundImage: hasImage ? NetworkImage(user.image!) : null,
            child: !hasImage
                ? Text(
              displayName[0].toUpperCase(),
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
                : null,
          ),
          const SizedBox(width: 12),

          // NAME & DROPDOWN / EMAIL
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        displayName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleMedium?.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  user.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    color: subtitleColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // ACTION BUTTONS
          Row(
            children: [
              // NOTIFICATION BELL WITH BADGE
              Stack(
                clipBehavior: Clip.none,
                children: [
                  _HeaderIconButton(
                    icon: Icons.notifications_rounded,
                    backgroundColor: iconBgColor,
                    borderColor: iconBorderColor,
                    iconColor: iconColor,
                    onPressed: onNotificationPressed,
                  ),
                  if (notificationCount > 0)
                    Positioned(
                      right: 2,
                      top: 2,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.error,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.scaffoldBackgroundColor,
                            width: 1.5,
                          ),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$notificationCount',
                          style: TextStyle(
                            color: theme.colorScheme.onError,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final VoidCallback? onPressed;

  const _HeaderIconButton({
    required this.icon,
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: iconColor,
          size: 20,
        ),
      ),
    );
  }
}
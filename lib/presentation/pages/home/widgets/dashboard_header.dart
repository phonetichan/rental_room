import 'package:flutter/material.dart';
import '../../../../domain/domain.dart';

class DashboardHeader extends StatelessWidget {
  final UserEntity user;
  final bool isOwner;
  final VoidCallback? onAddPressed;

  const DashboardHeader({
    super.key,
    required this.user,
    required this.isOwner,
    this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasImage = user.image != null && user.image!.trim().isNotEmpty;

    return Card(
      color: isDark ? Colors.grey.shade900 : Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isDark ? Colors.grey.shade800 : primaryColor.withValues(alpha: 0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // USER PROFILE IMAGE
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: primaryColor.withValues(alpha: 0.4),
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 26,
                backgroundColor: primaryColor.withValues(alpha: 0.12),
                backgroundImage: hasImage ? NetworkImage(user.image!) : null,
                child: !hasImage
                    ? Text(
                        user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 14),

            // WELCOME TEXT & EMAIL
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, ${user.name.isNotEmpty ? user.name : "User"}!',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    user.email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                  ),
                ],
              ),
            ),

            // PLUS ICON BUTTON
            IconButton(
              onPressed: onAddPressed ?? () {},
              icon: const Icon(Icons.add_rounded, size: 22),
              style: IconButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              tooltip: isOwner ? 'Add New Listing' : 'Post Requirement',
            ),
          ],
        ),
      ),
    );
  }
}

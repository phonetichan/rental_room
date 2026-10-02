import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entity/user_entity.dart';
import '../../../../domain/enum/role.dart';
import '../edit_profile/edit_profile.dart';

class ProfileHeaderCard extends StatelessWidget {
  final UserEntity currentUser;
  final Color primaryColor;
  final bool isDarkMode;

  const ProfileHeaderCard({
    super.key,
    required this.currentUser,
    required this.primaryColor,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final isOwner = currentUser.role == UserRole.owner;

    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
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
    );
  }
}

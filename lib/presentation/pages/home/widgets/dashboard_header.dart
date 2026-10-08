// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../domain/domain.dart';
// import '../../../presentation.dart';
//
// class DashboardHeader extends StatelessWidget {
//   final UserEntity user;
//   final bool isOwner;
//   final VoidCallback? onProfilePressed;
//   final VoidCallback? onCreatePressed;
//
//   const DashboardHeader({
//     super.key,
//     required this.user,
//     required this.isOwner,
//     this.onProfilePressed,
//     this.onCreatePressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//
//     final hasImage = user.image != null && user.image!.trim().isNotEmpty;
//     final displayName = user.name.isNotEmpty ? user.name : 'User';
//
//     return Container(
//       decoration: BoxDecoration(
//         color: colorScheme.surface,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             children: [
//               if (isOwner) ...[
//                 HeaderIconButton(
//                   icon: Icons.add_rounded,
//                   onPressed: onCreatePressed ?? () async {
//                     await context.push(AddEditRoomScreen.routePath);
//                     if (context.mounted) {
//                       context.read<RoomCubit>().fetchRooms();
//                     }
//                   },
//                 ),
//                 const SizedBox(width: 12),
//               ],
//               // USER PROFILE AVATAR & INFO (TAPABLE AREA)
//               Expanded(
//                 child: InkWell(
//                   onTap: onProfilePressed,
//                   borderRadius: BorderRadius.circular(12),
//                   child: Row(
//                     children: [
//                       // AVATAR WITH OUTER BORDER
//                       Container(
//                         width: 48,
//                         height: 48,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: colorScheme.primary.withValues(alpha: 0.2),
//                             width: 2,
//                           ),
//                         ),
//                         child: CircleAvatar(
//                           radius: 22,
//                           backgroundColor:
//                           colorScheme.primary.withValues(alpha: 0.1),
//                           backgroundImage:
//                           hasImage ? NetworkImage(user.image!) : null,
//                           child: !hasImage
//                               ? Text(
//                             displayName[0].toUpperCase(),
//                             style: TextStyle(
//                               color: colorScheme.primary,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           )
//                               : null,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//
//                       // NAME, ROLE BADGE & EMAIL
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Row(
//                               children: [
//                                 Flexible(
//                                   child: Text(
//                                     displayName,
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: theme.textTheme.titleMedium?.copyWith(
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 6),
//
//                                 // ROLE BADGE (OWNER / TENANT)
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 6,
//                                     vertical: 2,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: isOwner
//                                         ? colorScheme.primary.withValues(alpha: 0.12)
//                                         : colorScheme.secondary.withValues(alpha: 0.12),
//                                     borderRadius: BorderRadius.circular(6),
//                                   ),
//                                   child: Text(
//                                     isOwner ? 'Owner' : 'Tenant',
//                                     style: TextStyle(
//                                       color: isOwner
//                                           ? colorScheme.primary
//                                           : colorScheme.secondary,
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 2),
//                             Text(
//                               user.email,
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: theme.textTheme.bodySmall?.copyWith(
//                                 color: colorScheme.onSurfaceVariant
//                                     .withValues(alpha: 0.8),
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class HeaderIconButton extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onPressed;
//
//   const HeaderIconButton({
//     super.key,
//     required this.icon,
//     required this.onPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Material(
//       color: theme.colorScheme.primary.withValues(alpha: 0.1),
//       borderRadius: BorderRadius.circular(12),
//       child: InkWell(
//         onTap: onPressed,
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Icon(
//             icon,
//             size: 20,
//             color: theme.colorScheme.primary,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../domain/domain.dart';
import '../../../presentation.dart';

class DashboardHeader extends StatelessWidget {
  final UserEntity user;
  final bool isOwner;
  final VoidCallback? onProfilePressed;
  final VoidCallback? onCreatePressed;

  const DashboardHeader({
    super.key,
    required this.user,
    required this.isOwner,
    this.onProfilePressed,
    this.onCreatePressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final hasImage = user.image != null && user.image!.trim().isNotEmpty;
    final displayName = user.name.isNotEmpty ? user.name : 'User';

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // 1. USER PROFILE AVATAR & INFO (LEFT SIDE)
              Expanded(
                child: InkWell(
                  onTap: onProfilePressed,
                  borderRadius: BorderRadius.circular(12),
                  child: Row(
                    children: [
                      // AVATAR WITH OUTER BORDER
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colorScheme.primary.withValues(alpha: 0.2),
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor:
                          colorScheme.primary.withValues(alpha: 0.1),
                          backgroundImage:
                          hasImage ? NetworkImage(user.image!) : null,
                          child: !hasImage
                              ? Text(
                            displayName[0].toUpperCase(),
                            style: TextStyle(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                              : null,
                        ),
                      ),
                      const SizedBox(width: 12),

                      // NAME, ROLE BADGE & EMAIL
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    displayName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),

                                // ROLE BADGE (OWNER / TENANT)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isOwner
                                        ? colorScheme.primary.withValues(alpha: 0.12)
                                        : colorScheme.secondary.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    isOwner ? 'Owner' : 'Tenant',
                                    style: TextStyle(
                                      color: isOwner
                                          ? colorScheme.primary
                                          : colorScheme.secondary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
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
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant
                                    .withValues(alpha: 0.8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 2. CREATE BUTTON (RIGHT SIDE - OWNER ONLY)
              if (isOwner) ...[
                const SizedBox(width: 12),
                HeaderIconButton(
                  icon: Icons.add_rounded,
                  onPressed: onCreatePressed ?? () async {
                    await context.push(AddEditRoomScreen.routePath);
                    if (context.mounted) {
                      context.read<RoomCubit>().fetchRooms();
                    }
                  },
                ),
              ],
            ],
          ),
        ),
      ),
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
      color: theme.colorScheme.primary.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            size: 20,
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

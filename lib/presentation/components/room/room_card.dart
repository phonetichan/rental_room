import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/domain.dart';
import '../../extensions/extensions.dart';
import '../../pages/room/tenant/tenant_room_detail_page.dart';
import '../button/favourite_button.dart';
import '../../presentation.dart';
// import '../../widgets/favorite_button.dart'; // only if not exported by presentation.dart

import 'package:cached_network_image/cached_network_image.dart';

class RoomCard extends StatelessWidget {
  final RoomEntity room;
  final UserEntity currentUser;
  final bool showOwnerActions;
  final VoidCallback? onRoomUpdated;

  const RoomCard({
    super.key,
    required this.room,
    required this.currentUser,
    this.showOwnerActions = false,
    this.onRoomUpdated,
  });

  bool get isOwnerOfRoom => room.ownerId == currentUser.id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Only needed for the owner's "Saves" badge.
    // The tenant bookmark state is handled inside FavoriteButton.
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, favoriteState) {
        final favCount = favoriteState.getFavoriteCount(room.id);

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.2)
                    : colorScheme.shadow.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: isDark
                  ? colorScheme.outlineVariant.withValues(alpha: 0.15)
                  : colorScheme.outlineVariant.withValues(alpha: 0.2),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () async {
                await context.push(
                  TenantRoomDetailScreen.routePath,
                  extra: room,
                );
                onRoomUpdated?.call();
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Thumbnail Image Stack
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: room.images.isNotEmpty
                                ? CachedNetworkImage(
                              imageUrl: room.images.first.imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: isDark
                                    ? const Color(0xFF2A2A2A)
                                    : const Color(0xFFF1F5F9),
                                child: const Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child:
                                    CircularProgressIndicator.adaptive(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  _buildPlaceholderImage(isDark),
                            )
                                : _buildPlaceholderImage(isDark),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Right Content Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row 1: Room Name (Left) & Saved Badge / Bookmark Button (Right)
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      room.name.capitalizeWords,
                                      style:
                                      theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),

                                  // Owner: Display Static Gradient Saved Badge (View-Only)
                                  if (isOwnerOfRoom)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.clrDanger
                                                .withValues(alpha: 0.15),
                                            AppColors.clrDanger
                                                .withValues(alpha: 0.05),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: AppColors.clrDanger
                                              .withValues(alpha: 0.2),
                                          width: 0.8,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.bookmark_rounded,
                                            size: 13,
                                            color: AppColors.clrDanger,
                                          ),
                                          const SizedBox(width: 4),
                                          AnimatedSwitcher(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            transitionBuilder:
                                                (child, animation) {
                                              return ScaleTransition(
                                                scale: animation,
                                                child: FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                ),
                                              );
                                            },
                                            child: Text(
                                              '$favCount ${favCount == 1 ? 'Save' : 'Saves'}',
                                              key: ValueKey<int>(favCount),
                                              style: const TextStyle(
                                                color: AppColors.clrDanger,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 0.2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  // Tenant: shared Bookmark Toggle Button
                                  else
                                    FavoriteButton(
                                      room: room,
                                      userId: currentUser.id,
                                      // style defaults to plain
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),

                              // Row 2: Location Row
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 14,
                                    color: colorScheme.onSurfaceVariant
                                        .withValues(alpha: 0.7),
                                  ),
                                  const SizedBox(width: 2),
                                  Expanded(
                                    child: Text(
                                      room.location.capitalizeWords,
                                      style:
                                      theme.textTheme.bodyMedium?.copyWith(
                                        color: colorScheme.onSurfaceVariant
                                            .withValues(alpha: 0.8),
                                        fontSize: 12,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),

                              // Row 3: Price (Left) & Status Badge (Right)
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Left side: Price
                                  Text(
                                    room.pricePerMonth.toKsFormat,
                                    style:
                                    theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: colorScheme.onSurface,
                                      fontSize: 14,
                                    ),
                                  ),

                                  // Right side: Status Badge (Available / Rented)
                                  _buildStatusBadge(room.status),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Status Badge Helper Widget
  Widget _buildStatusBadge(String status) {
    final isAvailable = status.toLowerCase() == 'available';
    final badgeColor = isAvailable ? AppColors.clrSuccess : AppColors.clrGrey;
    final textColor = isAvailable ? AppColors.clrSuccess : AppColors.clrDarkGrey;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage(bool isDark) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF1F5F9),
      child: Center(
        child: Icon(
          Icons.apartment_rounded,
          size: 38,
          color: isDark ? Colors.grey[700] : Colors.grey[400],
        ),
      ),
    );
  }
}
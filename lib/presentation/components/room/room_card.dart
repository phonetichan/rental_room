import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../data/services/snack_shower.dart';
import '../../../di/di.dart';
import '../../../domain/domain.dart';
import '../../extensions/extensions.dart';
import '../../presentation.dart';

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

    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, favoriteState) {
        final isFav = favoriteState.isFavorite(room.id);
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
                        Stack(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: room.images.isNotEmpty
                                    ? Image.network(
                                        room.images.first.imageUrl,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Container(
                                            color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF1F5F9),
                                            child: Center(
                                              child: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator.adaptive(
                                                  strokeWidth: 2,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) => _buildPlaceholderImage(isDark),
                                      )
                                    : _buildPlaceholderImage(isDark),
                              ),
                            ),
                            // Bookmark / Save Action Button on top of Image
                            Positioned(
                              top: 6,
                              right: 6,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    if (isOwnerOfRoom) {
                                      inject<ISnackShower>().error(
                                        context: context,
                                        message:
                                            'You cannot save your own room.',
                                      );
                                      return;
                                    }
                                    context
                                        .read<FavoriteCubit>()
                                        .toggleFavorite(
                                          roomId: room.id,
                                          userId: currentUser.id,
                                          ownerId: room.ownerId,
                                        );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(
                                        alpha: 0.4,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      isFav
                                          ? Icons.bookmark_rounded
                                          : Icons.bookmark_border_rounded,
                                      color: isFav
                                          ? const Color(0xFFEF4444)
                                          : Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),

                        // Right Content Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Room Title
                              Text(
                                room.name.capitalizeWords,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),

                              // Location Row
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
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
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

                              // Bottom Row: Price & Rating/Badge
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Price
                                  Text(
                                    '${room.pricePerMonth.toKsFormat}',
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: colorScheme.onSurface,
                                          fontSize: 14,
                                        ),
                                  ),

                                  // Saved Count Pill Badge (Owner only) or Status Badge (Tenant)
                                  if (isOwnerOfRoom)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? AppColors.clrWhite.withValues(alpha: 0.08)
                                            : AppColors.clrSoftGrey.withValues(alpha: 0.5),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.bookmark_rounded,
                                            size: 14,
                                            color: AppColors.clrDanger,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '$favCount Saved',
                                            style: TextStyle(
                                              color: isDark ? AppColors.clrWhite : AppColors.clrBlack,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  else
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: (room.status == 'available'
                                            ? AppColors.clrSuccess
                                            : AppColors.clrGrey)
                                            .withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        room.status.toUpperCase(),
                                        style: TextStyle(
                                          color: room.status == 'available'
                                              ? AppColors.clrSuccess
                                              : AppColors.clrDarkGrey,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
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

  Widget _buildPlaceholderImage(bool isDark) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF1F5F9),
      child: Center(
        child: Icon(
          Icons.apartment_rounded,
          size: 28,
          color: isDark ? Colors.grey[700] : Colors.grey[400],
        ),
      ),
    );
  }
}

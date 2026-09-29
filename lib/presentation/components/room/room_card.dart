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
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.2)
                    : colorScheme.shadow.withValues(alpha: 0.06),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: isDark
                  ? colorScheme.outlineVariant.withValues(alpha: 0.15)
                  : colorScheme.outlineVariant.withValues(alpha: 0.3),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () async {
                await context.push(RoomDetailScreen.routePath, extra: room);
                onRoomUpdated?.call();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. IMAGE & OVERLAYS
                  Stack(
                    children: [
                      // Room Image
                      AspectRatio(
                        aspectRatio: 16 / 10,
                        child: room.images.isNotEmpty
                            ? Image.network(
                          room.images.first.imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildPlaceholderImage(isDark),
                        )
                            : _buildPlaceholderImage(isDark),
                      ),

                      // Status Badge (Top-Left Pill)
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: (room.status == 'available'
                                ? AppColors.clrPrimary // Emerald green (#12B76A)
                                : AppColors.clrGrey)
                                .withValues(alpha: 0.95),
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            room.status.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ),
                      ),

                      // Favorite Glassmorphic Button (Top-Right)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              if (isOwnerOfRoom) {
                                inject<ISnackShower>().error(
                                  context: context,
                                  message: 'You cannot favorite your own room.',
                                );
                                return;
                              }
                              context.read<FavoriteCubit>().toggleFavorite(
                                roomId: room.id,
                                userId: currentUser.id,
                                ownerId: room.ownerId,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.35),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isFav
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    color: isFav
                                        ? const Color(0xFFEF4444)
                                        : Colors.white,
                                    size: 18,
                                  ),
                                  if (favCount > 0) ...[
                                    const SizedBox(width: 4),
                                    Text(
                                      '$favCount',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // 2. CARD CONTENT
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Price & Title Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                room.name,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 12),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: room.pricePerMonth.toKsFormat,
                                    style:
                                    theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: colorScheme.primary,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        // Location Row
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 15,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                room.location,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                        ),
                        const SizedBox(height: 12),

                        // Metric Icons Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildSpecItem(
                              context,
                              icon: Icons.bed_outlined,
                              label: '${room.numberBedrooms} Beds',
                            ),
                            _buildDotDivider(colorScheme),
                            _buildSpecItem(
                              context,
                              icon: Icons.person_outline,
                              label: '${room.maxGuests} Guests',
                            ),
                            _buildDotDivider(colorScheme),
                            _buildSpecItem(
                              context,
                              icon: Icons.square_foot_outlined,
                              label:
                              '${room.roomSqft.toStringAsFixed(0)} sqft',
                            ),
                            _buildDotDivider(colorScheme),
                            _buildSpecItem(
                              context,
                              icon: Icons.layers_outlined,
                              label: 'Fl. ${room.floor}',
                            ),
                          ],
                        ),

                        // --- Added Description Section ---
                        if (room.description != null &&
                            room.description!.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text(
                            room.description!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                              height: 1.4, // Improved readability
                            ),
                            maxLines: 2, // Limit text to keep card compact
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        // ---------------------------------

                        // 3. OWNER ACTIONS SECTION
                        if (isOwnerOfRoom && showOwnerActions) ...[
                          const SizedBox(height: 14),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerHighest
                                  .withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.favorite_rounded,
                                  size: 16,
                                  color: Color(0xFFEF4444),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '$favCount ${favCount == 1 ? 'User Favorited' : 'Users Favorited'}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // --- Helper Widgets ---

  Widget _buildPlaceholderImage(bool isDark) {
    return Container(
      width: double.infinity,
      color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF1F5F9),
      child: Center(
        child: Icon(
          Icons.apartment_rounded,
          size: 48,
          color: isDark ? Colors.grey[700] : Colors.grey[400],
        ),
      ),
    );
  }

  Widget _buildSpecItem(BuildContext context,
      {required IconData icon, required String label}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildDotDivider(ColorScheme colorScheme) {
    return Container(
      width: 3,
      height: 3,
      decoration: BoxDecoration(
        color: colorScheme.outlineVariant,
        shape: BoxShape.circle,
      ),
    );
  }
}
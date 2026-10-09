
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/domain.dart';
import '../../../extensions/number.dart';
import '../../../presentation.dart';
import '../../room/tenant/tenant_room_detail_page.dart';
/// Static Promo Banner Widget
class StaticPromoCard extends StatelessWidget {
  final String title;
  final String expirationText;
  final String imageAssetPath;

  const StaticPromoCard({
    super.key,
    required this.title,
    required this.expirationText,
    required this.imageAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        color: const Color(0xFF432C81),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: 0,
              bottom: 0,
              width: 150,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFCB021),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    bottomLeft: Radius.circular(100),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          expirationText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      imageAssetPath,
                      height: 110,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.apartment_rounded,
                            size: 56,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Skeleton Loader placeholder matching both sections
/// Skeleton Loader placeholder matching all sections
class DashboardSkeletonLoader extends StatelessWidget {
  const DashboardSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final baseColor = isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade300;
    final highlightColor =
    isDark ? const Color(0xFF383838) : Colors.grey.shade100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Categories: title (no "See all", like the real section) ──
        Container(
          width: 110,
          height: 24,
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 104, // same as _CategoryList
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: baseColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 56,
                    height: 10,
                    decoration: BoxDecoration(
                      color: baseColor.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // ── Recommended: title + "See all" ──
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 130,
              height: 24,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            Container(
              width: 60,
              height: 16,
              decoration: BoxDecoration(
                color: baseColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (_, index) => Container(
              width: 240,
              decoration: BoxDecoration(
                color: index == 0 ? baseColor : highlightColor,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // ── Mini Condo: title + "See all" + vertical cards ──
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 110,
              height: 24,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            Container(
              width: 60,
              height: 16,
              decoration: BoxDecoration(
                color: baseColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, __) => Container(
            height: 96,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}

/// Custom Card Matching Design Mockup with Integrated Favorite/Save Logic
class RecommendedRoomCard extends StatefulWidget {
  final RoomEntity room;
  final UserEntity currentUser;
  final VoidCallback? onRoomUpdated;

  const RecommendedRoomCard({
    super.key,
    required this.room,
    required this.currentUser,
    this.onRoomUpdated,
  });

  @override
  State<RecommendedRoomCard> createState() => _RecommendedRoomCardState();
}

class _RecommendedRoomCardState extends State<RecommendedRoomCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentUser = context.read<AuthenticationCubit>().user;
      if (currentUser != null && mounted) {
        context.read<FavoriteCubit>().loadFavorites(currentUser.id);
        try {
          context.read<BookingCubit>().fetchBookings(
            currentUser.id,
            userId: currentUser.id,
          );
        } catch (_) {}
      }
    });
  }

  String? _getRoomImageUrl(RoomEntity room) {
    if (room.images.isEmpty) return null;
    final firstImg = room.images.first;
    try {
      dynamic img = firstImg;
      final String? url = img.imageUrl ?? img.url ?? img.imagePath ?? img.path;
      if (url != null && url.isNotEmpty) return url;
    } catch (_) {}
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.room.name;
    final String location = widget.room.location;
    final formattedPrice = widget.room.pricePerMonth.toKsLabelFormat;

    final String? imageUrl = _getRoomImageUrl(widget.room);

    return GestureDetector(
      onTap: () async {
        await context.push(
          TenantRoomDetailScreen.routePath,
          extra: widget.room,
        );
        widget.onRoomUpdated?.call();
      },
      child: Container(
        width: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.grey.shade300,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Positioned.fill(
                child: imageUrl != null && imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey.shade300,
                    child: const Icon(
                      Icons.apartment,
                      size: 48,
                      color: Colors.grey,
                    ),
                  ),
                )
                    : Container(
                  color: Colors.grey.shade300,
                  child: const Icon(
                    Icons.apartment,
                    size: 48,
                    color: Colors.grey,
                  ),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.75),
                      ],
                      stops: const [0.4, 0.7, 1.0],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'sans-serif',
                      ),
                      children: [
                        TextSpan(
                          text: formattedPrice,
                          style: const TextStyle(
                            color: Color(0xFF6C5CE7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: '/month',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 14,
                right: 14,
                bottom: 14,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Colors.white70,
                                size: 13,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  location,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    FavoriteButton(
                      room: widget.room,
                      userId: widget.currentUser.id,
                      style: FavoriteButtonStyle.onPhoto,
                      onToggled: widget.onRoomUpdated,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

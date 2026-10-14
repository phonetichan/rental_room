import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';
import '../../../components/components.dart';
import '../../../extensions/l10n/l10n.dart';
import '../../../extensions/color/string.dart';
import '../../../styles/colors.dart';
import 'full_screen_image_viewer.dart';

/// Hero header container with carousel slider, floating actions, gradient overlay, and floating metric info.
/// Used by both Owner and Tenant room detail screens.
class RoomHeroHeader extends StatefulWidget {
  final RoomEntity room;
  final List<RoomImageEntity> images;
  final UserEntity? currentUser; // decides owner vs tenant
  final Widget? ownerAction; // optional top-right widget for the owner (e.g. edit/delete icon)
  final VoidCallback? onBackPressed;

  const RoomHeroHeader({
    super.key,
    required this.room,
    this.images = const [],
    this.currentUser,
    this.ownerAction,
    this.onBackPressed,
  });

  @override
  State<RoomHeroHeader> createState() => _RoomHeroHeaderState();
}

class _RoomHeroHeaderState extends State<RoomHeroHeader> {
  int _currentPage = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void didUpdateWidget(covariant RoomHeroHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.images.length != widget.images.length) {
      if (_currentPage >= widget.images.length) {
        setState(() => _currentPage = 0);
        if (_pageController.hasClients) {
          _pageController.jumpToPage(0);
        }
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _openFullScreenViewer(int initialIndex) {
    if (widget.images.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FullScreenImageViewer(
          images: widget.images,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  /// Owner -> ownerAction. Tenant -> shared FavoriteButton.
  Widget? _buildTopRightAction() {
    final user = widget.currentUser;
    if (user == null) return widget.ownerAction;

    if (widget.room.ownerId == user.id) return widget.ownerAction;

    return FavoriteButton(
      room: widget.room,
      userId: user.id,
      style: FavoriteButtonStyle.floating,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final images = widget.images;
    final topRightAction = _buildTopRightAction();
    final l10n = context.l10n;

    return Stack(
      children: [
        // 1. Image Carousel
        SizedBox(
          height: 320,
          width: double.infinity,
          child: images.isNotEmpty
              ? PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _openFullScreenViewer(index),
                      child: CachedNetworkImage(
                        imageUrl: images[index].imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 320,
                        memCacheWidth: 1080,
                        placeholder: (context, url) => Container(
                          color: isDark
                              ? Colors.grey.shade900
                              : Colors.grey.shade200,
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: isDark
                              ? Colors.grey.shade900
                              : Colors.grey.shade200,
                          child: const Icon(
                            Icons.broken_image_rounded,
                            size: 50,
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  color: isDark
                      ? const Color(0xFF1E1E1E)
                      : Colors.grey.shade300,
                  child: Center(
                    child: Icon(
                      Icons.hotel_rounded,
                      size: 80,
                      color: isDark
                          ? Colors.grey.shade700
                          : Colors.grey.shade400,
                    ),
                  ),
                ),
        ),

        // 2. Bottom Gradient Overlay
        Positioned.fill(
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.35),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.2),
                    Colors.black.withValues(alpha: 0.85),
                  ],
                  stops: const [0.0, 0.25, 0.6, 1.0],
                ),
              ),
            ),
          ),
        ),

        // 3. Page Indicator
        if (images.length > 1)
          Positioned(
            top: 250,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${_currentPage + 1}/${images.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

        // 4. Floating Top Actions Bar
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingCircleButton(
                icon: Icons.arrow_back_rounded,
                onPressed: widget.onBackPressed ??
                    () => Navigator.of(context).maybePop(),
              ),
              ?topRightAction,
            ],
          ),
        ),

        // 5. Floating Bottom Info inside Image Card
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: IgnorePointer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.room.name.capitalizeWords,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black54, blurRadius: 6)],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      color: AppColors.clrWhite,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        widget.room.location.capitalizeWords,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.clrWhite,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      HeroMetricBadge(
                        icon: Icons.king_bed_outlined,
                        label: l10n.beds(widget.room.numberBedrooms),
                      ),
                      const SizedBox(width: 8),
                      HeroMetricBadge(
                        icon: Icons.group_outlined,
                        label: l10n.guests(widget.room.maxGuests),
                      ),
                      const SizedBox(width: 8),
                      HeroMetricBadge(
                        icon: Icons.straighten_outlined,
                        label: l10n.sqft(
                          widget.room.roomSqft.toStringAsFixed(0),
                        ),
                      ),
                      const SizedBox(width: 8),
                      HeroMetricBadge(
                        icon: Icons.layers_outlined,
                        label: l10n.floorShort(widget.room.floor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class HeroMetricBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const HeroMetricBadge({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.35),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class FloatingCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? iconColor;

  const FloatingCircleButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: iconColor ?? Colors.white, size: 22),
        onPressed: onPressed,
      ),
    );
  }
}

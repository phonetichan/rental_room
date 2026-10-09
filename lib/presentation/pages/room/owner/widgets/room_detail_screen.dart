import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:rental_room/data/data.dart';

import '../../../../../di/injector.dart';
import '../../../../../domain/domain.dart';
import '../../../../components/components.dart';
import '../../../../extensions/string.dart';
import '../../../../styles/colors.dart';

/// Hero header container with carousel slider, floating actions, gradient overlay, and floating metric info
class RoomHeroHeader extends StatefulWidget {
  final RoomEntity room;
  final List<RoomImageEntity> images;
  final UserEntity? currentUser; // decides owner vs tenant
  final Widget?
  ownerAction; // optional top-right widget for the owner (e.g. edit icon)
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

  /// Owner -> ownerAction (or nothing). Tenant -> shared FavoriteButton.
  /// Owner -> ownerAction. Tenant -> shared FavoriteButton.
  Widget? _buildTopRightAction() {
    final user = widget.currentUser;
    if (user == null) return widget.ownerAction; // was: return null

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

        // 3. Page Indicator Dots
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
                onPressed:
                    widget.onBackPressed ??
                    () => Navigator.of(context).maybePop(),
              ),
              if (topRightAction != null) topRightAction,
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
                        label: '${widget.room.numberBedrooms} Beds',
                      ),
                      const SizedBox(width: 8),
                      HeroMetricBadge(
                        icon: Icons.group_outlined,
                        label: '${widget.room.maxGuests} Guests',
                      ),
                      const SizedBox(width: 8),
                      HeroMetricBadge(
                        icon: Icons.straighten_outlined,
                        label:
                            '${widget.room.roomSqft.toStringAsFixed(0)} sqft',
                      ),
                      const SizedBox(width: 8),
                      HeroMetricBadge(
                        icon: Icons.layers_outlined,
                        label: 'Fl. ${widget.room.floor}',
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

// ==========================================
// Sub-Components for Hero Header
// ==========================================

class RoomVisitorStatsCard extends StatefulWidget {
  final String roomId;

  const RoomVisitorStatsCard({super.key, required this.roomId});

  @override
  State<RoomVisitorStatsCard> createState() => _RoomVisitorStatsCardState();
}

class _RoomVisitorStatsCardState extends State<RoomVisitorStatsCard> {
  int _visitorCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVisitorCount();
  }

  @override
  void didUpdateWidget(covariant RoomVisitorStatsCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.roomId != widget.roomId) {
      _loadVisitorCount();
    }
  }

  Future<void> _loadVisitorCount() async {
    try {
      final getVisitorCount = inject<GetRoomVisitorCountUseCase>();
      final result = await getVisitorCount(widget.roomId);
      result.onSuccess((count) {
        if (mounted) {
          setState(() {
            _visitorCount = count;
            _isLoading = false;
          });
        }
      });
    } catch (_) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF1E293B) : Colors.blue.shade50;
    final borderColor = isDark ? const Color(0xFF334155) : Colors.blue.shade200;
    final iconColor = isDark ? const Color(0xFF60A5FA) : Colors.blue.shade700;
    final titleColor = isDark ? Colors.white : Colors.blue.shade900;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.blue.shade700;

    final countText = _isLoading ? '...' : '$_visitorCount';
    final visitorText = _visitorCount == 1 ? 'Visitor' : 'Visitors';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.visibility_rounded, color: iconColor, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isLoading
                      ? 'Loading visitor stats...'
                      : '$countText $visitorText Viewed This Room',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Track view engagement and interest for this property listing.',
                  style: TextStyle(fontSize: 12, color: subtitleColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Legacy alias for backward compatibility
typedef RoomVisitorBadge = RoomVisitorStatsCard;

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

// ==========================================
// 2. FullScreenImageViewer (Zoom & Swipe Conflict Resolved)
// ==========================================

class FullScreenImageViewer extends StatefulWidget {
  final List<RoomImageEntity> images;
  final int initialIndex;

  const FullScreenImageViewer({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late final PageController _pageController;
  late final TransformationController _transformationController;
  late int _currentIndex;
  bool _isZoomed = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  void _onScaleChanged() {
    final scale = _transformationController.value.getMaxScaleOnAxis();
    if (scale > 1.05 && !_isZoomed) {
      setState(() => _isZoomed = true);
    } else if (scale <= 1.05 && _isZoomed) {
      setState(() => _isZoomed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            physics: _isZoomed
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
                _isZoomed = false;
              });
              _transformationController.value = Matrix4.identity();
            },
            itemBuilder: (context, index) {
              return InteractiveViewer(
                transformationController: _transformationController,
                minScale: 1.0,
                maxScale: 4.0,
                onInteractionUpdate: (_) => _onScaleChanged(),
                onInteractionEnd: (_) => _onScaleChanged(),
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: widget.images[index].imageUrl,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    ),
                    errorWidget: (_, __, ___) => const Center(
                      child: Icon(
                        Icons.broken_image_rounded,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: topPadding + 16,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.black.withValues(alpha: 0.5),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          Positioned(
            top: topPadding + 24,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '${_currentIndex + 1} / ${widget.images.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 3. RoomSectionCard
// ==========================================

class RoomSectionCard extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final List<Widget> children;

  const RoomSectionCard({
    super.key,
    this.title,
    this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasTitle = title != null && title!.isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasTitle) ...[
            Row(
              children: [
                if (icon != null) ...[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: theme.primaryColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                ],
                Text(
                  title!,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          ...children,
        ],
      ),
    );
  }
}

// ==========================================
// 4. RoomCollapsibleDescriptionSection
// ==========================================

class RoomCollapsibleDescriptionSection extends StatefulWidget {
  final String? description;

  const RoomCollapsibleDescriptionSection({super.key, this.description});

  @override
  State<RoomCollapsibleDescriptionSection> createState() =>
      _RoomCollapsibleDescriptionSectionState();
}

class _RoomCollapsibleDescriptionSectionState
    extends State<RoomCollapsibleDescriptionSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final text = widget.description?.trim();
    final hasText = text != null && text.isNotEmpty;

    return RoomSectionCard(
      title: 'Description',
      icon: Icons.description_outlined,
      children: [
        Text(
          hasText ? text : 'No description provided for this room.',
          maxLines: _isExpanded ? null : 3,
          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14,
            color: hasText
                ? (isDark ? Colors.grey.shade300 : Colors.grey.shade700)
                : (isDark ? Colors.grey.shade500 : Colors.grey.shade400),
            height: 1.5,
          ),
        ),
        if (hasText && text.length > 100) ...[
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _isExpanded ? 'Show Less' : 'Show More',
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: theme.primaryColor,
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

// ==========================================
// 5. RoomOwnerInfoTile
// ==========================================

class RoomOwnerInfoTile extends StatefulWidget {
  final String? ownerId;
  final UserModel? owner;

  const RoomOwnerInfoTile({super.key, this.ownerId, this.owner});

  @override
  State<RoomOwnerInfoTile> createState() => _RoomOwnerInfoTileState();
}

class _RoomOwnerInfoTileState extends State<RoomOwnerInfoTile> {
  Future<UserModel?>? _ownerFuture;
  UserModel? _cachedOwner;

  bool _isValidId(String? id) {
    if (id == null) return false;
    final trimmed = id.trim();
    return trimmed.isNotEmpty && trimmed != 'null' && trimmed != 'UNDEFINED';
  }

  String? get _cleanOwnerId {
    if (!_isValidId(widget.ownerId)) return null;
    return widget.ownerId!.trim();
  }

  @override
  void initState() {
    super.initState();
    _cachedOwner = widget.owner;
    if (_cachedOwner == null) {
      _initOwnerFuture();
    }
  }

  @override
  void didUpdateWidget(covariant RoomOwnerInfoTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.owner != oldWidget.owner) {
      setState(() {
        _cachedOwner = widget.owner;
      });
    }

    final oldCleanId = _isValidId(oldWidget.ownerId)
        ? oldWidget.ownerId!.trim()
        : null;
    final newCleanId = _cleanOwnerId;

    if (_cachedOwner == null && oldCleanId != newCleanId) {
      _initOwnerFuture();
    }
  }

  void _initOwnerFuture() {
    final cleanId = _cleanOwnerId;
    if (cleanId != null) {
      _ownerFuture = inject<AuthDataSource>().getUserById(cleanId);
    } else {
      _ownerFuture = null;
    }
  }

  Future<void> _makeCall(BuildContext context, String phone) async {
    final uri = Uri.parse('tel:$phone');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch call for $phone')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error making call: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cleanId = _cleanOwnerId;
    if (cleanId == null && widget.owner == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    if (_cachedOwner != null) {
      return _buildOwnerCard(context, _cachedOwner!, primaryColor, theme);
    }

    return FutureBuilder<UserModel?>(
      future: _ownerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildPlaceholder();
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const SizedBox.shrink();
        }

        return _buildOwnerCard(context, snapshot.data!, primaryColor, theme);
      },
    );
  }

  Widget _buildOwnerCard(
    BuildContext context,
    UserModel user,
    Color primaryColor,
    ThemeData theme,
  ) {
    final displayName = user.name.isNotEmpty ? user.name : 'Property Host';
    final phone = user.phoneNumber;

    return RoomSectionCard(
      children: [
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.person_rounded,
                  color: primaryColor,
                  size: 26,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    displayName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    (phone != null && phone.isNotEmpty) ? phone : 'Owner',
                    style: TextStyle(
                      color:
                          theme.textTheme.bodySmall?.color ?? Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            if (phone != null && phone.isNotEmpty)
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFF81D4FA),
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.phone_rounded, size: 20),
                onPressed: () => _makeCall(context, phone),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return RoomSectionCard(
      children: [
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 120,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 80,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
class RoomAmenitiesSection extends StatelessWidget {
  final List<String> amenityIds;
  final List<Map<String, dynamic>> amenitiesList;

  const RoomAmenitiesSection({
    super.key,
    required this.amenityIds,
    required this.amenitiesList,
  });

  @override
  Widget build(BuildContext context) {
    if (amenityIds.isEmpty) return const SizedBox.shrink();

    final primaryColor = Theme.of(context).primaryColor;

    return RoomSectionCard(
      title: 'Amenities',
      icon: Icons.star_outline,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: amenityIds.toSet().toList().map((amenityId) {
            final matching = amenitiesList
                .where((a) => a['id'] == amenityId)
                .firstOrNull;
            final name = matching != null
                ? (matching['name'] as String)
                : amenityId
                      .replaceAll('amenity_', '')
                      .replaceAll('_', ' ')
                      .toUpperCase();
            final iconName = matching != null
                ? ((matching['icon'] as String?) ?? 'help_outline')
                : amenityId.replaceFirst('amenity_', '');
            final icon = inject<AuthDataSource>().getAmenityIcon(iconName);

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: primaryColor.withValues(alpha: 0.3)),
                color: primaryColor.withValues(alpha: 0.05),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Prevents font bounding-box clipping and centers glyph
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: Center(
                      child: Transform.translate(
                        offset: const Offset(0, 1),
                        // Adjust vertical offset if font glyph is top-heavy
                        child: Icon(icon, size: 16, color: primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
// ==========================================
// 7. RoomLocationMapSection
// ==========================================

class RoomLocationMapSection extends StatelessWidget {
  final RoomEntity room;

  const RoomLocationMapSection({super.key, required this.room});

  Future<void> _openGoogleMaps(BuildContext context) async {
    final String query = (room.latitude != null && room.longitude != null)
        ? '${room.latitude},${room.longitude}'
        : Uri.encodeComponent(room.location);

    final googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$query',
    );
    final geoUrl = (room.latitude != null && room.longitude != null)
        ? Uri.parse(
            'geo:${room.latitude},${room.longitude}?q=${room.latitude},${room.longitude}(${Uri.encodeComponent(room.name)})',
          )
        : googleMapsUrl;

    try {
      if (await canLaunchUrl(geoUrl)) {
        await launchUrl(geoUrl, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error opening map: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final colorScheme = Theme.of(context).colorScheme;

    return RoomSectionCard(
      title: 'Location Map',
      icon: Icons.map_outlined,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _openGoogleMaps(context),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: primaryColor.withValues(alpha: 0.25),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          primaryColor.withValues(alpha: 0.2),
                          primaryColor.withValues(alpha: 0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          right: -20,
                          bottom: -20,
                          child: Icon(
                            Icons.map_rounded,
                            size: 140,
                            color: primaryColor.withValues(alpha: 0.1),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: primaryColor,
                              size: 40,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              room.name.capitalizeWords,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (room.latitude != null &&
                                  room.longitude != null) ...[
                                Text(
                                  'Lat: ${room.latitude}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Lng: ${room.longitude}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ] else ...[
                                Text(
                                  room.location.isNotEmpty
                                      ? room.location.capitalizeWords
                                      : 'Location coordinates not provided',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.directions_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Open Map',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

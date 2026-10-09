import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';
import '../../blocs/blocs.dart';
import '../../styles/colors.dart';


enum FavoriteButtonStyle {
  plain,    // no circle (RoomCard)
  onPhoto,  // white circle (RecommendedRoomCard)
  floating, // dark translucent circle (room detail hero header)
}

class FavoriteButton extends StatelessWidget {
  static const double iconSize = 18;     // one icon size for the whole project
  static const double circleSize = 38;   // circle styles
  static const double plainTapSize = 28; // plain style: no circle, just a tap area

  final RoomEntity room;
  final String userId;
  final FavoriteButtonStyle style;
  final VoidCallback? onToggled;

  const FavoriteButton({
    super.key,
    required this.room,
    required this.userId,
    this.style = FavoriteButtonStyle.plain,
    this.onToggled,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final Color? background;
    final Color inactiveColor;
    final double boxSize;

    switch (style) {
      case FavoriteButtonStyle.plain:
        background = null;
        inactiveColor = cs.onSurfaceVariant.withValues(alpha: 0.7);
        boxSize = plainTapSize;
        break;
      case FavoriteButtonStyle.onPhoto:
        background = Colors.white;
        inactiveColor = Colors.black87;
        boxSize = circleSize;
        break;
      case FavoriteButtonStyle.floating:
        background = Colors.black.withValues(alpha: 0.45);
        inactiveColor = Colors.white;
        boxSize = circleSize;
        break;
    }

    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final isFav = state.isFavorite(room.id);

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            context.read<FavoriteCubit>().toggleFavorite(
              userId: userId,
              roomId: room.id,
              ownerId: room.ownerId,
            );
            onToggled?.call();
          },
          child: Container(
            width: boxSize,
            height: boxSize,
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isFav ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              size: iconSize,
              color: isFav ? const Color(0xFFEF4444) : inactiveColor,
            ),
          ),
        );
      },
    );
  }
}
/// Opens the Saved rooms page and shows a live count badge.
class SavedRoomsButton extends StatelessWidget {
  static const double size = 52;

  final VoidCallback onTap;

  const SavedRoomsButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.clrDarkCard : AppColors.clrWhite;
    final iconColor = isDark ? Colors.white70 : AppColors.clrBlack;

    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final count = state.userFavoriteRoomIds.length;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(size / 2),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(size / 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.bookmark_rounded,
                  color: iconColor,
                  size: FavoriteButton.iconSize, // same size as every favourite icon
                ),
              ),
            ),
            if (count > 0)
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                  decoration: const BoxDecoration(
                    color: AppColors.clrRed,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$count',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.clrWhite,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

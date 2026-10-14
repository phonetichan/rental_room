import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/blocs.dart';
import '../../../../extensions/l10n/l10n.dart';

/// Card showing how many tenants favorited this room for the room owner.
class OwnerRoomFavoriteStatsCard extends StatelessWidget {
  final String roomId;

  const OwnerRoomFavoriteStatsCard({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, favoriteState) {
        final favCount = favoriteState.getFavoriteCount(roomId);
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Row(
            children: [
              Icon(
                Icons.favorite_rounded,
                color: Colors.red.shade600,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        l10n.userFavoritedRoom(favCount),
                        key: ValueKey<int>(favCount),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade900,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.trackEngagement,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../di/injector.dart';
import '../../../../../domain/domain.dart';
import '../../../../extensions/l10n/l10n.dart';

/// Card displaying visitor/views count stats for room owner.
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
    final l10n = context.l10n;

    final bgColor = isDark ? const Color(0xFF1E293B) : Colors.blue.shade50;
    final borderColor = isDark ? const Color(0xFF334155) : Colors.blue.shade200;
    final iconColor = isDark ? const Color(0xFF60A5FA) : Colors.blue.shade700;
    final titleColor = isDark ? Colors.white : Colors.blue.shade900;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.blue.shade700;

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
                      ? l10n.loadingVisitorStats
                      : l10n.visitorViewed(_visitorCount),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.visitorTrackText,
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

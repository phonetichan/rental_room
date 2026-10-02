import 'package:flutter/material.dart';

import '../../../../di/di.dart';
import '../../../../domain/domain.dart';

class AnimatedVisitorCounterCard extends StatefulWidget {
  final bool isVisited;
  final String? roomId;
  final int? count;

  const AnimatedVisitorCounterCard({
    super.key,
    required this.isVisited,
    this.roomId,
    this.count,
  });

  @override
  State<AnimatedVisitorCounterCard> createState() =>
      _AnimatedVisitorCounterCardState();
}

class _AnimatedVisitorCounterCardState
    extends State<AnimatedVisitorCounterCard> {
  int _baseCount = 0;
  late bool _initialIsVisited;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initialIsVisited = widget.isVisited;
    _fetchBaseCount();
  }

  @override
  void didUpdateWidget(covariant AnimatedVisitorCounterCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.roomId != widget.roomId || oldWidget.count != widget.count) {
      _initialIsVisited = widget.isVisited;
      _fetchBaseCount();
    }
  }

  Future<void> _fetchBaseCount() async {
    if (widget.count != null) {
      if (mounted) {
        setState(() {
          _baseCount = widget.count!;
          _isLoading = false;
        });
      }
      return;
    }

    final roomId = widget.roomId;
    if (roomId != null && roomId.isNotEmpty) {
      setState(() => _isLoading = true);
      try {
        final getVisitorCount = inject<GetRoomVisitorCountUseCase>();
        final result = await getVisitorCount(roomId);
        result.onSuccess((c) {
          if (mounted) {
            setState(() {
              _baseCount = c;
              _isLoading = false;
            });
          }
        });
      } catch (_) {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    } else {
      if (mounted) {
        setState(() {
          _baseCount = 0;
          _isLoading = false;
        });
      }
    }
  }

  int get _computedDisplayCount {
    if (widget.isVisited == _initialIsVisited) {
      return _baseCount;
    } else if (widget.isVisited) {
      return _baseCount + 1;
    } else {
      return _baseCount > 0 ? _baseCount - 1 : 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardBackground = theme.cardColor;
    final primaryAccent = theme.colorScheme.primary;
    final textPrimary =
        theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;
    final textSecondary =
        theme.textTheme.bodySmall?.color ?? theme.colorScheme.onSurfaceVariant;
    final borderColor = theme.dividerColor;

    final displayCount = _computedDisplayCount;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primaryAccent.withAlpha(35),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.people_alt_rounded,
              color: primaryAccent,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Room Inspections / Visits',
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Count of unique room visitors',
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: animation,
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: Container(
              key: ValueKey<int>(displayCount),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: displayCount > 0
                    ? Colors.green.withAlpha(40)
                    : Colors.grey.withAlpha(40),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: displayCount > 0 ? Colors.green : Colors.grey,
                ),
              ),
              child: Text(
                _isLoading
                    ? '...'
                    : '$displayCount ${displayCount == 1 ? "Visitor" : "Visitors"}',
                style: TextStyle(
                  color: displayCount > 0 ? Colors.green : textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../extensions/l10n/l10n.dart';
import 'room_section_card.dart';

/// Collapsible description section widget.
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
    final l10n = context.l10n;
    final text = widget.description?.trim();
    final hasText = text != null && text.isNotEmpty;

    return RoomSectionCard(
      title: l10n.description,
      icon: Icons.description_outlined,
      children: [
        Text(
          hasText ? text : l10n.noDescription,
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
                  _isExpanded ? l10n.showLess : l10n.showMore,
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

import 'package:flutter/material.dart';

import '../../../../data/data.dart';
import '../../../../di/injector.dart';
import '../../../extensions/l10n/l10n.dart';
import '../../../extensions/number/phone.dart';
import 'room_section_card.dart';

/// Property Host / Owner profile info tile.
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
    final l10n = context.l10n;
    final displayName = user.name.isNotEmpty ? user.name : l10n.propertyHost;
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
                    phone.isNotEmpty ? phone : l10n.owner,
                    style: TextStyle(
                      color:
                          theme.textTheme.bodySmall?.color ?? Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            if (phone.isNotEmpty)
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFF81D4FA),
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.phone_rounded, size: 20),
                onPressed: () => phone.makeCall(context: context),
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

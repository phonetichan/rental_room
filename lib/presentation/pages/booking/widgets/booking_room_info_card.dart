import 'package:flutter/material.dart';

import '../../../../data/data.dart';
import '../../../../domain/domain.dart';
import '../../../extensions/extensions.dart';
import '../../../styles/colors.dart';

class BookingRoomInfoCard extends StatelessWidget {
  final BookingEntity? booking;
  final RoomEntity? room;
  final UserEntity currentUser;
  final Future<UserModel?>? ownerFuture;
  final ValueChanged<String> onMakeCall;

  const BookingRoomInfoCard({
    super.key,
    this.booking,
    this.room,
    required this.currentUser,
    this.ownerFuture,
    required this.onMakeCall,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardBackground = theme.cardColor;
    final primaryAccent = theme.colorScheme.primary;
    final textPrimary = theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;
    final textSecondary = theme.textTheme.bodySmall?.color ?? theme.colorScheme.onSurfaceVariant;
    final borderColor = theme.dividerColor;

    final isOwner = currentUser.role == UserRole.owner;
    final status = booking?.status ?? 'draft';
    final roomName =
        (booking?.roomName ?? room?.name ?? 'Room Details').capitalizeWords;
    final roomId = booking?.roomId ?? room?.id ?? '';
    final roomPrice = booking?.roomPrice ?? room?.pricePerMonth;
    final imageUrl = booking?.roomImageUrl ??
        (room?.images.isNotEmpty == true ? room?.images.first.imageUrl : null);
    final location = room?.location;

    return Container(
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null && imageUrl.isNotEmpty)
            Image.network(
              imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        roomId.isNotEmpty && roomName == 'Room Details'
                            ? 'Room #${roomId.length > 6 ? roomId.substring(0, 6) : roomId}'
                            : roomName,
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(status).withAlpha(38),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          color: _getStatusColor(status),
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                if (location != null && location.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          color: textSecondary, size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                            color: textSecondary,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 8),
                if (roomPrice != null)
                  Text(
                    '${roomPrice.toStringAsFixed(0)} MMK / month',
                    style: TextStyle(
                      color: primaryAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: borderColor, height: 1),
                ),
                if (isOwner && booking?.tenantName != null)
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: theme.disabledColor.withOpacity(0.2),
                        child:
                            Icon(Icons.person, color: textPrimary, size: 18),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tenant: ${booking!.tenantName!}',
                              style: TextStyle(
                                  color: textPrimary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              booking!.tenantPhone ?? 'No phone provided',
                              style: TextStyle(
                                  color: textSecondary, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (!isOwner)
                  FutureBuilder<UserModel?>(
                    future: ownerFuture,
                    builder: (context, snapshot) {
                      final owner = snapshot.data;
                      final ownerName = owner?.name ?? 'Property Owner';
                      final ownerPhone = owner?.phoneNumber ?? 'N/A';

                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: theme.disabledColor.withOpacity(0.2),
                            child: Icon(Icons.real_estate_agent,
                                color: textPrimary, size: 18),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Owner: $ownerName',
                                  style: TextStyle(
                                      color: textPrimary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Phone: $ownerPhone',
                                  style: TextStyle(
                                      color: textSecondary, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          if (owner?.phoneNumber != null &&
                              owner!.phoneNumber!.isNotEmpty)
                            IconButton(
                              icon: Icon(Icons.phone,
                                  color: primaryAccent, size: 20),
                              onPressed: () => onMakeCall(owner.phoneNumber!),
                            ),
                        ],
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'success':
        return AppColors.clrPrimary;
      case 'pending':
        return Colors.amber.shade700;
      case 'cancelled':
        return Colors.red.shade700;
      case 'draft':
      default:
        return Colors.grey;
    }
  }
}

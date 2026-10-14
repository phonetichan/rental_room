import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../styles/colors.dart';
import '../../../extensions/number/number.dart';

class BookingPropertyHeaderCard extends StatelessWidget {
  final String roomName;
  final String? roomImageUrl;
  final double price;
  final int favCount;

  const BookingPropertyHeaderCard({
    super.key,
    required this.roomName,
    this.roomImageUrl,
    required this.price,
    required this.favCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedPrice = price.toKsLabelFormat;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.clrWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.clrSoftGrey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: roomImageUrl != null && roomImageUrl!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: roomImageUrl!,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 90,
                      height: 90,
                      color: AppColors.clrSofterGrey,
                      child: const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 90,
                      height: 90,
                      color: AppColors.clrSofterGrey,
                      child: Icon(
                        Icons.apartment_rounded,
                        size: 36,
                        color: AppColors.clrGrey,
                      ),
                    ),
                  )
                : Container(
                    width: 90,
                    height: 90,
                    color: AppColors.clrSofterGrey,
                    child: Icon(
                      Icons.apartment_rounded,
                      size: 36,
                      color: AppColors.clrGrey,
                    ),
                  ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roomName.isNotEmpty ? roomName : 'Property Name',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.clrBlack,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: AppColors.clrGrey,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Location Address',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.clrGrey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$formattedPrice/month',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.clrBlack,
                      ),
                    ),
                    Text(
                      '$favCount ${favCount == 1 ? 'Save' : 'Saves'}',
                      key: ValueKey<int>(favCount),
                      style: TextStyle(
                        color: theme.colorScheme.error,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

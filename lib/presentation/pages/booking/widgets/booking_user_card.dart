import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../styles/colors.dart';

class BookingUserCard extends StatelessWidget {
  final String title;
  final String userName;
  final String? userImage;
  final String phoneNumber;
  final IconData icon;
  final VoidCallback? onCallPressed;

  const BookingUserCard({
    super.key,
    required this.title,
    required this.userName,
    this.userImage,
    required this.phoneNumber,
    required this.icon,
    this.onCallPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.clrBlack,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
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
                borderRadius: BorderRadius.circular(50),
                child: userImage != null && userImage!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: userImage!,
                        width: 52,
                        height: 52,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 52,
                          height: 52,
                          color: const Color(0xFFF3EDF7),
                          child: const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                            ),
                          ),
                        ),
                        errorWidget: (_, __, ___) => _buildDefaultAvatar(),
                      )
                    : _buildDefaultAvatar(),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.clrBlack,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      phoneNumber.isNotEmpty ? phoneNumber : 'No phone provided',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.clrDarkGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (phoneNumber.isNotEmpty && onCallPressed != null)
                IconButton(
                  onPressed: onCallPressed,
                  icon: const Icon(
                    Icons.phone_outlined,
                    color: Color(0xFF7B51D3),
                  ),
                  tooltip: 'Call $userName',
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      width: 52,
      height: 52,
      color: const Color(0xFFF3EDF7),
      child: const Icon(
        Icons.person_rounded,
        color: Color(0xFF7B51D3),
        size: 28,
      ),
    );
  }
}

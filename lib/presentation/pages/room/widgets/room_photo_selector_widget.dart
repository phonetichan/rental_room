import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../domain/entity/room_image_entity.dart';

class RoomPhotoSelectorWidget extends StatelessWidget {
  final List<RoomImageEntity> existingImages;
  final List<XFile> selectedImages;
  final bool isSubmitting;
  final VoidCallback onPickImages;
  final ValueChanged<int> onRemoveExistingImage;
  final ValueChanged<int> onRemoveSelectedImage;

  const RoomPhotoSelectorWidget({
    super.key,
    required this.existingImages,
    required this.selectedImages,
    required this.isSubmitting,
    required this.onPickImages,
    required this.onRemoveExistingImage,
    required this.onRemoveSelectedImage,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          InkWell(
            onTap: isSubmitting ? null : onPickImages,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: primaryColor.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo_outlined, color: primaryColor, size: 28),
                  const SizedBox(height: 6),
                  Text(
                    'Add Photos',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Existing Images
          ...existingImages.asMap().entries.map((entry) {
            final index = entry.key;
            final img = entry.value;

            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      img.imageUrl,
                      width: 100,
                      height: 110,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: GestureDetector(
                      onTap: isSubmitting ? null : () => onRemoveExistingImage(index),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          // Newly Selected Images
          ...selectedImages.asMap().entries.map((entry) {
            final index = entry.key;
            final file = entry.value;

            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(file.path),
                      width: 100,
                      height: 110,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: GestureDetector(
                      onTap: isSubmitting ? null : () => onRemoveSelectedImage(index),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../domain/domain.dart';
import 'room_photo_selector_widget.dart';

class AddEditRoomPhotosStep extends StatelessWidget {
  final List<RoomImageEntity> existingImages;
  final List<XFile> selectedImages;
  final bool isSubmitting;
  final VoidCallback onPickImages;
  final ValueChanged<int> onRemoveExistingImage;
  final ValueChanged<int> onRemoveSelectedImage;

  const AddEditRoomPhotosStep({
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
    return Column(
      key: const ValueKey(2),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RoomPhotoSelectorWidget(
          existingImages: existingImages,
          selectedImages: selectedImages,
          isSubmitting: isSubmitting,
          onPickImages: onPickImages,
          onRemoveExistingImage: onRemoveExistingImage,
          onRemoveSelectedImage: onRemoveSelectedImage,
        ),
      ],
    );
  }
}

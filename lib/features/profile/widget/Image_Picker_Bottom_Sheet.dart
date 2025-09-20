import 'package:flutter/material.dart';

import '../../../core/widget/custom_button.dart';
class ImagePickerBottomSheet extends StatelessWidget {
  final Future<void> Function() onPickFromGallery;
  final Future<void> Function() onPickFromCamera;

  const ImagePickerBottomSheet({
    super.key,
    required this.onPickFromGallery,
    required this.onPickFromCamera,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      child: Wrap(
        children: [
          CustomButton(
            name: "Upload from gallery",
            onTap: () async {
              await onPickFromGallery();
              Navigator.pop(context); // يقفل البوتوم شيت بعد الاختيار
            },
          ),
          const SizedBox(height: 14),
          CustomButton(
            name: "Capture pic",
            onTap: () async {
              await onPickFromCamera();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

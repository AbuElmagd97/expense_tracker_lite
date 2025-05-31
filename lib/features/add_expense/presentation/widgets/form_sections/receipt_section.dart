import 'package:flutter/material.dart';
import 'dart:io';
import '../../../../../core/widgets/section_label.dart';
import '../inputs/receipt_upload_field.dart';

class ReceiptSection extends StatelessWidget {
  final Function(File?)? onImagePicked;
  final File? selectedImage;

  const ReceiptSection({
    super.key,
    this.onImagePicked,
    this.selectedImage,
  });

  Future<void> _pickImage(BuildContext context) async {
    // In a real app, you would use image_picker package
    // For demonstration, we'll simulate image selection
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image picker would open here')),
    );

    // Simulate image selection
    // onImagePicked?.call(pickedFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(text: 'Attach Receipt'),
        const SizedBox(height: 12),
        ReceiptUploadField(
          onTap: () => _pickImage(context),
          selectedImage: selectedImage,
        ),
      ],
    );
  }
}
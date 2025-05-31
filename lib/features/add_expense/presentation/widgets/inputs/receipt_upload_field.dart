import 'package:flutter/material.dart';
import 'dart:io';

class ReceiptUploadField extends StatelessWidget {
  final VoidCallback? onTap;
  final File? selectedImage;
  final String? placeholder;
  final IconData? icon;

  const ReceiptUploadField({
    super.key,
    this.onTap,
    this.selectedImage,
    this.placeholder,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: selectedImage != null ? 120 : 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: selectedImage != null
            ? _buildImagePreview()
            : _buildUploadPlaceholder(),
      ),
    );
  }

  Widget _buildImagePreview() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            selectedImage!,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () {
              // Handle remove image
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadPlaceholder() {
    return Row(
      children: [
        const SizedBox(width: 16),
        Text(
          placeholder ?? 'Upload Receipt',
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
        const Spacer(),
        Icon(icon ?? Icons.camera_alt, color: Colors.grey),
        const SizedBox(width: 12),
      ],
    );
  }
}
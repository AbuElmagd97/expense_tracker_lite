import 'package:flutter/material.dart';

class DateInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  final String? hintText;
  final IconData? suffixIcon;

  const DateInputField({
    super.key,
    required this.controller,
    required this.onTap,
    this.hintText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: InputBorder.none,
          suffixIcon: Icon(
            suffixIcon ?? Icons.calendar_today,
            color: Colors.grey,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a date';
          }
          return null;
        },
      ),
    );
  }
}
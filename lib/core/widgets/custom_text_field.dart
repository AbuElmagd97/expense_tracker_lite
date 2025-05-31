import 'package:flutter/material.dart';
import '../theming/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? toggleVisibility;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.obscureText = false,
    this.toggleVisibility,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8,),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            labelText: label,
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined),
              onPressed: toggleVisibility,
            )
                : null,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: AppColors.fieldBackground,
            filled: true,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/helpers/validator.dart';
import '../../../../core/widgets/custom_text_field.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggleVisibility;

  const PasswordField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: 'Password',
      controller: controller,
      isPassword: true,
      obscureText: obscureText,
      toggleVisibility: onToggleVisibility,
      validator: AppValidator.validatePassword,
    );
  }
}

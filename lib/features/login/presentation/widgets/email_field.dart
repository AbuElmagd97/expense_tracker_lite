import 'package:flutter/material.dart';

import '../../../../core/helpers/validator.dart';
import '../../../../core/widgets/custom_text_field.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: 'Email',
      controller: controller,
      validator: AppValidator.validateEmail,
    );
  }
}

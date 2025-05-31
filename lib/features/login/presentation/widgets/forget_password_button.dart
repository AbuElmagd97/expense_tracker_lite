import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // TODO: Handle forget password
        },
        child: const Text(
          'Forget Password',
          style: TextStyle(color: AppColors.primary),
        ),
      ),
    );
  }
}

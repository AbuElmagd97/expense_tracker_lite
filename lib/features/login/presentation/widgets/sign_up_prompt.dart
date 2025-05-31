import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';

class SignUpPrompt extends StatelessWidget {
  const SignUpPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {},
        child: RichText(
          text: const TextSpan(
            text: "Didn't have an account? ",
            style: TextStyle(color: AppColors.greyText),
            children: [
              TextSpan(
                text: "Sign Up",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

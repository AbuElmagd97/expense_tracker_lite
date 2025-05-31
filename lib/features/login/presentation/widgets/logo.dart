import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Expenset.',
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
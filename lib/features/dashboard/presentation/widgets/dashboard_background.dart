import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';

class DashboardBackground extends StatelessWidget {
  const DashboardBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
    );
  }
}
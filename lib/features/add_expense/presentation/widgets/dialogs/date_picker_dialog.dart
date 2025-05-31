import 'package:flutter/material.dart';
import '../../../../../core/theming/app_colors.dart';

class CustomDatePickerDialog {
  static Future<DateTime?> show(
      BuildContext context, {
        required DateTime initialDate,
        DateTime? firstDate,
        DateTime? lastDate,
      }) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(2020),
      lastDate: lastDate ?? DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
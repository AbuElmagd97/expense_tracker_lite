import 'package:flutter/material.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        displayLarge: AppTextStyle.heading,
        titleLarge: AppTextStyle.subheading,
        bodyMedium: AppTextStyle.body,
        bodySmall: AppTextStyle.small,
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3366FF)),
      useMaterial3: true,
    );
  }
}

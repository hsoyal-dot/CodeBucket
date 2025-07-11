import 'package:flutter/material.dart';
import 'package:leetsave/core/themes/app_sizes.dart' show AppSizes;
import 'package:leetsave/core/themes/app_textstyle.dart' show AppTextStyles1;
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors1.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors1.primary,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      headlineLarge: AppTextStyles1.section,
      bodyMedium: AppTextStyles1.body,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors1.background,
      foregroundColor: AppColors1.text,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors1.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        ),
      ),
    ),
  );
}

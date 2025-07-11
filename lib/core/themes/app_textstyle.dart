import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static final TextStyle section = GoogleFonts.quicksand(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );
  static final TextStyle headingLarge = GoogleFonts.cinzel(
    fontSize: 128,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static final TextStyle heading = GoogleFonts.quicksand(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static final TextStyle body = GoogleFonts.quicksand(
    fontSize: 16,
    color: AppColors.text,
  );

  static final TextStyle redButton = GoogleFonts.quicksand(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    backgroundColor: AppColors.danger,
  );
  static final TextStyle continueButton = GoogleFonts.quicksand(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    backgroundColor: AppColors.primary,
  );
}

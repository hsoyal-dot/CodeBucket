import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles1 {
  static final TextStyle headingLarge = GoogleFonts.cinzel(
    fontSize: 92,
    fontWeight: FontWeight.bold,
    color: AppColors1.text,
  );

  static final TextStyle section = GoogleFonts.quicksand(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors1.text,
  );

  static final TextStyle appBarStyle = GoogleFonts.quicksand(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors1.surface,
  );

  static final TextStyle heading = GoogleFonts.quicksand(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors1.text,
  );

  static final TextStyle body = GoogleFonts.quicksand(
    fontSize: 16,
    color: AppColors1.text,
  );

  static final TextStyle redTextStyle = GoogleFonts.quicksand(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    backgroundColor: AppColors1.danger,
  );

  static final TextStyle greenTextStyle = GoogleFonts.quicksand(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    backgroundColor: AppColors1.success,
  );

  static final TextStyle normalTextStyle = GoogleFonts.quicksand(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    backgroundColor: AppColors1.primary,
  );

  static final ButtonStyle elevButtonRed = ElevatedButton.styleFrom(
    backgroundColor: AppColors1.danger,
    foregroundColor: AppColors1.background,
    side: BorderSide(color: AppColors1.danger),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7),
    ),
  );

  static final ButtonStyle elevButtonSuccess = ElevatedButton.styleFrom(
    backgroundColor: AppColors1.success,
    foregroundColor: AppColors1.background,
    side: BorderSide(color: AppColors1.success),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7),
    ),
  );

  static final ButtonStyle elevButtonNormal = ElevatedButton.styleFrom(
    backgroundColor: AppColors1.primary,
    foregroundColor: AppColors1.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7),
    ),
  );

  static final ButtonStyle elevButtonOppNormal = ElevatedButton.styleFrom(
    backgroundColor: AppColors1.background,
    foregroundColor: AppColors1.primary,
    side: BorderSide(color: AppColors1.primary),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7),
    ),
  );
}

// Second theme styles (under development)
class AppTextStyles2 {
  static final TextStyle headingLarge = GoogleFonts.cinzel(
    fontSize: 102,
    fontWeight: FontWeight.bold,
    color: AppColors2.primary,
  );

  static final TextStyle section = GoogleFonts.quicksand(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors2.text,
  );

  static final TextStyle appBarStyle = GoogleFonts.quicksand(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors2.text,
  );

  static final TextStyle heading = GoogleFonts.quicksand(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors2.text,
  );

  static final TextStyle body = GoogleFonts.quicksand(
    fontSize: 16,
    color: AppColors2.text,
  );

  static final TextStyle redButton = GoogleFonts.quicksand(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    backgroundColor: AppColors2.danger,
  );

  static final TextStyle continueButton = GoogleFonts.quicksand(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    backgroundColor: AppColors2.primary,
  );
}

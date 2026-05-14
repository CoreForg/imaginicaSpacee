import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.accent,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        secondary: AppColors.accentPurple,
        surface: AppColors.surface,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.inter(color: AppColors.primaryText, fontWeight: FontWeight.w800),
        displayMedium: GoogleFonts.inter(color: AppColors.primaryText, fontWeight: FontWeight.bold),
        displaySmall: GoogleFonts.inter(color: AppColors.primaryText, fontWeight: FontWeight.w600),
        headlineLarge: GoogleFonts.inter(color: AppColors.primaryText, fontWeight: FontWeight.w700),
        headlineMedium: GoogleFonts.inter(color: AppColors.primaryText, fontWeight: FontWeight.w600),
        bodyLarge: GoogleFonts.inter(color: AppColors.secondaryText, height: 1.6),
        bodyMedium: GoogleFonts.inter(color: AppColors.secondaryText, height: 1.5),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceHighlight,
        contentTextStyle: GoogleFonts.inter(color: AppColors.primaryText),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

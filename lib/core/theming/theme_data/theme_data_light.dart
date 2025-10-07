import 'package:flutter/material.dart';
import 'package:glow_up_app/core/theming/app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_button_theme.dart';
import '../text_style.dart';

ThemeData getLightTheme(){
  return ThemeData(
    brightness: Brightness.light,

    // الألوان الأساسية
    primaryColor: AppColors.lightText,
    scaffoldBackgroundColor: AppColors.lightBackground,

    colorScheme: ColorScheme.light(
      primary: AppColors.lightText,
      primaryContainer: AppColors.lightPrimaryVariant,
      secondary: AppColors.lightSecondary,
      secondaryContainer: AppColors.lightSecondary.withOpacity(0.2),
      surface: AppColors.lightSurface,
      surfaceContainer: AppColors.lightTextSecondary,
      background: AppColors.lightBackground,
      error: AppColors.lightError,
      onPrimary: AppColors.lightOnPrimary,
      onSecondary: AppColors.lightOnSecondary,
      onSurface: AppColors.lightOnSurface,
      onBackground: AppColors.lightOnBackground,
      onError: Colors.red,
      brightness: Brightness.light,
    ),
    fontFamily: AppFont.Montserrat,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.lightText,
      ),
      displayMedium: GoogleFonts.montserrat(
    textStyle: TextStyle(
    fontSize: 27,
      fontWeight: FontWeight.bold,
    ),
  ),
      displaySmall: GoogleFonts.montserrat(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.lightText,
      ),

      headlineSmall: GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.lightText,
      ),
      titleLarge: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.lightText,
      ),

      titleSmall: GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.lightText,
      ),
      bodyLarge: GoogleFonts.montserrat(
        fontSize: 19,
        fontWeight: FontWeight.normal,
        color: AppColors.lightText,
      ),
      bodyMedium: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.lightText,
      ),
      bodySmall: GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.lightTextSecondary,
      ),
    ),


  cardTheme: CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    color: AppColors.lightSurface,
    shadowColor: Colors.black.withOpacity(0.1),
  ),

  // Button Themes
  elevatedButtonTheme: ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
  backgroundColor: AppColors.lightPrimary,
  foregroundColor: Colors.white,
  elevation: 2,
  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(12),
  ),
  textStyle: GoogleFonts.cairo(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  ),
  ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
  foregroundColor: AppColors.lightPrimary,
  side: BorderSide(color: AppColors.lightPrimary, width: 2),
  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(12),
  ),
  textStyle: GoogleFonts.cairo(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  ),
  ),
  ),

  textButtonTheme: TextButtonThemeData(
  style: TextButton.styleFrom(
  foregroundColor: AppColors.lightPrimary,
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  textStyle: GoogleFonts.cairo(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  ),
  ),
  ),

  // Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
  filled: true,
  fillColor: AppColors.lightSurface,
  border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: BorderSide(color: Colors.grey[300]!),
  ),
  enabledBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: BorderSide(color: Colors.grey[300]!),
  ),
  focusedBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: BorderSide(color: AppColors.lightPrimary, width: 2),
  ),
  errorBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: BorderSide(color: AppColors.lightError, width: 2),
  ),
  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  hintStyle: GoogleFonts.cairo(
  color: AppColors.lightTextSecondary,
  fontSize: 14,
  ),
  ),

  // Icon Theme
  iconTheme: IconThemeData(
  color: AppColors.lightText,
  size: 24,
  ),

  // Divider Theme
  dividerTheme: DividerThemeData(
  color: Colors.grey[300],
  thickness: 1,
  ),
  );


}

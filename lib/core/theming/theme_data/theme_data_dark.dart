import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_color.dart';


  // Dark Theme
   ThemeData? getDarkTheme() {
    final base = ThemeData.dark();
    return base.copyWith(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.darkPrimary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: ColorScheme.dark(
        primary: AppColors.darkPrimary,
        primaryContainer: AppColors.darkPrimaryVariant,
        secondary: AppColors.darkSecondary,
        secondaryContainer: AppColors.darkSecondary.withOpacity(0.2),
        surface: AppColors.darkSurface,
        background: AppColors.darkBackground,
        error: AppColors.darkError,
        surfaceVariant: AppColors.darkGray200,
        onPrimary: AppColors.darkOnPrimary,
        onSecondary: AppColors.darkOnSecondary,
        onSurface: AppColors.darkOnSurface,
        onBackground: AppColors.darkOnBackground,
        onError: Colors.white,
        outline: AppColors.darkGray400,
        // للـ borders
        outlineVariant: AppColors.darkGray300,
      ),
      textTheme: _buildDarkTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.darkText,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkPrimary,
          foregroundColor: AppColors.darkOnPrimary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkGray100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.darkGray300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.darkPrimary, width: 2),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ).copyWith(
    );

}
TextTheme _buildDarkTextTheme() {
return GoogleFonts.montserratTextTheme().copyWith(
displayLarge: GoogleFonts.montserrat(
fontSize: 32.sp,
fontWeight: FontWeight.w700,
color: AppColors.darkText,
),
displayMedium: GoogleFonts.montserrat(
fontSize: 28.sp,
fontWeight: FontWeight.w700,
color: AppColors.darkText,
),
displaySmall: GoogleFonts.montserrat(
fontSize: 22.sp,
fontWeight: FontWeight.w600,
color: AppColors.darkText,
),
headlineLarge: GoogleFonts.montserrat(
fontSize: 18.sp,
fontWeight: FontWeight.w600,
color: AppColors.darkText,
),
titleLarge: GoogleFonts.montserrat(
fontSize: 16.sp,
fontWeight: FontWeight.w600,
color: AppColors.darkText,
),
titleMedium: GoogleFonts.montserrat(
fontSize: 14.sp,
fontWeight: FontWeight.w500,
color: AppColors.darkText,
),
titleSmall: GoogleFonts.montserrat(
fontSize: 12.sp,
fontWeight: FontWeight.w500,
color: AppColors.darkTextSecondary,
),
bodyLarge: GoogleFonts.montserrat(
fontSize: 16.sp,
fontWeight: FontWeight.w400,
color: AppColors.darkText,
),
bodyMedium: GoogleFonts.montserrat(
fontSize: 14.sp,
fontWeight: FontWeight.w400,
color: AppColors.darkText,
),
bodySmall: GoogleFonts.montserrat(
fontSize: 12.sp,
fontWeight: FontWeight.w400,
color: AppColors.darkTextSecondary,
),
labelLarge: GoogleFonts.montserrat(
fontSize: 14.sp,
fontWeight: FontWeight.w500,
color: AppColors.darkText,
),
);
}
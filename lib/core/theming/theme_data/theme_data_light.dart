import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_color.dart';

ThemeData getLightTheme() {
final base = ThemeData.light();
return base.copyWith(
useMaterial3: true,
brightness: Brightness.light,
primaryColor: AppColors.lightPrimary,
scaffoldBackgroundColor: AppColors.lightBackground,
colorScheme: ColorScheme.light(
primary: AppColors.lightPrimary,
primaryContainer: AppColors.lightPrimaryVariant,
secondary: AppColors.lightSecondary,
secondaryContainer: AppColors.lightSecondary.withOpacity(0.2),
surface: AppColors.lightSurface,
background: AppColors.lightBackground,
error: AppColors.lightError,
surfaceVariant: AppColors.gray200,
onPrimary: AppColors.lightOnPrimary,
onSecondary: AppColors.lightOnSecondary,
onBackground: AppColors.lightOnBackground,
onError: Colors.white,
outline: AppColors.gray400,
outlineVariant: AppColors.gray300,
),
textTheme: _buildLightTextTheme(),
appBarTheme: AppBarTheme(
backgroundColor: AppColors.lightSurface,
foregroundColor: AppColors.lightText,
elevation: 0,
),
elevatedButtonTheme: ElevatedButtonThemeData(
style: ElevatedButton.styleFrom(
backgroundColor: AppColors.lightPrimary,
foregroundColor: AppColors.lightOnPrimary,
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
),
),
inputDecorationTheme: InputDecorationTheme(
filled: true,
fillColor: AppColors.gray50,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(12),
borderSide: BorderSide(color: AppColors.gray300),
),
focusedBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(12),
borderSide: BorderSide(color: AppColors.lightPrimary, width: 2),
),
),
cardTheme: CardThemeData(
color: AppColors.lightSurface,
elevation: 2,
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
));
} TextTheme _buildLightTextTheme() {
return GoogleFonts.montserratTextTheme().copyWith(

displayLarge: GoogleFonts.montserrat(
fontSize: 32.sp,
fontWeight: FontWeight.w700,
color: AppColors.lightText,
),
displayMedium: GoogleFonts.montserrat(
fontSize: 27.sp,
fontWeight: FontWeight.w700,
color: AppColors.lightText,
),
displaySmall: GoogleFonts.montserrat(
fontSize: 22.sp,
fontWeight: FontWeight.w700,
color: AppColors.lightText,
),
headlineLarge: GoogleFonts.montserrat(
fontSize: 18.sp,
fontWeight: FontWeight.w600,
color: AppColors.lightText,
),
titleLarge: GoogleFonts.montserrat(
fontSize: 16.sp,
fontWeight: FontWeight.w600,
color: AppColors.lightText,
),
titleMedium: GoogleFonts.montserrat(
fontSize: 14.sp,
fontWeight: FontWeight.w500,
color: AppColors.lightText,
),
titleSmall: GoogleFonts.montserrat(
fontSize: 12.sp,
fontWeight: FontWeight.w500,
color: AppColors.lightTextSecondary,
),
bodyLarge: GoogleFonts.montserrat(
fontSize: 16.sp,
fontWeight: FontWeight.w400,
color: AppColors.lightText,
),
bodyMedium: GoogleFonts.montserrat(
fontSize: 14.sp,
fontWeight: FontWeight.w400,
color: AppColors.lightText,
),
bodySmall: GoogleFonts.montserrat(
fontSize: 12.sp,
fontWeight: FontWeight.w400,
color: AppColors.lightTextSecondary,
),
labelLarge: GoogleFonts.montserrat(
fontSize: 14.sp,
fontWeight: FontWeight.w500,
color: AppColors.lightText,
),
);

}
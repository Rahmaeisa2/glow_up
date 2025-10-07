import 'package:flutter/material.dart';
import '../app_color.dart';
import '../text_style.dart';

extension CustomButtonTheme on ThemeData {
  ButtonStyle get customButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: AppColors.lightSecondary,
    foregroundColor: AppColors.lightSurface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: AppColors.lightOnSurface),
    ),
  );
}

import 'dart:ui';

// lib/core/theme/app_colors.dart
class AppColors {
  AppColors._();

  // Light Theme Colors
  static const Color lightPrimaryVariant = Color(0xFF4F46E5);
  static const Color lightSecondary = Color(0xFFFFA726); // Orange
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightError = Color(0xFFEF4444);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnSecondary = Color(0xFF000000);
  static const Color lightOnBackground = Color(0xFF1F2937);
  static const Color lightPrimary = Color(0xFF1F2937);
  static const Color lightText = Color(0xFF34485E);
  static const Color lightTextSecondary = Color(0xFF6B7280);

  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFF818CF8);
  static const Color darkPrimaryVariant = Color(0xFF6366F1);
  static const Color darkSecondary = Color(0xFFFFB74D);
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkError = Color(0xFFF87171);
  static const Color darkOnPrimary = Color(0xFF000000);
  static const Color darkOnSecondary = Color(0xFF000000);
  static const Color darkOnBackground = Color(0xFFF1F5F9);
  static const Color darkOnSurface = Color(0xFFF1F5F9);
  static const Color darkText = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFF94A3B8);

  // درجات الرمادي المطلوبة (Gray Scale)
  // Light Grays
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE5E5E5);
  static const Color gray400 = Color(0xFFCCCCCC);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);

  // Dark Grays (للـ Dark Mode)
  static const Color darkGray100 = Color(0xFF1F2937);  // رمادي فاتح في الدارك
  static const Color darkGray200 = Color(0xFF374151);
  static const Color darkGray300 = Color(0xFF4B5563);
  static const Color darkGray400 = Color(0xFF6B7280);
  static const Color darkGray500 = Color(0xFF9CA3AF);
  static const Color darkGray600 = Color(0xFFD1D5DB);
  static const Color darkGray700 = Color(0xFFF3F4F6);
  static const Color darkGray800 = Color(0xFFF9FAFB);
  static const Color darkGray900 = Color(0xFFFFFFFF);  // أبيض للنصوص

  // Success, Warning, Info Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Borders & Dividers
  static const Color borderLight = gray300;
  static const Color borderDark = darkGray300;
  static const Color dividerLight = gray200;
  static const Color dividerDark = darkGray200;
}
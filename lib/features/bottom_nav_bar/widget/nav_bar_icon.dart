import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theming/app_color.dart';

class BottomNavBarIcon extends StatelessWidget {
  final IconData? icon;
  final String label;
  final bool isActive;
  final void Function()? onTap;

  const BottomNavBarIcon({
    super.key,
    this.icon,
    required this.label,
    this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive
                ? Theme.of(context).colorScheme.primary // أزرق/أخضر للأيقونة النشطة
                : Theme.of(context).colorScheme.onBackground.withOpacity(0.5), // رمادي خفيف للغير نشطة
            size: 24,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.aDLaMDisplay(
              textStyle: TextStyle(
                color: isActive
                    ? Theme.of(context).colorScheme.primary // أزرق/أخضر للنص النشط
                    : Theme.of(context).colorScheme.onBackground.withOpacity(0.6), // رمادي للغير نشط
                fontSize: 12, // صغير للـ bottom nav
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theming/app_color.dart';
class BottomNavBarIcon extends StatelessWidget {
  final IconData? icon;
  final String label;
  final bool isActive;
  final void Function()? onTap;

  const BottomNavBarIcon(
      {super.key, this.icon, required this.label, this.onTap, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: isActive ? ColorsApp.p  : Colors.grey[600],),
          SizedBox(height: 6,),
          Text(label, style:
          GoogleFonts.aDLaMDisplay(
            textStyle:  TextStyle(
              color: isActive ? ColorsApp.p  : Colors.grey[600],
               fontSize: 16,
                fontWeight: FontWeight.w400,
          ),))

        ],
      ),
    );
  }
}
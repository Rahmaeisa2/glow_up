import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theming/app_color.dart';
class ContainerForQuestionScreen extends StatelessWidget {
  final String? emoji;
  final String title;
  final String? text;
  final bool isSelected ;
  final VoidCallback? onTap;

  const ContainerForQuestionScreen({
    super.key,
    this.emoji,
    required this.title,
    required this.isSelected,
    this.onTap,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.indigo[100] : Colors.grey[100],
          border: Border.all(
            color: isSelected ? Colors.indigo : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            if (emoji != null) Text(emoji!, style: TextStyle(fontSize: 24)),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.aDLaMDisplay(
                  textStyle: TextStyle(
                    color: ColorsApp.p,
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                  ),
                ),
              ),
            ),
            if (text != null)
              Text(
                text!,
                style: GoogleFonts.aDLaMDisplay(
                  textStyle: TextStyle(
                    color: ColorsApp.p,
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

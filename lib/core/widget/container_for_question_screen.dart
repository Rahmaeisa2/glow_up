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
      child:Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],

          color: isSelected ?  Theme.of(context).colorScheme.surfaceContainer: Theme.of(context).colorScheme.surfaceVariant,
          border: Border.all(
            color: isSelected? Colors.white24 :Colors.transparent,
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
                style:  Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color:
                    Theme.of(context).colorScheme.onSecondaryFixedVariant,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                  ),
                ),
              ),

            if (text != null)
              Text(
                text!,
                style: GoogleFonts.aDLaMDisplay(
                  textStyle: TextStyle(
                    color:Theme.of(context).primaryColor,
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

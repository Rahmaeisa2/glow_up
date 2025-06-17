import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/core/theming/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final Color? background ;
  final Function () onTap;
  const CustomButton({super.key, required this.name,  this.background, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
       height: 50,

        decoration: BoxDecoration(
        color: background,
            borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorsApp.p)
        ),
        child: Center(
          child: Text(name , style:GoogleFonts.aDLaMDisplay(
            textStyle: TextStyle(
    color: background ==null ? ColorsApp.p : Colors.white,
              fontSize: 20,
    ),
          ),
        ),
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class StateItem extends StatelessWidget {
  final String label ;
  final String value;
  const StateItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label ,
            style: GoogleFonts.aDLaMDisplay(
              textStyle:  TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),)
        ),
        Text(value,
            style: GoogleFonts.aDLaMDisplay(
              textStyle:  TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),)
        )
      ],
    );
  }
}

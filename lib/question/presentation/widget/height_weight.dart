import 'package:flutter/material.dart';
import 'package:glow_up_app/core/theming/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class SliderHeightWeightScreen extends StatefulWidget {
  @override
  _SliderHeightWeightScreenState createState() => _SliderHeightWeightScreenState();
}

class _SliderHeightWeightScreenState extends State<SliderHeightWeightScreen> {
  double height = 160;
  double weight = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Let's set your height & weight",
            style: GoogleFonts.aDLaMDisplay(
              textStyle: const TextStyle(
                  color: ColorsApp.p,
                  fontSize: 20,
                  fontWeight: FontWeight.w400
              ),
            )            ),
            SizedBox(height: 40),

            // Height Section
            Text("Height",   style: GoogleFonts.aDLaMDisplay(
              textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400
              ),),),
            SizedBox(height: 8),
            Text("${height.toInt()} cm", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            Slider(
              min: 100,
              max: 220,
              value: height,
              activeColor:ColorsApp.p,
              onChanged: (value) {
                setState(() {
                  height = value;
                });
              },
            ),
            SizedBox(height: 32),

            // Weight Section
            Text("Weight",   style: GoogleFonts.aDLaMDisplay(
    textStyle: const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400
    ),)),
            SizedBox(height: 8),
            Text("${weight.toInt()} kg", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            Slider(
              min: 30,
              max: 150,
              value: weight,
              activeColor:ColorsApp.p,
              onChanged: (value) {
                setState(() {
                  weight = value;
                });
              },
            ),
            Spacer(),

          ],
        ),
      ),
    );
  }
}

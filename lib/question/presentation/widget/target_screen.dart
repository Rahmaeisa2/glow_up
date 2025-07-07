import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theming/app_color.dart';

class TargetScreen extends StatefulWidget {
  @override
  _TargetScreenState createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  String? selectedTarget;

  final List<Map<String, dynamic>> targets = [
    {"title": "Lose Weight", "emoji": "🏃‍♀️"},
    {"title": "Gain Muscle", "emoji": "💪"},
    {"title": "Stay Fit", "emoji": "🧘‍♂️"},
    {"title": "Improve Habits", "emoji": "🌿"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "What's your goal?",
            style: GoogleFonts.aDLaMDisplay(
              textStyle: const TextStyle(
                  color: ColorsApp.p,
                  fontSize: 24,
                  fontWeight: FontWeight.w400
              ),
            )),
            SizedBox(height: 40),
            ...targets.map((target) {
              bool isSelected = selectedTarget == target["title"];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTarget = target["title"];
                  });
                },
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
                      Text(
                        target["emoji"],
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(width: 16),
                      Text(
                        target["title"],

                        style: GoogleFonts.aDLaMDisplay(
                          textStyle:  TextStyle(
                              color: ColorsApp.p,
                              fontSize: 16,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                        ),)
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

          ],
        ),
      ),
    );
  }
}

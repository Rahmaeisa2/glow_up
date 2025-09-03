import 'package:flutter/material.dart';
import 'package:glow_up_app/core/widget/user-answers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theming/app_color.dart';
import '../../../core/widget/container_for_question_screen.dart';

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
                    UserAnswer.target = target["title"];
                  });
                },
                child:
                ContainerForQuestionScreen(emoji: target['emoji'], title: target['title'], isSelected: isSelected,
                  
                )
              );
            }).toList(),

          ],
        ),
      ),
    );
  }
}

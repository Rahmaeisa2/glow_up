import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/core/widget/container_for_question_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/theming/app_color.dart';
import '../../../../core/widget/user-answers.dart';
import '../../provider/user_onboarding_provider.dart';

class AvailableTime extends StatefulWidget {
  const AvailableTime({super.key});

  @override
  State<AvailableTime> createState() => _AvailableTimeState();
}
class _AvailableTimeState extends State<AvailableTime> {
  String? selectedTime;

  final List<Map<String, dynamic>> time =[
    {"emoji" : "⏱" , "title": "Less than 15 min"},
    {"emoji" : " 🕒 " , "title": " 15-30 min "},
    {"emoji" : "⏰ " , "title": "30-60 min "},
    {"emoji" : " 🧭 " , "title": " More than 1 hour "},
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserOnboardingProvider>(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 29,
            vertical: 50,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(textAlign: TextAlign.center,
                  "How much time can you give daily?",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color:
                   Theme.of(context).colorScheme.primary
                ),
                ),
                SizedBox(
                  height: 42,
                ),
                ...time.map(((time){

                  bool isSelected = provider.user.availableTime == time["title"];
                  return GestureDetector(
                    onTap: () {
                      provider.updateAvailableTime(selectedTime);
                      setState(() {
                        selectedTime = time["title"];
                        //for screen
                });},
                    child: ContainerForQuestionScreen(emoji: time['emoji'],title:time['title'], isSelected: isSelected,)
                  );
                  })).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


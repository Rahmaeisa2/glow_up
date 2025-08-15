import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/core/widget/custom_text_form_field.dart';

import '../../../core/widget/user-answers.dart';
import '../question_onboarding.dart';

class NameAndAgeScreen extends StatefulWidget {
  @override
  State<NameAndAgeScreen> createState() => _NameAndAgeScreenState();
}

class _NameAndAgeScreenState extends State<NameAndAgeScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final ValueNotifier<String?> gender = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30,
          vertical: 50),
      child: Column(
        children: [
          CustomTextFormField
            (
              onChanged: (v) {
                UserAnswer.name = v;
              },
              hintText: "Enter your name", title: "Name", controller: nameController),
          SizedBox(height: 30),
      CustomTextFormField(

          onChanged:(v){
            final n = int.tryParse(v);
            if(n !=null )UserAnswer.age=n;

      }
          ,hintText: "Enter your age", title: "Age", controller: ageController)
        ],
      ),
    );
  }
}

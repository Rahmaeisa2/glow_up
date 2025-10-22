import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/core/widget/custom_text_form_field.dart';
import 'package:glow_up_app/features/question/provider/user_onboarding_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/widget/user-answers.dart';
import '../question_onboarding.dart';

class NameAndAgeScreen extends StatefulWidget {
  @override
  State<NameAndAgeScreen> createState() => _NameAndAgeScreenState();
}

class _NameAndAgeScreenState extends State<NameAndAgeScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController ageController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserOnboardingProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30,
          vertical: 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextFormField
              (
                onChanged: provider.updateName,
                hintText: "Enter your name", title: "Name", controller: nameController),
            SizedBox(height: 30),
        CustomTextFormField(
        
            onChanged:provider.updateAge,
            hintText: "Enter your age", title: "Age", controller: ageController),

          ],
        ),
      ),
    );
  }
}

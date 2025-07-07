import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/core/widget/custom_text_form_field.dart';

class NameAndAgeScreen extends StatelessWidget {
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
          CustomTextFormField(hintText: "Enter your name", title: "Name", controller: nameController),
          SizedBox(height: 30),
      CustomTextFormField(hintText: "Enter your age", title: "Age", controller: ageController)
        ],
      ),
    );
  }
}

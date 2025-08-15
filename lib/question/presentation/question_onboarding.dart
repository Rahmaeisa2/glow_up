import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glow_up_app/core/widget/custom_button.dart';
import 'package:glow_up_app/login/presentation/login_screen.dart';
import 'package:glow_up_app/question/presentation/widget/available_time.dart';
import 'package:glow_up_app/question/presentation/widget/gender.dart';
import 'package:glow_up_app/question/presentation/widget/height_weight.dart';
import 'package:glow_up_app/question/presentation/widget/name_age.dart';
import 'package:glow_up_app/question/presentation/widget/target_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/theming/app_color.dart';
import '../../core/widget/user-answers.dart';
import '../../onBoarding/widgets/page_view.dart';
class QuestionOnBoarding extends StatefulWidget {
  const QuestionOnBoarding({super.key});

  @override
  State<QuestionOnBoarding> createState() => _QuestionOnBoardingState();
}
class _QuestionOnBoardingState extends State<QuestionOnBoarding> {
  PageController questionController = PageController(initialPage: 0);
  int currentIndex = 0;

   void _msg(String m) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));
  }
  Future<void> _submitToFirestore() async {
    print("User Answers: ${UserAnswer.toMap()}"); // نتاكد قبل الرفع

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("❌ No user signed in");
      _msg("سجّلي الدخول أولاً");
      return;
    }

    print("✅ User signed in: ${user.uid}");

    final dataToSave = UserAnswer.toMap();
    print("📦 Data to save: $dataToSave");

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({
        'onboarding': dataToSave,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      print("✅ Data saved successfully!");
      _msg("تم الحفظ ✅");


    } catch (e) {
      print("🔥 Error saving to Firestore: $e");
      _msg("حصل خطأ أثناء الحفظ: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      leading: InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios_new_outlined ,
          size: 22,),
      ),
    ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20
        ),
        child: Column(
          children: [
            SmoothPageIndicator(controller: questionController, count: 5 ,
            axisDirection: Axis.horizontal,
              effect:  WormEffect(
                dotHeight: 6,
                dotWidth: 30,
                spacing: 8,
                radius: 12,
                activeDotColor: ColorsApp.p,
              ),
                onDotClicked: (index){
                }
            ),
            SizedBox(
              height: 12,
            ),
        Expanded(child: PageView(
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
                controller: questionController,
                children: [
                  NameAndAgeScreen(),
                  GenderSelectionWidget(),
                  SliderHeightWeightScreen(),
                  TargetScreen(),
                  AvailableTime()
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CustomButton(
              name: currentIndex == 4 ? "Finish" : "Next",
              background: ColorsApp.p,
              onTap: () async {
                if (currentIndex < 4) {
                  questionController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                } else {
                  await _submitToFirestore();
                  Navigator.of(context).pushReplacementNamed("test");


                }
              },
            )
          ],
        ),
      ),
    );
  }
}

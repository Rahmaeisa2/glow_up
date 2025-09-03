import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/core/widget/custom_button.dart';
import 'package:glow_up_app/question/presentation/widget/activty_level.dart';
import 'package:glow_up_app/question/presentation/widget/available_time.dart';
import 'package:glow_up_app/question/presentation/widget/gender.dart';
import 'package:glow_up_app/question/presentation/widget/height_weight.dart';
import 'package:glow_up_app/question/presentation/widget/levels.dart';
import 'package:glow_up_app/question/presentation/widget/name_age.dart';
import 'package:glow_up_app/question/presentation/widget/target_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/routes/app_route.dart';
import '../../core/theming/app_color.dart';
import '../../core/widget/user-answers.dart';
class QuestionOnBoarding extends StatefulWidget {
  const QuestionOnBoarding({super.key});

  @override
  State<QuestionOnBoarding> createState() => _QuestionOnBoardingState();
}
class _QuestionOnBoardingState extends State<QuestionOnBoarding> {
  PageController questionController = PageController(initialPage: 0);
  int currentIndex = 0;
  TextEditingController loginController = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;
  late String? email = user?.email;

   void _msg(String m) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));
  }
  Future<void> _submitToFirestore() async {

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("❌ No user signed in");
      _msg("Login first");
      return;
    }

    print("✅ User signed in: ${user.uid}");



    Map<String, dynamic> dataToSave = UserAnswer.toMap();
    dataToSave['createdAt'] = FieldValue.serverTimestamp();
    dataToSave['updatedAt'] = FieldValue.serverTimestamp();
    dataToSave['userId'] = user.uid;

    print("📦 Data to save: $dataToSave");

    // Save to Firestore
   try{ await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set({
      'onboarding': dataToSave,
     'activityLevel': UserAnswer.activityLevel,

     'email': user.email,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

      print("✅ Data saved successfully!");
      _msg("Saved ✅");


    } catch (e) {
      print("🔥 Error saving to Firestore: $e");
      _msg("Error: $e");
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
            SmoothPageIndicator(controller: questionController, count: 6 ,
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
                  AvailableTime(),
                  ActivityLevelWidget(),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CustomButton(
              name: currentIndex == 5 ? "Finish" : "Next",
              background: ColorsApp.p,
              onTap: () async {
                if (currentIndex < 5) {
                  questionController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                } else {
                  await _submitToFirestore();
                  Navigator.pushNamed(context, AppRoutes.navBar);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

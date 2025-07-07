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
import '../../onBoarding/widgets/page_view.dart';
class QuestionOnBoarding extends StatefulWidget {
  const QuestionOnBoarding({super.key});

  @override
  State<QuestionOnBoarding> createState() => _QuestionOnBoardingState();
}
class _QuestionOnBoardingState extends State<QuestionOnBoarding> {
  PageController questionController = PageController(initialPage: 0);
  int currentIndex = 0;
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
            CustomButton(name: "Next",
                background: ColorsApp.p, onTap: (){
    if (currentIndex < 2) {
    questionController.nextPage(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut);
    } else {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()));
    }})
          ],
        ),
      ),
    );
  }
}

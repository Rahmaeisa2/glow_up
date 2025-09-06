
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:glow_up_app/core/theming/app_color.dart';
import 'package:glow_up_app/core/widget/custom_button.dart';
import 'package:glow_up_app/frist_screen.dart';
import 'package:glow_up_app/onBoarding/widgets/page_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../core/routes/app_route.dart';
import '../core/widget/responsive.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController=PageController(initialPage: 0);
int currentIndex = 0;

@override
  Widget build(BuildContext context) {
  SizeConfig.init(context);
  return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end ,
          children: [
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> FristScreen()));

            }, child: const Text(
              "Skip",style: TextStyle(
                fontSize: 17,
                color: ColorsApp.p,
                fontWeight: FontWeight.bold),
            )),
            const SizedBox(
              height: 100,
            ),
            Expanded(child: PageView(
              controller: pageController,
              children: const [
                PageViewItem(imageURL: "assets/images/frist.jpeg",
                  text: "Stay Fit",
                  text2: 'Start your journey with simple and fun workouts. \n Choose routines that fit your body and your time'

                  ,),
                PageViewItem(imageURL: "assets/images/healthy.jpeg",
                  text: " Eat Clean & Feel Great",
                  text2: 'Quick and delicious meals without guilt. \n Enjoy a balanced lifestyle that fuels your glow from within'),

                PageViewItem(imageURL: "assets/images/lifestyle.jpeg", text: "Glow Every Day	",
                  text2: 'Build habits that support your dream lifestyle.',),


              ],
              onPageChanged: (index){
                setState(() {

                  currentIndex = index;

                });
              },
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                    controller: pageController,  // PageController
                    count:  3,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 10,
                      activeDotColor: ColorsApp.p,
                    ),
                    // your preferred effect
                    onDotClicked: (index){
                    }
                ),
                GestureDetector(
                  onTap: () {
                    if (currentIndex < 2) {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    } else {
                      Navigator.pushNamed(context, AppRoutes.FristScreen);
                    }
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                    decoration: BoxDecoration(
                      color: ColorsApp.p,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: currentIndex < 2
                        ? const Icon(Icons.arrow_forward_ios, color: Colors.white ,
                    size: 20,)
                        :  Text(
                      "Start",
                      style: GoogleFonts.aDLaMDisplay(
                    textStyle: const TextStyle(
                      color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400
                    ),
                    ),
                  ),
                )


                )


              ],
            )
          ],
        ),
      ),
    );
  }
}
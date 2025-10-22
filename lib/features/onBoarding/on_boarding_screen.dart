
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:glow_up_app/core/theming/app_color.dart';
import 'package:glow_up_app/core/widget/custom_button.dart';
import 'package:glow_up_app/features/login/presentation/login_screen.dart';
import 'package:glow_up_app/features/onBoarding/widgets/page_view.dart';
import 'package:glow_up_app/features/frist_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/routes/app_route.dart';
import '../../core/widget/responsive.dart';


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

            }, child: Text(
              "Skip",style:Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Theme.of(context).colorScheme.onSecondary,
      )
                ),
            ),
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
                    effect:  ExpandingDotsEffect(
                      dotHeight: 10,

                      activeDotColor: Theme.of(context).colorScheme.onPrimary,

                    ),
                    // your preferred effect
                    onDotClicked: (index){
                    }
                ),
                GestureDetector(
                  onTap: () async{
                    if (currentIndex < 2) {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    } else {
                      final prefs =await SharedPreferences.getInstance();
                      await prefs.setBool('onboarding_completed', true);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FristScreen()));

                    }
                  },
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: currentIndex < 2
                        ? const Icon(Icons.arrow_forward_ios, color: Colors.white ,
                    size: 20,)
                        :  Text(
                      "Start",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                    ),
                  ),

                )


              ],
            )
          ],
        ),
      ),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/features/frist_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bottom_nav_bar/bottom_nav_bar.dart';
import '../onBoarding/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    navigateAfterDelay();
  }
  Future<void>navigateAfterDelay()async{
    await Future.delayed(Duration(seconds: 3),()  async {
      final prefs = await SharedPreferences.getInstance();
      final bool hasCompletedOnboarding = prefs.getBool('onboarding_completed') ?? false;
      final user = FirebaseAuth.instance.currentUser;
      if (!hasCompletedOnboarding){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnBoardingScreen()));
      }else if (user==null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FristScreen()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavBarScreen()));

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/fit.jpeg",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/frist_screen.dart';
import 'package:glow_up_app/login/presentation/login_screen.dart';
import 'package:glow_up_app/onBoarding/on_boarding_screen.dart';
import 'package:glow_up_app/question/presentation/question_onboarding.dart';
import 'package:glow_up_app/register/presentation/register_screen.dart';
import 'package:glow_up_app/splash/splash_screen.dart';
import 'package:glow_up_app/test.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('--------------User is currently signed out!');
      } else {
        print('--------------User is signed in!');
      }
    });    super.initState();
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified) ? test(): OnBoardingScreen(),
      routes: {
        "login" : (context) => LoginScreen(),
        "register" : (context) => RegisterScreen(),
        "question" :  (context) => QuestionOnBoarding(),
        "onboarding": (context) => OnBoardingScreen(),
        "frist": (context) => FristScreen(),
        "test": (context) => test(),
      },
    );
  }
}

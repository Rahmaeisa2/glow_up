import 'package:glow_up_app/frist_screen.dart';
import 'package:glow_up_app/login/presentation/login_screen.dart';
import 'package:glow_up_app/question/presentation/question_onboarding.dart';
import 'package:glow_up_app/register/presentation/register_screen.dart';
import 'package:glow_up_app/search/presentation/search_screen.dart';
import 'package:glow_up_app/test.dart';

import '../../bottom_nav_bar/bottom_nav_bar.dart';
import '../../onBoarding/on_boarding_screen.dart';
import '../../splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String init = '/';
  static const String onBoarding = '/onBoarding';
  static const String FristScreen = '/fristScreen';
  static const String questions = '/questionScreen';
  static const String test = '/test';
  static const String login = '/loginScreen';
  static const String register = '/register';
  static const String navBar = '/NavBar';
  static const String search = '/search';




}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.init:
        return MaterialPageRoute(builder: (_) =>  SplashScreen());

      case AppRoutes.onBoarding:
        return MaterialPageRoute(builder: (_) =>  OnBoardingScreen());

      case AppRoutes.FristScreen:
        return MaterialPageRoute(builder: (_) =>  FristScreen());
      case AppRoutes.questions:
        return MaterialPageRoute(builder: (_) =>  QuestionOnBoarding());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) =>  LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) =>  RegisterScreen());
      case AppRoutes.navBar:
        return MaterialPageRoute(builder: (_) =>  BottomNavBarScreen());
      case AppRoutes.search:
        return MaterialPageRoute(builder: (_) =>  SearchScreen());

    default:
    return MaterialPageRoute(
    builder: (_) => Scaffold(
    body: Center(
    child: Text('No route defined for ${settings.name}')
    ))
    );
    }

  }
}

import 'package:glow_up_app/Nutrition/presentation/recipre_details_screen.dart';
import 'package:glow_up_app/features/frist_screen.dart';


import '../../Nutrition/Data/recipe_model.dart';
import '../../features/bottom_nav_bar/bottom_nav_bar.dart';
import '../../features/login/presentation/login_screen.dart';
import '../../features/onBoarding/on_boarding_screen.dart';
import '../../features/question/presentation/question_onboarding.dart';
import '../../features/register/presentation/register_screen.dart';
import '../../features/search/presentation/search_screen.dart';
import '../../features/splash/splash_screen.dart';

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
    static const String recipeDetails = '/recipreDetail';




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
      case AppRoutes.recipeDetails:
         final recipe = settings.arguments as RecipeModel;
        return MaterialPageRoute(builder: (_) =>  RecipreDetailsScreen(recipe: recipe,));

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

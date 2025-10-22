import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_up_app/core/theming/theming_provider.dart';
import 'package:glow_up_app/features/Nutrition/provider/recipe_provider.dart';
import 'package:glow_up_app/features/frist_screen.dart';
import 'package:glow_up_app/features/question/provider/user_onboarding_provider.dart';

import 'package:glow_up_app/test.dart';
import 'package:provider/provider.dart';

import 'core/routes/app_route.dart';
import 'core/theming/theme_data/theme_data_dark.dart';
import 'core/theming/theme_data/theme_data_light.dart' hide AppTheme;
import 'features/onBoarding/on_boarding_screen.dart';
import 'features/workout/provider/workout_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WorkoutProvider()),
        ChangeNotifierProvider(create: (_)=>RecipeProvider()),
        ChangeNotifierProvider(create: (_)=>ThemeProvider()),
        ChangeNotifierProvider(create: (_)=>UserOnboardingProvider())
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;
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
          return
            Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return ScreenUtilInit(
                    designSize: const Size(360, 690),
                    minTextAdapt: true,
                    splitScreenMode: true,
                      builder: (context , child){
                      return MaterialApp(
                        theme:getLightTheme(),
                        darkTheme: getDarkTheme(),
                      themeMode: themeProvider.themeMode,
                      debugShowCheckedModeBanner: false,
                      initialRoute: AppRoutes.init,
                      onGenerateRoute: AppRouter.generateRoute,
                      );}
                  );
                });}
  }


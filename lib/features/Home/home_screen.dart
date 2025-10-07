import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/core/services/firestore_services.dart';
import 'package:glow_up_app/core/theming/app_color.dart';
import 'package:glow_up_app/core/widget/user-answers.dart';
import 'package:glow_up_app/features/Home/widget/nutrition_card.dart';
import 'package:glow_up_app/features/Home/widget/nutrition_summary.dart';
import 'package:glow_up_app/features/Home/widget/recommend_meals.dart';
import 'package:glow_up_app/features/Home/widget/recommend_video_section.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/routes/app_route.dart';
import '../../core/services/recommend_video_service.dart';
import '../../core/theming/theming_provider.dart';
import '../../core/widget/responsive.dart';
import '../Nutrition/model/recipe_model.dart';
import 'Model/recommendation_video_model.dart';
import 'data/recommended_video_data.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final FirestoreService firestoreServices = FirestoreService();

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser!;
    RecommendedVideoService().addVideosNotExists(defaultVideos);
  }
  @override
  Widget build(BuildContext context) {
    String userTarget = (UserAnswer.target ?? 'stay_fit').toLowerCase().replaceAll(' ', '_');
    print('UserAnswer.target: ${UserAnswer.target}');
    print('userTarget after null check: $userTarget');

    SizeConfig.init(context);

    return Scaffold(
      appBar: AppBar(  actions: [
        InkWell(
          onTap: (){
            context.read<ThemeProvider>().toggleTheme();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              context.watch<ThemeProvider>().themeMode == ThemeMode.dark
                  ? Icons.wb_sunny
                  : Icons.nightlight_round,),
          ),
        )],
        automaticallyImplyLeading: false,
        title: Text(
          "HOME",
          style: GoogleFonts.aDLaMDisplay(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body:
      FutureBuilder<Map<String, dynamic>?>(
        future: firestoreServices.getUserData(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No user data found"));
          }

          final userData = snapshot.data!;
          final plan = Map<String, dynamic>.from(userData['nutritionPlan'] ?? {});
          print("🔥 Plan Data: $plan");
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 20),
            child: SingleChildScrollView(
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 👋 Greeting
                  Row(
                    children: [
                      Text(
                        "Hello, ",
                        style: GoogleFonts.aDLaMDisplay(
                          textStyle: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        userData['onboarding']?['name'] ?? '',
                        style: GoogleFonts.aDLaMDisplay(
                          textStyle: const TextStyle(
                            fontSize: 22,
                            color: Colors.indigo,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Progress, not perfection",
                    style: GoogleFonts.aDLaMDisplay(
                      textStyle: const TextStyle(
                        color: Colors.indigo,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 🔥 Nutrition summary
                  Text(
                      "Nutrition Summary",
                    style: GoogleFonts.aDLaMDisplay(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),)),
                  const SizedBox(height: 12),
                  NutritionSummary(plan: plan),
                  const SizedBox(height: 12),

                  Divider(
                    thickness: 2,
                    endIndent: 23,
                    indent: 23,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 15),
                  Text(
                      "Workout Recommendation",
                      style: GoogleFonts.aDLaMDisplay(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),)),
                  const SizedBox(height: 15),
                  RecommendVideoSection(userTarget: userTarget),
                  const SizedBox(height: 10),

                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RecommendMeals()));
                    },
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.indigo,

                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text('Your Diet Plan' ,
                            style:TextStyle(
                              fontSize: 25,
                              color: Colors.white60,
                              fontWeight: FontWeight.bold
                            ) ,) ,
                          SizedBox(
                            width: 12,
                          ),
                          Icon(Icons.arrow_forward,size: 24,
                            color: Colors.white60,
                            fontWeight: FontWeight.bold,
                          ),

                        ],),

                      )
                    ),
                  ),

               ],
              ),
            ),
          );
        },
      ),
    );
  }
}


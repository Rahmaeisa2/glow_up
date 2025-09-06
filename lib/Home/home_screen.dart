import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/Home/widget/nutrition_card.dart';
import 'package:glow_up_app/core/services/firestore_services.dart';
import 'package:glow_up_app/core/theming/app_color.dart';
import 'package:glow_up_app/core/widget/user-answers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/services/calories_sevices.dart';
import '../core/widget/responsive.dart';

class HomeScreen extends StatefulWidget {


   HomeScreen({super.key, });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final String userId = FirebaseAuth.instance.currentUser!.uid;
 @override
 void initState() {
    // TODO: implement initState
    super.initState();
    user = _auth.currentUser!;

 } 
 final FirestoreService firestoreServices = FirestoreService();
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      appBar: AppBar(
        title:Text("HOME",
          style:  GoogleFonts.aDLaMDisplay(
            textStyle:  TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,),
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String,dynamic>?>
        (  future: firestoreServices.getUserData(userId),
          builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return  Center( child: CircularProgressIndicator(),);
          } ;
          if(snapshot.hasError){
            return Center(child: Text("Error ${snapshot.hasError}"),);
          };
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No user data found"));
          }
          final userData = snapshot.data!; // هيرجع كل حاجه
          final plan = Map<String, dynamic>.from(userData['nutritionPlan'] ?? {});
          print("🔥 Plan Data: $plan");

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 27,
              vertical: 20,
            ),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Hello ,",
                          style:  GoogleFonts.aDLaMDisplay(
                            textStyle:  TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,),
                          ),),
            Text(userData['onboarding']?['name'] ?? '',

            style:  GoogleFonts.aDLaMDisplay(
                            textStyle:  TextStyle(
                              fontSize: 22,
                              color: Colors.indigo,
                              fontWeight: FontWeight.w400,),
                          ),
                                  ),
                      ],
                    ),

                    Text("Progress, not perfection",
                      style:  GoogleFonts.aDLaMDisplay(
                        textStyle:  TextStyle(
                          color: Colors.indigo,
                          fontSize: 22,
                          fontWeight: FontWeight.w400,),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),

                NutritionCard(title: "Calories",
                    value: "${plan['totalCalories'] ?? 'No data'} kcal",
                    icon: Icons.local_fire_department) ,
               Row(
                 children: [ Expanded(
                   child: NutritionCard(
                     title: "Protein",
                     value: "${plan['protein'] ?? 'No data'} g",
                     icon: Icons.fitness_center,
                   ),
                 ),
                   SizedBox(
                     width: 12,
                   ),
                   Expanded(
                     child: NutritionCard(
                       title: "Carbs",
                       value: "${plan['carbs'] ?? 'No data'} g",
                       icon: Icons.grain,
                     ),
                   ),],
               )
              ],
            ),
          );
          }),
    );
  }
}

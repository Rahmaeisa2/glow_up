import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/core/services/recipe_service.dart';
import 'package:glow_up_app/features/Nutrition/model/recipe_model.dart';
import 'package:glow_up_app/features/Nutrition/presentation/recipre_details_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/widget/user-answers.dart';
import '../../Nutrition/Data/recipre.dart';
class RecommendMeals extends StatefulWidget {
  const RecommendMeals({super.key});


  @override
  State<RecommendMeals> createState() => _RecommendMealsState();
}


class _RecommendMealsState extends State<RecommendMeals> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String userTarget = (UserAnswer.target ?? 'stay_fit').toLowerCase().replaceAll(' ', '_');
    Stream<QuerySnapshot>mealsStream ;
    try{
      mealsStream = FirebaseFirestore.instance.collection("recipes")
          .where('target', isEqualTo: userTarget.toLowerCase()).snapshots();
      print('Stream created for target: ${userTarget}');

    }catch(e){
      print('Error creating videoStream: $e');
      mealsStream = Stream.error(e);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Recommended Meals",
            style: GoogleFonts.aDLaMDisplay(
              textStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),),
          leading: InkWell(onTap: (){
            Navigator.maybePop(context);
          },
              child: Icon(Icons.arrow_back_ios_new_rounded)),
        ),
        body: StreamBuilder(stream: mealsStream, builder:(context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print('Meal stream error: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            print('No meals found for target: $userTarget');
            return Center(child: Text('No recommended meals found'));
          }
          final meals = snapshot.data!.docs.map((doc)=>RecipeModel.fromMap(doc.data() as Map<String,dynamic> , doc.id))
              .where((m) => m.target.isNotEmpty && m.mealType.isNotEmpty)
              .toList();
          final breakfast = meals.where((m)=>m.mealType == 'breakfast').take(1).toList();
          final lunch = meals.where((m) => m.mealType == 'lunch').take(1).toList();
          final dinner = meals.where((m) => m.mealType == 'dinner').take(1).toList();
          final mealsToShow = [...breakfast, ...lunch, ...dinner, ];

          if (mealsToShow.isEmpty) {
            print('No meals after filtering for target: $userTarget');
            return Center(child: Text('No matching meals found', style: Theme.of(context).textTheme.bodyMedium));
          }

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildMealSection(context, 'Breakfast', breakfast),
              _buildMealSection(context, 'Lunch', lunch),
              _buildMealSection(context, 'Dinner', dinner),
            ],
          );

        }

        )
    );
  }
}
Widget _buildMealSection(BuildContext context, String title, List<RecipeModel> meals) {
  return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.aDLaMDisplay(
                  textStyle: const TextStyle(
                    color: Colors.indigo,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),              ),
              const SizedBox(height: 8),
              if (meals.isEmpty)
                Text(
                  'No $title recommended',
                  style: GoogleFonts.aDLaMDisplay(
                    textStyle: const TextStyle(
                      color: Colors.indigo,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),                )
              else
                ListTile(
                  title: Text(
                    meals[0].name.isNotEmpty ? meals[0].name : 'Untitled',
                    style: GoogleFonts.aDLaMDisplay(
                      textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),                  ),
                  subtitle: Text(
                    'Calories: ${meals[0].calories} kcal | Protein: ${meals[0].protein} g',
                    style: GoogleFonts.aDLaMDisplay(
                      textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecipreDetailsScreen(recipe: meals[0],)),
                    );
                  },
                ),
            ],))
  );}
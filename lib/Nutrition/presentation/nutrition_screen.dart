import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:glow_up_app/Nutrition/widget/recipe_card.dart';
import 'package:glow_up_app/core/routes/app_route.dart';
import 'package:glow_up_app/core/theming/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/services/recipe_service.dart';
import 'package:glow_up_app/Nutrition/Data/recipe_model.dart';

import '../Data/recipre.dart';
class NutrituonScreen extends StatefulWidget {
  const NutrituonScreen({super.key});

  @override
  State<NutrituonScreen> createState() => _NutrituonScreenState();
}
class _NutrituonScreenState extends State<NutrituonScreen>
    with SingleTickerProviderStateMixin{
  final List <String> mealsTab = ["Breakfast" , "Lunch" , "Dinner"];
  late TabController _tabController;
  final RecipeService _recipeService = RecipeService();

  Widget buildMealGrid(String mealType) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('recipes')
          .where('mealType', isEqualTo: mealType)
          .snapshots(),

      builder: (context, snapshot) {
        print("Connection State: ${snapshot.connectionState}");
        if (snapshot.hasError) {
          print("Error: ${snapshot.error}");
        }
        if (!snapshot.hasData) {
          print("No data yet");
        } if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          print("No data yet or empty");
          return const Center(child: Text("No recipes found"));
        }
        print("Documents count: ${snapshot.data?.docs.length}");

        List<RecipeModel> recipes = snapshot.data!.docs
            .map((doc) => RecipeModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
            .toList();


        return GridView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: recipes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
              childAspectRatio: 0.7          ),
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            return RecipeCard(
              recipe: recipe,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.recipeDetails ,
                arguments: recipe);

              },
            );
          },
        );
      },
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    addRecipes();

  }

  void addRecipes() async {
    await _recipeService.addRecipesIfNotExists(recipes);}
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrition' ,
          style: GoogleFonts.aDLaMDisplay(
            textStyle:  TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,),),
      ),
        centerTitle: true,
        elevation: 0,
    ),
    body: Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: mealsTab.map((tab) => Tab(text: tab)).toList(),
          labelColor: ColorsApp.p,
          unselectedLabelColor: Colors.grey,
          labelStyle: GoogleFonts.aDLaMDisplay(
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          unselectedLabelStyle: GoogleFonts.aDLaMDisplay(
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          indicatorColor: ColorsApp.p,
          indicatorWeight: 3,
        ),
        Expanded(
          child: TabBarView(
              controller: _tabController,
              children: [
                buildMealGrid("breakfast"),
                buildMealGrid("lunch"),
                buildMealGrid("dinner"),
          ]),
        ),
      ],
    ),);
  }
}


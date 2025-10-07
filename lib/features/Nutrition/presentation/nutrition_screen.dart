import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/core/routes/app_route.dart';
import 'package:glow_up_app/core/theming/app_color.dart';
import 'package:glow_up_app/features/Nutrition/provider/recipe_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/services/recipe_service.dart';
import '../Data/recipre.dart';
import '../widget/recipe_card.dart';
import 'nutrition_screen.dart' as _tabController;


class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen>
    with SingleTickerProviderStateMixin {
  final List<String> mealsTab = ["breakfast", "lunch", "dinner"];
  late TabController _tabController;
  final RecipeService _recipeService = RecipeService();

  Widget buildMealGrid(String mealType) {
    final provider = Provider.of<RecipeProvider>(context);
    final recipes = provider.getRecipesByMeal(mealType);
    print('Meal Type: $mealType, Recipes: ${recipes.length}'); // Debugging
    return provider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : recipes.isEmpty
        ? const Center(child: Text("No recipes found"))
        : GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: recipes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return RecipeCard(
          recipe: recipe,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.recipeDetails, arguments: recipe);
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    RecipeService().addRecipesIfNotExists(recipes);
    RecipeService().UpdateRecipes(recipes);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<RecipeProvider>(context, listen: false);
    for (var mealType in mealsTab) {
      provider.loadRecipes(mealType.toLowerCase());
    }
  }

  void addRecipes() async {
    await _recipeService.addRecipesIfNotExists(recipes);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(textAlign: TextAlign.center,
          'Nutrition',
          style: Theme.of(context).textTheme.displaySmall
          ),
        ),

      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10
        ),
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: mealsTab.map((tab) => Tab(text: tab.toUpperCase())).toList(),
              labelColor: Theme.of(context).colorScheme.onBackground,
              unselectedLabelColor: Colors.grey,
              labelStyle: Theme.of(context).textTheme.titleLarge
            ,
              unselectedLabelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w500
              ),
          indicatorColor: Theme.of(context).colorScheme.onSurface,
              indicatorWeight: 3,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: mealsTab.map((mealType) => buildMealGrid(mealType)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:glow_up_app/features/Nutrition/model/recipe_model.dart';

import '../../../core/services/recipe_service.dart';
class RecipeProvider extends ChangeNotifier{
  RecipeService _service = RecipeService();
  Map<String , List<RecipeModel>> recipes = {};
  bool isLoading = false;
  String errorMessage  ='';

  Future <void> loadRecipes(String mealType)async{
    if(recipes[mealType]?.isNotEmpty==true)return;
    isLoading = true;
    notifyListeners();

    try{
      final stream = _service.getRecipe(mealType);
      stream.listen((data){
        recipes[mealType]=data;
        isLoading = false;
        print("loaded ${data.length} for ${mealType}");
notifyListeners();
      });


    onError: (e) {
      errorMessage = 'error $e';
      isLoading = false;
      print(errorMessage);
      notifyListeners();
    };

  } catch (e) {
  errorMessage = 'connection error $e';
  isLoading = false;
  print(errorMessage);
  notifyListeners();
  }}

  List<RecipeModel> getRecipesByMeal(String mealType) {
    return recipes[mealType] ?? [];
  }
    }




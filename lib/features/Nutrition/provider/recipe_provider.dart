import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/features/Nutrition/model/recipe_model.dart';

import '../../../core/services/recipe_service.dart';
class RecipeProvider extends ChangeNotifier{
  RecipeService _service = RecipeService();
  Map<String , List<RecipeModel>> recipes = {};
  bool isLoading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String errorMessage  ='';

  Future <void> loadRecipes(String mealType)async{
    if(recipes[mealType]?.isNotEmpty==true)return;
    isLoading = true;
    notifyListeners();

    try{
      _firestore
      .collection('recipes')
          .where('mealType', isEqualTo: mealType)
          .snapshots()
          .listen((snapshot) {
        recipes[mealType] = snapshot.docs
            .map((doc) => RecipeModel.fromMap(doc.data(), doc.id))
            .toList();
        isLoading = false;
notifyListeners();
      });



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




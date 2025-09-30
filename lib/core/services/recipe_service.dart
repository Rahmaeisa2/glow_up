import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glow_up_app/features/Nutrition/model/recipe_model.dart';

import '../../features/Nutrition/Data/recipre.dart';

class RecipeService {
  final CollectionReference _recipesCollection =
  FirebaseFirestore.instance.collection('recipes');
  final String _userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  Stream<List<RecipeModel>> getRecipe(String mealType ){
    try{
      return _recipesCollection.where('mealType' , isEqualTo: mealType)
          .snapshots().map((snapshot)=>snapshot.docs
          .map((doc) => RecipeModel.fromMap(
          doc.data() as Map<String, dynamic>, doc.id))
          .toList());
    }catch(e){
      return Stream.error(e); // بيرجع ستريم فيه error

    }
  }

  Future<void> addRecipeIfNotExists(Map<String, dynamic> recipe) async {
    try {
      final doc = await _recipesCollection.doc(recipe['id']).get();
      if (!doc.exists) {
        await _recipesCollection.doc(recipe['id']).set(recipe);
        print("Recipe added: ${recipe['name']}");
      }
    } catch (e) {
      print("Failed to add recipe: $e");
    }
  }

  Future<void> addRecipesIfNotExists(List<Map<String, dynamic>> recipes) async {
    for (var recipe in recipes) {
      await addRecipeIfNotExists(recipe);
    }
  }
  Future<Map<String, dynamic>?> updateRecipe(Map<String, dynamic> recipe) async {
    try {
      await _recipesCollection.doc(_userId).update(recipe);

      final updatedDoc = await _recipesCollection.doc(_userId).get();

      if (updatedDoc.exists) {
        return updatedDoc.data() as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      print('Error updating document: $e');
      return null;
    }
  }

  Future<void> UpdateRecipes(List<Map<String, dynamic>> recipes) async {
    for (var recipe in recipes) {
      await updateRecipe(recipe);
    }
  }

  Future<void> deleteAllRecipes() async {
    final snapshot = await _recipesCollection.get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
    print("All recipes deleted.");
  }

}

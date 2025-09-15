import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeService {
  final CollectionReference _recipesCollection =
  FirebaseFirestore.instance.collection('recipes');

  // إضافة وصفة إذا مش موجودة بالفعل (based on id)
  Future<void> addRecipeIfNotExists(Map<String, dynamic> recipe) async {
    try {
      final doc = await _recipesCollection.doc(recipe['id']).get();
      if (!doc.exists) {
        await _recipesCollection.doc(recipe['id']).set(recipe);
        print("Recipe added: ${recipe['name']}");
      } else {
        print("Recipe already exists: ${recipe['name']}");
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

  Future<void> deleteAllRecipes() async {
    final snapshot = await _recipesCollection.get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
    print("All recipes deleted.");
  }
}

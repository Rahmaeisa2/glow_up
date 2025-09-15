class RecipeModel {
  final String id;
  final String name;
  final String imageUrl;
  final int calories;
  final List<String> tags;
  final int protein ;
  final int carbs;
  final List<Map<String, dynamic>> ingredients;
  final int fats;
  final List<String>steps ;
  final String tips;

  RecipeModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.calories,
    required this.tags,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.ingredients,
    required this.steps,
    required this.tips,


  });

  factory RecipeModel.fromMap(Map<String, dynamic> data, String documentId) {
    return RecipeModel(
      id: documentId,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      calories: data['calories'] ?? 0,
      tags: List<String>.from(data['tags'] ?? []),
      protein: data['protein'] ??0,
      carbs: data['carbs'] ??0,
      fats: data['fats'] ??0,
      ingredients: List<Map<String, dynamic>>.from(data['ingredients'] ?? []),
      steps: List<String>.from(data['steps'] ?? []),
      tips: data['tips'] ??'',


    );
  }
}




class RecipeModel {
  final String id;
  final String name;
  final String imageUrl;
  final String target;
  final String mealType;
  final int calories;
  final List<String> tags;
  final int protein ;
  final int carbs;
  final List<Map<String, dynamic>> ingredients;
  final int fat;
  final List<String>steps ;
  final String tips;

  RecipeModel({
    required this.id,
    required this.name,
    required this.target,
    required this.imageUrl,
    required this.mealType,
    required this.calories,
    required this.tags,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.ingredients,
    required this.steps,
    required this.tips,


  });

  factory RecipeModel.fromMap(Map<String, dynamic> data, String documentId) {
    return RecipeModel(
      id: documentId,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      target: data['target'] ?? '',
      tags: List<String>.from(data['tags'] ?? []),
      calories: int.tryParse(data['calories'].toString()) ?? 0,
      protein: int.tryParse(data['protein'].toString()) ?? 0,
      carbs: int.tryParse(data['carbs'].toString()) ?? 0,
      fat: int.tryParse(data['fat'].toString()) ?? 0,
      ingredients: List<Map<String, dynamic>>.from(data['ingredients'] ?? []),
      steps: List<String>.from(data['steps'] ?? []),
      tips: data['tips'] ??'',
      mealType: data['mealType'] ??'',




    );
  }
}





import '../widget/user-answers.dart';

class CalorieCalculatorService {

  static Map<String, dynamic>? calculateFromUserAnswer(UserAnswer userData) {
    // Validate user data
    if (!userData.isValid()) {
      print("❌ Incomplete user data for calorie calculation: "
          "name=${userData.name}, age=${userData.age}, height=${userData.height}, "
          "weight=${userData.weight}, gender=${userData.gender}, "
          "target=${userData.target}, availableTime=${userData.availableTime}, "
          "activityLevel=${userData.activityLevel}");
      return null;
    }

    // Additional validation for negative or unrealistic values
    if (userData.weight! <= 0 || userData.height! <= 0 || userData.age! <= 0) {
      print("❌ Invalid user data: weight, height, or age must be positive");
      return null;
    }

    try {
      return calculateNutritionPlan(userData);
    } catch (e) {
      print("🔥 Error calculating nutrition plan: $e");
      return null;
    }
  }

  static Map<String, dynamic> calculateNutritionPlan(UserAnswer userData) {
    double targetCalories = userData.calculateTargetCalories();

    double proteinCalories = targetCalories * 0.25;
    double carbCalories = targetCalories * 0.45;
    double fatCalories = targetCalories * 0.30;

    // Ensure macronutrients are non-negative
    final proteinGrams = (proteinCalories / 4).round();
    final carbGrams = (carbCalories / 4).round();
    final fatGrams = (fatCalories / 9).round();

    return {
      'totalCalories': targetCalories.round(),
      'protein': proteinGrams >= 0 ? proteinGrams : 0,
      'carbs': carbGrams >= 0 ? carbGrams : 0,        // 4 calories per gram of carbs
      'fats': fatGrams >= 0 ? fatGrams : 0,          // 9 calories per gram of fats
      'bmr': userData.calculateBMR().round(),
      'tdee': userData.calculateTDEE().round(),
      'activityMultiplier': userData.activityLevel?['multiplier']?.toDouble() ?? 1.0,
      'activityLevel': userData.activityLevel?['displayName'] ?? 'Unknown',
      'goal': userData.target ?? 'Unknown',
      'currentWeight': userData.weight ?? 0.0,
    };
  }
}
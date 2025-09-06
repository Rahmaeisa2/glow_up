import 'package:glow_up_app/core/widget/user-answers.dart';

class CalorieCalculatorService {
  // Calculate nutrition plan from UserAnswer static data
  static Map<String, dynamic>? calculateFromUserAnswer() {
    UserAnswer? userData = UserAnswer.fromUserAnswer();
    if (userData == null) {
      return null;
    }

    return calculateNutritionPlan(userData);
  }

  // Calculate nutrition plan from UserData object
  static Map<String, dynamic> calculateNutritionPlan(UserAnswer userData) {
    double targetCalories = userData.calculateTargetCalories();
    // Macronutrient distribution (example percentages)
    double proteinCalories = targetCalories * 0.25; // 25% protein
    double carbCalories = targetCalories * 0.45;    // 45% carbs
    double fatCalories = targetCalories * 0.30;     // 30% fats

    return {
      'totalCalories': targetCalories.round(),
      'protein': (proteinCalories / 4).round(),
      'carbs': (carbCalories / 4).round(),
      'fats': (fatCalories / 9).round(),
      'bmr': userData.calculateBMR().round(),
      'tdee': userData.calculateTDEE().round(),
      'activityMultiplier': UserAnswer.activityLevel?['multiplier'],
      'activityLevel': UserAnswer.activityLevel?['displayName'],
      'goal': UserAnswer.target,
      'currentWeight': UserAnswer.weight,


    };

  }
}


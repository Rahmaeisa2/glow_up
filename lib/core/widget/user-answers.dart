import '../../question/presentation/widget/levels.dart';

class UserAnswer {
  static String? name;
  static int? age;
  static String? email;
  static String? gender;
  static double? height;
  static double? weight;
  static String? availableTime;
  static String? target;
  static Map<String, dynamic>? activityLevel;

  static Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'gender': gender,
      'height_cm': height,
      'weight_kg': weight,
      'target': target,
      'availableTime': availableTime,
      'activityLevel': activityLevel,
    };
  }

  /// استرجاع بيانات المستخدم كـ Object
  static UserAnswer? fromUserAnswer() {
    if (name == null ||
        age == null ||
        weight == null ||
        height == null ||
        gender == null ||
        target == null ||
        activityLevel == null) {
      print('⚠️ User data is not complete');
      return null;
    }

    try {
      String activityName = activityLevel!['name'] ?? 'sedentary';
      ActivityLevel selectedLevel = ActivityLevel.values.firstWhere(
            (level) => level.name == activityName,
        orElse: () => ActivityLevel.sedentary,
      );

      print('✅ Activity Level Loaded: $selectedLevel');
    } catch (e) {
      print('❌ Error parsing activity level: $e');
    }

    return UserAnswer();
  }

  static void reset() {
    name = null;
    age = null;
    gender = null;
    height = null;
    weight = null;
    target = null;
    availableTime = null;
    activityLevel = null;
  }

  /// 🔹 حساب معدل الحرق الأساسي BMR
  double calculateBMR() {
    if (gender?.toLowerCase() == "male") {
      return 10 * weight! + 6.25 * height! - 5 * age! + 5;
    } else {
      return 10 * weight! + 6.25 * height! - 5 * age! - 161;
    }
  }

  double calculateTDEE() {
    double multiplier = activityLevel?['multiplier'] ?? 1.0;
    double tdee = calculateBMR() * multiplier;
    print("Activity multiplier: $multiplier");
    print("TDEE: $tdee");
    return tdee;
  }

  double calculateTargetCalories() {
    double tdee = calculateTDEE();

    switch (target) {
      case 'lose_weight':
        return tdee - 500; // عجز 500 سعر حراري يوميًا
      case 'gain_weight':
        return tdee + 500; // زيادة 500 سعر حراري يوميًا
      case 'maintain':
      default:
        return tdee;
    }
  }
}

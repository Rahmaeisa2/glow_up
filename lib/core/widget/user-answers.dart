import '../../features/question/presentation/widget/levels.dart';

class UserAnswer {
  String? _name;
  int? _age;
   String? _email;
   String? _gender;
   double? _height;
   double? _weight;
   String? _availableTime;
   String? _target;
   Map<String, dynamic>? _activityLevel;

   String? get name => _name;
   int? get age => _age;
String? get email => _email;
   String? get gender => _gender;
   double? get height => _height;
   double? get weight => _weight;
   String? get availableTime => _availableTime;
   String? get target => _target;
   Map<String, dynamic>? get activityLevel => _activityLevel;

   set name(String? value)=> _name=value;
   set age(int? value) => _age = value;
   set email(String? value) => _email = value;
   set gender(String? value) => _gender = value;
   set height(double? value) => _height = value;
   set weight(double? value) => _weight = value;
   set availableTime(String? value) => _availableTime = value;
   set target(String? value) => _target = value;
   set activityLevel(Map<String, dynamic>? value) => _activityLevel = value;

   Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'email': _email,
      'age': _age,
      'gender': _gender,
      'height_cm': _height,
      'weight_kg': _weight,
      'target': _target,
      'availableTime': _availableTime,
      'activityLevel': _activityLevel,
    };
  }

  /// استرجاع بيانات المستخدم كـ Object
   UserAnswer? fromUserAnswer() {
    if (_name == null ||
        _age == null ||
        _weight == null ||
        _height == null ||
       _gender == null ||
        _target == null ||
        _activityLevel == null) {
      print('⚠️ User data is not complete');
      return null;
    }

    try {
      String activityName = _activityLevel!['name'] ?? 'sedentary';
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

  bool isValid() =>
      _name != null &&
          _name!.isNotEmpty &&
          _age != null &&
          _age! > 0 &&
          _height != null &&
          _height! > 0 &&
          _weight != null &&
          _weight! > 0 &&
          _gender != null &&
          _gender!.isNotEmpty &&
          _target != null &&
          _target!.isNotEmpty &&
          _availableTime != null &&
          _availableTime!.isNotEmpty &&
          _activityLevel != null;
   void reset() {
    _name = null;
    _age = null;
    _gender = null;
    _height = null;
    _weight = null;
    _target = null;
    _availableTime = null;
    _activityLevel = null;
  }

  /// 🔹 حساب معدل الحرق الأساسي BMR
  double calculateBMR() {
    if (_gender?.toLowerCase() == "male") {
      return 10 * _weight! + 6.25 * _height! - 5 * _age! + 5;
    } else {
      return 10 * _height! - 5 * _age! - 161;
    }
  }

  double calculateTDEE() {
    double multiplier = _activityLevel?['multiplier'] ?? 1.0;
    double tdee = calculateBMR() * multiplier;
    print("Activity multiplier: $multiplier");
    print("TDEE: $tdee");
    return tdee;
  }

  double calculateTargetCalories() {
    double tdee = calculateTDEE();

    switch (_target) {
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

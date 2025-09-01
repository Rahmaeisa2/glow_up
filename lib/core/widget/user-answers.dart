class UserAnswer {
  static String? name;
  static int? age;
  static String? email
  ;
  static String? gender;
  static double? height;
  static double? weight;
  static String? availableTime;
  static String? target;

  static Map<String , dynamic>toMap(){

    return{
      'name'         : name,
      'email': email,
      'age'          : age,
      'gender'       : gender,
      'height_cm'    : height,
      'weight_kg'    : weight,
      'target'       : target,
      'availableTime': availableTime,

    };

  }

  static void reset() {
    name = null; age = null; gender = null;
    height = null; weight = null;
    target = null; availableTime = null;
  }
}
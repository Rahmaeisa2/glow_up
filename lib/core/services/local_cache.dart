
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalCache{
  static Future<void> saveMeals (List<Map<String ,dynamic>> meals)async {
    final prefs = await SharedPreferences.getInstance();
    // احول الليست لjson
    final jsonString = jsonEncode(meals);
    await prefs.setString("cachedMeals" , jsonString);

  }
  static Future<List<Map<String,dynamic>>> getMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString("cachedMeals");
    if(jsonString!=null){
      final decoded = jsonDecode(jsonString);
      return decoded.map((e) => Map<String , dynamic>.from(e)).toList();
    }
    return [];

  }


}
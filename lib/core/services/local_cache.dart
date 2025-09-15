import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalCache {
  // حفظ وجبات كاملة (لو حابة تستخدمها)
  static Future<void> saveMeals(List<Map<String, dynamic>> meals) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(meals);
    await prefs.setString("cachedMeals", jsonString);
  }

  static Future<List<Map<String, dynamic>>> getMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString("cachedMeals");
    if (jsonString != null) {
      final decoded = jsonDecode(jsonString) as List;
      return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
    }
    return [];
  }

  static Future<void> saveSearchHistory(List<String> history) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("searchHistory", history);
  }

  static Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("searchHistory") ?? [];
  }
  static Future<void> clearMeals() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("cachedMeals"); // مسح الكاش كله
  }
}




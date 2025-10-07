import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  bool _isDarkMode = false;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadThemeFromPrefs();
  }

  Future<void> _loadThemeFromPrefs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
      print('✅ loaded: ${_isDarkMode ? "Dark" : "Light"}');
    } catch (e) {
      print('❌ error: $e');
    }
  }

  // تبديل الثيم
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    _themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDarkMode', _isDarkMode);
      print('💾 theme saved: ${_isDarkMode ? "Dark" : "Light"}');
    } catch (e) {
      print('❌error: $e');
    }

    notifyListeners();
  }

  // تعيين ثيم معين
  Future<void> setThemeMode(bool isDark) async {
    _isDarkMode = isDark;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDarkMode', _isDarkMode);
    } catch (e) {
      print('❌ error: $e');
    }

    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
class ThemeController extends GetxController {
  // Observable state
  var currentTheme = AppTheme.premiumGold.obs;
  var isDarkMode = false.obs;

  // Custom theme colors
  var customThemeColors =
      AppColors(
        primary: Colors.blue,
        secondary: Colors.blueAccent,
        background: Colors.white,
        surface: Colors.grey,
        onSurface: Colors.grey.shade300,
        accent: Colors.teal,
        textColor: Colors.black,
      ).obs;

  // SharedPreferences keys
  static const String _themeIndexKey = 'selectedThemeIndex';
  static const String _darkModeKey = 'isDarkMode';
  static const String _customThemeKey = 'customThemeColors';

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  // 🔹 Change theme and save preference
  Future<void> changeTheme(AppTheme theme) async {
    currentTheme.value = theme;
    await _saveTheme();
    update();
  }

  // 🔄 Toggle between light and dark modes
  Future<void> toggleDarkMode() async {
    isDarkMode.value = !isDarkMode.value;
    await _saveTheme();
    update();
  }

  // 🔹 Update custom theme colors
  Future<void> updateCustomTheme(AppColors newColors) async {
    customThemeColors.value = newColors;
    currentTheme.value = AppTheme.customTheme;
    await _saveTheme();
    update();
  }

  // ♻️ Reset to default theme
  Future<void> reset() async {
    currentTheme.value = AppTheme.premiumGold;
    isDarkMode.value = false;
    customThemeColors.value = AppColors(
      primary: Colors.blue,
      secondary: Colors.blueAccent,
      background: Colors.white,
      surface: Colors.grey,
      onSurface: Colors.grey.shade300,
      accent: Colors.teal,
      textColor: Colors.black,
    );
    await _saveTheme();
    update();
  }

  // 🧩 Active color palette
  AppColors get colors {
    if (currentTheme.value == AppTheme.customTheme) {
      return customThemeColors.value;
    }
    return isDarkMode.value
        ? currentTheme.value.darkColors
        : currentTheme.value.lightColors;
  }

  // 💾 Save preferences
  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeIndexKey, currentTheme.value.index);
    await prefs.setBool(_darkModeKey, isDarkMode.value);

    // Save custom theme colors as JSON
    if (currentTheme.value == AppTheme.customTheme) {
      final customMap = {
        'primary': customThemeColors.value.primary.value,
        'secondary': customThemeColors.value.secondary.value,
        'background': customThemeColors.value.background.value,
        'surface': customThemeColors.value.surface.value,
        'onSurface': customThemeColors.value.onSurface.value,
        'accent': customThemeColors.value.accent.value,
        'textColor': customThemeColors.value.textColor.value,
      };
      await prefs.setString(_customThemeKey, customMap.toString());
    }
  }

  // 📦 Load preferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeIndexKey) ?? 0;
    final darkMode = prefs.getBool(_darkModeKey) ?? false;

    currentTheme.value = AppTheme.values[themeIndex];
    isDarkMode.value = darkMode;

    // Load custom theme colors if saved
    if (currentTheme.value == AppTheme.customTheme) {
      final customString = prefs.getString(_customThemeKey);
      if (customString != null) {
        try {
          final map = Map<String, dynamic>.fromEntries(
            customString
                .replaceAll('{', '')
                .replaceAll('}', '')
                .split(', ')
                .map((e) => e.split(':'))
                .map((e) => MapEntry(e[0].trim(), int.parse(e[1].trim()))),
          );

          customThemeColors.value = AppColors(
            primary: Color(map['primary']!),
            secondary: Color(map['secondary']!),
            background: Color(map['background']!),
            surface: Color(map['surface']!),
            onSurface: Color(map['onSurface']!),
            accent: Color(map['accent']!),
            textColor: Color(map['textColor']!),
          );
        } catch (_) {
          // handle error or fallback
        }
      }
    }

    update();
  }
}
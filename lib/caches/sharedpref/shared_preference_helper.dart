import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  Future<SharedPreferences> _sharedPreference;
  static const String is_dark_mode = "is_dark_mode";
  static const String current_language = "en";
  static const String current_theme = "system";

  SharedPreferenceHelper() {
    _sharedPreference = SharedPreferences.getInstance();
  }

  //Theme module
  /*Future<void> changeTheme(bool value) {
    return _sharedPreference.then((prefs) {
      return prefs.setBool(is_dark_mode, value);
    });
  }*/

  /*Future<bool> get isDarkMode {
    return _sharedPreference.then((prefs) {
      return prefs.getBool(is_dark_mode) ?? false;
    });
  }*/

  Future<void> changeTheme(String value) {
    return _sharedPreference.then((prefs) {
      return prefs.setString(current_theme, value);
    });
  }

  Future<String> get getCurrentTheme {
    return _sharedPreference.then((prefs) {
      String currentTheme = prefs.getString(current_theme);
      return currentTheme;
    });
  }

//Language
  Future<void> changeLanguage(String value) {
    return _sharedPreference.then((prefs) {
      return prefs.setString(current_language, value);
    });
  }

  Future<String> get appCurrentLanguage {
    return _sharedPreference.then((prefs) {
      return prefs.getString(current_language) ?? 'en';
    });
  }
}

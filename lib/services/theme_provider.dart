import 'package:flutter/material.dart';
import 'package:flutter_starter/services/store/store.dart';

class ThemeProvider extends ChangeNotifier {
  // shared pref object
  SharedPreferenceHelper _sharedPrefsHelper;
  String _currentTheme = "system";

  ThemeProvider() {
    _sharedPrefsHelper = SharedPreferenceHelper();
  }

  bool get isDarkModeOn {
    if (getTheme == 'system') {
      if (WidgetsBinding.instance.window.platformBrightness ==
          Brightness.dark) {
        return true;
      }
    }
    if (getTheme == 'dark') {
      return true;
    }
    return false;
  }

  String get getTheme {
    _sharedPrefsHelper.getCurrentTheme.then((theme) {
      _currentTheme = theme;
    });
    return _currentTheme;
  }

  void updateTheme(String theme) {
    _sharedPrefsHelper.changeTheme(theme);
    _sharedPrefsHelper.getCurrentTheme.then((theme) {
      _currentTheme = theme;
    });
    notifyListeners();
  }
}

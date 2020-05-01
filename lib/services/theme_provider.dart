import 'package:flutter/material.dart';
import 'package:flutter_starter/store/store.dart';

class ThemeProvider extends ChangeNotifier {
  // shared pref object
  SharedPreferenceHelper _sharedPrefsHelper;
  String _currentTheme = "system";

  ThemeProvider() {
    _sharedPrefsHelper = SharedPreferenceHelper();
  }

  // checks whether darkmode is set via system or previously by user
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

  // gets currentTheme stored in shared preferences
  String get getTheme {
    _sharedPrefsHelper.getCurrentTheme.then((theme) {
      _currentTheme = theme;
    });
    return _currentTheme;
  }

  // updates selected theme into sharepreferences
  // and notifies ui to update via provider
  void updateTheme(String theme) {
    _sharedPrefsHelper.changeTheme(theme);
    _sharedPrefsHelper.getCurrentTheme.then((theme) {
      _currentTheme = theme;
    });
    notifyListeners();
  }
}

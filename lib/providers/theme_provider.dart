import 'package:flutter/material.dart';
import 'package:flutter_starter/caches/sharedpref/shared_preference_helper.dart';

class ThemeProvider extends ChangeNotifier {
  // shared pref object
  SharedPreferenceHelper _sharedPrefsHelper;

  //bool _isDarkModeOn = false;
  String _currentTheme = "system";

  ThemeProvider() {
    _sharedPrefsHelper = SharedPreferenceHelper();
  }

  /*bool get isDarkModeOn {
    _sharedPrefsHelper.isDarkMode.then((statusValue) {
      _isDarkModeOn = statusValue;
    });

    return _isDarkModeOn;
  }*/

  bool isDarkModeOn(BuildContext context) {
    if (getTheme(context) == 'dark') {
      return true;
    } else {
      return false;
    }
  }

  String getTheme(BuildContext context) {
    _sharedPrefsHelper.getCurrentTheme.then((theme) {
      _currentTheme = theme;
      if (_currentTheme == "system") {
        final Brightness brightnessValue =
            MediaQuery.of(context).platformBrightness;
        if (brightnessValue == Brightness.dark) {
          _currentTheme = "dark";
        } else {
          _currentTheme = "light";
        }
      }
    });
    return _currentTheme;
  }

  String get getStoredTheme {
    _sharedPrefsHelper.getCurrentTheme.then((theme) {
      _currentTheme = theme;
    });
    return _currentTheme;
  }
  /*void updateTheme(bool isDarkModeOn) {
    _sharedPrefsHelper.changeTheme(isDarkModeOn);
    _sharedPrefsHelper.isDarkMode.then((darkModeStatus) {
      _isDarkModeOn = darkModeStatus;
    });

    notifyListeners();
  }*/

  void updateTheme(String theme) {
    _sharedPrefsHelper.changeTheme(theme);
    _sharedPrefsHelper.getCurrentTheme.then((theme) {
      _currentTheme = theme;
    });
    notifyListeners();
  }
}

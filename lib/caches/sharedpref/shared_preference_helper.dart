import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  Future<SharedPreferences> _sharedPreference;
  static const String current_language = "";
  static const String current_theme = "system";

  SharedPreferenceHelper() {
    _sharedPreference = SharedPreferences.getInstance();
  }

//Theme
  Future<void> changeTheme(String value) {
    return _sharedPreference.then((prefs) {
      return prefs.setString(current_theme, value);
    });
  }

  Future<String> get getCurrentTheme {
    return _sharedPreference.then((prefs) {
      String currentTheme = prefs.getString(current_theme) ?? 'system';
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
      return prefs.getString(current_language);
    });
  }
}

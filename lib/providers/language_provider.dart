import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_starter/localizations.dart';
import 'package:flutter_starter/caches/sharedpref/shared_preference_helper.dart';

class LanguageProvider extends ChangeNotifier {
  // shared pref object
  SharedPreferenceHelper _sharedPrefsHelper;

  String _currentLanguage = 'en';

  LanguageProvider() {
    _sharedPrefsHelper = SharedPreferenceHelper();
  }

  String get currentLanguage {
    _sharedPrefsHelper.appCurrentLanguage.then((value) {
      _currentLanguage = value;
    });
    return _currentLanguage;
  }

  Locale get getLocale {
    Locale updatedLocal = AppLocalizations.languages.keys.first;
    AppLocalizations.languages.keys.forEach((locale) {
      if (locale.languageCode == currentLanguage) {
        updatedLocal = locale;
      }
    });
    return updatedLocal;
  }

  void updateLanguage(String selectedLanguage) {
    _sharedPrefsHelper.changeLanguage(selectedLanguage);
    _sharedPrefsHelper.appCurrentLanguage.then((languageSelected) {
      _currentLanguage = languageSelected;
    });

    notifyListeners();
  }
}

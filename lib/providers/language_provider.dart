import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter/localizations.dart';
import 'package:flutter_starter/services/services.dart';

class LanguageProvider extends ChangeNotifier {
  // shared pref object
  SharedPreferenceHelper _sharedPrefsHelper;

  String _currentLanguage = '';

  LanguageProvider() {
    _sharedPrefsHelper = SharedPreferenceHelper();
  }

  setInitialLocalLanguage() async {
    _sharedPrefsHelper.appCurrentLanguage.then((currentLanguageCode) async {
      if ((currentLanguageCode == '') || (currentLanguageCode == null)) {
        //begin taken from devicelocale flutter plugin
        //gets language code (en-US)
        const MethodChannel _channel =
            const MethodChannel('uk.spiralarm.flutter/devicelocale');
        final List deviceLanguages =
            await _channel.invokeMethod('preferredLanguages');
        //end taken from devicelocale flutter plugin
        String deviceLanguage = deviceLanguages.first;
        deviceLanguage =
            deviceLanguage.substring(0, 2); //only get 1st 2 characters
        print('deviceLanguage: ' + deviceLanguage);
        updateLanguage(deviceLanguage);
      }
    });
  }

  String get currentLanguage {
    _sharedPrefsHelper.appCurrentLanguage.then((value) {
      _currentLanguage = value;
    });

    return _currentLanguage;
  }

  Locale get getLocale {
    Locale _updatedLocal = AppLocalizations.languages.keys.first;
    AppLocalizations.languages.keys.forEach((locale) {
      if (locale.languageCode == currentLanguage) {
        _updatedLocal = locale;
      }
    });
    return _updatedLocal;
  }

  void updateLanguage(String selectedLanguage) {
    _sharedPrefsHelper.changeLanguage(selectedLanguage);
    _sharedPrefsHelper.appCurrentLanguage.then((languageSelected) {
      _currentLanguage = languageSelected;
    });

    notifyListeners();
  }
}

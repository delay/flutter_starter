import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localizations.dart';
import 'package:flutter_starter/controllers/controllers.dart';
import 'package:flutter_starter/constants/constants.dart';
import 'package:flutter_starter/ui/components/components.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<AuthController>(AuthController());
  Get.put<ThemeController>(ThemeController());
  Get.put<LanguageController>(LanguageController());
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromStore();
    return GetBuilder<LanguageController>(
        builder: (languageController) => Loading(
              child: GetMaterialApp(
                //begin language translation stuff //https://github.com/aloisdeniel/flutter_sheet_localization
                locale: languageController.getLocale, // <- Current locale
                localizationsDelegates: [
                  const AppLocalizationsDelegate(), // <- Your custom delegate
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.languages.keys
                    .toList(), // <- Supported locales
                //end language translation stuff
                navigatorObservers: [
                  FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
                ],
                debugShowCheckedModeBanner: false,
                //defaultTransition: Transition.fade,
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                themeMode: ThemeMode.system,
                initialRoute: "/",
                getPages: AppRoutes.routes,
              ),
            ));
  }
}
